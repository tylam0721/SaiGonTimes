const express = require('express');
const config = require('../../config/default.json');
const  postModel = require('../../models/posts.model');
const  catModel = require('../../models/categories.model');
const editorModel = require('../../models/Admin/admin_publish.model');
const router = express.Router();

router.get('/publish', async function(req, res) {
    if (res.locals.lcAuthUser && (res.locals.lcAuthUser.Permission == 1)) {
        const editor = await editorModel.select(1);
        let listStatus = await postModel.loadstatuspost();
        let tag = await editorModel.selectAllTag();
        let cat = await catModel.all();
        res.render('vwadmin/publish', {
            layout: "newLayout",
            editor,
            listStatus,
            tag,
            cat
        });
    } else res.render('vwadmin/error', { layout: false })
});

router.post('/', async function(req, res) {
    if (req.body.statusid == 3) {
        await postModel.updateStatus({ Status: req.body.statusid }, { PostID: req.body.postid });
        var d = new Date();
        console.log(req.body);
        today = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate() + ' ' + (d.getHours() + 1) + ':' + (d.getMinutes() + 1) + ':' + ((d.getSeconds() + 1));
        var data = {
            StatusID: req.body.statusid,
            UserID: 3,
            PostID: req.body.postid,
            Reason: req.body.reason,
            Date: today
        }
        console.log(data);
        await editorModel.updatereason(data);
        res.render('vwadmin/publish');
    } else {
        let entity = { CatID: req.body.cat, TagID: req.body.tag.toString(), Status: req.body.statusid };
        let con = { PostID: req.body.postid }
        console.log(req.body);
        await editorModel.updateposts(entity, con);
        res.render('vwadmin/publish');
    }
});
module.exports = router;