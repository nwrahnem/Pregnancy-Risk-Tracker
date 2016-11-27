var express = require('express');
var router = express.Router();
var mongoose = require('mongoose');
var User = mongoose.model('User');
var Checkup = mongoose.model('Checkup');
var CHW = mongoose.model('CHW');
var fs = require('fs');

function isAuthenticated(req, res, next){

    if(req.isAuthenticated()){
        return next();
    }

    return res.redirct('/#login');
}

router.use('/CHW', isAuthenticated);
router.use('/users', isAuthenticated);

router.route('CHW/:chwid')
    .get(function(req, res){
        CHW.findbyId(req.params.chwid, function(err, CHW){
            if(err)
                res.send(err);
            res.json(CHW);
        })
    });

router.route('users/:userid')
    .get(function(req, res){
        User.findById(req.params.userid, function(err, user){
            if(err)
                res.send(err);
            res.json(user);
        })
    });


router.route('/users/:userid/checkups')
    .post(function(req, res){
        var checkup = new Checkup();
        checkup.creator = req.body.creator;

        //add checkup paramas
        
        
        checkup.save(function(err, checkup){
            if(err){
                return res.send(500, err);
            }
            res.json(checkup);
        });
        User.findById(req.params.userid, function(err, user){
            if(err)
                return res.send(500, err);
            user.push(checkup._id);
            user.save();
        });
    })
    .get(function(req, res){
        User.findById(req.params.userid, function(err, user){
            if(err)
                return res.send(500, err);
            return res.send(200, user.checkups);
        });
    });

router.route('/checkups/:checkupid')
    //returns specific routine
    .get(function(req, res){
        Checkup.findById(req.params.checkupid, function(err, checkup){
            if(err)
                res.send(err);
            res.json(checkup);
        });
    })
    // updates specific routine
    .put(function(req, res){
        User.findById(req.params.userid, function(err, user){
            if(err)
                res.send(err);
            user.checkups[req.params.checkupid] = req.body.checkup;
            user.save(function(err, user){
                if(err)
                    res.send(err);
                res.json(user);
            })
        })
    });

module.exports = router;
