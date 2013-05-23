
module 'Чтение и запись cookies'

# возможность очистить cookies на странице с тестами
$('.removeCookies').on 'click', (e) ->
	$.each($.cookie(), $.removeCookie)


test 'чтение и запись простых значений', () ->

	$.removeCookie 'test'
	$.cookie 'test', 'go', expires: 7
	strictEqual $.cookie('test'), 'go', 'запись простого значения'

	$.removeCookie 'test'
	strictEqual $.cookie('test'), null, 'удаление простого значения'


test 'запись cookies после перехода по страницам', () ->

	$.removeCookie 'last_href'
	$('#sn').snEvents '#main/text/main'
	ok $.cookie('last_href'), 'last_href'
