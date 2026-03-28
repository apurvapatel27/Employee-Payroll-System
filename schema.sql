-- ============================================================
-- PayrollSystem Database Schema
-- Database: payroll_db
-- Run this file in MySQL Workbench or MySQL CLI before deploying
-- WARNING: This will DROP and recreate payroll_db cleanly.
-- ============================================================

DROP DATABASE IF EXISTS payroll_db;
CREATE DATABASE payroll_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE payroll_db;

-- ----------------------
-- Table: admin
-- ----------------------
CREATE TABLE IF NOT EXISTS admin (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50)  NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    email       VARCHAR(100),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------
-- Table: departments
-- ----------------------
CREATE TABLE IF NOT EXISTS departments (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------
-- Table: employees
-- ----------------------
-- NOTE: If you already have payroll_db and DON'T want to drop it,
-- run this manually instead:
--   ALTER TABLE employees ADD COLUMN IF NOT EXISTS password VARCHAR(100) NOT NULL DEFAULT 'emp123';
CREATE TABLE IF NOT EXISTS employees (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    emp_code      VARCHAR(20)  NOT NULL UNIQUE,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100),
    phone         VARCHAR(20),
    department_id INT,
    designation   VARCHAR(100),
    basic_salary  DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    join_date     DATE,
    status        ENUM('Active','Inactive') DEFAULT 'Active',
    password      VARCHAR(100) NOT NULL DEFAULT 'emp123',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
);

-- ----------------------
-- Table: payroll
-- ----------------------
CREATE TABLE IF NOT EXISTS payroll (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    employee_id   INT NOT NULL,
    month         INT NOT NULL,
    year          INT NOT NULL,
    basic_salary  DECIMAL(10,2) NOT NULL,
    hra           DECIMAL(10,2) NOT NULL,
    da            DECIMAL(10,2) NOT NULL,
    gross_salary  DECIMAL(10,2) NOT NULL,
    pf            DECIMAL(10,2) NOT NULL,
    tax           DECIMAL(10,2) NOT NULL,
    net_salary    DECIMAL(10,2) NOT NULL,
    generated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE,
    UNIQUE KEY uk_payroll (employee_id, month, year)
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- Admin account  (username: admin | password: admin123)
INSERT IGNORE INTO admin (username, password, email) VALUES
('admin', 'admin123', 'admin@payroll.com');

-- Departments
INSERT IGNORE INTO departments (name, description) VALUES
('Engineering',      'Software development and IT operations'),
('Human Resources',  'HR management and recruitment'),
('Finance',          'Financial management and accounting'),
('Marketing',        'Marketing and brand management'),
('Operations',       'Business operations and logistics');

-- Employees
INSERT IGNORE INTO employees
    (emp_code, first_name, last_name, email, phone, department_id, designation, basic_salary, join_date, status)
VALUES
('EMP001','Raj',    'Sharma','raj.sharma@company.com',   '9876543210',1,'Senior Developer', 75000.00,'2021-03-15','Active'),
('EMP002','Priya',  'Patel', 'priya.patel@company.com',  '9876543211',2,'HR Manager',        60000.00,'2020-06-01','Active'),
('EMP003','Amit',   'Kumar', 'amit.kumar@company.com',   '9876543212',3,'Finance Analyst',   55000.00,'2022-01-10','Active'),
('EMP004','Sneha',  'Gupta', 'sneha.gupta@company.com',  '9876543213',1,'Junior Developer',  45000.00,'2023-07-20','Active'),
('EMP005','Vikram', 'Singh', 'vikram.singh@company.com', '9876543214',4,'Marketing Executive',50000.00,'2021-11-05','Active'),
('EMP006','Anita',  'Desai', 'anita.desai@company.com',  '9876543215',5,'Operations Manager',65000.00,'2020-02-14','Active'),
('EMP007','Ravi',   'Tiwari','ravi.tiwari@company.com',  '9876543216',1,'Tech Lead',         90000.00,'2019-08-01','Active'),
('EMP008','Meena',  'Joshi', 'meena.joshi@company.com',  '9876543217',3,'Senior Accountant', 58000.00,'2021-04-22','Inactive');
