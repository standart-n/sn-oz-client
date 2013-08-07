
User = 							require('User')

module.exports = User.extend

	defaults: () ->
		firstname:				''
		lastname:				''
		email: 					''
		company:				''

	initialize: () ->

		# this.region = window.sn.get('region')
