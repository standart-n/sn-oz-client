
Template = 		require('Template')

module.exports = Template.extend

	events:
		'submit .form':		 		'submit'

	render: () ->
		this.template()

	open: () ->
		this.show()

	afterOpen: () ->
		this.afterShow()

	show: () ->
		this.$modal.modal 'show'
		this.$modal.on 'hide', () ->
			window.app.navigate('#')
		this.afterShow()

	afterShow: () ->


	close: () ->
		this.hide()

	hide: () ->
		this.$modal.modal 'hide'
