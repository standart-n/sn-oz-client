
require('cookie')

User = 									require('User')

module.exports = User.extend

	defaults: () ->
		firstname:						''
		lastname:						''
		email:							''
		company:						''
		signin:							false


	initialize: () ->

		this.on 'change:key', () =>
			if this.get('key') isnt ''
				this.updateCookie()

		this.on 'change:signin', () =>
			if this.get('signin') is true
				this.updateCookie()

	logout: () ->
		this.set('signin', false)
		this.removeCookie()
		this.reset()

	updateCookie: () ->
		$.cookie 'id', 		this.get('id'), 			expires: 365
		$.cookie 'key', 	this.get('key'), 			expires: 365

	removeCookie: () ->
		$.removeCookie 'id'
		$.removeCookie 'key'
		