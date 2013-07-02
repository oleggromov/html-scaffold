$ ->
	$sticky = $ '.stickyeah' 
	$wrapper = $ '.layout__contentWrapper'
	wrapperHeight = $wrapper.height()
	wrapperTop = $wrapper.offset().top
	topLimit = wrapperTop + wrapperHeight - 1.5*$sticky.outerHeight(true)
	$w = $ window

	$w.scroll (e) ->
		if !$sticky.data('initialized')
			return	

		if $w.scrollTop() >= topLimit
			$sticky.trigger('stickyeah:disable')
		else
			$sticky.trigger('stickyeah:enable')	

		