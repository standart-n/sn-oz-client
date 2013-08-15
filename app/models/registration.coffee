
Backbone = 							require('Backbone')

module.exports = Backbone.Model.extend

	defaults: () ->
		result = 
			firstname:				''
			lastname:				''
			email: 					''
			company:				''

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
		this.unset 					'valid'

		# this.region = window.sn.get('region')
