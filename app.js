const express = require('express');
const app = express();

//use middleware
app.use('/public', express.static('public'));
require('./middlewares/view.mdw')(app);

// const categories = require('./models/categories.model');

// app.use( async function (req, res,next) {
//   const rows = await categories.AllCat();
//   res.locals.lccategories = rows;
//   next();
// })
//demo hello world:

const { post } = require('./routes/demo-routes');

const cat = require('./models/categories.model')

app.get('/', async function(req, res) {
    const listposts = await cat.PostsTrending();
    const listcategories = await cat.AllCategories();
    const catmostviews = await cat.CatMostView();
    const newposts = await cat.NewPost();
    const newpostbycats = await cat.NewpostByCat();
    const allusers = await cat.AllUsers();
    res.render('home',{
      post : listposts,
      categories : listcategories,
      catmostview : catmostviews,
      newpost : newposts,
      newpostbycat : newpostbycats,
      allusers : allusers,
      empty : listposts.lenght === 0
    });
})

//use routes:
app.use('/demo', require('./routes/demo-routes'));
app.use('/account', require('./routes/account.routes'));
app.use ('/categories', require('./routes/categories.routes'));
//throw error:
app.use(function (req, res) {
    res.render('404', { layout: false });
})

//run server:
const PORT = 3000;
app.listen(PORT, function () {
  console.log(`Server SaiGonTimes is running at http://localhost:${PORT}`);
})