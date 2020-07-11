const express = require('express');
const moment = require('moment');
const bcrypt = require('bcryptjs');
const userModel = require('../models/account.model');
const restrict = require('../middlewares/auth.mdw');
const config = require('../config/default.json');

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
router.post('/login', async function(req, res){
  const user=await userModel.singleByUserNameorEmail(req.body.username, req.body.username);
  if(user===null){
    return res.render('vwAccount/login',{
      err: 'Invalid username or password.'
    })
  }
  const rs = bcrypt.compareSync(req.body.password, user.HashPassword);
  if (rs === false) {
    return res.render('vwAccount/login', {
      err: 'Invalid username or password.'
    })
  }
  delete user.HashPassword;
  req.session.isAuthenticated = true;
  req.session.authUser = user;

  const url = req.query.retUrl || '/';
  res.redirect(url);
})

router.post('/logout', restrict, function (req, res) {
  req.session.isAuthenticated = false;
  req.session.authUser = null;
  res.redirect(req.headers.referer);
})

router.get('/register', function(req, res){
  res.render('vwAccount/register');
})
router.post('/register', async function(req, res){
  const DOB=moment(req.body.dob, 'DD/MM/YYYY').format('YYYY-MM-DD');
  const HashPassword=bcrypt.hashSync(req.body.password, config.authentication.saltRounds);
  const entity={
    EmailAdress: req.body.email,
    FullName: req.body.fullname,
    DOB,
    Permission: 5,
    UserName: req.body.username,
    HashPassword,
    Phone: req.body.phone
  }
  await userModel.add(entity);
  res.render('vwAccount/register');
  
})
router.get('/profile', restrict, async function (req, res) {
  console.log(req.session.authUser);
  res.render('vwAccount/profile');
})

router.get('/is-available', async function (req, res) {
  const user = await userModel.singleByUserName(req.query.user);
  if (!user) {
    return res.json(true);
  }

  res.json(false);
})
module.exports = router;