$ ->

	methods =
		init: (options = {}) ->

		checkRegForm: (options = {}) ->

			def =
				error: false
			_this = this
			$.extend true, def, options

			$('.signin-warning').hide()
			$('.signin-form-warning').hide()
			$('.signin-type-reg').each () ->
				__this = this
				check = $(_this).snValidation('checkField',
						type:		$(this).data('check-type')
						value:		$(this).val()
						caption:	$(this).data('def-value')
					)
				if check.error isnt undefined
					if check.error
						def.error = true

				$('.signin-warning').each () ->
					if $(this).data('check-type') is $(__this).data('check-type')
						if check.error isnt undefined
							if check.error
								$(this).html(check.start + ' ' + check.caption + ' ' + check.exp).show()

				$('.signin-form-warning').each () ->
					if $(this).data('check-type') is $(__this).data('check-type')
						if check.error isnt undefined
							if check.error
								$(this).show()

				$('.signin-form-check').each () ->
					if $(this).data('check-type') is $(__this).data('check-type')
						if check.error isnt undefined
							if $(this).hasClass('signin-form-check-clear')
								$(this).removeClass('signin-form-check-clear')

							if check.error
								$(this).removeClass('signin-form-check-true')
								$(this).addClass('signin-form-check-false')
							else
								$(this).removeClass('signin-form-check-false')
								$(this).addClass('signin-form-check-true')

			console.info 'afterCheckRegForm', def
			$(this).snRegistration 'afterCheckRegForm', def
			false

		afterCheckRegForm: (options = {}) ->

			def =
				error: false
			$.extend true, def, options
			if def.error
				# alert 'yest error'
				console.warn 'ошибки при проверке формы регистрации'
			else
				alert 'bez oshibok'
				console.info 'regOnServer'
				$(this).snRegistration 'regOnServer'

		regOnServer: (options = {}) ->

			def =
				debug:				off
				type:				'jsonp'
				firstname:			$('#signin-input-firstname').val()
				lastname:			$('#signin-input-lastname').val()
				patronymic:			$('#signin-input-patronymic').val()
				email:				$('#signin-input-email').val()
				phone:				$('#signin-input-phone').val()
				company:			$('#signin-input-company').val()
				post:				$('#signin-input-post').val()
				error:				off

			_this = this
			$.extend true, def, options			
			def.type = 'text' if def.debug
			sn = $(this).data 'sn'

			$.ajax
				url: 'http://oz.st-n.ru/server-dev/?callback=?'
				async: off
				type: 'POST'
				data:
					action:			'registration'
					region:			sn.region.name
					theme:			sn.theme.name
					firstname:		def.firstname
					lastname:		def.lastname
					patronymic:		def.patronymic
					email:			def.email
					phone:			def.phone
					company:		def.company
					post:			def.post

				dataType: def.type
				timeout: 10000
				success: (s) ->
					$.extend true, sn.result, s.registration

					alert s if def.debug
					$(_this).data 'sn', sn
					alert sn.result.alert if sn.result.alert
					console.log 'afterCheckRegFormOnServer', s
					$(_this).snRegistration 'afterCheckRegFormOnServer', s

				error: (XMLHttpRequest,textStatus,error) ->
					console.error 'ajax:', textStatus, error
			
		afterCheckRegFormOnServer: (options = {}) ->
			def =
				'error': false
				'start': 'В поле'

			$.extend true, def, options
			sn = $(this).data 'sn'

			if sn.result.reg
				$(this).snRegistration 'afterSuccessReg', def

			if !sn.result.reg
				def.error = true
				if sn.result.valid
					$.each sn.result.valid, (field,check) ->
						$('.signin-warning').each () ->
							if $(this).data('check-type') is field
								if check.error isnt undefined
									if check.error
										$(this).html(def.start + ' ' + check.def + ' ' + check.exp).show()

						$('.signin-form-warning').each () ->
							if $(this).data('check-type') is field
								if check.error isnt undefined
									if check.error
										$(this).show()
		
						$('.signin-form-check').each () ->
							if $(this).data('check-type') is field
								if check.error isnt undefined
									if $(this).hasClass('signin-form-check-clear')
										$(this).removeClass('signin-form-check-clear')
									
									if (check.error)
										$(this)
											.removeClass('signin-form-check-true')
											.addClass('signin-form-check-false')
									else
										$(this)
											.removeClass('signin-form-check-false')
											.addClass('signin-form-check-true')


	$.fn.snRegistration = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'

	$('#sn').snSignin()

