test "Проверка работы cookies", () ->
	ok $.cookie('last_href'), "Сохранение cookies при переходах по страницам" 
	ok $.cookie('contacts'), "Сохранение cookies после закрытия программы" 
