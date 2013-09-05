

Sync = 										require('Sync')

module.exports = Sync.extend

	startSync: () ->

		if this.posts?

			this.adding()

			this.removing()



	adding: () ->

		this.posts.on 'add', (post) =>

			console.log post.toJSON()

			post.on 'change:formatting', () =>

				$post = 	this.$el.find("[data-post-id=\"#{post.get('id')}\"]")
				$text = 	$post.find('.post-text')

				$text.html post.get 'formatting'


			post.on 'change:post_moment', () =>

				$post = 	this.$el.find("[data-post-id=\"#{post.get('id')}\"]")
				$moment = 	this.$el.find('.post-footer-date')

				$moment.html post.get 'post_moment'



			if this.isFirst(this.posts,post) 
				this.prepend(post) 

			else 
				this.append(post)


	removing: () ->

		this.posts.on 'remove', (post) =>

			$post = 	this.$el.find("[data-post-id=\"#{post.get('id')}\"]")

			$post.remove()





