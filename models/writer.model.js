const db = require('../utils/db');
const { post } = require('../routes/writer.routes');

const TBL_POST = 'posts';
const SUB_CAT = 'sub_categories';
const TBL_POST_TAGS = 'post_tag';

module.exports = {
  allPostsByAuthor: function (authorID) {
    return db.load(`select * from ${TBL_POST} where Author = ${authorID}`);
  },
  getCatByPostID: function (postID) {
    return db.load(`select * from ${SUB_CAT} sc where sc.SubCatID = ${postID}`);
  },
  updatePost: async function(title, adstract, postCat, cond) {
    const entity = {
      Title: title,
      Abtract: adstract,
      SubCatID: postCat
    }
    console.log(entity);
    return db.patch(TBL_POST, entity, cond);
  },
  allTagsByPost: function(postID) {
    return db.load(`select * from ${TBL_POST_TAGS} where PostID=${postID}`);
  }
};
