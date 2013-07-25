
# Content

Template = require('Template')

module.exports = Template.extend

	path: 		'content'
	ext: 		'.html'
	markup: 	on

	render: () ->
		if this.file?
			this.beforeRender()
			region = 		window.sn.get('region').name
			this.url = 		"#{this.path}/#{region}/#{this.file}"
			this.template()
			this.afterRender()

	
	data: () ->
		result = 
			region: 	window.sn.get('region')
			theme:		window.sn.get('theme')

	beforeRender: () ->

	afterRender: () ->
		this.$el.find('.tooltip-toggle').tooltip()

		# if $.browser.msie and parseInt($.browser.version, 10) is 6
		# 	$(".row div[class^=\"span\"]:last-child").addClass "last-child"
		# 	$("[class*=\"span\"]").addClass "margin-left-20"
		# 	$('[class*="span"][class*="offset"]').removeClass('margin-left-20');
		# 	$(":button[class=\"btn\"], :reset[class=\"btn\"], :submit[class=\"btn\"], input[type=\"button\"]").addClass "button-reset"
		# 	$(":checkbox").addClass "input-checkbox"
		# 	$("[class^=\"icon-\"], [class*=\" icon-\"]").addClass "icon-sprite"
		# 	$(".pagination li:first-child a").addClass "pagination-first-child"		
				
		# setTimeout () ->
		# 	if $.isFunction($.bootstrapIE6) then $.bootstrapIE6(this.el)
		# , 1
