
Template = 									require('Template')
Post = 										require('Post')

module.exports = Template.extend

	el: 									'#feed-box'
	url: 									'view/feed/feedBox.html'

	events: () ->
		'submit form'						: 'submit'
		'keyup .feed-post-message'			: 'keyup'

	initialize: () ->

		this.post = 						new Post()

		this.render()

		this.$form = 						this.$el.find('form')
		this.$message = 					this.$el.find('textarea')
		this.$alertError = 					this.$el.find('.alert-error')
		this.$alertSuccess = 				this.$el.find('.alert-success')
		this.$button = 						this.$el.find('button')

		# key 'enter', () ->
		# 	alert 'keymaster!'


	render: () ->
		this.template()


	focus: () ->
		this.$message.attr('rows',7)

	blur: () ->
		this.$message.attr('rows',3)

	checking: () ->

		setTimeout () =>
			this.$button.button					'reset'
		, 400

		if !this.post.get('post_result')
			error()
		else
			this.$el.trigger					'send.success'
			this.$message.val					''


		window.news.feed.news.fetch()

		this.post.unset('id')
		this.post.unset('key')
		this.post.unset('notice')
		this.post.unset('message')
		this.post.unset('post_result')

	submit: (e) ->

		e.preventDefault()

		if window.user?

			this.post.set
				id:								window.user.get('id')
				key:							window.user.get('key')

			this.post.save
				message:						if window.markup? then window.markup.render(this.$message.val()) else this.$message.val()
			,
				url: 							window.sn.get('server').host + '/feed/post/'
				timeout: 						3000
				dataType: 						'jsonp'

				beforeSend: () =>
					this.$button.button 		'loading'

				success: (s) => 
					this.checking()

				error: () =>
					this.$button.button			'reset'
					this.error 					'<b>Ошибка!</b> Сервер не отвечает!'

	keyup: (e) ->
		if e.keyCode is 13 and e.ctrlKey
			this.$form.submit()


	success: () ->
		this.$alertError.hide()

	error: (notice = '') ->

		this.$alertError.show().html 			notice

		setTimeout () =>
			this.$alertError.hide()
		, 2000


