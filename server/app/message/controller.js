module.exports = function() {
	var Message = require('mongoose').model('Message');
	var reqError = require('../common/reqError.js');

	var c = {};

	c.create = function(req, res) {
		console.log(JSON.stringify(req.body));

		var newMessage = new Message(req.body);

		newMessage.save(function(err) {
			if (err) return reqError(res, 500, err);

			res.status(201).json({
				newMessage : newMessage
			});
		});
	}

	c.getAll = function(req, res) {
		var q = Message.find({});
		q.sort('date');
		q.exec(function(err, messages) {
			if (err) return reqError(res, 500, err);

			res.json(messages);
		});
	}

	return c;
}