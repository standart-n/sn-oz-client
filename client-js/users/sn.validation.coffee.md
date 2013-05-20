	$ ->

		methods =
			init: (options = {}) ->
				$(this).snValidation 'checkField', options

			checkField: (options = {}) ->

				def =
					type:		'post'
					value:		''
					caption:	''
					error:		true
					start:		'В поле'
					exp:		''

				$.extend true, def, options
				value = def.value.toString()

				console.log 'validation: ' + def.type + ' - ' + value if console?

				switch def.type
					when 'firstname'
						if value is '' or value is def.caption 
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
						if value is '' or value is def.caption
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
						if value is '' or value is def.caption
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
						if value is '' or value is def.caption
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
						if value is '' or value is def.caption
							def.exp = 'ничего не указано!'
						else
							if value.length < 3 
								def.exp = 'слишком короткое значение!'
							else
								if value.length > 28 
									def.exp = 'слишком длинное значение!'
								else
									if !value.match(/\+?\d{1,3}(?:\s*\(\d+\)\s*)?(?:(?:\-\d{1,3})+\d|[\d\-]{4,}|(?:\s\d{1,3})+\d)/gi)
										def.exp = 'некорректное значение!'
									else
										def.error = false

					when 'company'
						if value is '' or value is def.caption
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
						if value is '' or value is def.caption
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
				if !def.error
					console.warn def.exp if console?
				def


		$.fn.snValidation = (sn = {}) ->
			if methods[sn]
				methods[sn].apply @, Array.prototype.slice.call arguments, 1
			else 
				methods.init.apply @, arguments


