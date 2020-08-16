const db = require('../../utils/db');

const TBL_user = 'users';
const TBL_Cat = 'categories';
const TBL_Tag = 'tag';
const TBL_Premium = 'premiumusers';
module.exports = {
  all: function () {
    return db.load(`select * from ${TBL_user} u join permission p on u.Permission=p.PerID `);
  },
  allPer: function () {
    return db.load(`select * from Permission`);
  },
  del: function (userid) {
    const condition = {
      UserID: userid
    }
    return db.del(TBL_user, condition);
  },
  single: function (id) {
    return db.load(`select * from ${TBL_user} where UserID = ${id}`);
  },
  patch: function (entity, condition) {
    return db.patch(TBL_user, entity, condition);
  },

  patchCat: function (entity, condition) {
    return db.patch(TBL_Cat, entity, condition);
  },

  assign: function () {
    return db.load(`select c.CatID,c.CatName,u.FullName,u.UserID from categories c left JOIN users u ON c.Editor=u.UserID`)
  },
  editor: function () {
    return db.load(`select users.FullName, users.UserID  from users where Permission= '2'`)
  },
  Tag: function () {
    return db.load(`select TagID,Name from tag where status= 1` );
  },
  DeleteTag : function(entity,condition){
    return db.patch(TBL_Tag,entity,condition)
  },
  addtag: function (entity) {
    return db.add(TBL_Tag, entity);
  },
  edittag: function (entity, condition) {
    return db.patch(TBL_Tag, entity, condition);
  },
  Guest: function () {
    return db.load(`select u.UserID,u.EmailAdress,u.FullName,u.DOB,u.Phone,u.Status,u.NickName,p.PermissionName,pr.TimeEnd
                    from premiumusers pr join users u on pr.UserID=u.UserID
                    join permission p on u.Permission=p.PerID  
                    where Permission= '5'`);
  },
  GuestTimeEnd :function(entity,condition){
    return db.patch(TBL_Premium,entity,condition)
  }
};
