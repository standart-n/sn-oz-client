
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
			
			view:
				options:
					pretty: on
				files: [
					{
						expand:			true
						cwd:			'./jade/view/'
						src:			'**/*.jade'
						dest:			'./view/'
						ext:			'.html'
					}
				]

			layout:
				options:
					pretty: on
				files: [
					{
						expand:			true
						cwd:			'./jade/layout/'
						src:			'**/*.jade'
						dest:			'./layout/'
						ext:			'.html'
					}
				]

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
				files: [
					{
						expand:			true
						cwd:			'./app/'
						src:			'./**/*.coffee'
						dest:			'./script/'
						ext:			'.js'
					}
				]
			
			server:
				options:
					bare: on
				src: 	'server/server.coffee'
				dest: 	'./server.js'

			test:
				options:
					bare: on
				src: 	'test/*'
				dest: 	'script/test.js'

		concat:
			bootstrap:
				src: 	'bootstrap/bootstrap-*.js'
				dest: 	'bootstrap/bootstrap.js'


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
				options:
					compress: true					
					report: 'min'
				files: 
					'lib/bootstrap/bootstrap.min.js': '<%= concat.bootstrap.dest %>'

		lmd:
			build_name: 'sn'


	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-recess'
	grunt.loadNpmTasks 'grunt-lmd'
	
	grunt.registerTask 'default', ['recess:css', 'coffee:sn', 'jade:index', 'jade:view', 'jade:layout', 'lmd']
	grunt.registerTask 'all', ['bootstrap','default']
	grunt.registerTask 'test', ['coffee:server', 'coffee:test']
	grunt.registerTask 'bootstrap', ['concat:bootstrap', 'uglify:bootstrap']
