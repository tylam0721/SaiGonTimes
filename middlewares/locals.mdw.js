const catModel=require('../models/categories.model');
const postModel=require('../models/posts.model');

module.exports=function(app){
    app.use(function(req,res,next){
        if(req.session.isAutheticated==null){
            req.session.isAutheticated=false;
        }
        res.locals.lcIsAuthenticated = req.session.isAuthenticated;
        res.locals.lcAuthUser = req.session.authUser;
        next();
    })
    app.use(async function(req,res,next){
        const list= await catModel.all();
        const listdetail=await catModel.allWithDetails();
        res.locals.lcAllcatdetail=listdetail;
        res.locals.lcCategories=list;
        next();
    })
    app.use(async function(req,res,next){
        const listview= await postModel.topMostView();
        const listdate=await postModel.topPostWeek();
        const listnewest=await postModel.topLastest();
        const allPost=await postModel.allPostsDetail();
        res.locals.lcTopviewposts=listview;
        res.locals.lcTopnewposts=listdate;
        res.locals.lcLatestpost=listnewest;
        res.locals.lcAllpost=allPost;

        next();
    })
}