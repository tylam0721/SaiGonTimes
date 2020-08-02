const express = require('express');
const config = require('../config/default.json');
const editorModel = require('../models/editor.model');
const postModel = require('../models/posts.model');
const router = express.Router();

router.get('/', async function(req, res) {
    const editor = await editorModel.select();
    let listStatus = await postModel.loadstatuspost()
    res.render('vwEditor/home', {
        editor,listStatus
    });
});
router.post('/', async function(req, res) {
    if(req.body.statusid==3)
    { 
        //await postModel.updateStatus({Status:req.body.statusid}, {PostID:req.body.postid});
        var d=new Date();
        today=d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate()+' '+(d.getHours()+1)+':'+(d.getMinutes()+1)+':'+((d.getSeconds()+1));
        var data={
            StatusID:req.body.statusid,
            UserID:3, PostID:req.body.postid,
            Reason:req.body.reason,
            Date:today
        }
        console.log(data);
        await editorModel.updatereason(data);
        res.render('vwEditor/home');
    }
    else {
        res.render('vwEditor/home');
    }
});
module.exports = router;