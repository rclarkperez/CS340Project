const express = require("express");
const db = require("../database/db-connector");
const router = express.Router();

router.get("/api/visits", async (req, res) => {
  const query = `
  SELECT *
  FROM EDVisits 
    INNER JOIN Patients ON EDVisits.patient_id = Patients.patient_id
    INNER JOIN EmergencyDepartments ON EDVisits.emergency_department_id = EmergencyDepartments.emergency_department_id
    LEFT OUTER JOIN Treatments ON EDVisits.treatment_id = Treatments.treatment_id
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

router.put("/api/visits/:id", async (req, res) => {
  const { id } = req.params;

  const date = new Date(Date.parse(req.body.date_of_visit));

  await db.pool.query(
    `
    UPDATE EDVisits
    SET
      emergency_department_id = ?,
      patient_id = ?,
      treatment_id = ?,
      date_of_visit = ?,
      admit_time = ?
    WHERE
      ed_visit_id = ?;
  `,
    [
      req.body.emergency_department_id,
      req.body.patient_id,
      req.body.treatment_id,
      `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`,
      req.body.admit_time,
      id,
    ]
  );

  await db.pool.query(
    `
    DELETE FROM EDVisitPhysicians WHERE ed_visit_id = ?
  `,
    [id]
  );

  for (const ed_visit_physician_id of req.body.ed_visit_physician_ids) {
    await db.pool.query(
      `
      INSERT INTO EDVisitPhysicians(ed_visit_id, emergency_physician_id)
      VALUES(?, ?)
    `,
      [id, ed_visit_physician_id]
    );
  }

  res.json({ message: "Visit updated successfully!" });
});

module.exports = router;
