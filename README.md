# html-scaffold
An easy way to compile project made with independent blocks.

Html-scaffold allows you to use **Jade templates** (with inheritance, data and view separation etc.) while writing clientside code, split your site into **independent blocks** each with its own **LESS stylesheets** (with variables, mixins and functions) and **scripts in CoffeeScript**, put into **separate folders** on the filesystem. Then it takes all project files, compiles, minifies and concatenates them together to the production version. 

This is all about using [**BEM methodology**](http://bem.info/method/)—a powerful approach for writing client-side code. The BEM itself gives good, but complicated tools. They're needed when continously developing big projects by big teams, but not for freelance coders or html-guys who make simple web sites every day basically alone.

Html-scaffold gives you chance to make your code better and obtain more pleasant workflow. 


## Requirments
* **Node.js** can be [easily installed](http://nodejs.org/download/) on most OSes. Once you're ready, install grunt.
* **Grunt.js** is better when installed globally, so you can use it in every project located anywhere on your filesystem:
	
		$ npm install -g grunt


## Usage

Cd to your new project folder and **clone the repo**:
		
	$ git clone git://github.com/oleggromov/html-scaffold.git .

This will create the following directory structure and files. Contents of css/ and js/ directories and index.html will be overwritten each time you exec grunt.
	
	blocks/
		layout/
			layout.less
			layout.coffee
		blocks.less
	css/
		html-scaffold.min.css
	js/
		html-scaffold.js
		html-scaffold.min.js
	templates/
		index.data.jade
		index.jade
	grunt.js
	index.html
	package.json

Then **install node modules**. If you don't have Node.js and Grunt.js installed, see the above section.

	$ npm install

This will download needed modules and create node_modules/ which is ignored in this repo.

	$ ls node-modules/
	grunt-contrib-coffee  grunt-contrib-jade  grunt-contrib-less


**Change your project name** in grunt.js.
	
	module.exports = function(grunt) {
		var projectName = "html-scaffold",

Project name is used in config and passed to **index.jade**, so you don't have to change filenames manually. 

	- var stylesheet	= "css/" + projectName + ".min.css"
	- var script		= "js/" + projectName + ".min.js"

Edit your **template's data and template** itself.

index.data.jade

	- var title = "Perfect symmetry"
	- var description = "This is a great album of progmetal group"

index.jade
	
	- var stylesheet	= "css/" + projectName + ".min.css"
	- var script		= "js/" + projectName + ".min.js"
	include index.data.jade

	!!!
	html
		head
			link(href=stylesheet, type="text/css", rel="stylesheet")
			title= title
		body.layout
			h1.layout__caption= title
			p.layout__text !{description}

			script(src=script)

Edit **styles for layout block**.

blocks/layout/layout.less

	@widthLayout: 600px;
	@sizeCaption: 48px;
	@sizeText: 14px;

	.layout {
		width: @widthLayout;
		margin: 0 auto;

		&__caption {
			font-size: @sizeCaption;
		}

		&__text {
			font-size: @sizeText;
		}
	}


Write some **CoffeeScript** for block.

blocks/layout/layout.coffee
	
	document.write "<b>This is my first html-scaffold project</b>"

This code is automatically wrapped with an immediate function.

**Run grunt.**

	$ grunt

This will create and overwrite the following files.
	
	$ ls css/ js/ index.html
	index.html

	css/:
	html-scaffold.min.css

	js/:
	html-scaffold.js  html-scaffold.min.js

Then **open index.html** in browser. It's easy and fun!


## Why should HTML-coder use this

1. **Organize your code** and make projects scalable using independent blocks in separate folders on the filesystem.

		$ ls blocks/
		footer/
		head/
		layout/
		link/
		blocks.less

2. **Compile all stuff automatically** into plain HTML, CSS and Javascript.
	
		$ grunt
		Running "jade:production" (jade) task
		File index.html created.

		Running "less:production" (less) task
		File css/html-scaffold.min.css created.

		Running "coffee:compile" (coffee) task
		File js/html-scaffold.js created.

		Running "min:simple" (min) task
		File "js/html-scaffold.min.js" created.
		Uncompressed size: 78 bytes.
		Compressed size: 89 bytes gzipped (69 bytes minified).

		Done, without errors.

3. **Detach content from HTML** using Jade includes.
	
	index.data.jade

		- var title 		= "html-scaffold"
		- var description	= "Project template for an HTML-coder."

	index.jade

		- var stylesheet	= "css/" + projectName + ".min.css"
		- var script		= "js/" + projectName + ".min.js"
		include index.data.jade

		!!!
		html
			head
				link(href=stylesheet, type="text/css", rel="stylesheet")
				title= title
			body.layout
				h1.layout__caption= title
				p.layout__text !{description}

				script(src=script)

	resulting index.html (with whitespaces)

		<!DOCTYPE html>
		<html>
			<head>
				<link href="css/html-scaffold.min.css" type="text/css" rel="stylesheet">
				<title>html-scaffold</title>
			</head>
			<body class="layout">
				<h1 class="layout__caption">
					html-scaffold
				</h1>

				<p class="layout__text">
					Project template for an HTML-coder.
				</p>

				<script src="js/html-scaffold.min.js"></script>
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

	styles.less

		@width: 280px;
		@padding: 23px;

		.layout {
			width: @width - @padding * 2;
			padding: 10px @padding;
		}

5. Use and learn **CoffeeScript** in your everyday work.
6. **Learn Node.js** in a simple and useful for your everyday work way.
7. Get **advanced experience of paid tools for free.** CodeKit and so on are great, but you can get the same things for free.


## TODO
There're many features those can be very useful but not implemented yet.

* Filesystem abstraction: simple grunt commands with [grunt-shell](https://npmjs.org/package/grunt-shell) to manipulate blocks.
* Automatic image movement from blocks/ to img/ directory using [grunt-string-replace](https://npmjs.org/package/grunt-string-replace) or [grunt-text-replace](https://npmjs.org/package/grunt-text-replace).
* Image optimizations with pngcrush or any other plugin.
* Development / production versions each in its own directory.
* SCSS instead of LESS.
* Add coffeescript example to the Why to use section.
* Add grunt production task which creates a folder and moves there all necessary files
* Add grunt watch task
* Correct dependencies' versions in package.json.

* Case: include into existing project on Yii, for example
* How does this stuff work.

* JSON as input data for Jade templates

* Concatenating also plain js-files
