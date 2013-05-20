test "Проверка наличия файлов-настроек в пакете", () ->

	$.ajax
		url: 'conf/main.json'
		async: off
		dataType: 'json'
		success: (s) ->
			ok s?, "Наличие /conf/main.json" 

	$.ajax
		url: 'conf/themes.json'
		async: off
		dataType: 'json'
		success: (s) ->
			ok s?, "Наличие /conf/themes.json" 

	$.ajax
		url: 'conf/settings.json'
		async: off
		dataType: 'json'
		success: (s) ->
			ok s?, "Наличие /conf/settings.json" 

	
