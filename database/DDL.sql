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
VALUES (1,'Gayle C. White', 32, 'Hispanic','Female','2924 Hickman Street, Los Angeles, California, 60515', '202-918-2132'), 
(2, 'Jerry Seindfeld', 31, 'White', 'Male', '2222 NW Broadway, New York, New York, 10282', '316-569-5275'),
(3,'Cosmo Kramer', 38, 'Declined','Male','93 Bastin Drive, Miami, Florida, 10282', '472-285-0188');
(4,'Jesus N. Taulbee', 22, 'Hispani','Male','1519 Stone Lane, Tremont, Pennsylvania, 17981', '472-251-5051');
(5,'Doris R. Harris', 74, 'Declined','Female','3952 Ash Street, Arlington, Texas, 10282', '472-274-4819');

-- Sample data EmergencyPhysicians

INSERT INTO `EmergencyPhysicians`
VALUES (1,'John Smith', 'DO'), 
(2, 'Katy Price', 'MD'), 
(3,'Mary Jones', 'DO'), 
(4,'Jason Brown', 'MD'),
(5,'Lisa Miller', 'MD');

-- Sample data HospitalRegions

INSERT INTO `HospitalRegions` 
VALUES (1,'Turner', 'NE'),  
(2, 'Clark', 'NW'), 
(3,'Rabun', 'SW'),
(4, 'Bamberg', 'SW'), 
(5, 'Laramie ', 'NE'), 
(6, 'Harlan ', 'SE'),;

-- Sample data EmergencyDepartments

INSERT INTO `EmergencyDepartments` 
VALUES (1, 1 ,'Princeton-Plainsboro','4421 State St, Princeton, New Jersey, 08542', '888-541-9104', 120), 
(2, 1 ,'Portland-Vancouver' ,'4001 State St, Portland, Oregon, 98771', '888-541-9104', 150), 
(3, 2 ,'Chicago-Metro','900 Prince Crossing Rd, Chicago, Illinois, 60185', '681-441-9205', 170),
(4, 2 ,'Houston-Methodist','6565 Fannin St, Houston, Texas, 77030', '713-790-3311', 100), 
(5, 3 ,'Santa Clara Valley Medical Center','751 S. Bascom Ave, San Jose, California, 95128', '408-885-5000', 220)
(6, 3 ,'Jackson Memorial Hospital','1611 NW 12th Ave, Miami, Florida, 33136', '305-585-1111', 250);

-- Sample data EDVisitPhysicians

INSERT INTO `Treatments` 
VALUES (1,'Tramadol'),
(2,'Morphine'),
(3,'Oxycodone')
(4,'Aspirin')
(5,'Epinephrine')
(6,'Glucose');
-- Sample data EDVisits

INSERT INTO `EDVisits` 
VALUES (1,1,1,1, '2007-01-01', '12:30:30'),
(2,2,2,2, '2008-02-01', '05:45:00'), 
(3,3,3,3, '2008-03-02', '18:14:04'),
(4,4,3,3, '2008-03-02', '22:00:55'),
(5,5,3,3, '2008-03-02', '03:11:51'),
(6,6,3,3, '2008-03-02', '10:49:24');

-- Sample data EDVisitPhysicians

INSERT INTO `EDVisitPhysicians` 
VALUES (1,1,1),
(2,1,2),
(3,2,1),
(4,1,2),
(5,1,2),
(6,1,2);

