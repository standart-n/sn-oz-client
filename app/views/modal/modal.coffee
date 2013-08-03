
# modal

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
		this.$el.find('.modal').modal 'show'
		this.$el.find('.modal').on 'hide', () ->
			window.app.navigate('#')
		this.afterShow()

	afterShow: () ->
