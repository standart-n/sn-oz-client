
Template = 									require('Template')
Files = 									require('Files')

module.exports = Template.extend

	el: 									'#feed-box-files'
	url: 									'view/feed/feedBoxFiles.html'

	initialize: () ->

		this.files = 						new Files()


