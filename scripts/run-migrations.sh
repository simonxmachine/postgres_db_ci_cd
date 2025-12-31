#!/bin/bash

# Database Migration Runner Script
# Usage: ./run-migrations.sh [staging|production]

set -e  # Exit on any error

ENVIRONMENT=${1:-staging}
MIGRATION_DIR="supabase/migrations"
LOG_FILE="migration-$(date +%Y%m%d-%H%M%S).log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}" | tee -a "$LOG_FILE"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}" | tee -a "$LOG_FILE"
}

# Validate environment
if [[ "$ENVIRONMENT" != "staging" && "$ENVIRONMENT" != "production" ]]; then
    error "Invalid environment. Use 'staging' or 'production'"
    exit 1
fi

log "Starting migration process for $ENVIRONMENT environment"

# Check if DATABASE_URL is set
if [[ -z "$DATABASE_URL" ]]; then
    error "DATABASE_URL environment variable is not set"
    exit 1
fi

# Create migrations table if it doesn't exist
log "Ensuring migrations tracking table exists..."
psql "$DATABASE_URL" -c "
CREATE TABLE IF NOT EXISTS _migrations (
    id SERIAL PRIMARY KEY,
    filename VARCHAR(255) UNIQUE NOT NULL,
    applied_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    checksum VARCHAR(64)
);" || {
    error "Failed to create migrations table"
    exit 1
}

# Function to calculate file checksum
calculate_checksum() {
    sha256sum "$1" | cut -d' ' -f1
}

# Function to check if migration was already applied
is_migration_applied() {
    local filename="$1"
    local count=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM _migrations WHERE filename = '$filename';" | tr -d ' ')
    [[ "$count" -gt 0 ]]
}

# Function to apply a single migration
apply_migration() {
    local file="$1"
    local filename=$(basename "$file")
    local checksum=$(calculate_checksum "$file")
    
    log "Applying migration: $filename"
    
    # Start transaction
    psql "$DATABASE_URL" -v ON_ERROR_STOP=1 << EOF
BEGIN;

-- Apply the migration
\i $file

-- Record the migration
INSERT INTO _migrations (filename, checksum) VALUES ('$filename', '$checksum');

COMMIT;
EOF
    
    if [[ $? -eq 0 ]]; then
        log "✅ Successfully applied: $filename"
    else
        error "❌ Failed to apply: $filename"
        return 1
    fi
}

# Main migration logic
log "Scanning for migration files in $MIGRATION_DIR"

if [[ ! -d "$MIGRATION_DIR" ]]; then
    error "Migration directory $MIGRATION_DIR does not exist"
    exit 1
fi

# Get all .sql files sorted by name (timestamp)
migration_files=($(find "$MIGRATION_DIR" -name "*.sql" | sort))

if [[ ${#migration_files[@]} -eq 0 ]]; then
    warn "No migration files found in $MIGRATION_DIR"
    exit 0
fi

log "Found ${#migration_files[@]} migration file(s)"

# Apply each migration
failed_migrations=()
applied_count=0

for file in "${migration_files[@]}"; do
    filename=$(basename "$file")
    
    if is_migration_applied "$filename"; then
        log "⏭️  Skipping already applied migration: $filename"
        continue
    fi
    
    log "📝 Processing migration: $filename"
    
    if apply_migration "$file"; then
        ((applied_count++))
    else
        failed_migrations+=("$filename")
        if [[ "$ENVIRONMENT" == "production" ]]; then
            error "Migration failed in production. Stopping execution."
            break
        fi
    fi
done

# Summary
log "Migration process completed"
log "Applied: $applied_count new migration(s)"

if [[ ${#failed_migrations[@]} -gt 0 ]]; then
    error "Failed migrations: ${failed_migrations[*]}"
    exit 1
fi

log "🎉 All migrations applied successfully!"
