const db=require('../utils/db');
const TBL_Comment='comments';
module.exports = {
    all: async function(id) {
        return db.load(`select * from ${TBL_Comment} WHERE PostID=${id}`);
    },
    patch: async function(entity)
    {
        const condition={
            User: entity.User,
            PostID: entity.PostID
        }
        return db.patch(TBL_Comment,entity, condition);
    },
    add: async function(entity)
    {
        return db.add(TBL_Comment, entity);
    }
};
