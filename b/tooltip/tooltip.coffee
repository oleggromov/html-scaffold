class Tooltip
	constructor: (container, @options) ->
		@container = $ container
		@trigger = $ '.' + @options.trigger, @container
		@content = $ "." + @options.content, @container
		@init()

	init: ->
		
		if (!@content.length)
			return false

		@content.append(
			$ "<span>",
				class: "tooltip__closeButton"
				text: "x"
		)

		@closeButton = $ ".tooltip__closeButton", @content

		@trigger.click (e) =>
			e.preventDefault()
			@show()

		@closeButton.click (e) =>
			e.preventDefault()
			@hide()

	show: ->
		$('.' + @options.content + '_opened')
			.removeClass @options.content + '_opened'
		$('.' + @options.trigger + '_current')
			.removeClass @options.trigger + '_current'
				
		@trigger.addClass(@options.trigger + '_current');
		@content.addClass(@options.content + '_opened');

	hide: ->
		@trigger.removeClass(@options.trigger + '_current');
		@content.removeClass(@options.content + '_opened');			

$ ->
	tooltips = $ ".tooltip"
	options =
		trigger: "tooltip__trigger"
		content: "tooltip__content"

	tooltips.each ->
		new Tooltip this, options		
