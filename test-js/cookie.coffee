test "Проверка работы cookies", () ->
	sn = $('#sn').data 'sn'
	ok $.cookie('last_href'), "Сохрание cookie при переходах по страница" 
	ok $.cookie('contacts'), "Сохрание cookie после закрытия программы" 
