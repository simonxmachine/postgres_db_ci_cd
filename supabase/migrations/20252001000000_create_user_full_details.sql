-- Migration: Create user_full_details table with JSONB arrays
-- Created: 2025-01-01

-- Create user_full_details table
CREATE TABLE IF NOT EXISTS user_full_details (
    -- Primary key - references user_profile (1-to-1 relationship)
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

-- Insert sample data for ALL users in user_profile
-- Each user_profile row gets a corresponding user_full_details row
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT 
    up.user_id,
    -- Varied school data based on row number
    CASE (ROW_NUMBER() OVER (ORDER BY up.created_at)) % 5
        WHEN 0 THEN '[{"institution": "MIT", "degree": "Computer Science", "year": "2018-2022", "gpa": "3.9"}]'::jsonb
        WHEN 1 THEN '[{"institution": "Stanford University", "degree": "Software Engineering", "year": "2019-2023", "gpa": "3.8"}]'::jsonb
        WHEN 2 THEN '[{"institution": "UC Berkeley", "degree": "Data Science", "year": "2017-2021", "gpa": "3.7"}]'::jsonb
        WHEN 3 THEN '[{"institution": "Carnegie Mellon", "degree": "Information Systems", "year": "2020-2024", "gpa": "3.85"}]'::jsonb
        ELSE '[{"institution": "Georgia Tech", "degree": "Computer Engineering", "year": "2016-2020", "gpa": "3.6"}]'::jsonb
    END,
    -- Varied experience data
    CASE (ROW_NUMBER() OVER (ORDER BY up.created_at)) % 4
        WHEN 0 THEN '[{"company": "Google", "position": "Software Engineer", "duration": "2023-Present", "description": "Full-stack development on Cloud Platform"}]'::jsonb
        WHEN 1 THEN '[{"company": "Meta", "position": "Frontend Developer", "duration": "2022-Present", "description": "React Native mobile development"}]'::jsonb
        WHEN 2 THEN '[{"company": "Amazon", "position": "Backend Engineer", "duration": "2021-Present", "description": "AWS services and microservices architecture"}]'::jsonb
        ELSE '[{"company": "Microsoft", "position": "DevOps Engineer", "duration": "2024-Present", "description": "CI/CD pipelines and Azure infrastructure"}]'::jsonb
    END,
    -- Varied skills based on role
    CASE up.role
        WHEN 'admin' THEN '["JavaScript", "TypeScript", "React", "Node.js", "PostgreSQL", "AWS", "Docker", "Kubernetes"]'::jsonb
        WHEN 'moderator' THEN '["Python", "Django", "React", "MongoDB", "Redis", "GraphQL"]'::jsonb
        WHEN 'guest' THEN '["HTML", "CSS", "JavaScript"]'::jsonb
        ELSE '["JavaScript", "React", "Node.js", "PostgreSQL", "Git"]'::jsonb
    END,
    -- Varied certificates
    CASE (ROW_NUMBER() OVER (ORDER BY up.created_at)) % 3
        WHEN 0 THEN '[{"name": "AWS Certified Developer", "issuer": "Amazon", "date": "2024-03-15"}, {"name": "Google Cloud Professional", "issuer": "Google", "date": "2023-11-20"}]'::jsonb
        WHEN 1 THEN '[{"name": "Meta React Developer", "issuer": "Meta", "date": "2024-01-10"}]'::jsonb
        ELSE '[{"name": "Kubernetes Administrator", "issuer": "CNCF", "date": "2024-05-22"}, {"name": "HashiCorp Terraform", "issuer": "HashiCorp", "date": "2023-08-15"}]'::jsonb
    END,
    -- Portfolio projects
    json_build_array(
        json_build_object(
            'title', CONCAT(up.first_name, '''s Project'),
            'description', 'A full-stack web application',
            'url', CONCAT('https://github.com/', up.username, '/project'),
            'technologies', ARRAY['React', 'Node.js', 'PostgreSQL']
        )
    )::jsonb,
    -- Social/professional links - personalized with username
    json_build_array(
        json_build_object('platform', 'GitHub', 'url', CONCAT('https://github.com/', up.username)),
        json_build_object('platform', 'LinkedIn', 'url', CONCAT('https://linkedin.com/in/', up.username)),
        json_build_object('platform', 'Portfolio', 'url', CONCAT('https://', up.username, '.dev'))
    )::jsonb
FROM user_profile up;

-- Enable Row Level Security (RLS)
ALTER TABLE user_full_details ENABLE ROW LEVEL SECURITY;

-- Comment on table and columns
COMMENT ON TABLE user_full_details IS 'Extended user profile information with JSONB arrays - 1-to-1 with user_profile';
COMMENT ON COLUMN user_full_details.user_school IS 'Array of education objects: [{institution, degree, year, gpa}]';
COMMENT ON COLUMN user_full_details.user_experience IS 'Array of work experience objects: [{company, position, duration, description}]';
COMMENT ON COLUMN user_full_details.user_skills IS 'Array of skill strings: ["JavaScript", "Python"]';
COMMENT ON COLUMN user_full_details.user_certificates IS 'Array of certificate objects: [{name, issuer, date}]';
COMMENT ON COLUMN user_full_details.user_portfolio IS 'Array of project objects: [{title, description, url, technologies}]';
COMMENT ON COLUMN user_full_details.user_links IS 'Array of social/professional links: [{platform, url}]';