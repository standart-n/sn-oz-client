$ ->

	methods =
		init: (options = {}) ->
			_this = this
			$(this).on 'click', () ->
				sn = $(_this).data 'sn'
				if sn.levels.one is 'users'
					switch sn.levels.two
						when 'signin'
							$(_this).snSignin()
						when 'help'
							$(_this).snSignin 'help'
					



	$.fn.snUsers = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'

	$('#sn').snUsers()

