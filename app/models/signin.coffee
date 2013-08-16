
Backbone = 							require('Backbone')

module.exports = Backbone.Model.extend

	defaults: () ->
		result = 
			email: 					''
			password: 				''

	initialize: () ->


	reset: () ->
		this.set this.defaults()

		this.unset 					'id'
		this.unset 					'key'
		this.unset 					'reg_dt'
		this.unset 					'_id'
		this.unset 					'__v'
		this.unset 					'success'
		this.unset 					'password'
		this.unset 					'notice'
