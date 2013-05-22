
module 'Чтение и запись cookies'


test 'autoload', () ->
	alert(document.cookie)

	ok $.cookie('test'), 'test 1'

test 'simple value', () ->

	#set_cookie('test','asfa')
	$.cookie 'test', 'go', expires: 7

	alert(document.cookie)

	ok $.cookie('test'), 'test 2'


test 'Проверка работы cookies в приложении', () ->	
	ok $.cookie('last_href'), 'Сохранение cookies при переходах по страницам'
	ok $.cookie('contacts'), 'Сохранение cookies после закрытия программы'
