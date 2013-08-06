
Template = 								require('Template')

module.exports = Template.extend

	el: 								'.signin-alert-error'
	url:								'view/signin/alertError.html'

	initialize: () ->

	render: () ->
		this.template()

	show: () ->
		this.$el.show()
		this.render()

	hide: () ->
		this.$el.hide()

	data: () ->
