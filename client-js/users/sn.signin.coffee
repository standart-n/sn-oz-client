$ ->

	methods =
		init: (options = {}) ->

			sn = $(this).data 'sn'
			def = {}		
			$.extend true, def, options

			console.log 'signin: ' + 'init' if console?
			console.log 'render: ', def if console?

			$(this).snModels 'primary', view: 'signin.html'
			$(this).snModels 'side', view: 'signinSide.html'
			$(this).snTriggers 'switch', 'side', sn.levels.two
			$(this).snTriggers 'switch', 'bar', sn.levels.one
			$(this).snTriggers 'links', 'side'
			$(this).snTriggers 'hover', 'side'
			$(this).snSignin 'triggers', def

		help: (options = {}) ->

			console.log 'signin: ' + 'help' if console?

			def = {}
			$.extend true, def, options
			
			$(this).snModels 'primary', view: 'signinBlockHelp.html', position: 'before'
			$(this).snSignin 'triggers'


		triggers: (options = {}) ->

			_this = this
			console.log 'signin: ' + 'triggers' if console?

			$('.signin-input').on 'focus', () ->
				if $(this).val() is $(this).data('def-value') or $(this).val() is ''
					$(this).removeClass('signin-input-blur')
					$(this).addClass('signin-input-focus')
					$(this).val('')
					$(this).select()

			$('.signin-input').on 'blur', () ->
				if $(this).val() is $(this).data('def-value') or $(this).val() is ''
					$(this).removeClass('signin-input-focus')
					$(this).addClass('signin-input-blur')
					$(this).val($(this).data('def-value'))

			$('#signin-form-enter').on 'submit', (e) ->
				e.preventDefault()
				$(_this).snEnter 'checkEnterForm'

			$('#signin-button-enter').on 'click', (e) ->
				e.preventDefault()
				$(_this).snEnter 'checkEnterForm'

			$('#signin-form-reg').on 'submit', (e) ->
				e.preventDefault()
				$(_this).snRegistration 'checkRegForm'

			$('#signin-button-reg').on 'click', (e) ->
				e.preventDefault()
				$(_this).snRegistration 'checkRegForm'

			$('.signin-type-reg').on 'keyup', () ->
				__this = this
				check = $(_this).snValidation('checkField',
						type:		$(this).data('check-type')
						value:		$(this).val()
						caption:	$(this).data('def-value')
					)

				$('.signin-form-check').each () ->
					if $(this).data('check-type') is $(__this).data('check-type')
						if check.error?
							if $(this).hasClass 'signin-form-check-clear'
								$(this).removeClass 'signin-form-check-clear'

							if check.error
								$(this).removeClass('signin-form-check-true')
								$(this).addClass('signin-form-check-false')
							else
								$(this).removeClass('signin-form-check-false')
								$(this).addClass('signin-form-check-true')



	$.fn.snSignin = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments


