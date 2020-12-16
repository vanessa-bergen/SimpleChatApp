module.exports = function() {
	var Chat = require('mongoose').model('Chat');
	var reqError = require('../common/reqError.js');

	var c = {};

	c.create = function(req, res) {
		console.log(JSON.stringify(req.body));

		var newChat = new Chat(req.body);

		newChat.save(function(err) {
			if (err) return reqError(res, 500, err);

			res.status(201).json({
				newChat : newChat
			});
		});
	}

	c.getAll = function(req, res) {
		var q = Chat.find({});
		q.sort('name');
		q.exec(function(err, chats) {
			if (err) return reqError(res, 500, err);

			res.json(chats);
		});
	}

	return c;
}