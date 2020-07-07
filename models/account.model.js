const db=require('../utils/db');
const TBL_USER='users';
module.exports={
    all:function(){
        return db.load(`select * from ${TBL_USER}`);
    },
    single: function(id){
        return db.load(`select * from ${TBL_USER} where UserId = ${id}`);
    },
    add: function(entity){
        return db.add(TBL_USER,entity);
    },
    patch: function(entity){
        const condition = {
            id: entity.id
        }
        delete entity.id;
        return db.patch(TBL_USERS, entity, condition);
    },
    del: function (id) {
        const condition = { id }
        return db.del(TBL_USERS, condition);
    }
}