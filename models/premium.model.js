const db=require('../utils/db');
const TBL_PREMIUM='premiumusers';
module.exports = {
    insert: function(entity)
    {
        return db.add(TBL_PREMIUM, entity);
    }
};
