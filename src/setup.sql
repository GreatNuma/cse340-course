-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- ========================================
-- Service Project Table
-- ========================================
CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organization(organization_id),
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(150) NOT NULL,
    date DATE NOT NULL
);

-- ========================================
-- Insert sample data: Service Projects
-- ========================================
INSERT INTO project (organization_id, title, description, location, date)
VALUES
-- BrightFuture Builders (organization_id = 1)
(1, 'Community Center Renovation', 'Renovating the local community center to provide a safe gathering space for residents.', 'Rexburg, ID', '2026-03-15'),
(1, 'Accessible Playground Build', 'Constructing a wheelchair-accessible playground for children of all abilities.', 'Idaho Falls, ID', '2026-04-02'),
(1, 'Affordable Housing Repair', 'Repairing homes for low-income families in need of critical maintenance.', 'Blackfoot, ID', '2026-04-20'),
(1, 'Public Library Expansion', 'Adding a new wing to the public library to support growing community needs.', 'Rigby, ID', '2026-05-10'),
(1, 'Senior Center Roof Replacement', 'Replacing the aging roof at the senior center to prevent water damage.', 'Sugar City, ID', '2026-06-01'),

-- GreenHarvest Growers (organization_id = 2)
(2, 'Urban Community Garden', 'Establishing a community garden to provide fresh produce for local families.', 'Rexburg, ID', '2026-03-22'),
(2, 'School Garden Program', 'Teaching students how to grow their own vegetables in a school garden.', 'Idaho Falls, ID', '2026-04-05'),
(2, 'Composting Workshop Series', 'Hosting workshops to teach composting techniques to reduce food waste.', 'Rigby, ID', '2026-04-18'),
(2, 'Farmers Market Support', 'Assisting local farmers in setting up and running a weekly farmers market.', 'Blackfoot, ID', '2026-05-15'),
(2, 'Food Bank Garden Donation', 'Growing produce specifically to donate to the local food bank.', 'Sugar City, ID', '2026-06-08'),

-- UnityServe Volunteers (organization_id = 3)
(3, 'Homeless Shelter Meal Service', 'Coordinating volunteers to prepare and serve meals at the homeless shelter.', 'Idaho Falls, ID', '2026-03-10'),
(3, 'Winter Coat Drive', 'Collecting and distributing winter coats to families in need.', 'Rexburg, ID', '2026-03-28'),
(3, 'Reading Buddies Tutoring', 'Pairing volunteers with elementary students for weekly reading support.', 'Rigby, ID', '2026-04-12'),
(3, 'Disaster Relief Training', 'Training volunteers in emergency response and disaster relief procedures.', 'Blackfoot, ID', '2026-05-01'),
(3, 'Community Clean-Up Day', 'Organizing volunteers to clean up parks and public spaces around town.', 'Sugar City, ID', '2026-05-20');

-- ========================================
-- Category Table
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- ========================================
-- Project-Category Junction Table
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER NOT NULL REFERENCES project(project_id),
    category_id INTEGER NOT NULL REFERENCES category(category_id),
    PRIMARY KEY (project_id, category_id)
);

-- ========================================
-- Insert sample data: Categories
-- ========================================
INSERT INTO category (name)
VALUES
('Environmental'),
('Educational'),
('Community Service'),
('Health and Wellness');

-- ========================================
-- Insert sample data: Project-Category Associations
-- ========================================
INSERT INTO project_category (project_id, category_id)
VALUES
(1, 3),  -- Community Center Renovation -> Community Service
(2, 3),  -- Accessible Playground Build -> Community Service
(3, 3),  -- Affordable Housing Repair -> Community Service
(4, 2),  -- Public Library Expansion -> Educational
(5, 4),  -- Senior Center Roof Replacement -> Health and Wellness
(6, 1),  -- Urban Community Garden -> Environmental
(7, 2),  -- School Garden Program -> Educational
(8, 1),  -- Composting Workshop Series -> Environmental
(9, 3),  -- Farmers Market Support -> Community Service
(10, 1), -- Food Bank Garden Donation -> Environmental
(11, 4), -- Homeless Shelter Meal Service -> Health and Wellness
(12, 3), -- Winter Coat Drive -> Community Service
(13, 2), -- Reading Buddies Tutoring -> Educational
(14, 4), -- Disaster Relief Training -> Health and Wellness
(15, 3); -- Community Clean-Up Day -> Community Service