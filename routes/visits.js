const express = require("express");
const db = require("../database/db-connector");
const router = express.Router();

router.get("/api/visits", async (req, res) => {
  const query = `
  SELECT *
  FROM EDVisits 
    INNER JOIN Patients ON EDVisits.patient_id = Patients.patient_id
    INNER JOIN EmergencyDepartments ON EDVisits.emergency_department_id = EmergencyDepartments.emergency_department_id
  `;
  const [visits] = await db.pool.query(query);

  for (const visit of visits) {
    const query = `
      SELECT *
      FROM EmergencyPhysicians
        INNER JOIN EDVisitPhysicians ON
        EmergencyPhysicians.emergency_physician_id = EDVisitPhysicians.emergency_physician_id
      WHERE 
        EDVisitPhysicians.ed_visit_id = ?
    `;
    const [physicians] = await db.pool.query(query, [visit.ed_visit_id]);

    visit.physicians = physicians;
  }

  res.json(visits);
});

module.exports = router;
