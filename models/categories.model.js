const db = require('../utils/db');
const TBL_CAT='categories';
const TBL_SUBCAT='sub_categories';
module.exports = {
    PostsTrending: function () {
        return db.load(`select * from posts  p order by p.Views desc LIMIT 0,4`);
    },
    all: async function(){
        return db.load(`select * from ${TBL_CAT}`);
    },
    NewPost: function () {
        return db.load(`SELECT c.CatName,p.PostID,p.Abtract,p.Views,p.Ranks, p.PostDate ,p.HasAvatar,p.BigAvatar           
        from post_categories pc ,posts p , categories c 
        WHERE c.CatID=pc.CatID and pc.PostID= p.PostID 
        group by c.CatName, c.CatID`);
    },
    AllCategories: function () {
        return db.load(`select c.*,  COUNT(pc.CatID) AS CountCat from categories c LEFT JOIN post_categories pc on c.CatID= pc.CatID
                            GROUP BY c.CatID, c.CatID`);
    },

    NewpostByCat: function () {
        return db.load(`select * from posts p order by p.PostDate desc limit 0,10`);
    },

    CatMostView: function () {
        return db.load(`select * from posts p order by p.Views desc limit 0,10`);
    },
    AllUsers: function () {
        return db.load(`select * from users`);
    },
    AllbyPost: function (postid) {
        return db.load(`SELECT * FROM posts p
                            WHERE p.PostID= ${postid}`);
    },
    AllbyCat: function (catid) {
        return db.load(`SELECT p.* FROM categories c, posts p , post_categories pc
        WHERE c.CatID=pc.CatID AND p.PostID=pc.PostID AND c.CatID= ${catid}`);
    },
    subCatsByCat: function(catID) {
        return db.load(`select * from ${TBL_SUBCAT} where CatID = ${catID}`);
    }
}