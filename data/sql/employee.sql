CREATE TABLE IF NOT EXISTS `employee` (
	`employee_id` BIGINT(10) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
	`first_name` VARCHAR(100) NOT NULL DEFAULT '',
    `middle_name` VARCHAR(50) NOT NULL DEFAULT '',
    `last_name` VARCHAR(50) NOT NULL DEFAULT '',
    `is_active` BOOLEAN NOT NULL DEFAULT true,
--     `employment_status` ENUM('full-time', 'part-time','contractual') NOT NULL DEFAULT 'contractual',
    `identification_number` VARCHAR(9) NOT NULL DEFAULT '' UNIQUE KEY,
    `email_address` VARCHAR(100) NOT NULL DEFAULT '',
    `phone_number` VARCHAR(100) NOT NULL DEFAULT '',
    `mobile_number` VARCHAR(50) NOT NULL DEFAULT '',
    `address` VARCHAR(255) NOT NULL DEFAULT '',
    `social_security_number` VARCHAR(50) NOT NULL DEFAULT '',
    `taxpayer_identification_number` VARCHAR(50) NOT NULL DEFAULT '',
    `philhealth_number` VARCHAR(50) NOT NULL DEFAULT '',
    `hmdf_number` VARCHAR(50) NOT NULL DEFAULT '',
    `umid_crn` VARCHAR(50) NOT NULL DEFAULT '',
    `date_hired` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX (employee_id, identification_number),
    UNIQUE KEY (first_name, middle_name, last_name)
) Engine=InnoDB;



CREATE TABLE IF NOT EXISTS `contact_person` (
    `employee_id` VARCHAR(9) NOT NULL DEFAULT '0000-0000',
    `first_name` VARCHAR(100) NOT NULL DEFAULT '',
    `middle_name` VARCHAR(50) NOT NULL DEFAULT '',
    `last_name` VARCHAR(50) NOT NULL DEFAULT '',
    `email_address` VARCHAR(100) NOT NULL DEFAULT '',
    `phone_number` VARCHAR(100) NOT NULL DEFAULT '',
    `mobile_number` VARCHAR(50) NOT NULL DEFAULT '',
    `address` VARCHAR(255) NOT NULL DEFAULT '',
    `relation` VARCHAR(50) NOT NULL DEFAULT '',
    FOREIGN KEY (employee_id)
            REFERENCES employee (employee_id)
            ON UPDATE CASCADE 
            ON DELETE CASCADE
) ENGINE=InnoDB;



CREATE TABLE IF NOT EXISTS `job_position` (
    `job_id` INT(10) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `title` VARCHAR(100) NOT NULL DEFAULT '' UNIQUE KEY,
    `is_executive` TINYINT(1) SIGNED NOT NULL DEFAULT 0,
    `is_manager` TINYINT(1) SIGNED NOT NULL DEFAULT 0,
    INDEX job_title (job_id, title),
    INDEX executive_title (job_id, title, is_executive),
    INDEX manager_title (job_id, title, is_manager)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `department` (
    `department_id` INT(10) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL DEFAULT '' UNIQUE KEY,
    INDEX (department_id, name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `branch` (
    `branch_id` INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL DEFAULT '' UNIQUE KEY,
    INDEX (branch_id, name)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `employee_branch_department` (
    `ebd_id` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     `employee_id` BIGINT(10) UNSIGNED NOT NULL,
    `identification_number` VARCHAR(9) NOT NULL DEFAULT '' UNIQUE KEY,
    `branch_id` INT(10) UNSIGNED NOT NULL,
    `department_id` INT(10) UNSIGNED NOT NULL,
    UNIQUE KEY (identification_number, branch_id, department_id),
    INDEX department_branch (department_id, branch_id),
    INDEX branch_employees (identification_number, branch_id),
    INDEX department_employees (identification_number, department_id),
    FOREIGN KEY (identification_number) REFERENCES employee (identification_number) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (branch_id) REFERENCES branch (branch_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (department_id) REFERENCES department (department_id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

