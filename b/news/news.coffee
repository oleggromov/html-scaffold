$ ->
	newsGalleries = $('.news__gallery')

	commonSlideEffect = 'fade'

	options =
		width: 400,
		height: 315,
		navigation:
			active: false
			effect: commonSlideEffect
		pagination:
			effect: commonSlideEffect
		play:
			active: false

	newsGalleries.slidesjs options