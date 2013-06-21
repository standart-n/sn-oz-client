
'use strict'

module.exports = (grunt) ->

	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')

		jade:
			index:
				options:
					pretty: on
				src: './jade/index.jade'
				dest: './index.html'

			test:
				options:
					pretty: on
				src: './jade/test.jade'
				dest: './test.html'
			
			view:
				options:
					pretty: on
				files: 
					'./view/users/signin.html':	 					'./jade/view/users/signin.jade'
					'./view/users/signinBlockHelp.html':	 		'./jade/view/users/signinBlockHelp.jade'
					'./view/users/signinFormEnter.html':	 		'./jade/view/users/signinFormEnter.jade'
					'./view/users/signinFormReg.html':	 			'./jade/view/users/signinFormReg.jade'
					'./view/users/signinSide.html':	 				'./jade/view/users/signinSide.jade'

			layout:
				options:
					pretty: on
				files: 
					'./layout/izhevsk/bar.html': 					'./jade/layout/izhevsk/bar.jade'
					'./layout/izhevsk/content.html':				'./jade/layout/izhevsk/content.jade'
					'./layout/izhevsk/main.html': 					'./jade/layout/izhevsk/main.jade'

					'./layout/kirov/bar.html': 						'./jade/layout/kirov/bar.jade'
					'./layout/kirov/content.html':					'./jade/layout/kirov/content.jade'
					'./layout/kirov/main.html': 					'./jade/layout/kirov/main.jade'

					'./layout/stavropol/bar.html': 					'./jade/layout/stavropol/bar.jade'
					'./layout/stavropol/content.html':				'./jade/layout/stavropol/content.jade'
					'./layout/stavropol/main.html': 				'./jade/layout/stavropol/main.jade'

					'./layout/volgograd/bar.html': 					'./jade/layout/volgograd/bar.jade'
					'./layout/volgograd/content.html':				'./jade/layout/volgograd/content.jade'
					'./layout/volgograd/main.html': 				'./jade/layout/volgograd/main.jade'

					'./layout/yoshkar/bar.html': 					'./jade/layout/yoshkar/bar.jade'
					'./layout/yoshkar/content.html':				'./jade/layout/yoshkar/content.jade'
					'./layout/yoshkar/main.html': 					'./jade/layout/yoshkar/main.jade'

		recess:
			css:
				options:
					compile: on
				files:
					'style/bootstrap/bootstrap.css': './less/bootstrap/bootstrap.less'
			min:
				options:
					compress: on
				files:
					'style/bootstrap/bootstrap.min.css': './less/bootstrap/bootstrap.less'

		coffee:			
			sn:
				src: ['client/main/*', 'client/users/*', 'client/widgets/*']
				dest: 'script/sn.js'

			test:
				options:
					bare: on
				src: 'test/*'
				dest: 'script/test.js'

		concat:
			bootstrap:
				src: 'bootstrap/*.js'
				dest: 'script/bootstrap.js'


		uglify:
			sn:
				options:
					report: 'min'
				files: 
					'script/sn.min.js': '<%= coffee.sn.dest %>'

			test:
				options:
					report: 'min'
				files: 
					'script/test.min.js': '<%= coffee.test.dest %>'

			bootstrap:
				files: 
					'script/bootstrap.min.js': '<%= concat.bootstrap.dest %>'


	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-recess'
	
	grunt.registerTask 'default', ['recess:css', 'coffee:sn', 'jade:index', 'jade:view', 'jade:layout']
	grunt.registerTask 'all', ['default', 'bootstrap']
	grunt.registerTask 'test', ['jade:test', 'coffee:test']
	grunt.registerTask 'bootstrap', ['concat:bootstrap']
