const express = require("express");
const db = require("../database/db-connector");
const router = express.Router();

router.get("/api/physicians", async (req, res) => {
  const query = `
  SELECT *
  FROM EmergencyPhysicians 
  `;
  const [physicians] = await db.pool.query(query);
  res.json(physicians);
});

module.exports = router;
