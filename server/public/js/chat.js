console.log('web socket client script will run here')
// establish connection to the server to create socket between client and server
var ws = new WebSocket('ws://localhost:4000');
ws.binaryType = 'arraybuffer';

ws.addEventListener('open', () => {
	console.log("web client connected");
});

ws.addEventListener('message', event => {
	console.log("received from server: ", event.data);
});

var message = document.getElementById('message');
var handle = document.getElementById('handle');
var btn = document.getElementById('send');
var output = document.getElementById('output');
var feedback = document.getElementById('feedback');

btn.addEventListener('click', function() { 

	ws.send("Hello from client");
	
});