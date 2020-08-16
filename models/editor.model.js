  const db = require('../utils/db');
  module.exports = {
      select: function(catid) {
          var sql = `select posts.*,users.UserName,status.StatusName
          from users,posts,status
          where (` + catid + `) and posts.Status=2 and posts.Author=users.UserId and posts.Status=status.StatusID`
          console.log(sql);
          return db.load(`select posts.*,users.UserName,status.StatusName
          from users,posts,status
          where (` + catid + `) and posts.Status=2 and posts.Author=users.UserId and posts.Status=status.StatusID`);
      },
      updatereason: function(entity) {
          return db.add('censorship', entity);
      },
      selectAllTag: function() {
          return db.load(`select * from tag`);
      },
      updateposts: function(entity, con) {
          return db.patch('posts', entity, con);
      },
      selectCat: function(userId) {
          return db.load(`select * from categories where Editor=${userId}`);
      },
      selectList: function(userId) {
          return db.load(`select * from posts where Editor=${userId}`);
      },
  }