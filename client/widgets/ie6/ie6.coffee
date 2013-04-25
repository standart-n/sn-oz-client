$ ->

	methods = 
		init: () ->
			if $.browser.msie and parseInt($.browser.version, 10) is 6
				$(".row div[class^=\"span\"]:last-child").addClass "last-child"
				$("[class*=\"span\"]").addClass "margin-left-20"
				$('[class*="span"][class*="offset"]').removeClass('margin-left-20');
				$(":button[class=\"btn\"], :reset[class=\"btn\"], :submit[class=\"btn\"], input[type=\"button\"]").addClass "button-reset"
				$(":checkbox").addClass "input-checkbox"
				$("[class^=\"icon-\"], [class*=\" icon-\"]").addClass "icon-sprite"
				$(".pagination li:first-child a").addClass "pagination-first-child"

	$.fn.ie6 = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

