const db = require('../../utils/db');
const TBL_Posts = "posts";
const TBL_Censor = "censorship"

module.exports= {
    allPost1 : function(){
        return db.load(`select p.* , u.FullName from posts p join users u on p.Author=u.UserID  where p.Status= 1`);
    },
    allPost2 : function(){
        return db.load(`select p.* , u.FullName from posts p join users u on p.Author=u.UserID  where p.Status= 2`);
    },
    allPost3 : function(){
        return db.load(`select p.*,u.FullName from posts p JOIN censorship c on p.PostID=c.PostID JOIN users u ON c.UserID=u.UserID`);
    },
    patch : function(entity,condition){
        return db.patch(TBL_Posts, entity ,condition)
    },
    delPosts : function(postid){
        return db.del(TBL_Posts,postid)
    },
    addCensor : function(entity){
        return db.add(TBL_Censor, entity);
    },
    delcensor : function(postsid){
        return db.del(TBL_Censor, postsid);
    }
}