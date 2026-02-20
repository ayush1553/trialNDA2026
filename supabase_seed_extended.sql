-- Seed Chapter Tests (Mathematics)
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_mat_sets', 'Chapter', 'Mathematics', 'Sets, Relations and Functions', 'sets-relations-functions', 'active'),
  ('ct_mat_trig', 'Chapter', 'Mathematics', 'Trigonometry', 'trigonometry', 'active'),
  ('ct_mat_determinants', 'Chapter', 'Mathematics', 'Determinants and Matrices', 'determinants-matrices', 'active'),
  ('ct_mat_diff', 'Chapter', 'Mathematics', 'Differential Calculus', 'differential-calculus', 'coming_soon');

-- Seed Chapter Tests (GAT - English)
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_gat_eng_spot', 'Chapter', 'English', 'Spotting Errors', 'spotting-errors', 'active'),
  ('ct_gat_eng_syn', 'Chapter', 'English', 'Synonyms', 'synonyms', 'active'),
  ('ct_gat_eng_ant', 'Chapter', 'English', 'Antonyms', 'antonyms', 'active');

-- Seed Current Affairs (Daily)
INSERT INTO test_registry (test_id, category, sub_category, title, status)
VALUES
  ('ca_daily_feb20', 'CA', 'Daily', '20 Feb 2026 Daily Quiz', 'active'),
  ('ca_daily_feb19', 'CA', 'Daily', '19 Feb 2026 Daily Quiz', 'active'),
  ('ca_monthly_jan26', 'CA', 'Monthly', 'January 2026 Monthly Roundup', 'coming_soon');
