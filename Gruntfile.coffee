module.exports = (grunt) ->
	name = 'scaffold'
	less = {}
	javascript = {}
	jsMinified = {}
	# separate templates for all pages
	jade =
		'index.html': 'tpl/index.jade'
	# styles are compiled to one minified css
	less["css/#{name}.min.css"] = 'b/blocks.less'
	# logic written with coffee is compiled to one js
	javascript["js/#{name}.js"] = 'b/**/*.coffee'
	jsMinified["js/#{name}.min.js"] = ["js/#{name}.js"]

	grunt.initConfig 
		pkg: grunt.file.readJSON 'package.json'
		jade: 
			production:
				files: jade
				options:
					pretty: true
					data:
						projectName: name
		less:
			production:
				files: less
			options:
				yuicompress: true
		coffee:
			compile:
				files: javascript
		uglify:
			default:
				files: jsMinified
					
		watch:
			jade:
				files: '**/*.jade'
				tasks: 'jade'
			less:
				files: 'b/**/*.less'
				tasks: 'less'
			coffee:
				files: 'b/**/*.coffee'
				tasks: 'coffee uglify'

	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'

	grunt.registerTask 'default', ['jade', 'less', 'coffee', 'uglify']