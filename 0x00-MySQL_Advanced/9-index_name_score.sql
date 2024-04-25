-- Task 9: Create an index on the first letter of name and score
CREATE INDEX idx_name_first_score ON names (LEFT(name, 1), score);
