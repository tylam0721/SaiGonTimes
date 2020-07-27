const express = require('express');
const catModel = require('../models/categories.model');
const postModel=require('../models/posts.model');
const router = express.Router();

// router.get('/:PostID', async function (req, res) {
//     const list = await postModel.AllbyPost(req.params.PostID);
//     res.render('vwPosts/listposts',{
//         posts : list,
//         empty : list.length ===0 
//     });
// })

router.get('/byCat/:CatID', async function (req, res) {
    const list = await postModel.allByCat(req.params.CatID);
    const list1 = await catModel.CatMostView();
    res.render('vwPosts/byCat',{
        posts : list,
        catmostview : list1,
        empty : list.length === 0 
    });
})
router.get('/detail/:postID', async function(req, res){
    const rows=await postModel.single(req.params.postID);
    
    res.render('vwPosts/detail', {
        layout: false,
        post: rows[0],
    
    });
    postModel.updateViews(req.params.postID);
  })

module.exports = router;