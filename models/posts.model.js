const db = require('../utils/db');

const TBL_POSTS = 'posts';

module.exports = {
  all: async function () {
    return db.load(`select * from ${TBL_POSTS} limit 5`);
  },
//   allByCat: function (catId) {
//     return db.load(`select * from ${TBL_POSTS} where CatID = ${catId}`);
//   },
//   pageByCat: function (catId, limit, offset) {
//     return db.load(`select * from ${TBL_POSTS} where CatID = ${catId} limit ${limit} offset ${offset}`);
//   },
//   countByCat: async function (catId) {
//     const rows = await db.load(`select count(*) as total from ${TBL_POSTS} where CatID = ${catId}`);
//     return rows[0].total;
//   },
//   single: function (id) {
//     return db.load(`select * from ${TBL_POSTS} where ProID = ${id}`);
//   },
};
