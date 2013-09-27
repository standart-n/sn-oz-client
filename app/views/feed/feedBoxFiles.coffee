
FeedBoxFilesSync = 							require('FeedBoxFilesSync')
Files = 									require('Files')

module.exports = FeedBoxFilesSync.extend

	el: 									'#feed-box-files'
	url: 									'view/feed/feedBoxFiles.html'

	initialize: () ->

		this.files = 						new Files()

		this.startSync()


