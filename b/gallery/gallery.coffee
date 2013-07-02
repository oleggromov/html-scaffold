indexGallery = (($)->
	gallery = $(".gallery__slidesjs")
	commonSlideEffect = "fade"
	options =
		width: 960,
		height: 610,
		navigation:
			effect: commonSlideEffect
		pagination:
			effect: commonSlideEffect
		play:
			active: false,
			auto: true,
			effect: commonSlideEffect,
			pauseOnHover: true

	{
		init: ->
			gallery.slidesjs options
	}
) jQuery

$ -> 
	indexGallery.init()
	