const db = require('../utils/db');

const TBL_POSTS = 'posts';
const TBL_TAG = 'tag';
const TBL_POST_TAG = 'post_tag';

module.exports = {
    search: async function(){
      return db.load(`SELECT * FROM posts WHERE MATCH (Title,Abtract,PostContent) AGAINST ('chủ quan')`);
    },
    all: async function() {
        return db.load(`select * from ${TBL_POSTS} limit 10`);
    },
    allByCat: function(catId) {
        return db.load(`select * from ${TBL_POSTS} where CatID = ${catId} limit 10`);
    },
    allPostsDetail: function() {
        return db.load(`select p.*, count(c.PostID) as num_of_com 
    from ${TBL_POSTS} p left join comments c on p.PostID=c.PostID group by p.PostID limit 10`)
  },
  insert: async function(entity) {
    return db.add(TBL_POSTS, entity);
  },
  insertPost_Tag: async function(postID, tagID) {
    const entity = {
      PostID: postID,
      TagID: tagID
    }
    console.log(entity);
    return db.add(TBL_POST_TAG, entity);
  },
//   allByCat: function (catId) {
//     return db.load(`select * from ${TBL_POSTS} where CatID = ${catId}`);
//   },
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
    topMostView: async function() {
        return db.load(`SELECT * FROM ${TBL_POSTS} ORDER BY Views DESC LIMIT 10`);
    },
    topLastest: async function() {
        return db.load(`SELECT * FROM ${TBL_POSTS} ORDER BY PostDate DESC LIMIT 10`);
    },
    topPostWeek: async function() {
        return db.load(`SELECT * from ${TBL_POSTS} p where TIMESTAMPDIFF(week,p.PostDate,CURDATE()) <= 1`)
    },
    updateViews: function(id) {
        return db.load(`UPDATE ${TBL_POSTS} SET VIEWS=VIEWS+1 WHERE PostID=${id}`)
    },
    allTagOfPost: async function(id) {
        return db.load(`SELECT t.* FROM ${TBL_POSTS} p join post_tag pt ON pt.PostID=p.PostID 
              join tag t on t.tagid=pt.tagid where p.PostID=${id}`)
    },
    allByTag: async function(id) {
        return db.load(`SELECT p.* FROM ${TBL_POSTS} p JOIN post_tag pt on pt.PostID=p.PostID where pt.TagID=${id}`)
  },
  
    allBySubCat: async function(id) {
        return db.load(`SELECT p.* from ${TBL_POSTS} p join sub_categories sc on sc.CatID = p.CatID where sc.SubCatID=${id}`)
    },
    loadstatuspost: function() {
        return db.load('select * from status where StatusID=1 or StatusID=3');
    },
    updateStatus: async function(status, condition) {
        return db.patch(TBL_POSTS, status, condition);
    },
    newestofcat: async function(){
        return db.load(`select p.*, cat.CatName from posts p join ( select max(p.PostID) as postiD from posts p join (select max(PostDate) as postdate, CatID from posts group by CatID limit 10) pc on (p.PostDate = pc.postdate and p.CatID = pc.CatID) group by p.CatID) pc on p.PostID = pc.postiD JOIN categories cat on p.CatID=cat.CatID`);
        
    },

  allTag: async function() {
    return db.load(`SELECT * from ${TBL_TAG}`);
  },

  loadstatuspost: function() {
      return db.load('select * from status where StatusID=1 or StatusID=3');
  },
  updateStatus: async function(status, condition) {
      return db.patch(TBL_POSTS, status, condition);
  }
};
