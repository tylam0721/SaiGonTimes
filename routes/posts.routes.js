const express = require('express');
const catModel = require('../models/categories.model');
const postModel=require('../models/posts.model');
const router = express.Router();
const moment=require('moment');
const commentModel=require('../models/comment.model');
const { json } = require('body-parser');
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
        //catmostview : list1,
        empty : list.length === 0 
    });
    
})
router.get('/bySubCat/:CatID', async function (req, res) {
    const list = await postModel.allSubByCat(req.params.CatID);
    const list1 = await catModel.CatMostView();
    res.render('vwPosts/byCat',{
        posts : list,
        catmostview : list1,
        empty : list.length === 0 
    });
})
router.get('/detail/:postID', async function(req, res){
    const rows=await postModel.single(req.params.postID);
    const listTag=await postModel.allTagOfPost(req.params.postID);
    const allComment=await commentModel.all(req.params.postID);
    res.render('vwPosts/detail', {
        layout: false,
        post: rows[0],
        tag: listTag,
        comment: allComment
    });
    
    postModel.updateViews(req.params.postID);
  })
router.get('/byTag/:TagID', async function(req, res){
    const list = await postModel.allByTag(req.params.TagID);
    
    res.render('vwPosts/byTag',{
        posts : list,
        empty : list.length === 0 
    });
    
})
router.post('/comment',async function(req,res){
    var info=""
    try {
        info=JSON.parse(req.body.info);
    } catch (error) {
        
    }
    const currendate=moment().format("YYYY-MM-DDTHH:mm:ss");
    const content=info.dataSend.comment;
    const user=info.dataSend.User;
    console.log(info);
    console.log(currendate);
    const entity={
        User: user,
        PostID: info.dataSend.postID,
        Commentcontent: content,
        CommentDate: currendate
    }
    

    commentModel.add(entity);

    const Comment=await commentModel.single();
    res.status(200).send(Comment);
})
module.exports = router;``