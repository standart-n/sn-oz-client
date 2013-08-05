
Backbone = require('Backbone')

module.exports = Backbone.Model.extend

	defaults:
		firstname:			''
		lastname:			''
		email:				''
		company:			''

	initialize: () ->
