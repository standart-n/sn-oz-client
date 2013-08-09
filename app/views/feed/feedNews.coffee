
Template = 									require('Template')

module.exports = Template.extend

	el: 									'#tab-feed-news'
	url: 									'view/feed/feedNews.html'

	events:
		'submit .feed-post-form' 			: 'submit'

	initialize: () ->

		this.user = 						window.user

		this.render()

		this.$message = 					this.$el.find('.feed-post-message')


	render: () ->
		this.template()


	checking: () ->

		this.user.unset('message')

	submit: (e) ->

		e.preventDefault()

		this.user.save
			message:						this.$message.val()
		,
			url: window.sn.get('server').host + '/feed/post/' + window.user.get('id') + '/' + window.user.get('key')
			dataType: 'jsonp'
			success: (s) => 
				this.checking()


