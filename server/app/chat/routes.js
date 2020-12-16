module.exports = function(app) {
	var ctrl = require('./controller.js')();
	app.post('/chat', ctrl.create);
	app.get('/chat', ctrl.getAll);
	console.log('chat routes initialized');
}