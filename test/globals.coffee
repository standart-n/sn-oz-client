
module 'Проверка глобальные переменных'

test 'наличие window.sn', () ->

	ok window.sn?, 'window.sn'
	ok window.sn.region?.name? and window.sn.region.name isnt 'unknow', 'window.sn.region.name'
	ok window.sn.region?.caption? and window.sn.region.caption isnt 'unknow', 'window.sn.region.caption'
	ok window.sn.theme?.name? and window.sn.theme.name isnt 'unknow', 'window.sn.theme.name'
	ok window.sn.theme?.caption? and window.sn.theme.caption isnt 'unknow', 'window.sn.theme.caption'
	ok window.sn.wiki?.images?.url?, 'window.sn.wiki.images'
	ok window.sn.wiki?.files?.url?, 'window.sn.wiki.files'
	ok window.sn.wiki?.gismeteo?.url?, 'window.sn.wiki.gismeteo'
	