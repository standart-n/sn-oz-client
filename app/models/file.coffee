
Backbone = 							require('Backbone')
bytes = 							require('Bytes')

module.exports = Backbone.Model.extend

	defaults: () ->

		result = 
			name:						''
			original:					''
			type:						''
			size:						0
			sizeFormat:					''
			url:						''

			post_dt:					new Date()



	initialize: () ->
		this.set 'sizeFormat', bytes(this.get('size'))
		alert this.get('sizeFormat')


	reset: () ->
		this.set this.defaults()



