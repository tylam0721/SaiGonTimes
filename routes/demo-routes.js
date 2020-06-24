const express = require('express');

const router = express.Router();

router.get('/about', async function (req, res) {
  res.render('vwDemo/about');
});
router.post('/about', async function(req, res){
  console.log('An love Ty');
});
module.exports = router;