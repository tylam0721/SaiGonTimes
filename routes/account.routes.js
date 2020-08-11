const express = require('express');
const moment = require('moment');
const bcrypt = require('bcryptjs');
const userModel = require('../models/account.model');
const restrict = require('../middlewares/auth.mdw');
const config = require('../config/default.json');
const mailer=require('../misc/mailer');
const router = express.Router();
const randomstring=require('randomstring');
const premium=require('../models/premium.model');
const { route } = require('./home.routes');
//login area
router.get('/login', function (req, res) {

  res.render('vwAccount/login')
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
//logout area
router.post('/logout', restrict, function (req, res) {
  req.session.isAuthenticated = false;
  req.session.authUser = null;
  res.redirect(req.headers.referer);
})
//register area
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
    Ranks: 0,
    NickName:'',
    Phone: req.body.phone
  }
  await userModel.add(entity);
  res.render('vwAccount/register');
  
})
//profile
router.get('/profile/:userID', restrict, async function (req, res) {
  const rows=await userModel.single(req.params.userID);
  res.render('vwAccount/profile',{
    user: rows[0]

  });
})
router.post('/profile/update', async function(req, res){
  const DOB=moment(req.body.dob, 'DD/MM/YYYY').format('YYYY-MM-DD');
  const entity={
    UserID:req.body.UserID,
    EmailAdress: req.body.email,
    FullName: req.body.fullname,
    DOB,
    UserName: req.body.username,
    Phone: req.body.phone
  }
  console.log(entity);
  await userModel.patch(entity);
  res.render('vwAccount/profile');
  
})
router.get('/is-available', async function (req, res) {
  
  const useremail=null;
  const userByEmail=null;
  
  
  if(req.query.user)
  {
    const  user = await userModel.singleByUserName(req.query.user);
    if (!user) {
      return res.json(true);
    }
    // if(useremail){
    //   return res.json(true);
    // }
    
  }
  
  // if(req.query.id){
  //   useremail = await userModel.singleByUserNameorEmail(req.query.id,req.query.id);
  // }
  else if(req.query.userEmail)
  {
    userByEmail = await userModel.singleByUserNameorEmail(req.query.userEmail,req.query.userEmail);
    if(userByEmail){
      return res.json(true);
    }
  }
  // if (!user) {
  //   return res.json(true);
  // }
  // if(useremail){
  //   return res.json(true);
  // }
  res.json(false);
})
//otp verify
router.get('/identify' , function(req,res){
  res.render('vwAccount/identify',
    {
      layout: false
    }
    );
  
})
router.post('/identify',async function(req, res){
  const token=randomstring.generate({
    length: 6,
    charset: 'numeric'
  });
  const rowsuser=await userModel.singleByUserNameorEmail(req.body.email,req.body.email);
  id=rowsuser.UserID.toString();
  
  const html = `Dear <br/>
                Please verify your Email  bty typing the following token: <br/>
                Token: <h3><b>${token}</b></h3></br> on the Follwing page: <br/>
                <a href="http://localhost:3000/account/verify/${id}">http://localhost:3000/account/verify</a>
                <br/><br/>
                Have a pleasant day.`
  await mailer.sendEmail('admin@gmail.com', req.body.email,'please check your mail', html);
  
  const entity={
    UserID: id,
    otpverify: token
  }
  
  await userModel.patch(entity);
  
  const url = req.query.retUrl || '/';
  res.redirect('/account/identify');

})
//check - otp code
router.post('/check-otp',async function(req, res){
  var info="";
  try {
    info=JSON.parse(req.body.info);
  } catch (error) {
    
  }
  var message="";
  
  const user=await userModel.single(info.dataSend.id);
  const otpCode=info.dataSend.otpCode;
  const userri=user[0];

  if(otpCode!=userri.otpverify)
  {
    message="invalid otpcode";
  }
  else{
    message="check passed";
  }
  res.status(200).send(message);
})
router.get('/verify/:user', async function(req,res){
  const getUser=await userModel.single(req.params.user);

  res.render('vwAccount/verify',{
    layout: false,
    user: getUser[0]
  })
  
})
router.post('/verify/:user', function(req,res){
  const url='/account/reset/'+req.params.user;
  //console.log('xxxx');
  res.redirect(url);
})
// //reset
router.get('/reset/:id', async function(req, res){
  const usersing= await userModel.single(req.params.id);
  res.render('vwAccount/reset',{
    layout: false,
    isEmpty: usersing.length===0,
    user: usersing[0]
  })
})

//check old password old user
router.get('/is-availablepass', async function(req, res){
  var info="";
  try {
    info=JSON.parse(req.body.info);
  } catch (error) {
    
  }
  var message="";
  
  const user=await userModel.single(info.dataSend.id);
  const otpCode=info.dataSend.otpCode;
  const userri=user[0];

  if(otpCode!=userri.otpverify)
  {
    message="invalid otpcode";
  }
  else{
    message="check passed";
  }
  res.status(200).send(message);
  // const user = await userModel.single(req.query.id)
  // const check=bcrypt.compareSync(req.body.oldPass, user.HashPassword)
  // if(check===false)
  // {
  //   return res.json(false)
  // }
  // res.json(true);
})
// save new passs
router.post('/reset', async function(req, res){
  const user=await userModel.singleByUserNameorEmail(req.body.username, req.body.username);
  if(user===null){
    return res.render('vwAccount/reset',{
      err: 'Invalid username or password.'
    })
  }
  const rs = bcrypt.compareSync(req.body.password, user.HashPassword);
  if (rs === false) {
    return res.render('vwAccount/reset', {
      err: 'Invalid password.'
    })
  }
  const pass=bcrypt.hashSync(req.body.newPass, config.saltRounds);
  const entity={
    UserId: req.params.id,
    HashPassword:pass
  }
  userModel.patch(entity);
  res.redirect('/');
})

// //premium
router.get('/premium', function(req, res){
  res.render('vwAccount/premium');
})
router.post('/premium', function(req, res){
  const date=moment().add(7,'days').format('YYYY-MM-DD');
  var id=parseInt(req.body.User)
  entity={
    UserID: id,
    TimeEnd: date
  }
  premium.insert(entity);
  res.redirect('/');
})
module.exports = router;