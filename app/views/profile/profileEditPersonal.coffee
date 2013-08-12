
Backbone = 									require('Backbone')
Template = 									require('Template')

module.exports = Template.extend

	el:										'#tab-profile-personal'
	url:									'view/profile/profileEditPersonal.html'

	events:
		'submit .profile-personal-form' 	: 'submit'

	initialize: () ->

		this.render()

		this.$firstname = 					this.$el.find('.profile-firstname')
		this.$lastname = 					this.$el.find('.profile-lastname')

		this.$success = 					this.$el.find('.alert-success')
		this.$error = 						this.$el.find('.alert-error')

		this.$button = 						this.$el.find('button')

		if window.user?

			window.user.on 'change:firstname', () =>
				this.$firstname.val window.user.get('firstname')

			window.user.on 'change:lastname', () =>
				this.$lastname.val window.user.get('lastname')

	render: () ->
		this.template()
		

	data: () ->
		if window.user? then window.user.toJSON() else {}

	submit: (e) ->
		e.preventDefault()

		if window.user? and window.sn?

			window.user.save
				firstname_new:				this.$firstname.val()
				lastname_new:				this.$lastname.val()
			,
				url: 						window.sn.get('server').host + '/edit/personal/'
				timeout: 					3000
				dataType: 					'jsonp'

				beforeSend: () =>
					this.$button.button 	'loading'

				success: (s) => 
					this.checking()

				error: () =>
					this.$button.button		'reset'
					this.error 				'<b>Ошибка!</b> Сервер не отвечает!'

	checking: () ->

		setTimeout () =>
			this.$button.button				'reset'
		, 400

		if window.user?

			if window.user.get('personal_change') is true
				this.success 				window.user.get('notice') + '.'

			else 
				this.error 					'<b>Ошибка!</b> ' + window.user.get('notice').replace('Error: ','') + '.'


			window.user.unset 'notice'
			window.user.unset 'firstname_new'
			window.user.unset 'lastname_new'

	error: (notice = '') ->

		this.$error.show().html	 			notice
		this.$success.hide()

		setTimeout () =>
			this.$error.hide()
		, 3000


	success: (notice = '') ->

		this.$success.show().html 			notice
		this.$error.hide()

		setTimeout () =>
			this.$success.hide()
		, 1500






