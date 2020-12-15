var express = require('express');
var WebSocket = require('ws');
const {v4 : uuidv4} = require('uuid'); 

var app = express();
var server = app.listen(4000, function() {
	console.log('listening to requests on port 4000');
});

var webSocketServer = new WebSocket.Server({ server: server });
webSocketServer.binaryType = 'arraybuffer';

webSocketServer.on('connection', function connection(ws) {
	console.log('client connected');
	ws.send("Hello from server");

	ws.on('message', function incoming(data) {
		console.log('Server Received: %s', data);
		webSocketServer.clients.forEach(function each(client) {
			client.send(data);
		});
	});

});

// telling it to use static files in the public folder
app.use(express.static('public'));

// creating a static route to the uuid module
app.use('/scripts', express.static(__dirname + '/node_modules/uuid/dist/'));

// Set Express routes
// Setting the home page of web server
app.get('/', (req, res) => {
  	res.sendFile(__dirname + '/public/views/chat.html');
});