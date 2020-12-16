var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var ChatSchema = Schema({
	name : {
		type : String,
		required : true,
		unique : true
	}
});

mongoose.model('Chat', ChatSchema);