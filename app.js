const express = require('express');
const flash = require('connect-flash');
const bodyParser = require('body-parser');
const app = express();

require('express-async-errors');
app.use(express.urlencoded({
    extended: true
}));
app.use(bodyParser.json());
//use middleware
app.use('/public', express.static('public'));

require('./middlewares/session.mdw')(app);
require('./middlewares/view.mdw')(app);
require('./middlewares/locals.mdw')(app);

app.use(flash());
//use controller
app.use('/',require('./routes/home.routes'));//home route
app.use('/demo', require('./routes/demo-routes'));//
app.use('/account', require('./routes/account.routes'));//account route
app.use('/writer', require('./routes/writer.routes'));

app.use('/post', require('./routes/posts.routes'));
app.use('/editor', require('./routes/editor.routes'));
//throw error:
app.get('/err', function(req, res) {
    throw new Error('beng beng');
})
app.use(function(req, res) {
    res.render('404', { layout: false });
})
app.use(function(err, req, res, next) {
    console.error(err.stack);
    res.status(500).render('500', { layout: false });
})

//run server:
const PORT = 3000;
app.listen(PORT, function() {
    console.log(`Server SaiGonTimes is running at http://localhost:${PORT}`);
})