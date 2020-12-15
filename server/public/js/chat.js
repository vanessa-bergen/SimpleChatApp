console.log('web socket client script will run here')
// establish connection to the server to create socket between client and server
var ws = new WebSocket('ws://localhost:4000');
ws.binaryType = 'arraybuffer';

ws.addEventListener('open', () => {
	console.log("web client connected");
});

ws.addEventListener('message', event => {
	console.log("received from server: ", event.data);

    var data = event.data
    // data send from iOS is an ArrayBuffer, convert to String
    if (data instanceof ArrayBuffer) {
        var enc = new TextDecoder("utf-8");
        var data = enc.decode(data);
    }

    try {
            var json = JSON.parse(data);
            console.log("sjon "+ json.message);
        } catch (e) {
            console.log('Error ' + e + ' This doesn\'t look like a valid JSON: ' + json);
            return;
        }
    output.innerHTML += '<p><strong>' + json.handle + ': </strong>' + json.message + '</p>';
    
});

var message = document.getElementById('message');
var handle = document.getElementById('handle');
var btn = document.getElementById('send');
var output = document.getElementById('output');
var feedback = document.getElementById('feedback');

btn.addEventListener('click', function() { 
    const newId = uuidv4()
	ws.send(JSON.stringify({ "id":newId,"handle": handle.value, "message": message.value }));
	
});