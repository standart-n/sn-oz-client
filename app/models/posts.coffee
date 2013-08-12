
Backbone = 									require('Backbone')

Post = 										require('Post')

module.exports = Backbone.Collection.extend

	model:									Post

	comparator: (post) ->
		Math.pow(10,10) - moment(post.get('post_dt')).unix()


	