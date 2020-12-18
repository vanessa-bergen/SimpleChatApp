module.exports = function(app, wss) {
	var ctrl = require('./controller.js')(wss);
	app.post('/message', ctrl.create);
	app.get('/message', ctrl.getAll);
	app.get('/message/:chat_name', ctrl.getByChat);
	console.log('message routes initialized');
}