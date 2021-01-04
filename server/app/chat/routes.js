module.exports = function(app) {
	var ctrl = require('./controller.js')();
	app.post('/chat', ctrl.create);
	app.get('/chat', ctrl.getAll);
	//app.get('/chat/:name', ctrl.getByName);
	app.get('/chat/:name', ctrl.chatExists);
	console.log('chat routes initialized');
}