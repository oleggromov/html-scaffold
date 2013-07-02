# html-scaffold
An easy way to compile project made with independent blocks.

Html-scaffold allows you to use **Jade templates** (with inheritance, data and view separation etc.) while writing clientside code, split your site into **independent blocks** each with its own **Stylus stylesheet** (with variables, mixins and functions) and **scripts in CoffeeScript**, put into **separate folders** on the filesystem. Then it takes all project files, compiles, minifies and concatenates them together to the production version. 

This is all about using [**BEM methodology**](http://bem.info/method/)—a powerful approach for writing client-side code. The BEM itself gives good, but complicated tools. They're needed when continously developing big projects by big teams, but not for freelance coders or html-guys who make simple web sites every day basically alone.

Html-scaffold gives you chance to make your code better and obtain more pleasant workflow. 


## Requirments
* **Node.js** can be [easily installed](http://nodejs.org/download/) on most OSes. Once you're ready, install grunt-cli.
* **Grunt.js** version 0.4 and higher is needed. Install it globally:
	
		$ npm install -g grunt-cli

	grunt-cli is just a command line wrapper which starts the required version of grunt.


## Usage

Cd to your new project folder and **clone the repo**:
		
	$ git clone git://github.com/oleggromov/html-scaffold.git .

This will create the following directory structure and files. Contents of css/ and js/ directories and index.html will be overwritten each time you exec grunt.
	
	b/
		layout/
			layout.coffee
			layout.jade
			layout.styl
		blocks.styl
	css/
		scaffold.min.css
	data/
		index.jade
	js/
		scaffold.js
		scaffold.min.js
	tpl/
		index.jade
	Gruntfile.coffee
	index.html
	package.json

Then **install node modules**. If you don't have Node.js and Grunt.js installed, see the above section.

	$ npm install

This will download needed modules and create node_modules/ which is ignored in this repo.

	$ ls node-modules/
	grunt  grunt-contrib-coffee  grunt-contrib-jade  grunt-contrib-less
	grunt-contrib-stylus  grunt-contrib-uglify  grunt-contrib-connect


**Change your project name** in Gruntfile.coffee.
	
	module.exports = (grunt) ->
		name = 'scaffold'

Project name is used in config and passed to **index.jade**, so you don't have to change filenames manually. 

	- var stylesheet	= "css/" + projectName + ".min.css"
	- var script		= "js/" + projectName + ".min.js"

Edit your **template's data and template** itself.

data/index.jade

	- var title = "Perfect symmetry"
	- var description = "This is a great album of progmetal group"

tpl/index.jade
	
	- var stylesheet	= "css/" + projectName + ".min.css"
	- var script		= "js/" + projectName + ".min.js"
	include index.data.jade

	- var stylesheet	= "css/" + projectName + ".min.css"
	- var script		= "js/" + projectName + ".min.js"
	include ../data/index
	include ../b/layout/layout

	!!!
	html
		head
			link(href=stylesheet, type="text/css", rel="stylesheet")
			title= title
		body.layout
			+layout(title, description)

			script(src=script)

You can see the definition of layout's mixin in the included /b/layout/layout.jade. Each block has its own templates with mixins, so we can share blocks with different projects easily.


Edit **styles for layout block**.

b/layout/layout.styl

	widthLayout 	= 980px
	sizeCaption 	= 36px
	sizeText 			= 16px

	.layout
		width: widthLayout
		margin: 0 auto

		&__caption
			font-size: sizeCaption
		
		&__text
			font-size: sizeText



Write some **CoffeeScript** for block.

b/layout/layout.coffee
	
	document.write "<b>This is my first html-scaffold project</b>"

This code is automatically wrapped with an immediate function.

**Run grunt.**

	$ grunt

This will create and overwrite the following files.
	
	$ ls css/ js/ index.html 
	index.html

	css/:
	scaffold.min.css

	js/:
	scaffold.js  scaffold.min.js


Then **open index.html** in browser. It's easy and fun!

### Compilation on change
You can also run 
	
	$ grunt watch

so grunt will watch and compile your *.jade, *.styl and *.coffee files located anywhere in your project tree.

### Simple Node.js server for project
You can run

    $ grunt connect watch

so grunt will not only watch and compile necessary files but also start server on localhost:8000.
You can make an ajax request no allowed if you would open index.html in browser just from filesystem.

### Some commands
Update npm:
    $ npm update npm -g

## Why should HTML-coder use this

1. **Organize your code** and make projects scalable using independent blocks in separate folders on the filesystem.

		$ ls b/
		footer/
		head/
		layout/
		link/
		blocks.styl

2. **Compile all stuff automatically** into plain HTML, CSS and Javascript.
	
		$ grunt
		Running "jade:compile" (jade) task
		File "index.html" created.

		Running "stylus:compile" (stylus) task
		File css/scaffold.min.css created.

		Running "coffee:compile" (coffee) task
		File js/scaffold.js created.

		Running "uglify:javascript" (uglify) task
		File "js/scaffold.min.js" created.

		Done, without errors.


3. **Detach content from HTML** using Jade includes.
	
	data/index.jade

		- var title 		= "html-scaffold"
		- var description	= "Project template for an HTML-coder."

	tpl/index.jade

		- var stylesheet	= "css/" + projectName + ".min.css"
		- var script		= "js/" + projectName + ".min.js"
		include ../data/index
		include ../b/layout/layout

		!!!
		html
			head
				link(href=stylesheet, type="text/css", rel="stylesheet")
				title= title
			body.layout
				+layout(title, description)

				script(src=script)

	resulting index.html (with whitespaces)

		<!DOCTYPE html>
		<html>
		  <head>
		    <link href="css/scaffold.min.css" type="text/css" rel="stylesheet">
		    <title>html-scaffold</title>
		  </head>
		  <body class="layout">
		    <h1 class="layout__caption">html-scaffold</h1>
		    <p class="layout__text">Project template for an HTML-coder.</p>
		    <script src="js/scaffold.min.js"></script>
		  </body>
		</html>


4. **Stop annoying by hand HTML writing** and get rid of typos: make an array and iterate through it.

	index.html (before)

		<ul>
			<li><a href="link1.html">First</a></li>
			<li><a href="link2.html">Second</a></li>
			<li><a href="link3.html">Third</a></li>
			<li><a href="link4.html">Fourth</a></li>
		</li>

	index.jade (after)

		- var links = ["link1.html", "link2.html", "link3.html", "link4.html"]
		- var texts = ["First", "Second", "Third", "Fourth"]
		ul
			for link, i in links
				li: a(href=link)= texts[i]


4. **Use variables, mixins, functions etc. in LESS**, which is very close to CSS.

	styles.css

		.layout {
			width: 234px; /* 280 - 23px padding  */
			padding: 10px 23px;
		}

	styles.styl

		width			= 280px
		padding 	= 23px

		.layout
			width: width - padding * 2;
			padding: 10px padding;


5. Use and learn **CoffeeScript** in your everyday work.
6. **Learn Node.js** in a simple and useful for your everyday work way.
7. Get **advanced experience of paid tools for free.** CodeKit and so on are great, but you can get the same things for free.


## TODO
There're many features those can be very useful but not implemented yet.

* JSON as input data for Jade templates
* Production version: unnecessary files removement, branches, images etc.
* Block manipulation commands. Filesystem abstraction: simple grunt commands with [grunt-shell](https://npmjs.org/package/grunt-shell) to manipulate blocks.
* Jade/BEM (kizu)

* Image optimizations with pngcrush or any other plugin.
* Automatic image movement from blocks/ to img/ directory using [grunt-string-replace](https://npmjs.org/package/grunt-string-replace) or [grunt-text-replace](https://npmjs.org/package/grunt-text-replace).

* Add coffeescript example to the Why to use section.
* How does this stuff work.

* Case: include into existing project on Yii, for example
	How to use with backend?
