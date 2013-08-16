
Backbone = 							require('Backbone')

module.exports = Backbone.Model.extend

	defaults: () ->
		result =

			author:
				id:				''
				firstname:		''
				lastname:		''
				email:			''
				company:		''

			message:
				text:			''

			region:
				caption:		''
				name:			''

			our:				false

			post_dt:			new Date()


	initialize: () ->

		if window.user?

			if window.user.get('signin') is true

				if this.get('author').id is window.user.get('id')

					this.set 'our', true


	reset: () ->
		this.set this.defaults()

		this.unset('id')
		this.unset('key')
		this.unset('notice')
		this.unset('message')
		this.unset('post_result')


