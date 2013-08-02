
Template = 								require('Template')

module.exports = Template.extend

	el: 								'.registration-alert-success'
	url:								'view/registration/alertSuccess.html'

	initialize: () ->

	render: () ->
		this.template()

	show: () ->
		this.$el.show()
		this.render()

	hide: () ->
		this.$el.hide()
		this.render()

	data: () ->
