module.exports = (grunt) ->
	name = 'magazinster'
	stylus = {}
	javascript = {}
	jsMinified = {}
	# separate templates for all pages
	jade =
		'index.html': 'tpl/index.jade'
		'cost.html': 'tpl/cost.jade'
		'detail.html': 'tpl/detail.jade'
		'list.html': 'tpl/list.jade'
	# styles are compiled to one minified css
	stylus["css/#{name}.css"] = 'b/blocks.styl'
	# logic written with coffee is compiled to one js
	javascript["js/#{name}.js"] = 'b/**/*.coffee'

	grunt.initConfig 
		pkg: grunt.file.readJSON 'package.json'
		jade: 
			compile:
				files: jade
				options:
					pretty: true
					data:
						projectName: name
						data:	grunt.file.readJSON 'data.json'
		stylus:
			compile:
				files: stylus
				options:
					compress: false
		coffee:
			compile:
				files: javascript
		connect:
			test:
				options:
					port: 8000
					base: '.'			
		watch:
			jade:
				files: ['tpl/**/*.jade', 'data/**/*.jade', 'b/**/*.jade']
				tasks: 'jade'
			stylus:
				files: 'b/**/*.styl'
				tasks: 'stylus'
			coffee:
				files: 'b/**/*.coffee'
				tasks: 'coffee'


	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-stylus'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-connect'

	grunt.registerTask 'default', ['jade', 'stylus', 'coffee']