const express = require('express');
const productModel = require('../models/categories.model');
const router = express.Router();

router.get('/categories/:CatID', async function (req, res) {
    const list = productModel.AllbyCat(req.param.CatID);
    res.render('vwCategories/list',{
        list : list,
        empty : list.lenght ===0 
    });
})

module.exports = router;