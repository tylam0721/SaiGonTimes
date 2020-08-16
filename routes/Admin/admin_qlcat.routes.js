const express = require('express');
const catModel = require('../../models/Admin/admin_qlcat.model');
const { route } = require('./admin_qluser.routes');
const router = express.Router();

router.get('/', function(req , res){
    res.render('vwadmin/home', {layout : "mainAdmin"});
})

router.get('/categories/:catid', async function (req, res) {
    // const list = await catModel.all();
    
    for(const c of res.locals.lccategories)
    {
        if(c.CatID === +req.params.catid)
        c.isActive = true;
    }
    const list = await catModel.Allbycat(req.params.catid);
    const list1 = await catModel.loadCat();
    res.render('vwadmin/QLCat',{
        layout: false,
        allbycat : list,
        loadcat : list1,
        empty : list1.length ===0 
    });
})

// route.get('categories/del/:subid', async function(req,res){
//     await catModel.del(req.params.subid);
//     res.redirect('/admin/categories/1')
// })
router.post('/categories/update', async function(req,res){
    const entity ={
        SubCatName : req.body.SubCatName
    }
    const condition ={
        SubCatID : req.body.SubCatID,
    }
    await catModel.patch(entity,condition);
    res.redirect(`/admin/categories/1`);
})


router.post('/categories/add', async function(req,res){
    const entity = {
        CatID : req.body.CatID,
        SubCatName : req.body.SubCatName
    }
    await catModel.AddSubCat(entity);
    res.redirect(`/admin/categories/${entity.CatID}`);
})  

router.post('/categories/AddCat', async function(req,res){
    const entity = {
        CatName : req.body.CatName
    } 
    await catModel.AddCAt(entity);
    res.redirect(`/admin/categories/1`);
})  

router.get('/categories/del/:catid/:subid', async function(req,res){
    await catModel.del(req.params.subid);
    res.redirect(`/admin/categories/${req.params.catid}`);
})

module.exports = router;