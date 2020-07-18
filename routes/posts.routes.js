const express = require('express');
const productModel = require('../models/categories.model');
const router = express.Router();

router.get('/:PostID', async function (req, res) {
    const list = await productModel.AllbyPost(req.params.PostID);
    res.render('vwPosts/listposts',{
        posts : list,
        empty : list.length ===0 
    });
})

router.get('/byCat/:CatID', async function (req, res) {
    const list = await productModel.AllbyCat(req.params.CatID);
    const list1 = await productModel.CatMostView();
    res.render('vwPosts/listcat',{
        cats : list,
        catmostview : list1,
        empty : list.length === 0 
    });
})
router.get('/detail/:PostID', async function (req, res) {
    const rows = await productModel.single(req.params.PostID);
    res.render('vwPosts/deatail',{
        posts : rows[0]
    });
})
module.exports = router;