
require('_')

Template = 									require('Template')
Post = 										require('Post')
Complete = 									require('Complete')
FeedBoxFiles = 								require('FeedBoxFiles')

module.exports = Template.extend

	el: 									'#feed-box'
	url: 									'view/feed/feedBox.html'

	events: () ->
		'submit form'						: 'submit'
		'keyup .feed-post-message'			: 'keyup'

	initialize: () ->

		this.el = 							'#feed-box'

		this.post = 						new Post()

		this.boxFiles = 					new FeedBoxFiles()

		this.render()

		this.$form = 						this.$el.find('form')
		this.$message = 					this.$el.find('textarea')
		this.$button = 						this.$el.find('button')
		this.$alertError = 					this.$el.find('.alert-error')
		this.$fileInput = 					this.$el.find('.feed-post-file')
		this.$fileUpload = 					this.$el.find('.feed-post-upload')

		this.showFileInput()

	
	showFileInput: () ->
		# if window.user.get('signin') is true
		# 	this.$fileInput.show()
		# 	this.fileUpload()
		# 	this.boxFiles.setElement 		'#feed-box-files'
		# else 
		# 	this.$fileInput.hide()
		this.$fileInput.hide()


	fileUpload: () ->

		this.$fileUpload.fileupload
			url: 		"#{window.sn.get('server').host}/upload/?id=#{window.user.get('id')}&key=#{window.user.get('key')}"
			dataType: 	'json'
			# done: (e, data) =>
			# 	this.afterFileUpload(data)
			done: (e, data) =>
				this.afterFileUpload(data)
			fail: (e, data) =>
				this.error('Произошла ошибка при загрузке файла')
				# alert e


	afterFileUpload: (data) ->
		# jalert(data)
		# alert data
		# console.log data

		# $('#feed').html JSON.stringify(data.toJSON())

		# $('#body').html JSON.stringify(data)

		# alert data.dataType

		if data.result?[0]
			if data.result[0].error?
				switch data.result[0].error
					when 'File is too big'
						this.error('Размер файла не должен превышать <b>10mb</b>')
					when 'User not found'
						this.error('Вы не авторизованы')
					else 
						this.error(data.error.toString())
			else 
				this.boxFiles.files.add
					name:		data.result[0].name
					original:	data.result[0].original
					type:		data.result[0].type
					size:		data.result[0].size
					url:		data.result[0].url

		else
			this.error('Ошибка при загрузке файла!')



	render: () ->
		this.template()
		new Complete
			el: 			this.el
			icons:			on


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

				message = 
					text:								this.$message.val()


				if message.text isnt ''

					this.post.save
						message:						message
						region:							window.sn.get('region')
					,
						url: 							window.sn.get('server').host + '/feed/post/'
						timeout: 						20000
						dataType: 						'jsonp'
						# data:
						# 	token:						window.user.get('token')


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

		this.$alertError.show().html(notice)

		setTimeout () =>
			this.$alertError.hide()
		, 3000

