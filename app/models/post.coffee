
Backbone = 							require('Backbone')

module.exports = Backbone.Model.extend

	defaults: () ->
		result =

			author:
				id:				''
				firstname:		''
				lastname:		''
				email:			''
				company:		''

			message:
				text:			''

			formatting:			''

			region:
				caption:		''
				name:			''

			our:				false

			post_dt:			''
			post_moment:		''


	initialize: () ->

		if window.user?

			this.checkOur()

			window.user.on 'change:signin', () => this.checkOur()


		# this.checkMoment()

		# this.on 'change', () => 

		this.checkMoment()

		setInterval () =>
			this.checkMoment()
		, 3000


		this.checkFormatting()

		this.on 'change:message', () => this.checkFormatting()

		


	checkFormatting: () ->

		this.set 'formatting', markup.render(this.get('message').text) 		if window.markup?


	checkMoment: () ->

		# console.log this.get('post_dt'), window.moment().format()

		# this.set 'post_moment', window.moment(this.get('post_dt').toString()).fromNow() 		if window.moment?


	checkOur: () ->

		if window.user.get('signin') is true

			if this.get('author').id is window.user.get('id')

				this.set 'our', true



	reset: () ->
		this.set this.defaults()

		this.unset('id')
		this.unset('key')
		this.unset('notice')
		this.unset('message')
		this.unset('post_result')



