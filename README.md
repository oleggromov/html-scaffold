# html-scaffold
Project template for an HTML-coder.

Html-scaffold takes your **Jade**, **CoffeeScript** and **LESS** files, compiles, minifies and concatenates them together to the production version.

This is all about using [**BEM methodology**](http://bem.info/method/)—a powerful approach for writing client-side code. The BEM itself gives good, but complicated tools. They're needed when continously developing big projects by big teams, but not for freelance coders or html-guys who make simple web sites every day basically alone.

Html-scaffold gives you chance to make your code better and obtain more pleasant workflow. 

## Why should I use it

1. **Organize your code** and make projects scalable using Blocks, Elements and their Modifiers.
2. Don't think about compiling all this stuff into plain HTML, CSS and Javascript.
	
		$ grunt

3. **Detach content from HTML** by using Jade includes.
	
	index.data.jade

		- var title = "html-scaffold"
		- var description = "An easy way to better code"

	index.jade

		include index.data.jade
		!!!
		html
			head
				title= title
			body
				h1= title
				p= description

	resulting index.html (with whitespaces)

		<!DOCTYPE html>
		<html>
			<head>
				<title>html-scaffold</title>
			</head>
			<body>
				<h1>html-scaffold</h1>
				<p>An easy way to better code</p>
			</body>
		</html>

3. **Stop annoying by hand HTML writing** and get rid of typos: make an array and iterate through it.

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
				li: a(href=link) #{texts[i]}


3. **Use variables, mixins, functions etc in LESS**, which is very close to CSS.

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

4. Use **CoffeeScript** in your everyday work.
5. **Learn Node.js** in a simple and useful for your everyday work way.
6. Stop paying for expensive tools like Codekit (which is great, of course), understand modern opensource tools and make your work simplier for the cost of $0,00.


## Requirments
* **Node.js** can be [easily installed](http://nodejs.org/download/) on most OSes. Once you're ready, install grunt.
* **Grunt.js** is better when installed globally, so you can use it in every project located anywhere on your filesystem:

		$ npm install -g grunt


## Usage

Cd to your new project folder and **clone the repo**:
		
	$ git clone git@github.com:oleggromov/html-scaffold.git .

This will create the following directory structure and files:
	
	blocks/
		layout/
			layout.less
			layout.coffee
		blocks.less
	css/
	js/
	templates/
		common.jade
		index.data.jade
		index.jade
	grunt.js
	index.html
	package.json

Then **install node modules**. If you don't have Node.js and Grunt.js installed, see the above section.

	$ npm install

This will download needed modules create directory which is ignored in this repo.

	$ ls 
	node_modules/


**Change your project name** in grunt.js.
	
	module.exports = function(grunt) {
		var projectName = "helloworld",

Project name is used in config and passed to **index.jade**, so you don't have to change filenames manually. 

	- var linkCss		= "css/" + projectName + ".min.css"
	- var linkJs		= "js/" + projectName + ".min.js"

Edit your **template's data and template** itself.

index.data.jade

	- var title = "Perfect symmetry"
	- var description = "This is a great album of progmetal group"

index.jade
	
	- var linkCss		= "css/" + projectName + ".min.css"
	- var linkJs		= "js/" + projectName + ".min.js"
	include index.data.jade
	!!!
	html
		head
			title= title
			link(href=linkCss, type="text/css", rel="stylesheet")
		body.layout
			.layout__wrapper
				h1.layout__title= title
				p.layout__desc= description

			script(src=linkJs)

Create **styles for layout block**.

blocks/layout/layout.less

	@width: 980px;

	.layout {
		min-width: @width;

		&__wrapper {
			width: @width;
			margin: 0 auto;
		}

		&__title {
			font-size: 36px;
		}

		&__desc {
			font-size: 14px;
		}
	}


Write some **CoffeeScript** for block.

blocks/layout/layout.coffee
	
	alert "HTML scaffold is ready"

This code is automatically wrapped with an immediate function.

**Run grunt.**

	$ grunt

This will create the following files.
	
	$ ls
	css/
		html-scaffold.css
	js/
		html-scaffold.js
		html-scaffold.min.js
	index.html

Then **open index.html** in browser. It's easy and fun!

## TODO
There're many features those can be very useful but not implemented yet.
* Filesystem abstraction: simple commands to manipulate blocks
* Automatic image movement from blocks/ to img/ directory.
* Development / production versions each in its own directory.
* SCSS instead of LESS.
* Add coffeescript example to the Why to use section.
* https://npmjs.org/package/grunt-shell for creating blocks with a command
* https://npmjs.org/package/grunt-string-replace or https://npmjs.org/package/grunt-text-replace for replacing paths to files
* grunt production task which creates a folder and moves there all necessary files