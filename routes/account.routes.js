const express = require('express');
// const moment = require('moment');
// const bcrypt = require('bcryptjs');
// const userModel = require('../models/user.model');
// const restrict = require('../middlewares/auth.mdw');
// const config = require('../config/default.json');

const router = express.Router();

router.get('/login', function (req, res) {
  res.render('vwAccount/login');
})

module.exports = router;