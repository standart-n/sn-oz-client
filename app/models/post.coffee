
Backbone = 							require('Backbone')
Files = 							require('Files')

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

			attachments:
				files:			[]

			formatting:			''

			region:
				caption:		''
				name:			''

			our:				false

			post_dt:			''


	initialize: () ->

		this.checkOur()
		
		this.checkFormatting()

		this.checkFiles()

		this.on 'change:message', () => this.checkFormatting()


	checkFiles: () ->

		attachments = this.get('attachments')

		attachments.files = new Files(attachments.files).toJSON()

		this.set
			attachments: attachments



	checkFormatting: () ->

		if this.get('message')?.text?

			this.set 'formatting', markup.render(this.get('message').text) 		if window.markup?


	checkOur: () ->

		if window.user.get('signin') is true

			if this.get('author').id.toString() is window.user.get('id').toString()

				this.set 'our', true


	reset: () ->
		this.set this.defaults()

		this.unset('id')
		this.unset('key')
		this.unset('notice')
		this.unset('message')
		this.unset('post_result')



