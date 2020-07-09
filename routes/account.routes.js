const express = require('express');
const mostview = require('../models/categories.model');
// const moment = require('moment');
// const bcrypt = require('bcryptjs');
// const userModel = require('../models/user.model');
// const restrict = require('../middlewares/auth.mdw');
// const config = require('../config/default.json');

const router = express.Router();

router.get('/login', async function (req, res) {
  const list = await mostview.CatMostView();
  const list1 = await mostview.NewPost();
  res.render('vwAccount/login',{
    catmostview : list,
    newpostbycat : list1,
    empty : list.lenght ===0 
  });
})


module.exports = router;