const db=require('../utils/db');
const { single } = require('./posts.model');
const TBL_Comment='comments';
module.exports = {
    all: async function(id) {
        return db.load(`SELECT cm.*, us.UserName FROM ${TBL_Comment} cm join Users us ON cm.User=us.UserID WHERE cm.PostID=${id}`);
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
    },
    single: async function()
    {
        return db.load(`SELECT cm.*, us.UserName FROM ${TBL_Comment} cm join Users us ON cm.User=us.UserID ORDER BY CommentDate DESC limit 1`);
    }
};
