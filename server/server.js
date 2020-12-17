var mongoScript = require('./config/mongoose.js');
var expressScript = require('./config/express.js');
var webSocketScript = require('./config/websocket.js');
const {v4 : uuidv4} = require('uuid'); 

var db = mongoScript();
var app = expressScript();

var server = app.listen(4000, function() {
	console.log('listening to requests on port 4000');
});

// initialize the websocket server
var wss = webSocketScript.init(server);

wss.on('connection', function connection(ws) {
	console.log('client connected');
});

// initialize http routs
require('./app/sample/routes.js')(app);
require('./app/chat/routes.js')(app);
// passing in the websocket server to send messages after POST of message
require('./app/message/routes.js')(app, wss);
console.log("routes initialized");

