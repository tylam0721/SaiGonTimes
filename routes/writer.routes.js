const express = require('express');
const multer = require('multer');
const categoriesModel = require('../models/categories.model');
const writerModel = require('../models/writer.model');
var upload = multer({ dest: 'public/img/post-avatar' })
var type = upload.single('avatar');

const router = express.Router();

router.get('/write', async function (req, res) {
  const categories = await categoriesModel.all();
  for(let i  = 0; i < categories.length; i++) {
    const subCats = await categoriesModel.subCatsByCat(categories[i].CatID);
    categories[i].subCats = subCats;
  }
  res.render('vwWriter/write', { categories: categories });
})

router.post('/write', type, async function (req, res) {
  const postDate = new Date();

  const entity = {
    Title: res.title,
    Abstract: res.abstract,
    Author: res.locals.lcAuthUser.UserID,
    HasAvatar: '',
    BigAvatar: req.file.filename,
    PostDate: `${postDate.getUTCFullYear()}-${postDate.getUTCMonth()+1}-${postDate.getUTCDate()}`,
    Views: 0,
    Status: 2,
    Ranks: 10
  }

  console.log(entity);
  res.render('vwWriter/write');
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