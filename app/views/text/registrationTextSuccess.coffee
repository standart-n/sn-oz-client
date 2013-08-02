
Template = 								require('Template')

module.exports = Template.extend

	el: 								'.registration-text-success'
	url:								'view/registration/textSuccess.html'

	initialize: () ->

	render: () ->
		this.template()

	show: (res) ->
		this.res = res
		this.$el.show()
		this.render()

	hide: () ->
		this.$el.hide()

	data: () ->
		this.res

