const express=require('express');
const catModel=require('../models/categories.model');
const postModel=require('../models/posts.model');
const router=express.Router();

router.get('/',async function(req, res){
  
    const listCat=await catModel.all();
    const listPost = await postModel.allPostsDetail();
    res.render('home',{
        categories: listCat,
        posts: listPost
    });
})

module.exports = router;