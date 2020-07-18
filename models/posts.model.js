const db = require('../utils/db');

const TBL_POSTS = 'posts';

module.exports = {
  all: async function () {
    return db.load(`select * from ${TBL_POSTS} limit 10`);
  },
  allByCat: function (catId) {
    return db.load(`select * from ${TBL_POSTS} where CatID = ${catId}`);
  },
//   pageByCat: function (catId, limit, offset) {
//     return db.load(`select * from ${TBL_POSTS} where CatID = ${catId} limit ${limit} offset ${offset}`);
//   },
  countByCat: async function (catId) {
    const rows = await db.load(`select count(*) as total from ${TBL_POSTS} where CatID = ${catId}`);
    return rows[0].total;
  },
  single: async function (id) {
    return db.load(`select * from ${TBL_POSTS} where ProID = ${id}`);
  },
  topMostView: async function(){
    return db.load(`SELECT * FROM ${TBL_POSTS} ORDER BY Views DESC LIMIT 10`);
  },
  topLastest: async function(){
    return db.load(`SELECT * FROM ${TBL_POSTS} ORDER BY PostDate DESC LIMIT 10`);
  },
  topPostWeek: async function(){
    return db.load(`SELECT * from ${TBL_POSTS} p where TIMESTAMPDIFF(week,p.PostDate,CURDATE()) <= 1`)
  }
};
