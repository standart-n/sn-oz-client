
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
					'./layout/izhevsk/main.html': 					'./jade/layout/izhevsk/main.jade'
					'./layout/izhevsk/footer.html':					'./jade/layout/izhevsk/footer.jade'

					'./layout/kirov/bar.html': 						'./jade/layout/kirov/bar.jade'
					'./layout/kirov/main.html': 					'./jade/layout/kirov/main.jade'
					'./layout/kirov/footer.html':					'./jade/layout/kirov/footer.jade'

					'./layout/stavropol/bar.html': 					'./jade/layout/stavropol/bar.jade'
					'./layout/stavropol/main.html': 				'./jade/layout/stavropol/main.jade'
					'./layout/stavropol/footer.html':				'./jade/layout/stavropol/footer.jade'

					'./layout/volgograd/bar.html': 					'./jade/layout/volgograd/bar.jade'
					'./layout/volgograd/main.html': 				'./jade/layout/volgograd/main.jade'
					'./layout/volgograd/footer.html':				'./jade/layout/volgograd/footer.jade'

					'./layout/yoshkar/bar.html': 					'./jade/layout/yoshkar/bar.jade'
					'./layout/yoshkar/main.html': 					'./jade/layout/yoshkar/main.jade'
					'./layout/yoshkar/footer.html':					'./jade/layout/yoshkar/footer.jade'

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
				options:
					bare: on
				files:
					'script/app.js': 					'app/app.coffee'
					'script/controllers/console.js':	'app/controllers/console.coffee'
					'script/controllers/layout.js':		'app/controllers/layout.coffee'
					'script/models/settings.js':		'app/models/settings.coffee'
					'script/views/template.js':			'app/views/template.coffee'
					'script/views/content.js': 			'app/views/content.coffee'
					'script/views/contentSide.js': 		'app/views/contentSide.coffee'
					'script/views/layout.js': 			'app/views/layout.coffee'
					'script/views/layoutBar.js': 		'app/views/layoutBar.coffee'
					'script/views/layoutMain.js': 		'app/views/layoutMain.coffee'
					'script/views/layoutFooter.js': 	'app/views/layoutFooter.coffee'
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

		lmd:
			build_name: 'sn'



	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-recess'
	grunt.loadNpmTasks 'grunt-lmd'
	
	grunt.registerTask 'default', ['recess:css', 'coffee:sn', 'jade:index', 'jade:view', 'jade:layout', 'lmd']
	grunt.registerTask 'all', ['default', 'bootstrap']
	grunt.registerTask 'test', ['jade:test', 'coffee:test']
	grunt.registerTask 'bootstrap', ['concat:bootstrap']
