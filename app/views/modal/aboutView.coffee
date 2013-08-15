
Modal = 								require('Modal')

module.exports = Modal.extend

	el:									'#about'
	url:								'view/feed/about.html'

	events:
		'click .btn'					: 'btn'

	initialize: () ->

		this.render()

		this.$modal = 					this.$el.find('.modal')
		this.$close = 					this.$el.find('.modal-header').find('.close')


	data: () ->
		result = {}


	btn: () ->
		this.close()
		