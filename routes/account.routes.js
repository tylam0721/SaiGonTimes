const express = require('express');
const moment = require('moment');
const bcrypt = require('bcryptjs');
const userModel = require('../models/account.model');
const restrict = require('../middlewares/auth.mdw');
const config = require('../config/default.json');
const mailer=require('../misc/mailer');
const router = express.Router();
const randomstring=require('randomstring');
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

router.post('/logout', restrict, function (req, res) {
  req.session.isAuthenticated = false;
  req.session.authUser = null;
  res.redirect(req.headers.referer);
})
//register
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
    Phone: req.body.phone,
    
    // Ty handsome did it:
    Ranks: 0,
    NickName: '',
    Status: 1,
    Avatar: '',
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
  const HashPassword=bcrypt.hashSync(req.body.password, config.authentication.saltRounds);
  const entity={
    EmailAdress: req.body.email,
    FullName: req.body.fullname,
    DOB,
    Permission: req.body.Permission,
    UserName: req.body.username,
    HashPassword,
    Phone: req.body.phone
  }
  await userModel.add(entity);
  res.render('vwAccount/profile');
  
})
router.get('/is-available', async function (req, res) {
  const user = await userModel.singleByUserName(req.query.user);
  if (!user) {
    return res.json(true);
  }

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
router.post('/identify',async function(req, res,next){
  const token=randomstring.generate({
    length: 6,
    charset: 'numeric'
  })
  //const user=userModel.single(req.body.email);
  const html = `Dear <br/>
                Please verify your Email  bty typing the following token: <br/>
                Token: <b>${token}</b></br> on the Follwing page: <br/>
                <a href="http://localhost:3000/account/verify">http://localhost:3000/account/verify</a>
                <br/><br/>
                Have a pleasant day.`
   await mailer.sendEmail('admin@gmail.com', req.body.email, 'please check your email', html);
   req.flash('success', 'please check your email!');
   res.redirect('/account/identify');
   res.locals.lcOtp=token;
   
})
router.get('/verify', function(req,res){
  res.render('vwAccount/verify',{
    layout: false
  })
})
router.post('/verify', function(req, res){
  const message='hello';
  const check=false;
  if(req.body.otpcode==lcOtp)
  {
    check=true;
    res.render('vwAccount/reset')
  }
  
})
// //reset
// router.get('/reset', function(req, res){

// })
// router.post('/reset', function(req, res){

// })
// //premium
// router.get('/premium', function(req, res){

// })
// router.post('/premium', function(req, res){

// })
module.exports = router;