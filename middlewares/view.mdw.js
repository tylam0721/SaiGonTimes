const exphbs = require('express-handlebars');

module.exports = function (app) {
  app.engine('hbs', exphbs({
    layoutsDir: 'views/_layouts',
    defaultLayout: 'main',
    partialsDir: 'views/_partials',
    extname: '.hbs'
  }));
  app.set('view engine', 'hbs');
}
