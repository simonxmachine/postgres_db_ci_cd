-- Migration: Insert sample data for all user_profile users into user_full_details
-- Created: 2025-01-02

-- Insert data for Emma Johnson (admin)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "Stanford University", "degree": "Computer Science", "year": "2018-2022", "gpa": "3.9"}]'::jsonb,
    '[{"company": "Google", "position": "Senior Software Engineer", "duration": "2022-Present", "description": "Leading cloud infrastructure team"}]'::jsonb,
    '["JavaScript", "TypeScript", "React", "Node.js", "PostgreSQL", "AWS", "Docker", "Kubernetes"]'::jsonb,
    '[{"name": "AWS Certified Solutions Architect", "issuer": "Amazon", "date": "2023-06-15"}, {"name": "Google Cloud Professional", "issuer": "Google", "date": "2024-01-20"}]'::jsonb,
    '[{"title": "Cloud Infrastructure Dashboard", "description": "Real-time monitoring platform", "url": "https://github.com/emma.johnson/cloud-dashboard", "technologies": ["React", "Node.js", "AWS"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/emma.johnson"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/emma.johnson"}, {"platform": "Portfolio", "url": "https://emmajohnson.dev"}]'::jsonb
FROM user_profile WHERE username = 'emma.johnson';

-- Insert data for Liam Williams (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "SUNY Binghamton", "degree": "Information Systems", "year": "2019-2023", "gpa": "3.7"}]'::jsonb,
    '[{"company": "Health Startup", "position": "Full Stack Developer", "duration": "2023-Present", "description": "Building telemedicine platform"}]'::jsonb,
    '["Python", "Django", "React", "PostgreSQL", "Redis", "GraphQL", "Tailwind CSS"]'::jsonb,
    '[{"name": "Meta React Developer", "issuer": "Meta", "date": "2024-02-10"}]'::jsonb,
    '[{"title": "Telemedicine App", "description": "Patient-doctor video consultation", "url": "https://github.com/liam.williams/telehealth", "technologies": ["React", "Django", "WebRTC"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/liam.williams"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/liam.williams"}]'::jsonb
FROM user_profile WHERE username = 'liam.williams';

-- Insert data for Olivia Brown (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "UCLA", "degree": "Software Engineering", "year": "2017-2021", "gpa": "3.8"}]'::jsonb,
    '[{"company": "Real Estate Office", "position": "Frontend Developer", "duration": "2021-Present", "description": "Property listing and CRM systems"}]'::jsonb,
    '["JavaScript", "Vue.js", "Nuxt.js", "SCSS", "Firebase", "Figma"]'::jsonb,
    '[{"name": "Google UX Design Certificate", "issuer": "Google", "date": "2023-09-05"}, {"name": "Certified Scrum Master", "issuer": "Scrum Alliance", "date": "2024-03-12"}]'::jsonb,
    '[{"title": "Property Finder", "description": "Real estate search platform", "url": "https://github.com/olivia.brown/property-finder", "technologies": ["Vue.js", "Firebase", "Google Maps API"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/olivia.brown"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/olivia.brown"}, {"platform": "Dribbble", "url": "https://dribbble.com/olivia.brown"}]'::jsonb
FROM user_profile WHERE username = 'olivia.brown';

-- Insert data for Noah Jones (moderator)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "New York University", "degree": "Computer Science", "year": "2016-2020", "gpa": "3.6"}]'::jsonb,
    '[{"company": "Meta", "position": "Backend Engineer", "duration": "2020-Present", "description": "Instagram API infrastructure"}]'::jsonb,
    '["Python", "Go", "GraphQL", "MongoDB", "Kafka", "Docker", "Prometheus"]'::jsonb,
    '[{"name": "Kubernetes Administrator", "issuer": "CNCF", "date": "2023-11-22"}, {"name": "HashiCorp Terraform Associate", "issuer": "HashiCorp", "date": "2024-01-15"}]'::jsonb,
    '[{"title": "API Gateway", "description": "High-performance API routing service", "url": "https://github.com/noah.jones/api-gateway", "technologies": ["Go", "Redis", "Docker"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/noah.jones"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/noah.jones"}, {"platform": "Twitter", "url": "https://twitter.com/noah.jones"}]'::jsonb
FROM user_profile WHERE username = 'noah.jones';

-- Insert data for Ava Garcia (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "UC Irvine", "degree": "Data Science", "year": "2018-2022", "gpa": "3.75"}]'::jsonb,
    '[{"company": "Dylan''s Candy Store", "position": "Data Analyst", "duration": "2022-Present", "description": "Inventory and sales analytics"}]'::jsonb,
    '["Python", "Pandas", "SQL", "Tableau", "Excel", "Power BI", "R"]'::jsonb,
    '[{"name": "Google Data Analytics", "issuer": "Google", "date": "2023-04-18"}, {"name": "Tableau Desktop Specialist", "issuer": "Tableau", "date": "2024-02-28"}]'::jsonb,
    '[{"title": "Sales Dashboard", "description": "Interactive sales analytics dashboard", "url": "https://github.com/ava.garcia/sales-dashboard", "technologies": ["Python", "Streamlit", "Plotly"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/ava.garcia"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/ava.garcia"}, {"platform": "Kaggle", "url": "https://kaggle.com/ava.garcia"}]'::jsonb
FROM user_profile WHERE username = 'ava.garcia';

-- Insert data for Ethan Miller (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "SUNY Albany", "degree": "Information Technology", "year": "2019-2023", "gpa": "3.5"}]'::jsonb,
    '[{"company": "Amazon", "position": "DevOps Engineer", "duration": "2023-Present", "description": "AWS infrastructure automation"}]'::jsonb,
    '["AWS", "Terraform", "Ansible", "Python", "Bash", "Jenkins", "GitHub Actions"]'::jsonb,
    '[{"name": "AWS Certified DevOps Engineer", "issuer": "Amazon", "date": "2024-05-10"}, {"name": "Linux Foundation Certified Admin", "issuer": "Linux Foundation", "date": "2023-08-20"}]'::jsonb,
    '[{"title": "Infrastructure as Code Templates", "description": "Reusable Terraform modules", "url": "https://github.com/ethan.miller/terraform-modules", "technologies": ["Terraform", "AWS", "Python"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/ethan.miller"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/ethan.miller"}]'::jsonb
FROM user_profile WHERE username = 'ethan.miller';

-- Insert data for Sophia Davis (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "Hunter College", "degree": "Computer Science", "year": "2017-2021", "gpa": "3.65"}]'::jsonb,
    '[{"company": "Health Startup", "position": "Mobile Developer", "duration": "2021-Present", "description": "iOS health tracking app"}]'::jsonb,
    '["Swift", "SwiftUI", "Objective-C", "Firebase", "Core Data", "HealthKit"]'::jsonb,
    '[{"name": "Apple Certified iOS Developer", "issuer": "Apple", "date": "2023-07-15"}, {"name": "CompTIA Security+", "issuer": "CompTIA", "date": "2024-04-01"}]'::jsonb,
    '[{"title": "FitTrack Pro", "description": "Health and fitness tracking app", "url": "https://github.com/sophia.davis/fittrack", "technologies": ["Swift", "HealthKit", "Firebase"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/sophia.davis"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/sophia.davis"}, {"platform": "App Store", "url": "https://apps.apple.com/developer/sophia.davis"}]'::jsonb
FROM user_profile WHERE username = 'sophia.davis';

-- Insert data for Mason Rodriguez (guest)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "SUNY Stony Brook", "degree": "Web Development Bootcamp", "year": "2023", "gpa": "N/A"}]'::jsonb,
    '[{"company": "Freelance", "position": "Junior Web Developer", "duration": "2023-Present", "description": "Building websites for small businesses"}]'::jsonb,
    '["HTML", "CSS", "JavaScript", "WordPress", "Shopify"]'::jsonb,
    '[{"name": "freeCodeCamp Responsive Web Design", "issuer": "freeCodeCamp", "date": "2023-06-01"}]'::jsonb,
    '[{"title": "Local Business Website", "description": "Website for local bakery", "url": "https://github.com/mason.rodriguez/bakery-site", "technologies": ["HTML", "CSS", "JavaScript"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/mason.rodriguez"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/mason.rodriguez"}]'::jsonb
FROM user_profile WHERE username = 'mason.rodriguez';

-- Insert data for Isabella Martinez (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "Rutgers University", "degree": "Software Engineering", "year": "2018-2022", "gpa": "3.7"}]'::jsonb,
    '[{"company": "Real Estate Office", "position": "Backend Developer", "duration": "2022-Present", "description": "Property management system APIs"}]'::jsonb,
    '["Java", "Spring Boot", "PostgreSQL", "RabbitMQ", "Docker", "Microservices"]'::jsonb,
    '[{"name": "Oracle Certified Java Developer", "issuer": "Oracle", "date": "2023-10-12"}, {"name": "MongoDB Certified Developer", "issuer": "MongoDB", "date": "2024-03-05"}]'::jsonb,
    '[{"title": "Property Management API", "description": "RESTful API for property management", "url": "https://github.com/isabella.martinez/property-api", "technologies": ["Java", "Spring Boot", "PostgreSQL"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/isabella.martinez"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/isabella.martinez"}]'::jsonb
FROM user_profile WHERE username = 'isabella.martinez';

-- Insert data for William Hernandez (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "MIT", "degree": "Electrical Engineering & CS", "year": "2015-2019", "gpa": "3.85"}]'::jsonb,
    '[{"company": "Microsoft", "position": "Machine Learning Engineer", "duration": "2019-Present", "description": "Azure AI services development"}]'::jsonb,
    '["Python", "TensorFlow", "PyTorch", "Azure ML", "Scikit-learn", "Kubernetes", "C++"]'::jsonb,
    '[{"name": "Azure AI Engineer Associate", "issuer": "Microsoft", "date": "2023-05-20"}, {"name": "TensorFlow Developer Certificate", "issuer": "Google", "date": "2022-11-15"}]'::jsonb,
    '[{"title": "Image Classification API", "description": "Production ML model serving", "url": "https://github.com/william.hernandez/image-classifier", "technologies": ["Python", "TensorFlow", "FastAPI"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/william.hernandez"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/william.hernandez"}, {"platform": "Hugging Face", "url": "https://huggingface.co/william.hernandez"}]'::jsonb
FROM user_profile WHERE username = 'william.hernandez';

-- Insert data for Mia Lopez (moderator)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "Carnegie Mellon", "degree": "Human-Computer Interaction", "year": "2017-2021", "gpa": "3.8"}]'::jsonb,
    '[{"company": "Dylan''s Candy Store", "position": "UX Engineer", "duration": "2021-Present", "description": "E-commerce platform redesign"}]'::jsonb,
    '["Figma", "React", "TypeScript", "Storybook", "CSS-in-JS", "A/B Testing", "User Research"]'::jsonb,
    '[{"name": "Google UX Design Professional", "issuer": "Google", "date": "2022-08-10"}, {"name": "Nielsen Norman UX Certification", "issuer": "Nielsen Norman Group", "date": "2023-12-01"}]'::jsonb,
    '[{"title": "Design System", "description": "Component library with Storybook", "url": "https://github.com/mia.lopez/design-system", "technologies": ["React", "Storybook", "TypeScript"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/mia.lopez"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/mia.lopez"}, {"platform": "Behance", "url": "https://behance.net/mia.lopez"}]'::jsonb
FROM user_profile WHERE username = 'mia.lopez';

-- Insert data for James Gonzalez (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "Georgia Tech", "degree": "Computer Engineering", "year": "2016-2020", "gpa": "3.55"}]'::jsonb,
    '[{"company": "Health Startup", "position": "Systems Engineer", "duration": "2020-Present", "description": "HIPAA-compliant infrastructure"}]'::jsonb,
    '["Linux", "Nginx", "PostgreSQL", "Redis", "Docker", "Kubernetes", "Prometheus", "Grafana"]'::jsonb,
    '[{"name": "Red Hat Certified Engineer", "issuer": "Red Hat", "date": "2023-02-28"}, {"name": "HIPAA Security Certification", "issuer": "AHLA", "date": "2024-01-10"}]'::jsonb,
    '[{"title": "Monitoring Stack", "description": "Complete observability solution", "url": "https://github.com/james.gonzalez/monitoring-stack", "technologies": ["Prometheus", "Grafana", "Docker"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/james.gonzalez"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/james.gonzalez"}]'::jsonb
FROM user_profile WHERE username = 'james.gonzalez';

-- Insert data for Charlotte Wilson (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "UC Berkeley", "degree": "Data Science", "year": "2018-2022", "gpa": "3.72"}]'::jsonb,
    '[{"company": "Real Estate Office", "position": "Data Engineer", "duration": "2022-Present", "description": "ETL pipelines and data warehousing"}]'::jsonb,
    '["Python", "Apache Spark", "Airflow", "Snowflake", "dbt", "SQL", "AWS Glue"]'::jsonb,
    '[{"name": "Snowflake SnowPro Core", "issuer": "Snowflake", "date": "2023-09-15"}, {"name": "Databricks Certified Data Engineer", "issuer": "Databricks", "date": "2024-02-20"}]'::jsonb,
    '[{"title": "Real Estate Data Pipeline", "description": "Automated property data ETL", "url": "https://github.com/charlotte.wilson/realestate-etl", "technologies": ["Python", "Airflow", "Snowflake"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/charlotte.wilson"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/charlotte.wilson"}, {"platform": "Medium", "url": "https://medium.com/@charlotte.wilson"}]'::jsonb
FROM user_profile WHERE username = 'charlotte.wilson';

-- Insert data for Benjamin Anderson (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "SUNY Binghamton", "degree": "Computer Science", "year": "2017-2021", "gpa": "3.6"}]'::jsonb,
    '[{"company": "Dylan''s Candy Store", "position": "E-commerce Developer", "duration": "2021-Present", "description": "Shopify Plus customization"}]'::jsonb,
    '["JavaScript", "Liquid", "Shopify", "React", "Node.js", "Stripe API", "Klaviyo"]'::jsonb,
    '[{"name": "Shopify Partner Certification", "issuer": "Shopify", "date": "2022-12-05"}, {"name": "Stripe Certified Developer", "issuer": "Stripe", "date": "2023-07-22"}]'::jsonb,
    '[{"title": "Custom Shopify Theme", "description": "High-converting e-commerce theme", "url": "https://github.com/benjamin.anderson/candy-theme", "technologies": ["Liquid", "JavaScript", "Tailwind CSS"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/benjamin.anderson"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/benjamin.anderson"}]'::jsonb
FROM user_profile WHERE username = 'benjamin.anderson';

-- Insert data for Amelia Thomas (guest)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "Hunter College", "degree": "Digital Media", "year": "2020-2024", "gpa": "3.4"}]'::jsonb,
    '[{"company": "Intern", "position": "Web Design Intern", "duration": "2024-Present", "description": "Creating social media graphics"}]'::jsonb,
    '["HTML", "CSS", "Canva", "Adobe Photoshop", "Wix"]'::jsonb,
    '[{"name": "Google Digital Marketing", "issuer": "Google", "date": "2024-05-01"}]'::jsonb,
    '[{"title": "Personal Portfolio", "description": "Digital media showcase", "url": "https://ameliathomas.wixsite.com/portfolio", "technologies": ["Wix", "Canva"]}]'::jsonb,
    '[{"platform": "LinkedIn", "url": "https://linkedin.com/in/amelia.thomas"}, {"platform": "Instagram", "url": "https://instagram.com/amelia.designs"}]'::jsonb
FROM user_profile WHERE username = 'amelia.thomas';

-- Insert data for Lucas Taylor (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "New York University", "degree": "Game Development", "year": "2016-2020", "gpa": "3.5"}]'::jsonb,
    '[{"company": "Indie Studio", "position": "Game Developer", "duration": "2020-Present", "description": "Unity game development"}]'::jsonb,
    '["C#", "Unity", "Blender", "Photoshop", "Git", "Unreal Engine", "3D Modeling"]'::jsonb,
    '[{"name": "Unity Certified Developer", "issuer": "Unity", "date": "2022-04-18"}, {"name": "Unreal Engine Developer", "issuer": "Epic Games", "date": "2023-10-30"}]'::jsonb,
    '[{"title": "Puzzle Adventure Game", "description": "Award-winning indie puzzle game", "url": "https://github.com/lucas.taylor/puzzle-adventure", "technologies": ["Unity", "C#", "Blender"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/lucas.taylor"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/lucas.taylor"}, {"platform": "Itch.io", "url": "https://lucas-taylor.itch.io"}]'::jsonb
FROM user_profile WHERE username = 'lucas.taylor';

-- Insert data for Harper Moore (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "UCLA", "degree": "Information Science", "year": "2018-2022", "gpa": "3.68"}]'::jsonb,
    '[{"company": "Real Estate Office", "position": "Product Manager", "duration": "2022-Present", "description": "PropTech product development"}]'::jsonb,
    '["Product Management", "Jira", "Figma", "SQL", "A/B Testing", "Roadmapping", "Agile"]'::jsonb,
    '[{"name": "Certified Scrum Product Owner", "issuer": "Scrum Alliance", "date": "2023-03-15"}, {"name": "Product Management Certificate", "issuer": "Product School", "date": "2024-01-08"}]'::jsonb,
    '[{"title": "Product Roadmap Template", "description": "Open-source PM templates", "url": "https://github.com/harper.moore/pm-templates", "technologies": ["Notion", "Figma"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/harper.moore"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/harper.moore"}, {"platform": "ProductHunt", "url": "https://producthunt.com/@harper.moore"}]'::jsonb
FROM user_profile WHERE username = 'harper.moore';

-- Insert data for Henry Jackson (admin)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "MIT", "degree": "Computer Science", "year": "2012-2016", "gpa": "3.92"}]'::jsonb,
    '[{"company": "Google", "position": "Engineering Manager", "duration": "2016-Present", "description": "Leading 15-person infrastructure team"}]'::jsonb,
    '["System Design", "Python", "Go", "Kubernetes", "Leadership", "Architecture", "Mentoring"]'::jsonb,
    '[{"name": "AWS Solutions Architect Professional", "issuer": "Amazon", "date": "2021-06-15"}, {"name": "Google Cloud Professional Architect", "issuer": "Google", "date": "2022-09-10"}, {"name": "PMP Certification", "issuer": "PMI", "date": "2020-03-22"}]'::jsonb,
    '[{"title": "Distributed Systems Guide", "description": "Open-source architecture patterns", "url": "https://github.com/henry.jackson/distributed-systems", "technologies": ["Go", "Kubernetes", "gRPC"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/henry.jackson"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/henry.jackson"}, {"platform": "Twitter", "url": "https://twitter.com/henryjackson_dev"}]'::jsonb
FROM user_profile WHERE username = 'henry.jackson';

-- Insert data for Evelyn Martin (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "UC Irvine", "degree": "Cybersecurity", "year": "2019-2023", "gpa": "3.7"}]'::jsonb,
    '[{"company": "Health Startup", "position": "Security Engineer", "duration": "2023-Present", "description": "HIPAA compliance and security audits"}]'::jsonb,
    '["Cybersecurity", "Python", "Penetration Testing", "SIEM", "AWS Security", "Compliance", "Incident Response"]'::jsonb,
    '[{"name": "CompTIA Security+", "issuer": "CompTIA", "date": "2023-05-12"}, {"name": "Certified Ethical Hacker", "issuer": "EC-Council", "date": "2024-02-28"}, {"name": "CISSP", "issuer": "ISC2", "date": "2024-06-01"}]'::jsonb,
    '[{"title": "Security Audit Toolkit", "description": "Automated security scanning tools", "url": "https://github.com/evelyn.martin/security-toolkit", "technologies": ["Python", "Bash", "Docker"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/evelyn.martin"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/evelyn.martin"}]'::jsonb
FROM user_profile WHERE username = 'evelyn.martin';

-- Insert data for Alexander Lee (user)
INSERT INTO user_full_details (user_id, user_school, user_experience, user_skills, user_certificates, user_portfolio, user_links)
SELECT user_id,
    '[{"institution": "SUNY Stony Brook", "degree": "Applied Mathematics & Statistics", "year": "2018-2022", "gpa": "3.75"}]'::jsonb,
    '[{"company": "Fintech Startup", "position": "Quantitative Developer", "duration": "2022-Present", "description": "Algorithmic trading systems"}]'::jsonb,
    '["Python", "R", "C++", "SQL", "Pandas", "NumPy", "Machine Learning", "Bloomberg Terminal"]'::jsonb,
    '[{"name": "CFA Level 1", "issuer": "CFA Institute", "date": "2023-08-20"}, {"name": "Python for Finance", "issuer": "DataCamp", "date": "2022-06-15"}]'::jsonb,
    '[{"title": "Backtesting Framework", "description": "Quantitative trading backtester", "url": "https://github.com/alexander.lee/backtest-engine", "technologies": ["Python", "Pandas", "Plotly"]}]'::jsonb,
    '[{"platform": "GitHub", "url": "https://github.com/alexander.lee"}, {"platform": "LinkedIn", "url": "https://linkedin.com/in/alexander.lee"}, {"platform": "QuantConnect", "url": "https://quantconnect.com/u/alexander.lee"}]'::jsonb
FROM user_profile WHERE username = 'alexander.lee';

-- Verify the inserts
DO $$
DECLARE
    detail_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO detail_count FROM user_full_details;
    RAISE NOTICE 'Total rows in user_full_details: %', detail_count;
END $$;
