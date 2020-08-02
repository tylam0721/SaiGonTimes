const db = require('../utils/db');

const TBL_POSTS = 'posts';

module.exports = {
  all: async function () {
    return db.load(`select * from ${TBL_POSTS} limit 10`);
  },
  allByCat: function (catId) {
    return db.load(`select * from ${TBL_POSTS} where CatID = ${catId}`);
  },
  allPostsDetail: function(){
    return db.load(`select p.*, count(c.PostID) as num_of_com 
    from ${TBL_POSTS} p left join comments c on p.PostID=c.PostID group by p.PostID`)
  },
//   pageByCat: function (catId, limit, offset) {
//     return db.load(`select * from ${TBL_POSTS} where CatID = ${catId} limit ${limit} offset ${offset}`);
//   },
  countByCat: async function (catId) {
    const rows = await db.load(`select count(*) as total from ${TBL_POSTS} where CatID = ${catId}`);
    return rows[0].total;
  },
  single: async function (id) {
    return db.load(`select p.*, count(c.PostID) as num_of_com 
    from ${TBL_POSTS} p join comments c on p.PostID=c.PostID
    where p.PostID = ${id}`);
  },
  topMostView: async function(){
    return db.load(`SELECT * FROM ${TBL_POSTS} ORDER BY Views DESC LIMIT 10`);
  },
  topLastest: async function(){
    return db.load(`SELECT * FROM ${TBL_POSTS} ORDER BY PostDate DESC LIMIT 10`);
  },
  topPostWeek: async function(){
    return db.load(`SELECT * from ${TBL_POSTS} p where TIMESTAMPDIFF(week,p.PostDate,CURDATE()) <= 1`)
  },
  updateViews: function(id)
  {
    return db.load(`UPDATE ${TBL_POSTS} SET VIEWS=VIEWS+1 WHERE PostID=${id}`)
  },
  allTagOfPost: async function(id){
    return db.load(`SELECT t.* FROM ${TBL_POSTS} p join post_tag pt ON pt.PostID=p.PostID 
              join tag t on t.tagid=pt.tagid where p.PostID=${id}`)
  },
  allByTag: async function(id){
    return db.load(`SELECT p.* FROM ${TBL_POSTS} p join post_tag pt ON pt.PostID=p.PostID 
    join tag t on t.tagid=pt.tagid where t.tagid=${id}`)
  },
  allBySubCat: async function(id){
      return db.load(`SELECT p.* from ${TBL_POSTS} p join sub_categories sc on sc.CatID = p.CatID where sc.SubCatID=${id}`)
    }
  };
