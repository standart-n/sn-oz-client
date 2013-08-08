
require('cookie')

User = 									require('User')

module.exports = User.extend

	defaults: () ->
		firstname:						''
		lastname:						''
		email:							''
		company:						''

	initialize: () ->


	updateCookie: () ->
		$.cookie 'id', 		this.get('id'), 			expires: 365
		$.cookie 'key', 	this.get('key'), 			expires: 365

	removeCookie: () ->
		$.removeCookie 'id'
		$.removeCookie 'key'
		