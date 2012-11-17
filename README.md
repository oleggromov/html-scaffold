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
				title #{title}
			body
				h1 #{title}
				p #{description}

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

4. **TODO CoffeeScript**
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
		blocks.less
	css/
		scaffold.min.css
	js/
		scaffold.min.js
	templates/
		common.jade
		index.data.jade
		index.jade
	grunt.js
	index.html
	package.json

# TODO grunt.js editing

Then **install node modules**. If you don't have Node.js and Grunt.js installed, see the below section.

	$ npm install

This will download needed modules create directory which is ignored in this repo.

	$ ls 
	node_modules/

**Write Jade templates and create jade data-files**

Put your **images and LESS files into separate directories** inside blocks/ folder and import them inside the blocks.less:
	
		@import url('common.less');

		@import url('layout/layout.less');
		@import url('head/head.less');
		@import url('footer/footer.less');


	grunt.js will compile them into a single scaffold.min.css (change fielname in grunt.js config).


**Link each peace of Javascript functionality to the block.** If you have, for example, the floating menu which takes its own folder, create the following file:

	blocks/
		menu/
			menu.coffee

grunt.js will take all cofee files, compile them to js and them concatenate and minify all together:

	$ ls js/
	scaffold.min.js


Every **block with all the files should be in its own directory**, for example:

	blocks/
		layout/
			layout.less
			bg.jpg
		head/
			head.less
			head.png
			menuitem.png
		footer/
			footer.less
			slider.js
			gradient.coffee

		blocks.less

They are **connected together in blocks.less** file

	@import url('layout/layout.less');
	@import url('head/head.less')
	@import url('footer/footer.less')

and then compiled to a single minified css

	$ ls css/
	scaffold.min.css

## TODO
There're many features those can be very useful but not implemented yet.
* SCSS instead of LESS.
* Automatic image movement from blocks/ to img/ directory.
* Development / production versions each in its own directory.