var express = require('express');
var WebSocket = require('ws');

var app = express();
var server = app.listen(4000, function() {
	console.log('listening to requests on port 4000');
});