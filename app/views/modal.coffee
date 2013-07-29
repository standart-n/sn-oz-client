
# modal

Template = 		require('Template')

module.exports = Template.extend

	events:
		'submit .form':		 		'submit'
		'click .modal-close':		'close'

	render: () ->
		this.template()

	open: () ->
		this.show()

	show: () ->
		this.$el.find('.modal').modal 'show'

	close: () ->
		this.hide()

	hide: () ->
		this.$el.find('.modal').modal 'hide'
