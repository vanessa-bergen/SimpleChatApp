module.exports = function() {
	var Chat = require('mongoose').model('Chat');
	var reqError = require('../common/reqError.js');

	var c = {};

	c.create = function(req, res) {
		console.log(JSON.stringify(req.body));

		delete req.body._id;

		var newChat = new Chat(req.body);

		newChat.save(function(err) {
			if (err) return reqError(res, 500, err);

			res.status(201).json(newChat);
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

	c.getByName = function(req, res) {
		var name = req.params.name;
		var q = Chat.findOne({name : name}, "-__v");
		q.exec(function(err, chat) {
			if (err) return reqError(res, 500, err);

			res.json(chat);
		});
	}

	c.chatExists = function(req, res) {
		var name = req.params.name;
		var q = Chat.findOne({name : name});
		q.exec(function(err, chat) {
			if (err) return reqError(res, 500, err);

			res.send(chat != null);
		});
	}

	return c;
}