
Backbone = 							require('Backbone')
bytes = 							require('Bytes')

module.exports = Backbone.Model.extend

	defaults: () ->

		result = 
			name:						''
			originalName:				''
			type:						''
			size:						0
			sizeFormat:					''
			url:						''
			group:						'files'

			thumbnail:					null
			preview:					null

			resolution:
				width:					0
				height:					0

			type: 						'file'

			post_dt:					new Date()



	initialize: () ->
			this.set 'sizeFormat', bytes(this.get('size'))

	reset: () ->
		this.set this.defaults()



