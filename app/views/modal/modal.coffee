
Template = 		require('Template')

module.exports = Template.extend

	el:								'modal'

	events:
		'focus input': 				'change'
		'keyUp input': 				'change'
		'submit .form':		 		'submit'

	render: () ->
		this.template()

	initialize: () ->
		this.$modal = 				this.$el.find('.modal')

	open: () ->
		this.show()

	afterOpen: () ->
		this.afterShow()

	show: () ->
		this.$modal.modal
			backdrop: 				true
			show:					true

		this.$modal.on 'hide', () ->
			window.app.navigate('#')

		this.afterShow()

	afterShow: () ->


	close: () ->
		this.hide()

	hide: () ->
		this.$modal.modal 'hide'

	change: () ->
		# if this.$alertError?
		# 	this.$alertError.hide()

	submit: () ->

		