
Backbone = 								require('Backbone')

module.exports = Backbone.Model.extend

	defaults: () ->
		result = 
			email: 					''

	initialize: () ->

		# this.region = window.sn.get('region')

	reset: () ->
		this.set this.defaults()

		this.unset 					'id'
		this.unset 					'key'
		this.unset 					'reg_dt'
		this.unset 					'_id'
		this.unset 					'__v'
	