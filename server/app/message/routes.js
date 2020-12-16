module.exports = function(app) {
	var ctrl = require('./controller.js')();
	app.post('/message', ctrl.create);
	app.get('/message', ctrl.getAll);
	console.log('message routes initialized');
}