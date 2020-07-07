const express = require('express');
const app = express();

//use middleware
app.use('/public', express.static('public'));
require('./middlewares/view.mdw')(app);
require('./middlewares/session.mdw')(app);
//demo hello world:
app.get('/', function(req, res) {
    res.render('home');
})

//use routes:
app.use('/demo', require('./routes/demo-routes'));
app.use('/account', require('./routes/account.routes'));
//throw error:
app.use(function (req, res) {
    res.render('404', { layout: false });
})

//run server:
const PORT = 3000;
app.listen(PORT, function () {
  console.log(`Server SaiGonTimes is running at http://localhost:${PORT}`);
})