
require('cookie')

Backbone = 						require('Backbone')

module.exports = Backbone.Model.extend

	defaults: () ->
		result =
			firstname:			''
			lastname:			''
			email:				''
			company:			''

			region:
				caption:		''
				name:			''


			signin:				false

			reg_dt:				new Date()

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


	reset: () ->
		this.set this.defaults()

		this.unset 					'id'
		this.unset 					'key'
		this.unset 					'reg_dt'
		this.unset 					'_id'
		this.unset 					'__v'

		