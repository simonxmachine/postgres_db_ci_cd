-- Migration: Seed user_profile table with sample data
-- Created: 2025-12-31

-- Insert 20 sample users for testing/development
INSERT INTO user_profile (first_name, last_name, username, user_email, user_phone, role) VALUES
    ('Emma', 'Johnson', 'emma.johnson', 'emma.johnson@example.com', '+1-555-0101', 'admin'),
    ('Liam', 'Williams', 'liam.williams', 'liam.williams@example.com', '+1-555-0102', 'user'),
    ('Olivia', 'Brown', 'olivia.brown', 'olivia.brown@example.com', '+1-555-0103', 'user'),
    ('Noah', 'Jones', 'noah.jones', 'noah.jones@example.com', '+1-555-0104', 'moderator'),
    ('Ava', 'Garcia', 'ava.garcia', 'ava.garcia@example.com', '+1-555-0105', 'user'),
    ('Ethan', 'Miller', 'ethan.miller', 'ethan.miller@example.com', '+1-555-0106', 'user'),
    ('Sophia', 'Davis', 'sophia.davis', 'sophia.davis@example.com', '+1-555-0107', 'user'),
    ('Mason', 'Rodriguez', 'mason.rodriguez', 'mason.rodriguez@example.com', '+1-555-0108', 'guest'),
    ('Isabella', 'Martinez', 'isabella.martinez', 'isabella.martinez@example.com', '+1-555-0109', 'user'),
    ('William', 'Hernandez', 'william.hernandez', 'william.hernandez@example.com', '+1-555-0110', 'user'),
    ('Mia', 'Lopez', 'mia.lopez', 'mia.lopez@example.com', '+1-555-0111', 'moderator'),
    ('James', 'Gonzalez', 'james.gonzalez', 'james.gonzalez@example.com', '+1-555-0112', 'user'),
    ('Charlotte', 'Wilson', 'charlotte.wilson', 'charlotte.wilson@example.com', '+1-555-0113', 'user'),
    ('Benjamin', 'Anderson', 'benjamin.anderson', 'benjamin.anderson@example.com', '+1-555-0114', 'user'),
    ('Amelia', 'Thomas', 'amelia.thomas', 'amelia.thomas@example.com', '+1-555-0115', 'guest'),
    ('Lucas', 'Taylor', 'lucas.taylor', 'lucas.taylor@example.com', '+1-555-0116', 'user'),
    ('Harper', 'Moore', 'harper.moore', 'harper.moore@example.com', '+1-555-0117', 'user'),
    ('Henry', 'Jackson', 'henry.jackson', 'henry.jackson@example.com', '+1-555-0118', 'admin'),
    ('Evelyn', 'Martin', 'evelyn.martin', 'evelyn.martin@example.com', '+1-555-0119', 'user'),
    ('Alexander', 'Lee', 'alexander.lee', 'alexander.lee@example.com', '+1-555-0120', 'user');

-- Verify the data was inserted
DO $$
DECLARE
    user_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO user_count FROM user_profile;
    RAISE NOTICE 'Total users in user_profile table: %', user_count;
END $$;

