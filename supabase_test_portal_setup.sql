-- Run this in your Supabase SQL Editor to enable the Test Management Portal

CREATE TABLE IF NOT EXISTS test_registry (
    test_id VARCHAR(100) PRIMARY KEY,
    category VARCHAR(50) NOT NULL, -- PYQ, Mock, Chapter, CA
    sub_category VARCHAR(50),      -- Mathematics, GAT, English, etc.
    title TEXT NOT NULL,
    year VARCHAR(10),
    session VARCHAR(10),
    slug VARCHAR(100),
    status VARCHAR(20) DEFAULT 'active', -- 'active' or 'coming_soon'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- OPTIONAL: Disable RLS for easier internal API access (recommended for this setup)
ALTER TABLE test_registry DISABLE ROW LEVEL SECURITY;

-- SEED DATA: PYQs
INSERT INTO test_registry (test_id, category, sub_category, title, year, session, status) VALUES
('pyq_mat_2025_2', 'PYQ', 'Mathematics', 'NDA 2 2025 Mathematics', '2025', '2', 'active'),
('pyq_mat_2025_1', 'PYQ', 'Mathematics', 'NDA 1 2025 Mathematics', '2025', '1', 'coming_soon'),
('pyq_mat_2024_2', 'PYQ', 'Mathematics', 'NDA 2 2024 Mathematics', '2024', '2', 'active'),
('pyq_mat_2024_1', 'PYQ', 'Mathematics', 'NDA 1 2024 Mathematics', '2024', '1', 'active'),
('pyq_mat_2023_2', 'PYQ', 'Mathematics', 'NDA 2 2023 Mathematics', '2023', '2', 'active'),
('pyq_mat_2023_1', 'PYQ', 'Mathematics', 'NDA 1 2023 Mathematics', '2023', '1', 'active'),
('pyq_mat_2022_2', 'PYQ', 'Mathematics', 'NDA 2 2022 Mathematics', '2022', '2', 'active'),
('pyq_mat_2022_1', 'PYQ', 'Mathematics', 'NDA 1 2022 Mathematics', '2022', '1', 'active'),
('pyq_gat_2022_1', 'PYQ', 'GAT', 'NDA 1 2022 GAT', '2022', '1', 'active'),
('pyq_gat_2021_1', 'PYQ', 'GAT', 'NDA 1 2021 GAT', '2021', '1', 'active'),
('pyq_gat_2020_2', 'PYQ', 'GAT', 'NDA 2 2020 GAT', '2020', '2', 'active');

-- SEED DATA: Mocks
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status) VALUES
('mock_mat_ft1', 'Mock', 'Mathematics', 'UPSC NDA 01/2026 FT 1: Mathematics', 'mt01_mat_full_length', 'active'),
('mock_mat_ft2', 'Mock', 'Mathematics', 'UPSC NDA 01/2026 FT 2: Mathematics', 'mt02_mat_full_length', 'active'),
('mock_mat_ft3', 'Mock', 'Mathematics', 'UPSC NDA 01/2026 FT 3: Mathematics', 'mt03_mat_full_length', 'active'),
('mock_gat_ft1', 'Mock', 'GAT', 'UPSC NDA 01/2026 FT 1: General Ability', 'mt01_gat_full_length', 'active'),
('mock_gat_ft2', 'Mock', 'GAT', 'UPSC NDA 01/2026 FT 2: General Ability', 'mt02_gat_full_length', 'active');
