const db = require('../utils/db');

module.exports ={
    PostsTrending: function(){
        return db.load(`select * from posts  p order by p.Views desc LIMIT 0,4`);
    },
   
    NewPost : function(){
        return db.load(`SELECT c.CatName,p.Abtract,p.Views,p.Ranks, p.PostDate ,p.HasAvatar,p.BigAvatar           
        from post_categories pc ,posts p , categories c 
        WHERE c.CatID=pc.CatID and pc.PostID= p.PostID 
        group by c.CatName, c.CatID`);
    },
    AllCategories : function(){
        return db.load(`select * from categories`);
    },

    NewpostByCat : function(){
        return db.load(`select * from posts p order by p.PostDate desc limit 0,10`);
    },

    CatMostView : function(){
        return db.load(`select * from posts p order by p.Views desc limit 0,10`);
    },
    AllUsers : function(){
        return db.load(`select * from users`);
    },
    AllbyCat: function(catid){
        return db.load(`SELECT * FROM categories c , post_categories pc , posts p
                            WHERE c.CatID=pc.CatID AND pc.PostID=p.PostID AND c.CatID= ${catid}`);
    }

}