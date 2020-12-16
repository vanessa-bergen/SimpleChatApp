var mongoose = require('mongoose');
var config = require('./config.js');

module.exports = function() {
	var db = mongoose.connect(
		config.DB_Connection,
		{
			useNewUrlParser: true,
			useUnifiedTopology: true,
			useCreateIndex: true,
			useFindAndModify: false

		},
		function(err) {
			console.log(err);
		}
	)

	require('../app/sample/model.js');
	require('../app/chat/model.js');
	require('../app/message/model.js');

	return db

}