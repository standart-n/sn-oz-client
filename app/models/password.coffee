
Backbone = 							require('Backbone')

module.exports = Backbone.Model.extend

	defaults:
		id:							''
		key:						''
		password_new:				''
		password_repeat:			''

	initialize: () ->

