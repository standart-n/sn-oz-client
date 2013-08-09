
Template = 									require('Template')
Post = 										require('Post')

module.exports = Template.extend

	el: 									'#tab-feed-news'
	url: 									'view/feed/feedNews.html'

	events:
		'submit .feed-post-form' 			: 'submit'
		'focus .feed-post-form' 			: 'focus'
	# 'blur .feed-post-form' 				: 'blur'

	initialize: () ->

		this.post = 						new Post()

		this.render()

		this.$message = 					this.$el.find('.feed-post-message')
		this.$alertError = 					this.$el.find('.alert-eror')


	render: () ->
		this.template()


	focus: () ->
		this.$message.attr('rows',7)

	blur: () ->
		this.$message.attr('rows',3)

	checking: () ->
		jalert this.post.toJSON()

		this.post.unset('message')

	submit: (e) ->

		e.preventDefault()

		if window.user?

			this.post.set
				id:								window.user.get('id')
				key:							window.user.get('key')

			this.post.save
				message:						this.$message.val()
			,
				url: 							window.sn.get('server').host + '/feed/post/'
				dataType: 						'jsonp'
				success: (s) => 
					this.checking()


