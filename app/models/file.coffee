
Backbone = 							require('Backbone')

module.exports = Backbone.Model.extend

	defaults: () ->

		result = 
			name:						''
			original:					''
			type:						''
			size:						0
			sizeFormat:					''
			url:						''
			group:						'files'

			post_dt:					new Date()



	initialize: () ->


	reset: () ->
		this.set this.defaults()



