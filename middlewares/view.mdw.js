const exphbs = require('express-handlebars');
const hbs_sections = require('express-handlebars-sections');
const numeral = require('numeral');
module.exports = function (app) {
  app.engine('hbs', exphbs({
    layoutsDir: 'views/_layouts',
    defaultLayout: 'main',
    partialsDir: 'views/_partials',
    extname: '.hbs',
    helpers: {
      section: hbs_sections(),
      format_number: function (value) {
        return numeral(value).format('0,0');
      },

      format_date: function (value) {
        date = new Date(value);
        var format = date.getFullYear() + '-' + (date.getMonth()) + '-' + date.getDate();
        return format;
      },

      format_datetime: function (value) {
        date = new Date(value);
        var format = (date.getMonth()+1) + '-' + date.getDate()  + '-' +  date.getFullYear()  + ' '+
        (date.getUTCHours()+7) + ":" + date.getUTCMinutes() + ":" + date.getUTCSeconds() ;
        return format;
      },
      count: function(index) {
        return index + 1;
    },

      isAdmin: (account) => account.Permission === 1,
      isEditor: (account) => account.Permission === 2,
      isWriter: (account) => account.Permission === 3,
      isPremium: (account) => account.Permission === 4,
    }
  }));
  app.set('view engine', 'hbs');
}