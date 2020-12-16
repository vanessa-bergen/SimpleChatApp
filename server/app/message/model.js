var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var MessageSchema = Schema({
	handle : {
		type : String,
		required : true
	},
	message : {
		type : String,
		required : true
	},
	date : {
		type : Date,
		required : true
	},
	chat_id : {
		type : Schema.Types.ObjectId, 
		ref : 'Chat',
		required : true
	}
});

mongoose.model('Message', MessageSchema);