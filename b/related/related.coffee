class Accordeon
	constructor: (container) ->
		@container = $(container)
		@trigger = $('.related__trigger', @container)
		@content = $('.related__text', @container)
		@activeClasses =
			trigger: 'related__trigger_current'
			content: 'related__text_current'
		@init()

	init: ->

		@trigger.click (e) =>
			$trigger = $(e.target)
			e.preventDefault()

			@show($trigger)

		@trigger.first().click()

	show: ($trigger) ->
		id = $trigger.data('id')

		@trigger
			.removeClass(@activeClasses.trigger)
			.filter('[data-id="' + id + '"]')
			.addClass(@activeClasses.trigger)

		@content
			.removeClass(@activeClasses.content)
			.filter('[data-id="' + id + '"]')
			.addClass(@activeClasses.content)	


$ -> 
	$posts = $('.related__list_faq')
	$posts.each ->
		new Accordeon(this)