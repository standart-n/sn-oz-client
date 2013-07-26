
# complete

Backbone = require('Backbone')

module.exports = Backbone.View.extend

	defaults:
		icons:	 		on
		tooltips:		off
		buttonGroups: 	off


	initialize: () ->
		_.defaults this.options, this.defaults
		this.tooltips() if this.options.tooltips
		if navigator?.userAgent?.toLowerCase().indexOf('msie 6.0') > -1
			this.icons() if this.options.icons

	icons: () ->
		this.$el.find('[class^="icon-"],[class*=" icon-"]').each () ->
			if (!$(this).hasClass('icon-xxx'))
					$(this).addClass('icon-xxx').css
						'background-position-y': (parseInt($(this).css('background-position-y')) + 1).toString() + 'px'

	tooltips: () ->
		this.$el.find('.tooltip-toggle').tooltip()

	buttonGroups: () ->
		# btn-first
		this.$el.find('.btn-group').parent().find('.btn-group:eq(0)').addClass('btn-group-first')
		this.$el.find('.btn').parent().find('.btn:eq(0)').addClass('btn-first')

