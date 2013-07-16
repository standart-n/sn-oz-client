
module 'Проверка целостности пакета'

# test 'наличие файлов-настроек в пакете', () ->

# 	sn = $('#sn').data 'sn'

# 	ok sn.conf.main?, '/conf/main.json' 
# 	ok sn.conf.theme?, '/conf/themes.json' 
# 	ok sn.conf.settings?, '/conf/settings.json' 


test 'наличие необходимых библиотек', () ->

	ok window.jQuery?, 'jQuery'
	ok window.EJS?, 'EJS'
	ok window.jQuery.cookie?, 'jquery.cookie' 
	ok window.jQuery.isFunction($.bootstrapIE6)?, 'bootstrap-ie6' 

test 'наличиние необходимых шаблонов и текстов', () ->
	
	ok $('#bar').html() isnt '', 'layout/' + window.sn.region.name + '/bar.html'
	ok $('#main').html() isnt '', 'layout/' + window.sn.region.name + '/main.html'
	ok $('#primary').html() isnt '', 'content/' + window.sn.region.name + '/main.html'
	ok $('#side').html() isnt '', 'content/' + window.sn.region.name + '/side_main.html'

	