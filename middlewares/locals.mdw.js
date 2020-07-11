module.exports=function(app){
    app.use(function(req,res,next){
        if(req.session.isAutheticated==null){
            req.session.isAutheticated=false;
        }
        res.locals.lcIsAuthenticated = req.session.isAuthenticated;
        res.locals.lcAuthUser = req.session.authUser;
        next();
    })

}