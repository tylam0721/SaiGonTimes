const express = require('express');

const router = express.Router();

router.get('/about', async function (req, res) {
  res.render('vwDemo/about');
})

module.exports = router;