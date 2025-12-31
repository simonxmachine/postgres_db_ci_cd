#!/bin/bash

# Supabase Migration Verification Script
# Verifies that migrations were applied correctly

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

log "Starting migration verification..."

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

# Authenticate with Supabase (should already be done, but just in case)
echo "$SUPABASE_ACCESS_TOKEN" | supabase login

# Link to the project (should already be done, but just in case)
supabase link --project-ref "$SUPABASE_PROJECT_ID" --password "$SUPABASE_DB_PASSWORD"

# Get database connection string for direct queries
DATABASE_URL="postgresql://postgres:$SUPABASE_DB_PASSWORD@db.$SUPABASE_PROJECT_ID.supabase.co:5432/postgres"

# Test 1: Check if user_profile table exists
log "✓ Checking user_profile table..."
user_profile_exists=$(psql "$DATABASE_URL" -t -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'user_profile');" | tr -d ' ')

if [[ "$user_profile_exists" != "t" ]]; then
    error "user_profile table does not exist"
    exit 1
fi

# Test 2: Verify table structure
log "✓ Verifying user_profile table structure..."
expected_columns=("user_id" "first_name" "last_name" "username" "user_email" "user_phone" "role" "created_at" "updated_at")

for column in "${expected_columns[@]}"; do
    column_exists=$(psql "$DATABASE_URL" -t -c "SELECT EXISTS (SELECT FROM information_schema.columns WHERE table_name = 'user_profile' AND column_name = '$column');" | tr -d ' ')
    
    if [[ "$column_exists" != "t" ]]; then
        error "Column '$column' does not exist in user_profile table"
        exit 1
    fi
done

# Test 3: Check constraints
log "✓ Checking table constraints..."

# Check primary key
pk_exists=$(psql "$DATABASE_URL" -t -c "SELECT EXISTS (SELECT FROM information_schema.table_constraints WHERE table_name = 'user_profile' AND constraint_type = 'PRIMARY KEY');" | tr -d ' ')

if [[ "$pk_exists" != "t" ]]; then
    error "Primary key constraint missing on user_profile table"
    exit 1
fi

# Test 4: Test basic operations
log "✓ Testing basic table operations..."

# Test insert
test_id=$(uuidgen)
psql "$DATABASE_URL" -c "INSERT INTO user_profile (user_id, first_name, last_name, username, user_email, role) VALUES ('$test_id', 'Test', 'User', 'testuser_$(date +%s)', 'test_$(date +%s)@example.com', 'user');" > /dev/null

if [[ $? -ne 0 ]]; then
    error "Failed to insert test record"
    exit 1
fi

# Test select
psql "$DATABASE_URL" -c "SELECT user_id, username FROM user_profile WHERE user_id = '$test_id';" > /dev/null

if [[ $? -ne 0 ]]; then
    error "Failed to select test record"
    exit 1
fi

# Clean up test record
psql "$DATABASE_URL" -c "DELETE FROM user_profile WHERE user_id = '$test_id';" > /dev/null

log "✅ All verification tests passed!"
log "🎉 Database migration verification completed successfully"