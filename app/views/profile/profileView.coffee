
Backbone = 									require('Backbone')
Template = 									require('Template')
Complete = 									require('Complete')

module.exports = Template.extend

	el:										'#profile'
	url:									'view/profile/profile.html'
	state:									'ready'

	initialize: () ->

		if window.user?

			window.user.on 'change:signin', () =>
				this.show()

			window.user.on 'change:firstname change:lastname', () =>
				this.show()

			window.app.on 'switch', () =>
				if this.$el.length?
					this.setElement('#profile')
					this.show()


	show: () ->

		if this.state is 'ready'

			this.state = 						'render'

			setTimeout () =>
				this.state = 					'ready'
			, 91 								# 91 was born Alexey Nickolaev 

			if window.user.get('signin') is true
				this.$el.show()
				this.render()
			else
				this.$el.empty().hide()

	render: () ->
		this.template()
		new Complete
			el: 							this.el
			icons:							on

	data: () ->
		window.user.toJSON()

