const express = require('express');
const publish = require('../../models/Admin/admin_publish.model');
const { addCensor } = require('../../models/Admin/admin_publish.model');

const router = express.Router();

router.get('/', function(req , res){
    res.render('vwadmin/home',{layout : "mainAdmin"});
})

router.get('/publish/post1', async function(req , res){
    const allposts = await publish.allPost1();
    res.render('vwadmin/Publish/QLPublish1', {
        allpost1 : allposts,  
    });
})

router.get('/publish/post2', async function(req , res){
    const allposts = await publish.allPost2();
    res.render('vwadmin/Publish/QLPublish2', {
        allpost2 : allposts,  
    });
})

router.get('/publish/post3', async function(req , res){
    const allposts = await publish.allPost3();
    res.render('vwadmin/Publish/QLPublish3', {
        allpost3 : allposts,  
    });
})

router.post('/publish/cancel', async function(req , res){
    const condition ={
        PostID : req.body.postid
    }
    const entityy ={
        Status : 3
    }
    const entity = {
        PostID : req.body.postid,
        UserID : req.body.userid,
        StatusID : 3,
        Date : req.body.postdate,   
        Reason : req.body.reason
    }
    await publish.patch(entityy,condition);
    await publish.addCensor(entity);
    res.redirect('/admin/publish/post1');
})

router.get('/publish/success2/:postid', async function(req , res){
    const condition ={
        PostID : req.params.postid
    }
    const entityy ={
        Status : 1
    }
    await publish.patch(entityy,condition);
    res.redirect('/admin/publish/post2');
})


router.get('/publish/success3/:postid', async function(req , res){
    const condition ={
        PostID : req.params.postid
    }
    const entityy ={
        Status : 1
    }
    await publish.patch(entityy,condition);
    await publish.delcensor(condition);
    res.redirect('/admin/publish/post3');
})
module.exports = router;