
require('jQueryWidget')
require('IframeTransport')
require('FileUpload')

Template = 									require('Template')
FeedBox = 									require('FeedBox')
FeedNews = 									require('FeedNews')
AboutView = 								require('AboutView')


module.exports = Template.extend

	el: 									'#feed'
	url: 									'view/feed/feed.html'

	initialize: () ->

		_this = this

		# this.$parent = 						'#primary'

		# if this.$parent.find(this.el).lenght
		# 	this.render()


		# this.render()

		this.aboutView = 					new AboutView()

		# if window.app?
		# 	window.app.on 'switch', () =>
		# 		this.setElement('#feed')
		# 		this.render()

		if window.user? and this.box?
			window.user.on 'change:signin', () =>
				# this.news.fetch()
				this.box.showFileInput()

		$(document).on 'scrollDown', () ->	
			if _this.news?
				_this.news.down()


		$(document).on 'click', '[data-action="edit post"]', (e) ->

			e.preventDefault()

			if $(this).data('post')? and _this.news?
				_this.news.editPost $(this).data('post')


		$(document).on 'click', '[data-action="save post"]', (e) ->

			e.preventDefault()

			if $(this).data('post')? and _this.news?
				_this.news.savePost $(this).data('post')


		$(document).on 'keyup', '.feed-post-edit', (e) ->

			if e.keyCode is 13 and e.ctrlKey

				if $(this).data('post')? and _this.news?
					_this.news.savePost $(this).data('post')


			if e.keyCode is 27

				if $(this).data('post')? and _this.news?
					_this.news.blurPost $(this).data('post')



		$(document).on 'click', '[data-action="blur post"]', (e) ->

			e.preventDefault()

			if $(this).data('post')? and _this.news?
				_this.news.blurPost $(this).data('post')



		$(document).on 'click', '[data-action="remove post"]', (e) ->

			e.preventDefault()

			if $(this).data('post')? and _this.news?
				_this.news.removePost $(this).data('post')


		$(document).on 'click', '[data-action="delete post"]', (e) ->

			e.preventDefault()

			if $(this).data('post')?
				_this.news.deletePost $(this).data('post')


		setInterval () =>
			if this.news?
				this.news.updating()
		, 60000



	render: (el = '#feed') ->

		if el?
			this.setElement(el)

		this.template()
		this.box.remove()					if this.box?
		this.news.remove()					if this.news?
		this.box = 							new FeedBox()
		this.news = 						new FeedNews()

		this.box.$el.on 'send', () =>
			if this.news?
				this.news.fetch()

		this.box.$el.on 'not_signin', () =>
			if this.aboutView?
				this.aboutView.show()
