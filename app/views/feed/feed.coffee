
require('jQueryWidget')
require('IframeTransport')
require('FileUpload')

# require('io')

# io = 										require('socket.io')
Template = 									require('Template')
FeedBox = 									require('FeedBox')
FeedNews = 									require('FeedNews')
AboutView = 								require('AboutView')


module.exports = Template.extend

	el: 									'#feed'
	url: 									'view/feed/feed.html'

	initialize: () ->

		_this = this


		this.aboutView = 					new AboutView()

		socket = 							window.io.connect window.sn.get('server').host + '/'

		# jalert _.keys window.io.sockets['http://dev.st-n.ru:80']

		socket.emit 'why', store: 'get out'

		socket.on 'news', (data) ->
			jalert data



		if window.user?
			window.user.on 'change:signin', () =>
				if window.user.get('signin') is true
					if this.news?
						this.news.fetch()
					if this.box?
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
