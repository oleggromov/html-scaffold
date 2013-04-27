module.exports = function(grunt) {
	var projectName = "html-scaffold",
		pathCSS 	= {},
		pathJS	 	= {},
		pathJade	= {};

	// Put here all your templates and filenames they needed to be compilated to.
	pathJade = {
		"index.html": "tpl/index.jade",
	};
	// LESS compiles all blocks to a single css/{projectName}.min.css file.
	// pathCSS['css/' + projectName + '.min.css'] = 'b/blocks.less';
	pathCSS['css/' + projectName + '.min.css'] = 'b/blocks.styl';
	// CoffeeScript creates single js/{projectName}.min.js script.
 	pathJS['js/' + projectName + '.js'] = 'b/*/*.coffee';

	grunt.initConfig({
		// Compile jade templates to plain htmls.
		jade: {
			production: {
				files: pathJade,
				options: {
					pretty: true,
					data: {
						// Project name is passed to templates too to know actual CSS and JS filesnames.
						projectName: projectName
					}
				}
			}
		},
		// Make CSS of LESS.
		// less: {
		// 	production: {
		// 		files: pathCSS,
		// 		options: {
		// 			yuicompress: true
		// 		}
		// 	}
		// },
		stylus: {
			compile: {
				files: pathCSS
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
			// less: {
			// 	files: '**/*.less',
			// 	tasks: 'less'
			// },
			stylus: {
				files: '**/*.styl',
				tasks: 'stylus'
			},
			coffee: {
				files: '**/*.coffee',
				tasks: 'coffee min'
			}
		}
	});

	grunt.loadNpmTasks('grunt-contrib-jade');
	// grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-stylus');
	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.registerTask('default', 'jade stylus coffee min');
};