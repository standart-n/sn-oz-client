
Template = 								require('Template')

module.exports = Template.extend

	el: 								'.registration-alert-error'
	url:								'view/registration/alertError.html'

	initialize: () ->

	render: () ->
		this.template()

	show: (err) ->
		this.err = err
		switch err.field
			when "firstname" 			then this.err.field = "Имя"
			when "lastname" 			then this.err.field = "Фамилия"
			when "company" 				then this.err.field = "Компания"			
			when "email" 				then this.err.field = "e-mail"
		this.$el.show()
		this.render()

	hide: () ->
		this.$el.hide()
		
	data: () ->
		result = 
			field: 						this.err.field
			description: 				this.err.description
