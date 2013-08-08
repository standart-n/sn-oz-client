
Template = 									require('Template')

module.exports = Template.extend

	el: 									'#feed'
	url: 									'view/feed/feed.html'

	initialize: () ->
		if this.$el.length?
			this.render()

		window.app.on 'switch', () =>
			if this.$el.length?
				this.setElement('#feed')
				this.render()

	render: () ->
		this.template()

