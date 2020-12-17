var WebSocket = require('ws');

// export two functions to be used elsewhere
module.exports = {
	// initialize the websocket server
	init: function(server) {
		wss = new WebSocket.Server({ server : server});
		wss.binaryType = 'arraybuffer';
		return wss;
	},

	// send the message object to all clients connected to the server via websocket
	send: function(wss, msg) {
		wss.clients.forEach(function each(client) {
			if (client.readyState === WebSocket.OPEN) {
				client.send(JSON.stringify(msg));
			}
		});
	}
}