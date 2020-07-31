const db = require('../utils/db');
const TBL_CAT='categories';
module.exports = {
    PostsTrending: function () {
        return db.load(`select * from posts  p order by p.Views desc LIMIT 0,4`);
    },
    all: async function(){
        return db.load(`select * from ${TBL_CAT}`);
    },
    allWithDetails: function () {
        return db.load(`
            select c.*, count(p.PostID) as num_of_posts
            from ${TBL_CAT} c left join posts p on c.CatID = p.CatID
            group by c.CatID, c.CatName`);
    },
    addComment: function(){

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
    AllsubCat: function(id){
        return db.load(`SELECT * FROM sub_categories where CatID=${id}`);
    }

}