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
	send: function(wss, room, msg) {
		wss.clients.forEach(function each(client) {
			console.log("room client is in " + client.room + " message room " + room);
			
			console.log(client.room.indexOf(String(room)));
			
			if (client.readyState === WebSocket.OPEN && client.room.indexOf(String(room)) != -1) {
				client.send(JSON.stringify(msg));
			}
		});
	}
}