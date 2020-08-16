const express = require('express');
const userModel = require('../../models/Admin/admin_qlser.model');
const router = express.Router();

router.get('/', function(req , res){
    res.render('vwadmin/home',{layout : "mainAdmin"});
})

router.get('/users', async function (req, res) {
    const list = await userModel.all();
    const per = await userModel.allPer();
    const assign = await userModel.assign();
    const editor = await userModel.editor();
    const tag = await userModel.Tag();
    // for(let i = 0; i < assign.length; i++) {
    //     assign[i].editor = editor;
    // }
    res.render('vwadmin/QLuser',{
        layout: false,
        permission : per,
        users : list,
        editors: editor,
        assign: assign,
        Tag : tag,
        empty : list.length ===0 
    });
})

router.get('/users/guest', async function (req, res) {
   const Guest= await userModel.Guest();
    res.render('vwadmin/Guest',{
        layout: false,
        guest : Guest,
        empty : Guest.length ===0 
    });
})

router.get('/del/:UserID/:status', async function(req,res){
    const status = req.params.status;
    const condition = {
        UserID : req.params.UserID
    }
    let x
    if(status == 0) 
        x = 1
    else 
        x= 0
    const entity = {
        Status : x
    }
    await userModel.patch(entity,condition);
    res.redirect('/admin/users');
})


router.post('/users/update', async function(req,res){
    const entity ={
        Permission : req.body.permission
    }
    const condition ={
        UserID : req.body.UserID
    }
    await userModel.patch(entity,condition);
    res.redirect('/admin/users');
})

router.post('/users/assign', async function(req,res){
    const entity ={
        Editor : req.body.editorass
    }
    const condition ={
        CatID : req.body.catidass
    }
    await userModel.patchCat(entity,condition);
    res.redirect('/admin/users');
})

router.post('/users/addtag', async function(req,res){
    const entity = {
        Name : req.body.tagname
    }
    await userModel.addtag(entity);
    res.redirect('/admin/users');
})

router.post('/users/EditTag', async function(req,res){
    const condition = {
        TagID : req.body.tagid
    }
    const entity = {
        Name : req.body.tagname
    }
    await userModel.edittag(entity,condition);
    res.redirect('/admin/users');
})

router.post('/users/GuestTimeEnd', async function(req,res){
    const condition = {
        TagID : req.body.tagid
    }
    const entity = {
        Name : req.body.tagname
    }
    await userModel.GuestTimeEnd(entity,condition);
    res.redirect('/admin/users');
})





module.exports = router;