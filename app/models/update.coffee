
Backbone = 							require('Backbone')

module.exports = Backbone.Model.extend

	defaults: 
		update:						false

	initialize: () ->

	reset: () ->
		this.set update, false

