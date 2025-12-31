#!/bin/bash

# Database Backup Script for Production Migrations
# Creates a backup before running migrations

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

# Check if DATABASE_URL is set
if [[ -z "$DATABASE_URL" ]]; then
    error "DATABASE_URL environment variable is not set"
    exit 1
fi

# Create backup directory
BACKUP_DIR="backups"
mkdir -p "$BACKUP_DIR"

# Generate backup filename with timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/db_backup_$TIMESTAMP.sql"

log "Creating database backup..."
log "Backup file: $BACKUP_FILE"

# Create the backup
pg_dump "$DATABASE_URL" > "$BACKUP_FILE"

if [[ $? -eq 0 ]]; then
    log "✅ Database backup created successfully"
    
    # Compress the backup
    gzip "$BACKUP_FILE"
    log "✅ Backup compressed: $BACKUP_FILE.gz"
    
    # Get backup size
    BACKUP_SIZE=$(du -h "$BACKUP_FILE.gz" | cut -f1)
    log "📦 Backup size: $BACKUP_SIZE"
    
    # Keep only last 5 backups
    log "🧹 Cleaning up old backups (keeping last 5)..."
    cd "$BACKUP_DIR"
    ls -t db_backup_*.sql.gz | tail -n +6 | xargs -r rm
    cd ..
    
    log "🎉 Backup process completed successfully"
else
    error "❌ Failed to create database backup"
    exit 1
fi
