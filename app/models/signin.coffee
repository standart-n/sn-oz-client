
User = require('User')

module.exports = User.extend

	defaults:
		email:				''
		password:			''

	initialize: () ->
