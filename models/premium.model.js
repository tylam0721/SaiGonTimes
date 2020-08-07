const db=require('../utils/db');

module.exports = {
    insert: function(entity)
    {
        return db.add(entity);
    }
};
