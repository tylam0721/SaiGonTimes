const db = require('../utils/db');
module.exports = {
    select: function() {
        return db.load(`select posts.PostID,posts.Abtract,posts.PostDate,posts.Author,posts.Status,users.UserName,status.StatusName from users,posts,status where posts.Author=users.UserId and posts.Status=status.StatusID`);
    },
}