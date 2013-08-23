
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


	checking: () ->

		setTimeout () =>
			this.$button.button					'reset'
		, 400

		if !this.post.get('success')
			this.error()
		else
			this.$el.trigger					'send'
			this.$message.val					''

		this.post.reset()

	submit: (e) ->


		e.preventDefault()

		if window.user?

			if window.user.get('signin') is true

				author = 
					id:								window.user.get('id')
					key:							window.user.get('key')

				message = 
					text:							this.$message.val()


				if message.text isnt ''

					this.post.save
						author:							author
						message:						message
						region:							window.sn.get('region')
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

			else

				this.$el.trigger 'not_signin'


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


