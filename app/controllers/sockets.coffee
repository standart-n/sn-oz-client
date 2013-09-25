
_ = 										require('underscore')
Backbone = 									require('Backbone')
SockJS = 									require('SockJS')

module.exports = class Sockets

	constructor: () ->

		_.extend this, Backbone.Events

		this.initSocket()

		if window.user?
			window.user.on 'change:signin', () =>
				this.authOnServer()
	

	initSocket: () ->

		this.socket = new SockJS(window.sn.get('server').host + '/sockets')

		# this.socket = new SockJS window.sn.get('server').host + '/sockets', null,
		# 	debug: on
		# 	protocols_whitelist: [
		# 		'jsonp-polling'
		# 	]

		this.socket.onopen = () =>
			window.isSocketReady = true
			this.authOnServer()
			

		this.socket.onmessage = (s) =>
			if s?.data?
				data = JSON.parse(s.data)
				if data?.message?
					this.trigger data.message, data

		
		this.socket.onclose = () =>
			window.isSocketReady = false
			# setTimeout () =>
			# 	this.initSocket()
			# , 10000



	authOnServer: () ->
		if isSocketReady
			this.socket.send JSON.stringify
				message:		'connect'
				user_id:		if window.user? 	then window.user.get('id') 		else null
				token:			if window.user? 	then window.user.get('token') 	else null
				sessid:			if window.user? 	then window.user.get('sessid') 	else null
				region:			if window.sn? 		then window.sn.get('region') 	else null






