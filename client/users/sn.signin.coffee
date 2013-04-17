$ ->

	methods =
		init: (options = {}) ->
			_this = this
			$(this).on 'click', () ->
				sn = $(_this).data 'sn'
				if sn.levels.two is 'signin'
					def =
						view: 
							signin: new EJS(url: 'view/signin.html', ext: '.html').render
									signinFormEnter:	new EJS(url: 'view/signinFormEnter.html', ext: '.html').render()
									signinFormReg:		new EJS(url: 'view/signinFormReg.html', ext: '.html').render()
						
					$.extend true, def, options

					$(_this).snModels 'primary', text: def.view.signin
					$(_this).snSignin 'triggers', def

		triggers: (def = {}) ->
			_this = this
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
						if check.error isnt undefined
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
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'

	$('#sn').snSignin()

