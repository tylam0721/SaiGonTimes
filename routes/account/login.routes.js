const express=require('express');
const router=express.Router();
const userModel=('../../models/account.model.js');
const bcrypt = require('bcryptjs');
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

module.exports=router;