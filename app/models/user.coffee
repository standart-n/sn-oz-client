
Backbone = 							require('Backbone')

module.exports = Backbone.Model.extend

	defaults: () ->
		email:						''
		key:						''

	initialize: () ->

	reset: () ->
		this.set 		'signin',		false
		this.set 		'firstname', 	''
		this.set 		'lastname',		''
		this.set 		'email',		''
		this.set 		'company',		''

		this.unset 		'id'
		this.unset 		'key'
		this.unset 		'reg_dt'
		this.unset 		'success'
		this.unset 		'_id'
		this.unset 		'__v'

