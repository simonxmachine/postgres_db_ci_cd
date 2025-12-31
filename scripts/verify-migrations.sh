#!/bin/bash

# Migration Verification Script
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

# Check if DATABASE_URL is set
if [[ -z "$DATABASE_URL" ]]; then
    error "DATABASE_URL environment variable is not set"
    exit 1
fi

log "Starting migration verification..."

# Test 1: Check if migrations table exists
log "✓ Checking migrations tracking table..."
migrations_table_exists=$(psql "$DATABASE_URL" -t -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = '_migrations');" | tr -d ' ')

if [[ "$migrations_table_exists" != "t" ]]; then
    error "Migrations tracking table does not exist"
    exit 1
fi

# Test 2: Check if user_profile table exists
log "✓ Checking user_profile table..."
user_profile_exists=$(psql "$DATABASE_URL" -t -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'user_profile');" | tr -d ' ')

if [[ "$user_profile_exists" != "t" ]]; then
    error "user_profile table does not exist"
    exit 1
fi

# Test 3: Verify table structure
log "✓ Verifying user_profile table structure..."
expected_columns=("user_id" "first_name" "last_name" "username" "user_email" "user_phone" "role" "created_at" "updated_at")

for column in "${expected_columns[@]}"; do
    column_exists=$(psql "$DATABASE_URL" -t -c "SELECT EXISTS (SELECT FROM information_schema.columns WHERE table_name = 'user_profile' AND column_name = '$column');" | tr -d ' ')
    
    if [[ "$column_exists" != "t" ]]; then
        error "Column '$column' does not exist in user_profile table"
        exit 1
    fi
done

# Test 4: Check constraints
log "✓ Checking table constraints..."

# Check primary key
pk_exists=$(psql "$DATABASE_URL" -t -c "SELECT EXISTS (SELECT FROM information_schema.table_constraints WHERE table_name = 'user_profile' AND constraint_type = 'PRIMARY KEY');" | tr -d ' ')

if [[ "$pk_exists" != "t" ]]; then
    error "Primary key constraint missing on user_profile table"
    exit 1
fi

# Check unique constraints
unique_constraints=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM information_schema.table_constraints WHERE table_name = 'user_profile' AND constraint_type = 'UNIQUE';" | tr -d ' ')

if [[ "$unique_constraints" -lt 2 ]]; then
    warn "Expected at least 2 unique constraints (username, user_email), found $unique_constraints"
fi

# Test 5: Check indexes
log "✓ Checking indexes..."
expected_indexes=("idx_user_profile_username" "idx_user_profile_email" "idx_user_profile_role")

for index in "${expected_indexes[@]}"; do
    index_exists=$(psql "$DATABASE_URL" -t -c "SELECT EXISTS (SELECT FROM pg_indexes WHERE indexname = '$index');" | tr -d ' ')
    
    if [[ "$index_exists" != "t" ]]; then
        warn "Index '$index' does not exist"
    fi
done

# Test 6: Check triggers
log "✓ Checking triggers..."
trigger_exists=$(psql "$DATABASE_URL" -t -c "SELECT EXISTS (SELECT FROM information_schema.triggers WHERE trigger_name = 'update_user_profile_updated_at');" | tr -d ' ')

if [[ "$trigger_exists" != "t" ]]; then
    warn "Auto-update trigger for updated_at column does not exist"
fi

# Test 7: Test basic operations
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

# Test update (should trigger updated_at)
psql "$DATABASE_URL" -c "UPDATE user_profile SET first_name = 'Updated' WHERE user_id = '$test_id';" > /dev/null

if [[ $? -ne 0 ]]; then
    error "Failed to update test record"
    exit 1
fi

# Clean up test record
psql "$DATABASE_URL" -c "DELETE FROM user_profile WHERE user_id = '$test_id';" > /dev/null

log "✅ All verification tests passed!"
log "🎉 Database migration verification completed successfully"
