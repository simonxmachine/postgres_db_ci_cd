#!/bin/bash

# Supabase Migration Runner Script
# Usage: ./run-migrations.sh [staging|production]

set -e  # Exit on any error

ENVIRONMENT=${1:-staging}
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

# Check if required Supabase environment variables are set
if [[ -z "$SUPABASE_ACCESS_TOKEN" ]]; then
    error "SUPABASE_ACCESS_TOKEN environment variable is not set"
    exit 1
fi

if [[ -z "$SUPABASE_PROJECT_ID" ]]; then
    error "SUPABASE_PROJECT_ID environment variable is not set"
    exit 1
fi

if [[ -z "$SUPABASE_DB_PASSWORD" ]]; then
    error "SUPABASE_DB_PASSWORD environment variable is not set"
    exit 1
fi

# Authenticate with Supabase
log "Authenticating with Supabase..."
echo "$SUPABASE_ACCESS_TOKEN" | supabase login

# Link to the project
log "Linking to Supabase project: $SUPABASE_PROJECT_ID"
supabase link --project-ref "$SUPABASE_PROJECT_ID" --password "$SUPABASE_DB_PASSWORD"

# Push migrations using Supabase CLI
log "Pushing migrations to $ENVIRONMENT..."
supabase db push

if [[ $? -eq 0 ]]; then
    log "✅ Migrations pushed successfully!"
    log "🎉 Migration process completed for $ENVIRONMENT environment"
else
    error "❌ Failed to push migrations"
    exit 1
fi