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
    console.log("hello");
    if (req.body.hiddenstatus == 'Đã duyệt') req.body.hiddenstatus = 1;
    else if (req.body.hiddenstatus == 'Đang chờ duyệt') req.body.hiddenstatus = 1;
    else req.body.hiddenstatus = 3;
    const sql = await postModel.updateStatus(req.body.hiddenstatus, req.body.hiddenid);
    console.log(sql);
})
module.exports = router;