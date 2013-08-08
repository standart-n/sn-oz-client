
Backbone = 									require('Backbone')
Template = 									require('Template')
Complete = 									require('Complete')

module.exports = Template.extend

	el:										'#profile'
	url:									'view/profile/profile.html'

	initialize: () ->

		this.model = 						window.user

		this.model.on 'change:signin', () =>
			if this.model.get('signin') is true
				this.$el.show()
				this.render()
			else
				this.$el.html('').hide()

		this.model.on 'change:firstname change:lastname', () =>
			this.render()

	render: () ->
		this.template()
		new Complete
			el: 							this.el
			icons:							on

	data: () ->
		this.model.toJSON()

