$ ->

	methods =
		init: (options = {}) ->
			def =
				'el':'#primary-content'

			$.extend true, def, options
			$(this).ozSignin 'triggers', def
			sn = $(this).data 'oz'

		triggers: (def = {}) ->
			oz = $(this)
			$('.signin-input').on 'focus', () ->
				if $(this).val() == $(this).data('def-value') || $(this).val() == ''
					$(this).removeClass('signin-input-blur')
					$(this).addClass('signin-input-focus')
					$(this).val('')
					$(this).select()

			$('.signin-input').on 'blur', () ->
				if $(this).val() == $(this).data('def-value') || $(this).val() == ''
					$(this).removeClass('signin-input-focus')
					$(this).addClass('signin-input-blur')
					$(this).val($(this).data('def-value'))

			$('#signin-form-enter').on 'submit', (e) ->
				e.preventDefault()
				oz.ozSignin 'checkEnterForm'

			$('#signin-button-enter').on 'click', (e) ->
				e.preventDefault()
				oz.ozSignin 'checkEnterForm'

			$('#signin-form-reg').on 'submit', (e) ->
				e.preventDefault()
				oz.ozSignin 'checkRegForm'

			$('#signin-button-reg').on 'click', (e) ->
				e.preventDefault()
				oz.ozSignin 'checkRegForm'

			$('.signin-type-reg').on 'keyup', () ->
				th = $(this)
				check = oz.ozSignin('checkField',
						'type': $(this).data('check-type')
						'value': $(this).val()
						'caption': $(this).data('def-value')
					)

				$('.signin-form-check').each () ->
					if $(this).data('check-type') == th.data('check-type')
						if check.error != undefined
							if $(this).hasClass 'signin-form-check-clear'
								$(this).removeClass 'signin-form-check-clear'

							if check.error
								$(this).removeClass('signin-form-check-true')
								$(this).addClass('signin-form-check-false')
							else
								$(this).removeClass('signin-form-check-false')
								$(this).addClass('signin-form-check-true')


		checkField: (options = {}) ->

			def =
				'type': 'post'
				'value': ''
				'caption': ''
				'error': true
				'start': 'В поле'
				'exp': ''

			$.extend true, def, options
			value = def.value.toString()

			switch def.type
				when 'firstname'
					if value == '' || value == def.caption 
						def.exp = 'ничего не указано!'
					else
						if value.length < 3 
							def.exp = 'слишком короткое значение!'
						else
							if value.length > 28
								def.exp = 'слишком длинное значение!'
							else
								if !value.match(/^([а-я\-\.]+)$/gi)
									def.exp = 'некорректное значение!'
								else
									def.error = false

				when 'lastname'
					if value == '' || value == def.caption
						def.exp = 'ничего не указано!'
					else
						if value.length < 3
							def.exp = 'слишком короткое значение!'
						else
							if value.length > 28
								def.exp = 'слишком длинное значение!'
							else
								if !value.match(/^([а-я\-\.]+)$/gi)
									def.exp = 'некорректное значение!'
								else
									def.error = false

				when 'patronymic'
					if value == '' || value == def.caption
						def.exp = 'ничего не указано!'
					else
						if value.length < 3
							def.exp = 'слишком короткое значение!'
						else
							if value.length > 28
								def.exp = 'слишком длинное значение!'
							else
								if !value.match(/^([а-я\-\.]+)$/gi)
									def.exp = 'некорректное значение!'
								else
									def.error = false

				when 'email'
					if value == '' || value == def.caption
						def.exp = 'ничего не указано!'
					else
						if value.length < 3
							def.exp = 'слишком короткое значение!'
						else
							if value.length > 28
								def.exp = 'слишком длинное значение!'
							else
								if !value.match(/\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b/gi)
									def.exp = 'некорректное значение!'
								else
									def.error = false

				when 'phone'
					if value == '' || value == def.caption
						def.exp = 'ничего не указано!'
					else
						if value.length < 3 
							def.exp = 'слишком короткое значение!'
						else
							if value.length > 28 
								def.exp = 'слишком длинное значение!'
							else
								if !value.match(/\+?\d{1,3}(?:\s*\(\d+\)\s*)?(?:(?:\-\d{1,3})+\d|[\d\-]{6,}|(?:\s\d{1,3})+\d)/gi)
									def.exp = 'некорректное значение!'
								else
									def.error = false

				when 'company'
					if value == '' || value == def.caption
						def.exp = 'ничего не указано!'
					else
						if value.length < 3
							def.exp = 'слишком короткое значение!'
						else
							if value.length > 28
								def.exp = 'слишком длинное значение!'
							else
								if !value.match(/^([а-яa-z0-9\-\.\,\'\'\<\>\ ]+)$/gi)
									def.exp = 'некорректное значение!'
								else
									def.error = false

				when 'post'
					if value == '' || value == def.caption
						def.exp = 'ничего не указано!'
					else
						if value.length < 3
							def.exp = 'слишком короткое значение!'
						else
							if value.length > 28
								def.exp = 'слишком длинное значение!'
							else
								if !value.match(/^([а-яa-z0-9\-\.\,\'\'\ ]+)$/gi)
									def.exp = 'некорректное значение!'
								else
									def.error = false

			def

		checkEnterForm: (options = {}) ->
			alert 'enter'
			false

		checkRegForm: (options = {}) ->
			def =
				'error': false
			oz = $(this)
			$.extend true, def, options

			$('.signin-warning').hide()
			$('.signin-form-warning').hide()
			$('.signin-type-reg').each () ->
				th=$(this)
				check = oz.ozSignin('checkField',
						'type':$(this).data('check-type')
						'value':$(this).val()
						'caption':$(this).data('def-value')
					)
				if check.error != undefined
					if check.error
						def.error = true

				$('.signin-warning').each () ->
					if $(this).data('check-type') == th.data('check-type')
						if check.error != undefined
							if check.error
								$(this).html(check.start + ' ' + check.caption + ' ' + check.exp).show()

				$('.signin-form-warning').each () ->
					if $(this).data('check-type') == th.data('check-type')
						if check.error != undefined
							if check.error
								$(this).show()

				$('.signin-form-check').each () ->
					if $(this).data('check-type') == th.data('check-type')
						if check.error != undefined
							if $(this).hasClass('signin-form-check-clear')
								$(this).removeClass('signin-form-check-clear')

							if check.error
								$(this).removeClass('signin-form-check-true')
								$(this).addClass('signin-form-check-false')
							else
								$(this).removeClass('signin-form-check-false')
								$(this).addClass('signin-form-check-true')

			$(this).ozSignin 'afterCheckRegForm', def
			false

		afterCheckRegForm: (options = {}) ->

			def =
				'error':false
			$.extend true, def, options
			if def.error
				alert 'yest error'
			else
				alert 'bez oshibok'
				$(this).ozSignin 'regOnServer'

		regOnServer: (options = {}) ->

			def =
				'debug': false
				'type': 'jsonp'
				'firstname': $('#signin-input-firstname').val()
				'lastname': $('#signin-input-lastname').val()
				'patronymic': $('#signin-input-patronymic').val()
				'email': $('#signin-input-email').val()
				'phone': $('#signin-input-phone').val()
				'company': $('#signin-input-company').val()
				'post': $('#signin-input-post').val()
				'error': false

			oz = $(this)
			$.extend true, def, options
			if def.debug
				def.type = 'text'
			sn = $(this).data('oz')

			$.ajax
				url: 'http://oz.st-n.ru/server-dev/?callback=?'
				async: true
				type: 'POST'
				data:
					action: 'registration'
					region: sn.region.name
					theme: sn.theme.name
					firstname: def.firstname
					lastname: def.lastname
					patronymic: def.patronymic
					email: def.email
					phone: def.phone
					company: def.company
					post: def.post

				dataType: def.type
				timeout: 10000
				success: (s) ->
					$.extend true, sn.result, s.registration

					alert s if def.debug
					$(this).data 'oz', sn
					alert sn.result.alert if sn.result.alert
					if !s.reg
						if s.valid
							oz.ozSignin 'afterCheckRegFormOnServer', s
					else
						# alert('go!')

				error: (XMLHttpRequest,textStatus,error) ->
					alert error
			
		afterCheckRegFormOnServer: (options = {}) ->
			def =
				'error': false
				'start': 'В поле'

			$.extend true, def, options
			sn = $(this).data 'oz'
			if !sn.result.reg
				def.error = true
				if sn.result.valid
					$.each sn.result.valid, (field,check) ->
						$('.signin-warning').each () ->
							if $(this).data('check-type') == field
								if check.error != undefined
									if check.error
										$(this).html(def.start + ' ' + check.def + ' ' + check.exp).show()

						$('.signin-form-warning').each () ->
							if $(this).data('check-type') == field
								if check.error != undefined
									if check.error
										$(this).show()
		
						$('.signin-form-check').each () ->
							if $(this).data('check-type') == field
								if check.error != undefined
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


	$.fn.ozSignin = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
