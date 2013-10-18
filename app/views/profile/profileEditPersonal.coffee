
require('moment')

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

			window.user.set
				firstname_new:				this.$firstname.val()
				lastname_new:				this.$lastname.val()

			req = JSON.stringify _.pick(window.user.toJSON(),'id','firstname_new', 'lastname_new')

			window.user.save null,
				url: 						window.sn.get('server').host + '/edit/personal/'
				timeout: 					10000
				dataType: 					'jsonp'
				data:
					model:					req
					sessid:					window.user.get('sessid')
					token:					window.user.get('token')
					_method:				'PUT'

				beforeSend: () =>
					this.$button.button 	'loading'

				success: (s) => 
					this.checking(s)

				error: () =>
					this.$button.button		'reset'
					this.error 				'<b>Ошибка!</b> Сервер не отвечает!'

	checking: () ->

		# jalert s

		setTimeout () =>
			this.$button.button				'reset'
		, 400

		if window.user?

			if window.user.get('success') is true
				this.success 				window.user.get('notice') + '.'

			else 
				this.error 					'<b>Ошибка!</b> ' + window.user.get('notice') + '.'


			window.user.unset 'notice'
			window.user.unset 'firstname_new'
			window.user.unset 'lastname_new'

	
	error: (notice = 'Произошла ошибка!') ->

		mark = moment().unix()

		this.$error.show().html	 			notice
		this.$error.data 'mark', 			mark
		this.$success.hide()

		setTimeout () =>
			if this.$error.data('mark') is mark
				this.$error.hide()
		, 3000


	success: (notice = '') ->

		mark = moment().unix()

		this.$success.show().html 			notice
		this.$success.data 'mark', 			mark
		this.$error.hide()

		setTimeout () =>
			if this.$success.data('mark') is mark
				this.$success.hide()
		, 3000






