
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

			post_dt:			new Date()

	initialize: () ->

	reset: () ->
		this.set this.defaults()

		this.unset('id')
		this.unset('key')
		this.unset('notice')
		this.unset('message')
		this.unset('post_result')



