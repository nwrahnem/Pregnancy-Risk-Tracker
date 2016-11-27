var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var userSchema = new Schema({
    created_at: {type: Date, default: Date.now},

    //user information
    name: String,
    age: Number,
    address: String,
    phone_number: String,
    checkups : [{type: Schema.Types.ObjectId, ref: 'Checkup'}]
});

var checkupSchema = new Schema({
    creator : String,
    created_at: {type: Date, default: Date.now}
    
    //Add stuff
});

var CHWSchema = new Schema({
    username: String,
    password: String,
    created_at: {type: Date, default: Date.now},
    name: String,
    users : [{type: Schema.Types.ObjectId, ref: 'User'}]
});

mongoose.model('User', userSchema);
mongoose.model('Checkup', checkupSchema);
mongoose.model('CHW', CHWSchema);