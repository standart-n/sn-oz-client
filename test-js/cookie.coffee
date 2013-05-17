test "Проверка cookies", () ->
	sn = $('#sn').data 'sn'
	ok $.cookie('last_href'), "Наличие $.cookie('last_href')" 
