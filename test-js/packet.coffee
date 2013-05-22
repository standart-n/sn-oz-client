
module 'Проверка целостности пакета'

test 'Проверка наличия файлов-настроек в пакете', () ->

	sn = $('#sn').data 'sn'

	ok sn.conf.main?, '/conf/main.json' 
	ok sn.conf.theme?, '/conf/themes.json' 
	ok sn.conf.settings?, '/conf/settings.json' 


test 'Проверка на наличиние необходимых библиотек', () ->

	ok window.jQuery?, 'jQuery'
	ok window.EJS?, 'EJS'
	ok window.jQuery.cookie?, 'jquery.cookie' 
	ok window.jQuery.isFunction($.bootstrapIE6)?, 'bootstrap-ie6' 

test 'Проверка на наличиние необходимых шаблонов и текстов', () ->
	
	sn = $('#sn').data 'sn'

	ok $('#bar').length, 'layout/' + sn.region.name + '/bar.html'
	ok $('#main').length, 'layout/' + sn.region.name + '/main.html'
	ok $('#primary').length, 'content/' + sn.region.name + '/main.html'
	ok $('#side').length, 'content/' + sn.region.name + '/side_main-dev.html'

	