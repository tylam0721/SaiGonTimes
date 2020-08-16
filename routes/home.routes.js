const express=require('express');
const catModel=require('../models/categories.model');
const postModel=require('../models/posts.model');
const { post } = require('./posts.routes');
const router=express.Router();

router.get('/',async function(req, res){
  
    const listCat=await catModel.all();
    const listPost = await postModel.allPostsDetail();
    const listOfweek= await postModel.topPostWeek();
    res.render('home',{
        categories: listCat,
        posts: listPost,
        postofweek: listOfweek
    });
})

module.exports = router;