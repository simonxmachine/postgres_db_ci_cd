-- Migration: Create user_profile table
-- Created: 2025-12-30

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create user_profile table (independent, not linked to auth.users)
CREATE TABLE IF NOT EXISTS user_profile (
    -- Primary key - independent UUID
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
    -- Personal information
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    username VARCHAR(50) UNIQUE,
    
    -- Contact information
    user_email VARCHAR(255) UNIQUE NOT NULL,
    user_phone VARCHAR(20),
    
    -- Role management
    role VARCHAR(50) DEFAULT 'user' CHECK (role IN ('user', 'admin', 'moderator', 'guest')),
    
    -- Metadata timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index on commonly queried fields
CREATE INDEX idx_user_profile_username ON user_profile(username);
CREATE INDEX idx_user_profile_email ON user_profile(user_email);
CREATE INDEX idx_user_profile_role ON user_profile(role);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to auto-update updated_at on row changes
CREATE TRIGGER update_user_profile_updated_at
    BEFORE UPDATE ON user_profile
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Enable Row Level Security (RLS)
ALTER TABLE user_profile ENABLE ROW LEVEL SECURITY;

-- Comment on table
COMMENT ON TABLE user_profile IS 'Stores user profile information - independent user management';
