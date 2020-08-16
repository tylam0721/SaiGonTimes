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
    singleByUserName: async function (username) {
        const rows = await db.load(`select * from ${TBL_USER} where UserName = '${username}'`);
        if (rows.length === 0)
            return null;

        return rows[0];
    },
    singleByUserNameorEmail: async function (username, email) {
        const rows = await db.load(`select * from ${TBL_USER} where UserName = '${username}' or EmailAdress = '${email}'`);
        if (rows.length === 0)
            return null;
        return rows[0];
    },
    patch: function(entity){
        const condition = {
            UserID: entity.UserID
        }
        delete entity.UserID;
        return db.patch(TBL_USER, entity, condition);
    },
    del: function (id) {
        const condition = {id}
        return db.del(TBL_USER, condition);
    },
    singleID: async function (username, email) {
        const rows = await db.load(`select UserID from ${TBL_USER} where UserName = '${username}' or EmailAdress = '${email}'`);
        if (rows.length === 0)
            return null;
        return rows[0];
    },
    singleHashPass: async function (username, email) {
        const rows = await db.load(`select HashPassword from ${TBL_USER} where UserName = '${username}' or EmailAdress = '${email}'`);
        if (rows.length === 0)
            return null;
        return rows[0];
    },
    singleOtp: async function (username, email) {
        const rows = await db.load(`select otpverify from ${TBL_USER} where UserName = '${username}' or EmailAdress = '${email}'`);
        if (rows.length === 0)
            return null;
        return rows[0];
    }
}