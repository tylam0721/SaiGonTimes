const express = require('express');
const config = require('../config/default.json');
const editorModel = require('../models/editor.model');
const postModel = require('../models/posts.model');
const router = express.Router();

router.get('/', async function(req, res) {
    const editor = await editorModel.select();
    res.render('vwEditor/home', {
        editor: editor
    });
});
router.post('/', async function(req, res) {
    var s;
    if (req.body.status == 'Đã duyệt') s = 1;
    else if (req.body.status == 'Đang chờ duyệt') s = 2;
    else s = 3
    var en = { Status: s };
    var con = { PostID: req.body.id };
    res.render('vwEditor/home');
    const sql = await postModel.updateStatus(en, con);
    console.log(sql);
});
module.exports = router;