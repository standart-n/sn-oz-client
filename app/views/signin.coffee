
# Signin

require('jquery')

Backbone = require('Backbone')

module.exports = Backbone.View.extend

	el:			'#signin'

	events:
		'submit #signin-form': 		'submit'

	submit: (e) ->
		e.preventDefault()
		alert 'submit'



		