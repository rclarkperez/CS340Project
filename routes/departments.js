const express = require("express");
const db = require("../database/db-connector");
const router = express.Router();

router.get("/api/departments", async (req, res) => {
  const query = `
  SELECT *
  FROM EmergencyDepartments 
  `;
  const [departments] = await db.pool.query(query);
  res.json(departments);
});

module.exports = router;
