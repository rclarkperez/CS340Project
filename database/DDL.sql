DROP DATABASE IF EXISTS patient_physician_db;
CREATE DATABASE patient_physician_db;
USE patient_physician_db;

-- Create Patients table

CREATE TABLE `Patients`(
  `patient_id` int(250) UNIQUE NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `age` int(11) NOT NULL,
  `race` varchar(50) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  PRIMARY KEY (`patient_id`)
);

-- Create EmergencyPhysicians table

CREATE TABLE `EmergencyPhysicians` (
  `emergency_physician_id` int(250) UNIQUE NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `credential` varchar(11) NOT NULL,
  PRIMARY KEY (`emergency_physician_id`)
);

-- Create HospitalRegions table

CREATE  TABLE `HospitalRegions`(
  `hospital_region_id` int(250) UNIQUE NOT NULL AUTO_INCREMENT,
  `county_name` varchar(250) NOT NULL,
  `geographical_region_served` varchar(250) NOT NULL,
   PRIMARY KEY (`hospital_region_id`)
);

-- Create EmergencyDepartments table

CREATE  TABLE `EmergencyDepartments` (
  `emergency_department_id` int(250) UNIQUE NOT NULL AUTO_INCREMENT,
  `hospital_region_id` int(250) NOT NULL,
  `hospital_name` varchar(250) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `capacity` int(10) NOT NULL,
  PRIMARY KEY (`emergency_department_id`),
  FOREIGN KEY (`hospital_region_id`) REFERENCES HospitalRegions(`hospital_region_id`)
);

-- Create Treatments table

CREATE TABLE `Treatments` (
  `treatment_id` int(250) UNIQUE NOT NULL AUTO_INCREMENT,
  `treatment_name` varchar(255) NOT NULL,
  PRIMARY KEY (`treatment_id`)
);

-- Create EDVisits table

CREATE  TABLE `EDVisits` (
  `ed_visit_id` int(250) UNIQUE NOT NULL AUTO_INCREMENT,
  `emergency_department_id` int(250) NOT NULL,
  `patient_id` int(250) NOT NULL,
  `treatment_id` int(250),
  `date_of_visit` date DEFAULT NULL,
  `admit_time` time DEFAULT NULL,
  PRIMARY KEY (`ed_visit_id`),
  FOREIGN KEY (`emergency_department_id`) REFERENCES EmergencyDepartments(`emergency_department_id`),
  FOREIGN KEY (`patient_id`) REFERENCES Patients(`patient_id`),
  FOREIGN KEY (`treatment_id`) REFERENCES Treatments(`treatment_id`) ON DELETE SET NULL
);

-- Create EDVisitPhysicians table

CREATE  TABLE `EDVisitPhysicians` (
  `ed_visit_physician_id` int(250) UNIQUE NOT NULL AUTO_INCREMENT,
  `ed_visit_id` int(250) NOT NULL,
  `emergency_physician_id` int(250) NOT NULL,
  PRIMARY KEY (`ed_visit_physician_id`),
  FOREIGN KEY (`ed_visit_id`) REFERENCES EDVisits(`ed_visit_id`),
  FOREIGN KEY (`emergency_physician_id`) REFERENCES EmergencyPhysicians(`emergency_physician_id`)
);

-- Sample data Patients

INSERT INTO `Patients` 
VALUES (1,'George Castanza', 32, 'Hispanic','Male','2225 NW Broadway, New York, New York, 10282', '555-555-5555'), 
(2, 'Jerry Seindfeld', 31, 'White', 'Male', '2222 NW Broadway, New York, New York, 10282', '555-555-5555'),
(3,'Cosmo Kramer', 38, 'Declined','Male','2223 NW Broadway, New York, New York, 10282', '555-555-5555');

-- Sample data EmergencyPhysicians

INSERT INTO `EmergencyPhysicians`
VALUES (1,'Gregory House', 'DO'), (2, 'Dr Grey', 'DO'), (3,'Emmett Brown', 'Other');

-- Sample data HospitalRegions

INSERT INTO `HospitalRegions` 
VALUES (1,'Turner', 'NE'),  (2, 'Clark', 'NW'), (3,'Cook', 'MW');

-- Sample data EmergencyDepartments

INSERT INTO `EmergencyDepartments` 
VALUES (1, 1 ,'Princeton-Plainsboro','4421 State St, Princeton, New Jersey, 08542', '888-541-9104', 150), (2, 2 ,'Portland-Vancouver' ,'4001 State St, Portland, Oregon, 98771', '888-541-9104', 150), (3, 3 ,'Chicago-Metro','900 Prince Crossing Rd, Chicago, Illinois, 60185', '681-441-9205', 170);

-- Sample data EDVisitPhysicians

INSERT INTO `Treatments` 
VALUES (1,'Placebo'),(2,'Morphine'),(3,'Oxycodone');
-- Sample data EDVisits

INSERT INTO `EDVisits` 
VALUES (1,1,1,1, '2007-01-01', '12:30:30'),(2,2,2,2, '2008-02-01', '12:45:30'), (3,3,3,3, '2008-03-02', '12:50:30');

-- Sample data EDVisitPhysicians

INSERT INTO `EDVisitPhysicians` 
VALUES (1,1,1),(2,1,2),(3,2,1);

