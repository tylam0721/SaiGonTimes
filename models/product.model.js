const db = require('../utils/db');

const TBL_PRODUCTS = 'products';

module.exports = {
  all: function () {
    return db.load(`select * from ${TBL_PRODUCTS}`);
  },
  allByCat: function (catId) {
    return db.load(`select * from ${TBL_PRODUCTS} where CatID = ${catId}`);
  },
  pageByCat: function (catId, limit, offset) {
    return db.load(`select * from ${TBL_PRODUCTS} where CatID = ${catId} limit ${limit} offset ${offset}`);
  },
  countByCat: async function (catId) {
    const rows = await db.load(`select count(*) as total from ${TBL_PRODUCTS} where CatID = ${catId}`);
    return rows[0].total;
  },
  single: function (id) {
    return db.load(`select * from ${TBL_PRODUCTS} where ProID = ${id}`);
  },
};
