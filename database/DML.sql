use cs340_clarkr2;
-- Patients
-- 1. Insert Statement (@ character being used to denote the variables that will have data from the backend programming language)
INSERT INTO Patients(name, age, race, sex, address, phone)
VALUES (
    @name,
    @age,
    @race,
    @sex,
    @address,
    @phone
  );

-- 2. Select Statement (Visible on browser as "____ List")
SELECT *
FROM Patients;

-- EmergencyPhysicians 
-- 1. Insert Statement
INSERT INTO EmergencyPhysicians (name, credential)
VALUES (@name, @credential);

-- 2. Select Statement
SELECT *
FROM EmergencyPhysicians;

-- 3. Select Physicians of a visit
SELECT *
      FROM EmergencyPhysicians
        INNER JOIN EDVisitPhysicians ON
        EmergencyPhysicians.emergency_physician_id = EDVisitPhysicians.emergency_physician_id
      WHERE 
        EDVisitPhysicians.ed_visit_id = @ed_visit_id

-- EmergencyDepartments
-- 1. Insert Statement
INSERT INTO EmergencyDepartments (hospital_name, address, phone, capacity)
VALUES (
    @hospital_name,
    @address,
    @phone,
    @capacity
  );

-- 2. Select Statement
SELECT *
FROM EmergencyDepartments;

-- HospitalRegions
-- 1. Insert Statement
INSERT INTO HospitalRegions (county, geographical_region_served)
VALUES (@county, @geographical_region_served);

-- 2. Select Statement
SELECT *
FROM HospitalRegions;

-- EDVisits
-- 1. Insert Statement
INSERT INTO EDVisits (
    emergency_department_id,
    patient_id,
    treatment_id,
    date_of_visit,
    admit_time
  )
VALUES (
    @emergency_department_id,
    @patient_id,
    @treatment_id,
    @date_of_visit,
    @admit_time
  );

-- 2. Select Statement
SELECT *
  FROM EDVisits 
    INNER JOIN Patients ON EDVisits.patient_id = Patients.patient_id
    INNER JOIN EmergencyDepartments ON EDVisits.emergency_department_id = EmergencyDepartments.emergency_department_id
    LEFT OUTER JOIN Treatments ON EDVisits.treatment_id = Treatments.treatment_id

-- 3. Update Statement (To be synced up with EDVisits edit button)
UPDATE EDVisits
  SET
    emergency_department_id = @emergency_department_id,
    patient_id = @patient_id,
    treatment_id = @treatment_id,
    date_of_visit =  @date_of_visit,
    admit_time = @admit_time;

-- EDVisitPhysicians
-- 1. Insert Statement
INSERT INTO EDVisitPhysicians (
    ed_visit_id,
    emergency_physician_id
  )
VALUES (
    @ed_visit_id,
    @emergency_physician_id
  );

-- 2. Select Statement
SELECT *
FROM EDVisitPhysicians;

-- 3. Delete Statement (Remove physician from visit if needed, to be synced up with x buttons if needed)
DELETE FROM EDVisitPhysicians
WHERE ed_visit_id = @ed_visit_id
AND   ed_visit_physician_id = @ed_visit_physician_id;

-- Treatments
-- 1. Insert Statement
INSERT INTO Treatments(
    treatment_name
  )
VALUES (
    @treatment_name
  );

-- 2. Select Statement
SELECT *
FROM Treatments;



