var LocalStrategy = require("passport-local").Strategy;
var bCrypt = require("bcrypt-nodejs");
var mongoose = require('mongoose');
var CHW = mongoose.model('CHW');

module.exports = function(passport){

    passport.serializeUser(function(user, done){
        return done(null, user._id);
    });

    passport.deserializeUser(function(id, done){
        CHW.findById(id, function(err, CHW){
            if(err)
                return done(err);
            return done(null, CHW);
        });
    });

    passport.use("login", new LocalStrategy({
            passReqToCallback : true
        },
        function(req, username, password, done){
            //check if user is in mongo
            CHW.findOne({'username' : username},
                function(err, CHW){
                    if(err) {
                        console.log('Error in login ' + err);
                        return done(err);
                    }
                    if(!CHW){
                        console.log('User not found with username ' + username);
                        return done(null, false, {message : 'No such user found'});
                    }
                    if(!isValidPassword(CHW, password)){
                        console.log('Invalid Password');
                        return done(null, false, {message : 'Invalid password'});
                    }
                    return done(null, CHW);
                });
        }
    ));

    passport.use("register", new LocalStrategy({
            passReqToCallback : true
        },
        function(req, username, password, done){
            CHW.findOne({'username': username},
                function(err, CHW){
                    if(CHW){
                        console.log('Error in register ' + err);
                        return done(err);
                    }
                    if(CHW){
                        console.log('User already exists');
                        return done(null, false, {message : 'User already exists'});
                    }
                    else{
                        var newCHW = new CHW();
                        newCHW.username = username;
                        newCHW.password = createHash(password);
                        newCHW.name = req.body.name;

                        newCHW.save(function(err){
                            if(err){
                                console.log('Error in saving user: ' + err);
                                return done(err);
                            }
                            console.log('Registered ' + newCHW.username);
                            return done(null, newCHW);
                        });
                    }
                });
        }
    ));

    var isValidPassword = function(user, password){
        return bCrypt.compareSync(password, user.password);
    };

    var createHash = function(password){
        return bCrypt.hashSync(password, bCrypt.genSaltSync(10), null);
    };

};