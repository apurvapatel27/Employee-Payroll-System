-- Run this if you already have payroll_db set up and don't want to drop everything.
-- This adds the employee password column with default value 'emp123'.

USE payroll_db;

ALTER TABLE employees
    ADD COLUMN IF NOT EXISTS password VARCHAR(100) NOT NULL DEFAULT 'emp123';

-- Verify it worked:
SELECT emp_code, first_name, last_name, password FROM employees;
