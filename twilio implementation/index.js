var express = require('express');
var bodyParser = require('body-parser');
var providers = require('providers.json');
var app = express();
var AccountSid = "AC4ef1e41dd27be23b7aeac25d02238ec5";
var AuthToken = "98f4034beaf5e86944a3e43071d12d8d";
var twilio = require('twilio');
var client = new twilio.RestClient(AccountSid, AuthToken);
var FromNumber = "16473602949";

app.use(bodyParser.urlencoded({ extended: false}));

app.post('/message', function (req, res) {
	console.log(req.body);
	var msgFrom = req.body.From;
	var msgBody = req.body.Body;
	providers.forEach(function(provider) {
		client.messages.create({
            body: msgBody,
			to: provider.phoneNumber,
			from: FromNumber 
        }, function(err,message){
			console.log(message.sid);
		})
	});
	res.send(`
		<Response>
			<Message>
				Thank you ${msgFrom}. Your question has been received.
			</Message>
		</Response>
	`);
});

app.listen(3000);