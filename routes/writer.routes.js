const express = require('express');
const multer = require('multer');
const categoriesModel = require('../models/categories.model');
const postModel = require('../models/posts.model');
const writerModel = require('../models/writer.model');

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/img/post-avatar/')
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + '.png') //Appending .jpg
  }
})
var upload = multer({ storage: storage });

// var upload = multer({ dest: 'public/img/post-avatar' })
var type = upload.single('avatar');

const router = express.Router();

router.get('/write', async function (req, res) {
  if(res.locals.lcAuthUser && res.locals.lcAuthUser.Permission == 3) {
    let categories = await categoriesModel.all();
    for(let i  = 0; i < categories.length; i++) {
      const subCats = await categoriesModel.subCatsByCat(categories[i].CatID);
      categories[i].subCats = subCats;
    }
    const tags = await postModel.allTag();
    res.render('vwWriter/write', { categories: categories, tags: tags, layout: "writerLayout" });
  }
  else {
    res.render('vwWriter/error', { layout: "writerLayout" });
  }
})

router.post('/write', type, async function (req, res) {
  // cần thêm trường hợp permission user
  if(res.locals.lcAuthUser && res.locals.lcAuthUser.Permission == 3) {
    const postDate = new Date();
    const entity = {
      Title: req.body.title,
      Abtract: req.body.abstract,
      Author: res.locals.lcAuthUser.UserID,
      HasAvatar: '',
      BigAvatar: (req.file) ? `${req.file.filename}` : '',
      PostDate: `${postDate.getUTCFullYear()}-${postDate.getUTCMonth()+1}-${postDate.getUTCDate()}`,
      Views: 0,
      Status: 2,
      Ranks: 10,
      PostContent: req.body.FullDes,
      SubCatID: req.body.postCat
    }
    console.log(entity);
    const postID = await postModel.insert(entity);
    for(let i = 0; i < req.body.tags.length; i++) {
      await postModel.insertPost_Tag(postID.insertId, req.body.tags[i]);
    }   
    res.redirect('/writer/posts');
  }
  else {
    res.render('vwWriter/error', { layout: "writerLayout" });
  }
})

router.get('/posts', async function(req, res) {
  // cần thêm trường hợp permission user
  if(res.locals.lcAuthUser && res.locals.lcAuthUser.Permission == 3) {
    let posts = await writerModel.allPostsByAuthor(res.locals.lcAuthUser.UserID);
    for(let i = 0; i < posts.length; i++) {
      if(posts[i].Status == 1) { 
        posts[i].StatusName = 'Đã duyệt';
        posts[i].isApproved = 'disabled'
      }
      
      else if(posts[i].Status == 2) posts[i].StatusName = 'Đang chờ duyệt';
      else posts[i].StatusName = 'Không được duyệt';

      let cat = await writerModel.getCatByPostID(posts[i].SubCatID);

      if(cat[0]) {
        posts[i].catName = cat[0].SubCatName;
        posts[i].subCatID = cat[0].SubCatID;
      }
    }
    res.render('vwWriter/posts', { 
      layout: "writerLayout",
      posts: posts
    });
  }

  else {
    res.render('vwWriter/error', { layout: "writerLayout" });
  }
})

router.post('/posts', async function(req, res) {
  const condition = { PostID: req.body.postID }
  writerModel.updatePost(req.body.title, req.body.adstract, condition);
  res.redirect('/writer/posts');
})

router.post('/upload', function (req, res) {
  const storage = multer.diskStorage({
    filename(req, file, cb) {
      cb(null, file.originalname);
    },
    destination(req, file, cb) {
      cb(null, './public/imgs');
    }
  })

  const upload = multer({ storage });
  upload.array('fuMain', 3)(req, res, function (err) {
    if (!err)
      res.render('vwDemo/upload');
    else res.send('err');
  })
})
module.exports = router;