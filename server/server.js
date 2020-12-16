var mongoScript = require('./config/mongoose.js');
var expressScript = require('./config/express.js');
var WebSocket = require('ws');
const {v4 : uuidv4} = require('uuid'); 

var db = mongoScript();
var app = expressScript();

//var app = express();
var server = app.listen(4000, function() {
	console.log('listening to requests on port 4000');
});

var webSocketServer = new WebSocket.Server({ server: server });
webSocketServer.binaryType = 'arraybuffer';

webSocketServer.on('connection', function connection(ws) {
	console.log('client connected');

	ws.on('message', function incoming(data) {
		console.log('Server Received: %s', data);
		webSocketServer.clients.forEach(function each(client) {
			client.send(data);
		});
	});

});