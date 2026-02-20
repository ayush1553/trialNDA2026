-- 1. ACTIVATE EVERYTHING CURRENTLY IN THE REGISTRY
UPDATE test_registry SET status = 'active';

-- 2. MOCK TESTS (1-10 for MAT and GAT)
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('mock_mat_1', 'Mock', 'MAT', 'Mathematics Mock Test 1', 'mat-mock-1', 'active'),
  ('mock_mat_2', 'Mock', 'MAT', 'Mathematics Mock Test 2', 'mat-mock-2', 'active'),
  ('mock_mat_3', 'Mock', 'MAT', 'Mathematics Mock Test 3', 'mat-mock-3', 'active'),
  ('mock_mat_4', 'Mock', 'MAT', 'Mathematics Mock Test 4', 'mat-mock-4', 'active'),
  ('mock_mat_5', 'Mock', 'MAT', 'Mathematics Mock Test 5', 'mat-mock-5', 'active'),
  ('mock_mat_6', 'Mock', 'MAT', 'Mathematics Mock Test 6', 'mat-mock-6', 'active'),
  ('mock_mat_7', 'Mock', 'MAT', 'Mathematics Mock Test 7', 'mat-mock-7', 'active'),
  ('mock_mat_8', 'Mock', 'MAT', 'Mathematics Mock Test 8', 'mat-mock-8', 'active'),
  ('mock_mat_9', 'Mock', 'MAT', 'Mathematics Mock Test 9', 'mat-mock-9', 'active'),
  ('mock_mat_10', 'Mock', 'MAT', 'Mathematics Mock Test 10', 'mat-mock-10', 'active'),
  ('mock_gat_1', 'Mock', 'GAT', 'General Ability Test Mock 1', 'gat-mock-1', 'active'),
  ('mock_gat_2', 'Mock', 'GAT', 'General Ability Test Mock 2', 'gat-mock-2', 'active'),
  ('mock_gat_3', 'Mock', 'GAT', 'General Ability Test Mock 3', 'gat-mock-3', 'active'),
  ('mock_gat_4', 'Mock', 'GAT', 'General Ability Test Mock 4', 'gat-mock-4', 'active'),
  ('mock_gat_5', 'Mock', 'GAT', 'General Ability Test Mock 5', 'gat-mock-5', 'active'),
  ('mock_gat_6', 'Mock', 'GAT', 'General Ability Test Mock 6', 'gat-mock-6', 'active'),
  ('mock_gat_7', 'Mock', 'GAT', 'General Ability Test Mock 7', 'gat-mock-7', 'active'),
  ('mock_gat_8', 'Mock', 'GAT', 'General Ability Test Mock 8', 'gat-mock-8', 'active'),
  ('mock_gat_9', 'Mock', 'GAT', 'General Ability Test Mock 9', 'gat-mock-9', 'active'),
  ('mock_gat_10', 'Mock', 'GAT', 'General Ability Test Mock 10', 'gat-mock-10', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- 3. PREVIOUS YEAR QUESTIONS (2020-2025)
INSERT INTO test_registry (test_id, category, sub_category, title, year, session, status)
VALUES
  ('pyq_mat_2025_1', 'PYQ', 'Mathematics', 'NDA 1 2025 Mathematics', '2025', '1', 'active'),
  ('pyq_mat_2025_2', 'PYQ', 'Mathematics', 'NDA 2 2025 Mathematics', '2025', '2', 'active'),
  ('pyq_mat_2024_1', 'PYQ', 'Mathematics', 'NDA 1 2024 Mathematics', '2024', '1', 'active'),
  ('pyq_mat_2024_2', 'PYQ', 'Mathematics', 'NDA 2 2024 Mathematics', '2024', '2', 'active'),
  ('pyq_mat_2023_1', 'PYQ', 'Mathematics', 'NDA 1 2023 Mathematics', '2023', '1', 'active'),
  ('pyq_mat_2023_2', 'PYQ', 'Mathematics', 'NDA 2 2023 Mathematics', '2023', '2', 'active'),
  ('pyq_mat_2022_1', 'PYQ', 'Mathematics', 'NDA 1 2022 Mathematics', '2022', '1', 'active'),
  ('pyq_mat_2022_2', 'PYQ', 'Mathematics', 'NDA 2 2022 Mathematics', '2022', '2', 'active'),
  ('pyq_mat_2021_1', 'PYQ', 'Mathematics', 'NDA 1 2021 Mathematics', '2021', '1', 'active'),
  ('pyq_mat_2021_2', 'PYQ', 'Mathematics', 'NDA 2 2021 Mathematics', '2021', '2', 'active'),
  ('pyq_mat_2020_1', 'PYQ', 'Mathematics', 'NDA 1 2020 Mathematics', '2020', '1', 'active'),
  ('pyq_mat_2020_2', 'PYQ', 'Mathematics', 'NDA 2 2020 Mathematics', '2020', '2', 'active'),
  ('pyq_gat_2025_1', 'PYQ', 'GAT', 'NDA 1 2025 GAT', '2025', '1', 'active'),
  ('pyq_gat_2025_2', 'PYQ', 'GAT', 'NDA 2 2025 GAT', '2025', '2', 'active'),
  ('pyq_gat_2024_1', 'PYQ', 'GAT', 'NDA 1 2024 GAT', '2024', '1', 'active'),
  ('pyq_gat_2024_2', 'PYQ', 'GAT', 'NDA 2 2024 GAT', '2024', '2', 'active'),
  ('pyq_gat_2023_1', 'PYQ', 'GAT', 'NDA 1 2023 GAT', '2023', '1', 'active'),
  ('pyq_gat_2023_2', 'PYQ', 'GAT', 'NDA 2 2023 GAT', '2023', '2', 'active'),
  ('pyq_gat_2022_1', 'PYQ', 'GAT', 'NDA 1 2022 GAT', '2022', '1', 'active'),
  ('pyq_gat_2022_2', 'PYQ', 'GAT', 'NDA 2 2022 GAT', '2022', '2', 'active'),
  ('pyq_gat_2021_1', 'PYQ', 'GAT', 'NDA 1 2021 GAT', '2021', '1', 'active'),
  ('pyq_gat_2021_2', 'PYQ', 'GAT', 'NDA 2 2021 GAT', '2021', '2', 'active'),
  ('pyq_gat_2020_1', 'PYQ', 'GAT', 'NDA 1 2020 GAT', '2020', '1', 'active'),
  ('pyq_gat_2020_2', 'PYQ', 'GAT', 'NDA 2 2020 GAT', '2020', '2', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- 4. MATHEMATICS CHAPTER TESTS (CT 1 - CT 47)
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_mat_1', 'Chapter', 'Mathematics', 'CT 1: Set Theory & Types of Sets', 'ct01_set_theory_and_types_of_sets', 'active'),
  ('ct_mat_2', 'Chapter', 'Mathematics', 'CT 2: Relations & Functions', 'ct02_relations_and_functions', 'active'),
  ('ct_mat_3', 'Chapter', 'Mathematics', 'CT 3: Complex Numbers', 'ct03_complex_numbers', 'active'),
  ('ct_mat_4', 'Chapter', 'Mathematics', 'CT 4: Binary System', 'ct04_binary_system', 'active'),
  ('ct_mat_5', 'Chapter', 'Mathematics', 'CT 5: Sequence and Series', 'ct05_sequence_and_series', 'active'),
  ('ct_mat_6', 'Chapter', 'Mathematics', 'CT 6: Quadratic Equations', 'ct06_quadratic_equations', 'active'),
  ('ct_mat_7', 'Chapter', 'Mathematics', 'CT 7: Theory of Equations', 'ct07_theory_of_equations', 'active'),
  ('ct_mat_8', 'Chapter', 'Mathematics', 'CT 8: Linear Inequalities', 'ct08_linear_inequalities', 'active'),
  ('ct_mat_9', 'Chapter', 'Mathematics', 'CT 9: Permutation & Combination', 'ct09_permutation_and_combination', 'active'),
  ('ct_mat_10', 'Chapter', 'Mathematics', 'CT 10: Binomial Theorem', 'ct10_binomial_theorem', 'active'),
  ('ct_mat_11', 'Chapter', 'Mathematics', 'CT 11: Logarithms', 'ct11_logarithms', 'active'),
  ('ct_mat_12', 'Chapter', 'Mathematics', 'CT 12: Matrices – I', 'ct12_matrices_1', 'active'),
  ('ct_mat_13', 'Chapter', 'Mathematics', 'CT 13: Matrices – II', 'ct13_matrices_2', 'active'),
  ('ct_mat_14', 'Chapter', 'Mathematics', 'CT 14: Determinants – I', 'ct14_determinants_1', 'active'),
  ('ct_mat_15', 'Chapter', 'Mathematics', 'CT 15: Determinants – II', 'ct15_determinants_2', 'active'),
  ('ct_mat_16', 'Chapter', 'Mathematics', 'CT 16: Trigonometry Fundamentals', 'ct16_trigonometry_fundamentals', 'active'),
  ('ct_mat_17', 'Chapter', 'Mathematics', 'CT 17: Trigonometric Ratios', 'ct17_trigonometric_ratios', 'active'),
  ('ct_mat_18', 'Chapter', 'Mathematics', 'CT 18: Trigonometric Identities', 'ct18_trigonometric_identities', 'active'),
  ('ct_mat_19', 'Chapter', 'Mathematics', 'CT 19: Inverse Trigonometric Functions', 'ct19_inverse_trigonometric_functions', 'active'),
  ('ct_mat_20', 'Chapter', 'Mathematics', 'CT 20: Heights & Distance', 'ct20_heights_and_distance', 'active'),
  ('ct_mat_21', 'Chapter', 'Mathematics', 'CT 21: Lines', 'ct21_lines', 'active'),
  ('ct_mat_22', 'Chapter', 'Mathematics', 'CT 22: Circles', 'ct22_circles', 'active'),
  ('ct_mat_23', 'Chapter', 'Mathematics', 'CT 23: Parabola', 'ct23_parabola', 'active'),
  ('ct_mat_24', 'Chapter', 'Mathematics', 'CT 24: Ellipse', 'ct24_ellipse', 'active'),
  ('ct_mat_25', 'Chapter', 'Mathematics', 'CT 25: Hyperbola', 'ct25_hyperbola', 'active'),
  ('ct_mat_26', 'Chapter', 'Mathematics', 'CT 26: Three Dimensional Geometry – I', 'ct26_three_dimensional_geometry_1', 'active'),
  ('ct_mat_27', 'Chapter', 'Mathematics', 'CT 27: Three Dimensional Geometry – II', 'ct27_three_dimensional_geometry_2', 'active'),
  ('ct_mat_28', 'Chapter', 'Mathematics', 'CT 28: Functions', 'ct28_functions', 'active'),
  ('ct_mat_29', 'Chapter', 'Mathematics', 'CT 29: Limits & Continuity', 'ct29_limits_and_continuity', 'active'),
  ('ct_mat_30', 'Chapter', 'Mathematics', 'CT 30: Continuity & Differentiability', 'ct30_continuity_and_differentiability', 'active'),
  ('ct_mat_31', 'Chapter', 'Mathematics', 'CT 31: Derivatives', 'ct31_derivatives', 'active'),
  ('ct_mat_32', 'Chapter', 'Mathematics', 'CT 32: Tangents & Normals', 'ct32_tangents_and_normals', 'active'),
  ('ct_mat_33', 'Chapter', 'Mathematics', 'CT 33: Maxima & Minima', 'ct33_maxima_and_minima', 'active'),
  ('ct_mat_34', 'Chapter', 'Mathematics', 'CT 34: Indefinite Integrals', 'ct34_indefinite_integrals', 'active'),
  ('ct_mat_35', 'Chapter', 'Mathematics', 'CT 35: Definite Integrals', 'ct35_definite_integrals', 'active'),
  ('ct_mat_36', 'Chapter', 'Mathematics', 'CT 36: Application of Definite Integrals', 'ct36_application_of_definite_integrals', 'active'),
  ('ct_mat_37', 'Chapter', 'Mathematics', 'CT 37: Differential Equations – Order & Degree', 'ct37_differential_equations_order_and_degree', 'active'),
  ('ct_mat_38', 'Chapter', 'Mathematics', 'CT 38: Differential Equations', 'ct38_differential_equations', 'active'),
  ('ct_mat_39', 'Chapter', 'Mathematics', 'CT 39: Vector Algebra', 'ct39_vector_algebra', 'active'),
  ('ct_mat_40', 'Chapter', 'Mathematics', 'CT 40: Vector Algebra – Applications', 'ct40_vector_algebra_applications', 'active'),
  ('ct_mat_41', 'Chapter', 'Mathematics', 'CT 41: Statistics – Frequency', 'ct41_statistics_frequency', 'active'),
  ('ct_mat_42', 'Chapter', 'Mathematics', 'CT 42: Statistics – Graphical Representation', 'ct42_statistics_graphical_representation', 'active'),
  ('ct_mat_43', 'Chapter', 'Mathematics', 'CT 43: Statistics – Measures', 'ct43_statistics_measures', 'active'),
  ('ct_mat_44', 'Chapter', 'Mathematics', 'CT 44: Statistics – Correlation & Regression', 'ct44_statistics_correlation_and_regression', 'active'),
  ('ct_mat_45', 'Chapter', 'Mathematics', 'CT 45: Probability – Events & Outcomes', 'ct45_probability_events_and_outcomes', 'active'),
  ('ct_mat_46', 'Chapter', 'Mathematics', 'CT 46: Probability – Theorems & Conditional Probability', 'ct46_probability_theorems_and_conditional_probability', 'active'),
  ('ct_mat_47', 'Chapter', 'Mathematics', 'CT 47: Probability – Random Variable & Binomial Distribution', 'ct47_probability_random_variable_and_binomial_distribution', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- 5. GAT CHAPTER TESTS
-- Physics
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_phy_1', 'Chapter', 'Physics', 'CT 1: Units & Dimensions', 'ct01_units_and_dimensions', 'active'),
  ('ct_phy_2', 'Chapter', 'Physics', 'CT 2: Vectors', 'ct02_vectors', 'active'),
  ('ct_phy_3', 'Chapter', 'Physics', 'CT 3: Motion in 1D', 'ct03_motion_in_1d', 'active'),
  ('ct_phy_4', 'Chapter', 'Physics', 'CT 4: Motion in 2D', 'ct04_motion_in_2d', 'active'),
  ('ct_phy_5', 'Chapter', 'Physics', 'CT 5: Newton’s Laws of Motion', 'ct05_newtons_laws_of_motion', 'active'),
  ('ct_phy_6', 'Chapter', 'Physics', 'CT 6: Work, Energy & Power', 'ct06_work_energy_and_power', 'active'),
  ('ct_phy_7', 'Chapter', 'Physics', 'CT 7: Properties of Matter', 'ct07_properties_of_matter', 'active'),
  ('ct_phy_8', 'Chapter', 'Physics', 'CT 8: Gravitation', 'ct08_gravitation', 'active'),
  ('ct_phy_9', 'Chapter', 'Physics', 'CT 9: Basics of Rotational Dynamics', 'ct09_basics_of_rotational_dynamics', 'active'),
  ('ct_phy_10', 'Chapter', 'Physics', 'CT 10: Heat & Calorimetry', 'ct10_heat_and_calorimetry', 'active'),
  ('ct_phy_11', 'Chapter', 'Physics', 'CT 11: Electrostatics', 'ct11_electrostatics', 'active'),
  ('ct_phy_12', 'Chapter', 'Physics', 'CT 12: Electromagnetism – I', 'ct12_electromagnetism_1', 'active'),
  ('ct_phy_13', 'Chapter', 'Physics', 'CT 13: Electromagnetism – II', 'ct13_electromagnetism_2', 'active'),
  ('ct_phy_14', 'Chapter', 'Physics', 'CT 14: General Appliances & Instruments', 'ct14_general_appliances_and_instruments', 'active'),
  ('ct_phy_15', 'Chapter', 'Physics', 'CT 15: Optics', 'ct15_optics', 'active'),
  ('ct_phy_16', 'Chapter', 'Physics', 'CT 16: Modern Physics', 'ct16_modern_physics', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- English
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_eng_1', 'Chapter', 'English', 'CT 1: Conditional Sentences & Basic Verb Errors', 'ct01_Conditional_Sentences_and_Basic_Verb_Errors', 'active'),
  ('ct_eng_2', 'Chapter', 'English', 'CT 2: Causative Verbs & Perfect Tense Errors', 'ct02_Causative_Verbs_and_Perfect_Tense_Errors', 'active'),
  ('ct_eng_3', 'Chapter', 'English', 'CT 3: Verb Patterns & Time Expressions', 'ct03_Verb_Patterns_and_Time_Expressions', 'active'),
  ('ct_eng_4', 'Chapter', 'English', 'CT 4: Parts of Speech & Word Function', 'ct04_Parts of Speech and_Word_Function_Identification', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- Chemistry
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_chem_1', 'Chapter', 'Chemistry', 'CT 1: Physical & Chemical Changes', 'ct01_physical_and_chemical_changes', 'active'),
  ('ct_chem_2', 'Chapter', 'Chemistry', 'CT 2: Elements, Mixtures & Compounds', 'ct02_elements_mixtures_and_compounds', 'active'),
  ('ct_chem_3', 'Chapter', 'Chemistry', 'CT 3: Laws of Chemical Combination', 'ct03_laws_of_chemical_combination', 'active'),
  ('ct_chem_4', 'Chapter', 'Chemistry', 'CT 4: Atomic Structure I', 'ct04_Atomic_Structure', 'active'),
  ('ct_chem_5', 'Chapter', 'Chemistry', 'CT 5: Atomic Structure II', 'ct05_Atomic_Structure', 'active'),
  ('ct_chem_6', 'Chapter', 'Chemistry', 'CT 6: Atomic Structure III', 'ct06_Atomic_Structure', 'active'),
  ('ct_chem_7', 'Chapter', 'Chemistry', 'CT 7: Periodic Classification', 'ct07_Periodic_Classification', 'active'),
  ('ct_chem_8', 'Chapter', 'Chemistry', 'CT 8: Periodic Properties', 'ct08_Periodic_Properties', 'active'),
  ('ct_chem_9', 'Chapter', 'Chemistry', 'CT 9: Chemical Bonding', 'ct09_Chemical_Bonding', 'active'),
  ('ct_chem_10', 'Chapter', 'Chemistry', 'CT 10: Mole Concept I', 'ct10_Mole_Concept', 'active'),
  ('ct_chem_11', 'Chapter', 'Chemistry', 'CT 11: Mole Concept II', 'ct11_Mole_Concept_II', 'active'),
  ('ct_chem_12', 'Chapter', 'Chemistry', 'CT 12: Redox Reaction', 'ct12_Redox_Reaction', 'active'),
  ('ct_chem_13', 'Chapter', 'Chemistry', 'CT 13: Electrochemistry', 'ct13_Electrochemistry', 'active'),
  ('ct_chem_14', 'Chapter', 'Chemistry', 'CT 14: Nomenclature of Carbon Compounds', 'ct14_Nomenclature_of_Carbon_Compounds', 'active'),
  ('ct_chem_15', 'Chapter', 'Chemistry', 'CT 15: Non-Metals & Their Compounds I', 'ct15_Non-Metals_and_Their_Compounds', 'active'),
  ('ct_chem_16', 'Chapter', 'Chemistry', 'CT 16: Non-Metals & Their Compounds II', 'ct16_Non-Metals_and_Their_Compounds', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- History
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_hist_1', 'Chapter', 'History', 'CT 1: Indus Valley Civilization', 'ct01_Indus_Valley_Civilization', 'active'),
  ('ct_hist_2', 'Chapter', 'History', 'CT 2: Vedic Civilization', 'ct02_Vedic_Civilization', 'active'),
  ('ct_hist_3', 'Chapter', 'History', 'CT 3: Religious Movements', 'ct03_Religious_Movements', 'active'),
  ('ct_hist_4', 'Chapter', 'History', 'CT 4: Mahajanpass & Foreign Invasions', 'ct04_Mahajanpads_Foreign_Invasions', 'active'),
  ('ct_hist_5', 'Chapter', 'History', 'CT 5: Mauryan Empire I', 'ct05_Mauryan_Empire', 'active'),
  ('ct_hist_6', 'Chapter', 'History', 'CT 6: Mauryan Empire II', 'ct06_Mauryan_Empire', 'active'),
  ('ct_hist_7', 'Chapter', 'History', 'CT 7: Mauryan Empire III', 'ct07_Mauryan_Empire2', 'active'),
  ('ct_hist_8', 'Chapter', 'History', 'CT 8: Gupta Empire', 'ct08_Gupta_Empire', 'active'),
  ('ct_hist_9', 'Chapter', 'History', 'CT 9: Post Mauryan Age', 'ct09_Post_Mauryan_Age', 'active'),
  ('ct_hist_10', 'Chapter', 'History', 'CT 10: Gupta Empire II', 'ct10_Gupta_Empire2', 'active'),
  ('ct_hist_11', 'Chapter', 'History', 'CT 11: Wardhan Dynasty', 'c11_Wardhan_Dynasty', 'active'),
  ('ct_hist_12', 'Chapter', 'History', 'CT 12: Pallava Chalukya & Architecture', 'ct12_Pallava_Chalukya_Conflict_and_Temple_Architecture', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- Polity
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_pol_1', 'Chapter', 'Polity', 'CT 1: Features of Indian Constitution', 'ct01_Features_of_the_Indian_Constitution', 'active'),
  ('ct_pol_2', 'Chapter', 'Polity', 'CT 2: Philosophy of Indian Constitution', 'ct02_Philosophy_of_the_Indian_Constitution', 'active'),
  ('ct_pol_3', 'Chapter', 'Polity', 'CT 3: Preamble', 'ct03_Preamble_of_the_Indian_Constitution', 'active'),
  ('ct_pol_4', 'Chapter', 'Polity', 'CT 4: Fundamental Rights', 'ct04_Fundamental_Rights', 'active'),
  ('ct_pol_5', 'Chapter', 'Polity', 'CT 5: Constitutional Remedies & Duties', 'ct05_Right_to_Constitutional_Remedies_and_Fundamental_Duties', 'active'),
  ('ct_pol_6', 'Chapter', 'Polity', 'CT 6: Union, Territory & Citizenship', 'ct06_Union_and_its_Territory_Citizenship', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- Economy
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_eco_1', 'Chapter', 'Economy', 'CT 1: Govt Schemes & Budget', 'ct01_Important_Government_Schemes_and_Budget', 'active'),
  ('ct_eco_2', 'Chapter', 'Economy', 'CT 2: Int. Orgs & Financial Institutions', 'ct02_International_Organizations_and_Financial_Institutions', 'active'),
  ('ct_eco_3', 'Chapter', 'Economy', 'CT 3: Intro to Economics & National Income', 'ct03_Introduction_to_Economics_and_National_Income', 'active'),
  ('ct_eco_4', 'Chapter', 'Economy', 'CT 4: Monetary Policy & Banking', 'ct04_Monetary_Policy_and_Banking_System_in_India', 'active'),
  ('ct_eco_5', 'Chapter', 'Economy', 'CT 5: Planning in India', 'ct05_Planning_in_India', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- Geography
INSERT INTO test_registry (test_id, category, sub_category, title, slug, status)
VALUES
  ('ct_geo_1', 'Chapter', 'Geography', 'CT 1: Universe & Solar System', 'ct01_Origin_of_the_Universe_and_Solar_System', 'active'),
  ('ct_geo_2', 'Chapter', 'Geography', 'CT 2: Solar System & Earth in Space', 'ct02_Solar_System_and_Earth_in_Space', 'active'),
  ('ct_geo_3', 'Chapter', 'Geography', 'CT 3: Interior Structure of Earth', 'ct03_Interior_Structure_of_the_Earth', 'active'),
  ('ct_geo_4', 'Chapter', 'Geography', 'CT 4: Drift Theory & Plate Tectonics', 'ct04_Continental_Drift_Theory_and_Plate_Tectonics', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';

-- 6. CURRENT AFFAIRS (Mapping numeric IDs from HTML)
INSERT INTO test_registry (test_id, category, sub_category, title, status)
VALUES
  ('301', 'CA', 'Monthly', 'January 2026 - Week 1', 'active'),
  ('302', 'CA', 'Monthly', 'January 2026 - Week 2', 'active'),
  ('303', 'CA', 'Monthly', 'January 2026 - Week 3', 'active'),
  ('304', 'CA', 'Monthly', 'January 2026 - Week 4', 'active'),
  ('101', 'CA', 'Daily', '19th February 2026 - Daily Updates', 'active')
ON CONFLICT (test_id) DO UPDATE SET status = 'active';
