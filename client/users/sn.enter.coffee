$ ->

	$this =
		init: (options = {}) ->


		checkEnterForm: (options = {}) ->

			sn = $(this).data 'sn'
			console.log 'enter: ' + 'checkEnterForm'

			alert 'enter'
			console.info 'sn', sn
			false


	$.fn.snEnter = (sn = {}) ->
		if $this[sn]
			$this[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			$this.init.apply @, arguments


