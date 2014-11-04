CREATE DATABASE IF NOT EXISTS `mot_data`;

USE `mot_data`;

CREATE TABLE IF NOT EXISTS `employee` (
	`employee_id` BIGINT(10) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
	`first_name` VARCHAR(100) NOT NULL DEFAULT '',
    `middle_name` VARCHAR(50) NOT NULL DEFAULT '',
    `last_name` VARCHAR(50) NOT NULL DEFAULT '',
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `employment_status` ENUM('full-time', 'part-time','contractual') NOT NULL DEFAULT 'contractual',
    `identification_number` VARCHAR(9) NOT NULL DEFAULT '',
    `email_address` VARCHAR(100) NOT NULL DEFAULT '',
    `phone_number` VARCHAR(100) NOT NULL DEFAULT '',
    `mobile_number` VARCHAR(50) NOT NULL DEFAULT '',
    `address` VARCHAR(255) NOT NULL DEFAULT '',
    `date_hired` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX (employee_id, identification_number),
    UNIQUE KEY (first_name, middle_name, last_name),
    UNIQUE KEY (identification_number)
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS `goverment_information` (
    `gov_id` BIGINT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `identification_number` VARCHAR(9) NOT NULL DEFAULT '',
    `social_security_number` VARCHAR(50) NOT NULL DEFAULT '',
    `taxpayer_identification_number` VARCHAR(50) NOT NULL DEFAULT '',
    `philhealth_number` VARCHAR(50) NOT NULL DEFAULT '',
    `hmdf_number` VARCHAR(50) NOT NULL DEFAULT '',
    `umid_crn` VARCHAR(50) NOT NULL DEFAULT '',
    UNIQUE KEY (identification_number),
    UNIQUE KEY (social_security_number),
    UNIQUE KEY (taxpayer_identification_number),
    UNIQUE KEY (philhealth_number),
    UNIQUE KEY (hmdf_number),
    UNIQUE KEY (umid_crn),
    FOREIGN KEY (identification_number) REFERENCES employee (identification_number) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;
 

CREATE TABLE IF NOT EXISTS `contact_person` (
    `identification_number` VARCHAR(9) NOT NULL DEFAULT '',
    `first_name` VARCHAR(100) NOT NULL DEFAULT '',
    `middle_name` VARCHAR(50) NOT NULL DEFAULT '',
    `last_name` VARCHAR(50) NOT NULL DEFAULT '',
    `email_address` VARCHAR(100) NOT NULL DEFAULT '',
    `phone_number` VARCHAR(100) NOT NULL DEFAULT '',
    `mobile_number` VARCHAR(50) NOT NULL DEFAULT '',
    `address` VARCHAR(255) NOT NULL DEFAULT '',
    `relation` VARCHAR(50) NOT NULL DEFAULT '',
    FOREIGN KEY (identification_number) REFERENCES employee (identification_number) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `job_position` (
    `job_id` INT(10) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `job_code` VARCHAR(30) NOT NULL DEFAULT '',
    `title` VARCHAR(150) NOT NULL DEFAULT '',
    `is_executive` TINYINT(1) SIGNED NOT NULL DEFAULT 0,
    `is_manager` TINYINT(1) SIGNED NOT NULL DEFAULT 0,
    INDEX job_id (job_id, job_code),
    INDEX code_title (job_code, title),
    INDEX executive_title (job_code, title, is_executive),
    INDEX manager_title (job_code, title, is_manager)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `department` (
    `dept_id` INT(10) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `dept_code` VARCHAR(10) NOT NULL DEFAULT '',
    `dept_name` VARCHAR(100) NOT NULL DEFAULT '',
    UNIQUE KEY (dept_code, dept_name),
    INDEX dept_id (dept_id, dept_code),
    INDEX code_name (dept_code, dept_name)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `branch` (
    `branch_id` INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `branch_code` VARCHAR(10) NOT NULL DEFAULT '', 
    `branch_name` VARCHAR(100) NOT NULL DEFAULT '',
    UNIQUE KEY (branch_code, branch_name),    
    INDEX branch_id (branch_id, branch_code),
    INDEX code_name (branch_code, branch_name)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `branch_department` (
    `bd_id` BIGINT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `branch_code` VARCHAR(20) NOT NULL DEFAULT '',
    `dept_code` VARCHAR(10) NOT NULL DEFAULT '',
    UNIQUE KEY (branch_code, dept_code),
    INDEX branch_dept_id (bd_id, branch_code, dept_code),
    FOREIGN KEY (branch_code) REFERENCES branch (branch_code) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (dept_code) REFERENCES department (dept_code) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `employee_branch_department` (
    `ebd_id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `identification_number` VARCHAR(9) NOT NULL DEFAULT '',
    `branch_code` VARCHAR(10) NOT NULL DEFAULT '', 
    `dept_code` VARCHAR(10) NOT NULL DEFAULT '',
    INDEX department_branch (dept_code, branch_code),
    INDEX branch_employees (identification_number, branch_code),
    INDEX department_employees (identification_number, dept_code),
    FOREIGN KEY (identification_number) REFERENCES employee (identification_number) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (branch_code) REFERENCES branch (branch_code) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (dept_code) REFERENCES department (dept_code) ON UPDATE CASCADE ON DELETE RESTRICT,
    UNIQUE KEY (identification_number, branch_code, dept_code)
) ENGINE=InnoDB;