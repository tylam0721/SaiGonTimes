const express = require('express');
const app = express();

//use middleware
app.use('/public', express.static('public'));
require('./middlewares/view.mdw')(app);


const cat = require('./models/categories.model')
app.use(async function (req, res,next) {
  const row = await cat.NewPost();
  const row1 = await cat.NewpostByCat();
  const row2 = await cat.AllUsers();
  const row3 = await cat.AllCategories();

  res.locals.newpost =row;
  res.locals.newpostbycat=row1;
  res.locals.allusers=row2;
  res.locals.categories=row3;
  next();
})

// const categories = require('./models/categories.model');

// app.use( async function (req, res,next) {
//   const rows = await categories.AllCat();
//   res.locals.lccategories = rows;
//   next();
// })
//demo hello world:

const { post } = require('./routes/demo-routes');



app.get('/', async function (req, res) {
  const listposts = await cat.PostsTrending();
  const catmostviews = await cat.CatMostView();
  res.render('home', {
    post: listposts,
    catmostview: catmostviews,
    empty: listposts.lenght === 0
  });
})

//use routes:
app.use('/demo', require('./routes/demo-routes'));
app.use('/account', require('./routes/account.routes'));
app.use('/posts', require('./routes/posts.routes'));

//throw error:
app.use(function (req, res) {
  res.render('404', { layout: false });
})

//run server:
const PORT = 3000;
app.listen(PORT, function () {
  console.log(`Server SaiGonTimes is running at http://localhost:${PORT}`);
})