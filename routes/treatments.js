const express = require("express");
const db = require("../database/db-connector");
const router = express.Router();

router.get("/api/treatments", async (req, res) => {
  const query = `
  SELECT *
  FROM Treatments 
  `;
  const [treatments] = await db.pool.query(query);
  res.json(treatments);
});

module.exports = router;
