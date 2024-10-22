CREATE DATABASE helpdesk_db;

USE helpdesk_db;

-- Users table for storing operators, technicians, and admins
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL, 
    role ENUM('operator', 'technician', 'admin') NOT NULL,
    full_name VARCHAR(100),
    contact_phone VARCHAR(15),
    email VARCHAR(100)
);

-- Offices table for storing office details
CREATE TABLE offices (
    office_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    contact_phone VARCHAR(15),
    specialisation VARCHAR(100)
);

-- Employees table for storing employee details
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    office_id INT,
    name VARCHAR(100),
    contact_phone VARCHAR(15),
    email VARCHAR(100),
    start_date DATE,
    end_date DATE,
    job_title VARCHAR(50),
    department VARCHAR(50),
    FOREIGN KEY (office_id) REFERENCES offices(office_id)
);

-- Equipment register for hardware and software
CREATE TABLE equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    office_id INT,
    serial_number VARCHAR(50),
    equipment_type VARCHAR(50), -- e.g., PC, Laptop, Printer, etc.
    make VARCHAR(50),
    model VARCHAR(50),
    manufacturer VARCHAR(50),
    warranty_expiry_date DATE,
    software_licence_number VARCHAR(50),
    software_type VARCHAR(50),
    FOREIGN KEY (office_id) REFERENCES offices(office_id)
);

-- Helpdesk call logs
CREATE TABLE helpdesk_calls (
    call_id INT AUTO_INCREMENT PRIMARY KEY,
    caller_id INT,
    operator_id INT,
    call_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    problem_description TEXT,
    equipment_id INT,
    operating_system VARCHAR(50),
    software_used VARCHAR(50),
    status ENUM('open', 'closed') DEFAULT 'open',
    FOREIGN KEY (caller_id) REFERENCES employees(employee_id),
    FOREIGN KEY (operator_id) REFERENCES users(user_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

-- Problems table for managing issues assigned to technicians
CREATE TABLE problems (
    problem_id INT AUTO_INCREMENT PRIMARY KEY,
    call_id INT,
    technician_id INT,
    problem_type VARCHAR(100), -- e.g., hardware issue, software issue, etc.
    assigned_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolution_time TIMESTAMP,
    resolution_description TEXT,
    time_taken FLOAT, -- Time taken to resolve in hours
    status ENUM('open', 'closed') DEFAULT 'open',
    FOREIGN KEY (call_id) REFERENCES helpdesk_calls(call_id),
    FOREIGN KEY (technician_id) REFERENCES users(user_id)
);
