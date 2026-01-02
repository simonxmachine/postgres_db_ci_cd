-- Allow anonymous read access to user_profile table
CREATE POLICY "Allow anonymous read access" ON user_profile
FOR SELECT USING (true);