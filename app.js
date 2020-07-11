const express = require('express');
const app = express();
require('express-async-errors');
app.use(express.urlencoded({
  extended: true
}));
//use middleware
app.use('/public', express.static('public'));
require('./middlewares/session.mdw')(app);
require('./middlewares/view.mdw')(app);
require('./middlewares/locals.mdw')(app);
//demo hello world:
app.get('/', function(req, res) {
    res.render('home');
})

//use routes:
app.use('/demo', require('./routes/demo-routes'));
app.use('/account', require('./routes/account.routes'));
//throw error:
app.get('/err', function (req, res) {
  throw new Error('beng beng');
})
app.use(function (req, res) {
    res.render('404', { layout: false });
})
app.use(function (err, req, res, next) {
  console.error(err.stack);
  res.status(500).render('500', { layout: false });
})

//run server:
const PORT = 3000;
app.listen(PORT, function () {
  console.log(`Server SaiGonTimes is running at http://localhost:${PORT}`);
})