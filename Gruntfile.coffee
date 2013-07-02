module.exports = (grunt) ->
	name = 'scaffold'
	stylus = {}
	javascript = {}
	jsMinified = {}
	# separate templates for all pages
	jade =
		'index.html': 'tpl/index.jade'
	# styles are compiled to one minified css
	stylus["css/#{name}.min.css"] = 'b/blocks.styl'
	# logic written with coffee is compiled to one js
	javascript["js/#{name}.js"] = 'b/**/*.coffee'
	jsMinified["js/#{name}.min.js"] = ["js/#{name}.js"]

	grunt.initConfig 
		pkg: grunt.file.readJSON 'package.json'
		jade: 
			compile:
				files: jade
				options:
					pretty: true
					data:
						projectName: name
		stylus:
			compile:
				files: stylus
		coffee:
			compile:
				files: javascript
		uglify:
			javascript:
				files: jsMinified
		watch:
			jade:
				files: ['tpl/**/*.jade', 'data/**/*.jade', 'b/**/*.jade']
				tasks: 'jade'
			stylus:
				files: 'b/**/*.styl'
				tasks: 'stylus'
			coffee:
				files: 'b/**/*.coffee'
				tasks: 'coffee uglify'

	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-stylus'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-watch'

	grunt.registerTask 'default', ['jade', 'stylus', 'coffee', 'uglify']
