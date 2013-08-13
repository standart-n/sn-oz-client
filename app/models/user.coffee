
Backbone = 							require('Backbone')

module.exports = Backbone.Model.extend

	defaults:
		email:						''
		key:						''

	initialize: () ->
		_.extend this, Backbone.Event

	reset: () ->
		this.set 		
			firstname: 				''
			lastname:				''
			email:					''
			company:				''

		this.unset 					'id'
		this.unset 					'key'
		this.unset 					'reg_dt'
		this.unset 					'success'
		this.unset 					'_id'
		this.unset 					'__v'

