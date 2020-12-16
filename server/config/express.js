var express = require('express');
var path = require('path');
var bodyParser = require('body-parser')
var morgan = require('morgan');

module.exports = function() {
	console.log('initializing server.js');

	var app = express();

	app.use(morgan('dev'));
	app.use(bodyParser.urlencoded({ extended : true }));
	app.use(bodyParser.json());

	// telling it to use static files in the public folder
	//app.use(express.static('/../public'));
	//app.use(express.static(__dirname + '../public'));
	app.use(express.static(path.join(__dirname, '../public')));

	// creating a static route to the uuid module
	app.use('/scripts', express.static(path.join(__dirname, '../node_modules/uuid/dist/')));

	// // Set Express routes
	// // Setting the home page of web server
	app.get('/', (req, res) => {
	  	//res.sendFile(__dirname + '../public/views/chat.html');
	  	res.sendFile(path.join(__dirname, '../public/views/chat.html'));

	});

	require('../app/sample/routes.js')(app);
	require('../app/chat/routes.js')(app);
	require('../app/message/routes.js')(app);
	console.log("routes initialized");

	return app
}