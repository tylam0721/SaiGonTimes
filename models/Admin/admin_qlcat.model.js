const db = require('../../utils/db');

const TBL_cat = 'categories';
const TBL_sub_cat = 'sub_categories'
const TBL_Cat_Editor ='cat_editor'
module.exports = {
  all: function () {
    return db.load(`select c.*,  COUNT(sc.CatID) as countcat from ${TBL_cat} c LEFT JOIN sub_categories sc on c.CatID= sc.CatID
                    group by c.CatID, c.CatID`);
  },

  Allbycat: function (catid) {
    return db.load(`select * from categories c join sub_categories sc on c.CatID=sc.CatID
                    where c.CatID= ${catid}`);
  },
  loadCat: function(){
    return db.load(`select CatID , CatName from ${TBL_cat}`);
  },
  
  CountCat : function(){
    return db.load(`SELECT COUNT(*) as countcat FROM categories`);
  },
  
  single: function (id) {
    return db.load(`select * from ${TBL_sub_cat} where UserID = ${id}`);
  },
  
  del : function(subid){
    condition ={
      SubCatID : subid
    }
    return db.del(TBL_sub_cat, condition);
  },

  patch: function (entity,condition) {
    return db.patch(TBL_sub_cat, entity, condition);
  },

  AddSubCat: function (entity) {
    return db.add(TBL_sub_cat, entity);
  },
  AddCAt : function(entity){
    return db.add(TBL_cat, entity);
  },
  AddCatEditor : function(entity){
    return db.add(TBL_Cat_Editor, entity);
  }
};
