
# bootstrap buttons

require('jquery')

module.exports = class BootstrapButtons

	constructor: () ->

		this.options =
			btnColorCls: 	['btn-primary','btn-warning','btn-danger','btn-success','btn-info','btn-inverse','btn-link']
			btnSizeCls:		['btn-mini','btn-small','btn-large']

		_this = this

		$ () ->

			if 	navigator?.userAgent?.toLowerCase().indexOf('msie 6.0') > -1

				$(document).on 'mouseenter', '.btn', () ->
					__this = this
					hover = 'btn-hover'
					
					$.each _this.options.btnColorCls, (k,v) ->				
						hover = v + '-hover' if $(__this).hasClass(v)
					
					$(this).data 'ie6hover', hover
					$(this).addClass hover

				$(document).on 'mouseleave', '.btn', () ->			
					hover = $(this).data('ie6hover')

					$(this).removeData 'ie6hover', hover
					if (hover) then $(this).removeClass hover
