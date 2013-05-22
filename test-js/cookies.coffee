
module 'Чтение и запись cookies'


test 'autoload', () ->
	ok getCookie('test'), 'test'

test 'simple value', () ->

	set_cookie('test','asfa',7)

	ok getCookie('test'), 'test 2'


# test 'Проверка работы cookies в приложении', () ->
# 	ok $.cookie('last_href'), 'Сохранение cookies при переходах по страницам' 
# 	ok $.cookie('contacts'), 'Сохранение cookies после закрытия программы' 
