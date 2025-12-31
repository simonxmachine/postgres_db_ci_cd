-- Migration: Create user_full_details table with JSONB arrays
-- Created: 2025-01-01

-- Create user_full_details table
CREATE TABLE IF NOT EXISTS user_full_details (
    -- Primary key - references user_profile
    user_id UUID PRIMARY KEY REFERENCES user_profile(user_id) ON DELETE CASCADE,
    
    -- Education and experience (arrays of objects)
    user_school JSONB DEFAULT '[]'::jsonb,
    user_experience JSONB DEFAULT '[]'::jsonb,
    
    -- Skills and achievements (arrays of strings)
    user_skills JSONB DEFAULT '[]'::jsonb,
    user_certificates JSONB DEFAULT '[]'::jsonb,
    
    -- Portfolio and links (arrays of objects)
    user_portfolio JSONB DEFAULT '[]'::jsonb,
    user_links JSONB DEFAULT '[]'::jsonb,
    
    -- Metadata timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create GIN indexes for fast JSONB queries
CREATE INDEX idx_user_full_details_skills ON user_full_details USING GIN (user_skills);
CREATE INDEX idx_user_full_details_certificates ON user_full_details USING GIN (user_certificates);
CREATE INDEX idx_user_full_details_experience ON user_full_details USING GIN (user_experience);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_user_full_details_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to auto-update updated_at on row changes
CREATE TRIGGER update_user_full_details_updated_at
    BEFORE UPDATE ON user_full_details
    FOR EACH ROW
    EXECUTE FUNCTION update_user_full_details_updated_at();

-- Add some example data to demonstrate JSONB structure
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT 
    user_id,
    -- School as array of objects
    '[
        {
            "institution": "Stanford University",
            "degree": "Computer Science",
            "year": "2020-2024",
            "gpa": "3.8"
        }
    ]'::jsonb,
    -- Experience as array of objects
    '[
        {
            "company": "Tech Corp",
            "position": "Software Engineer",
            "duration": "2024-Present",
            "description": "Full-stack development"
        }
    ]'::jsonb,
    -- Skills as simple array
    '["JavaScript", "Python", "React", "Node.js", "PostgreSQL"]'::jsonb,
    -- Certificates as array of objects
    '[
        {
            "name": "AWS Certified Developer",
            "issuer": "Amazon",
            "date": "2024-06-15"
        }
    ]'::jsonb,
    -- Portfolio as array of objects
    '[
        {
            "title": "E-commerce Platform",
            "description": "Full-stack web application",
            "url": "https://github.com/user/ecommerce",
            "technologies": ["React", "Node.js", "MongoDB"]
        }
    ]'::jsonb,
    -- Links as array of objects
    '[
        {
            "platform": "GitHub",
            "url": "https://github.com/username"
        },
        {
            "platform": "LinkedIn",
            "url": "https://linkedin.com/in/username"
        }
    ]'::jsonb
FROM user_profile 
WHERE username = 'emma.johnson'
LIMIT 1;

-- Enable Row Level Security (RLS)
ALTER TABLE user_full_details ENABLE ROW LEVEL SECURITY;

-- Comment on table and columns
COMMENT ON TABLE user_full_details IS 'Extended user profile information with JSONB arrays for flexible data storage';
COMMENT ON COLUMN user_full_details.user_school IS 'Array of education objects: [{institution, degree, year, gpa}]';
COMMENT ON COLUMN user_full_details.user_experience IS 'Array of work experience objects: [{company, position, duration, description}]';
COMMENT ON COLUMN user_full_details.user_skills IS 'Array of skill strings: ["JavaScript", "Python"]';
COMMENT ON COLUMN user_full_details.user_certificates IS 'Array of certificate objects: [{name, issuer, date}]';
COMMENT ON COLUMN user_full_details.user_portfolio IS 'Array of project objects: [{title, description, url, technologies}]';
COMMENT ON COLUMN user_full_details.user_links IS 'Array of social/professional links: [{platform, url}]';
