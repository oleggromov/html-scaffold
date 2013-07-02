class Faq
	constructor: (@node, @options) ->
		
		for k, v of @options.containers
			@["$#{k}"] = $("." + v);	
		
		@init()

	init: -> 
		@addEvents()

		@$triggers
			.eq( @options.start - 1 )
			.addClass(@options.containers.triggers + @options.currentMod)

		@$texts	
			.eq( @options.start - 1 )
			.addClass(@options.containers.texts + @options.currentMod)

	addEvents: ->
		@$triggers.click (e) =>
			@showText e

	showText: (e) ->
		e.preventDefault()
		
		$trigger = $(e.target.parentNode)
		id = $trigger.attr "href"

		if not id.length
			return false

		@$triggers
			.removeClass(@options.containers.triggers + @options.currentMod)
			.filter($trigger)
			.addClass @options.containers.triggers + @options.currentMod

		@$texts
			.removeClass(@options.containers.texts + @options.currentMod)
			.filter('[id = "' + id.slice(1, this.length) + '"]')
			.addClass @options.containers.texts + @options.currentMod

		false	

$ -> 
	block = "faq"
	options =
		containers:
			block: block
			triggers: block + "__trigger"
			texts: block + "__text"
		currentMod: "_current"
		start: 1

	$("." + block).each ->
		new Faq this, options