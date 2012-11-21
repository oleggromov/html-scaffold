module.exports = function(grunt) {
	var projectName = "html-scaffold",
		pathCSS 	= {},
		pathJS	 	= {},
		pathJade	= {};

	// Put here all your templates and filenames they needed to be compilated to.
	pathJade = {
		"index.html": "templates/index.jade",
	};
	// LESS compiles all blocks to a single css/{projectName}.min.css file.
	pathCSS['css/' + projectName + '.min.css'] = 'blocks/blocks.less';
	// CoffeeScript creates single js/{projectName}.min.js script.
 	pathJS['js/' + projectName + '.js'] = 'blocks/*/*.coffee';

	grunt.initConfig({
		// Compile jade templates to plain htmls.
		jade: {
			production: {
				files: pathJade,
				options: {
					data: {
						// Project name is passed to templates too to know actual CSS and JS filesnames.
						projectName: projectName
					}
				}
			}
		},
		// Make CSS of LESS.
		less: {
			production: {
				files: pathCSS,
				options: {
					yuicompress: true
				}
			}
		},
		// Compile CoffeeScript to JavaScript.
		coffee: {
			compile: {
				files: pathJS
			}
		},
		// Concatenate JS files with ';' separator.
		min: {
			simple: {
				src: ['js/' + projectName + '.js'],
				dest: 'js/' + projectName + '.min.js',
				separator: ';'
			}
		},
		// Watches on your files' changes
		watch: {
			jade: {
				files: '**/*.jade',
				tasks: 'jade'
			},
			less: {
				files: '**/*.less',
				tasks: 'less'
			},
			coffee: {
				files: '**/*.coffee',
				tasks: 'coffee min'
			}
		}
	});

	grunt.loadNpmTasks('grunt-contrib-jade');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.registerTask('default', 'jade less coffee min');
};