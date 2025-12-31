#!/bin/bash

# Migration Rollback Script
# Restores database from the latest backup

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

# Check if DATABASE_URL is set
if [[ -z "$DATABASE_URL" ]]; then
    error "DATABASE_URL environment variable is not set"
    exit 1
fi

BACKUP_DIR="backups"

# Check if backup directory exists
if [[ ! -d "$BACKUP_DIR" ]]; then
    error "Backup directory does not exist: $BACKUP_DIR"
    exit 1
fi

# Find the latest backup
LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/db_backup_*.sql.gz 2>/dev/null | head -n1)

if [[ -z "$LATEST_BACKUP" ]]; then
    error "No backup files found in $BACKUP_DIR"
    exit 1
fi

log "🔄 Starting rollback process..."
log "Using backup: $LATEST_BACKUP"

# Extract backup timestamp
BACKUP_TIMESTAMP=$(basename "$LATEST_BACKUP" | sed 's/db_backup_\(.*\)\.sql\.gz/\1/')
log "Backup timestamp: $BACKUP_TIMESTAMP"

# Confirm rollback (in CI, this should be automatic)
if [[ -t 0 ]]; then  # Check if running interactively
    warn "This will restore the database to state: $BACKUP_TIMESTAMP"
    read -p "Are you sure you want to proceed? (yes/no): " confirm
    if [[ "$confirm" != "yes" ]]; then
        log "Rollback cancelled by user"
        exit 0
    fi
fi

# Create a temporary file for the decompressed backup
TEMP_BACKUP="/tmp/rollback_backup_$(date +%s).sql"

log "📦 Decompressing backup..."
gunzip -c "$LATEST_BACKUP" > "$TEMP_BACKUP"

if [[ $? -ne 0 ]]; then
    error "Failed to decompress backup"
    exit 1
fi

log "🗄️  Restoring database from backup..."

# Drop existing database and recreate (DANGEROUS - only for emergencies)
# In production, you might want a more surgical approach
warn "This is a full database restore - all current data will be lost!"

# Get database name from URL
DB_NAME=$(echo "$DATABASE_URL" | sed 's/.*\/\([^?]*\).*/\1/')
BASE_URL=$(echo "$DATABASE_URL" | sed 's/\/[^\/]*$/\/postgres/')

log "Database name: $DB_NAME"

# Terminate active connections
psql "$BASE_URL" -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME' AND pid <> pg_backend_pid();" || true

# Drop and recreate database
psql "$BASE_URL" -c "DROP DATABASE IF EXISTS \"$DB_NAME\";"
psql "$BASE_URL" -c "CREATE DATABASE \"$DB_NAME\";"

# Restore from backup
psql "$DATABASE_URL" < "$TEMP_BACKUP"

if [[ $? -eq 0 ]]; then
    log "✅ Database restored successfully"
    
    # Clean up temporary file
    rm "$TEMP_BACKUP"
    
    # Verify restoration
    log "🔍 Verifying restoration..."
    table_count=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';" | tr -d ' ')
    log "Tables restored: $table_count"
    
    log "🎉 Rollback completed successfully"
    log "Database has been restored to backup: $BACKUP_TIMESTAMP"
else
    error "❌ Failed to restore database"
    rm "$TEMP_BACKUP"
    exit 1
fi
