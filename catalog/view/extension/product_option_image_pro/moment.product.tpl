<script type="text/javascript"><!--
	// 2016/02/24

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.custom_init = function(){
		
	}
	
	// << ITS OWN FUNCTIONS
	// >> ITS OWN FUNCTIONS
	
	// << ADDITIONAL FUNCTIONS
	// without replacing or stopping original script execution, just addition
	
	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm (prefixes replace_ and if_)

	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		clearTimeout(this_object.set_visible_images_timer_id);
		if (!counter) counter = 1;
		if (counter == 50) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		var carousel_elem = $('#image-additional');
	
		if ( carousel_elem.length ) {
			
			if ( !$('#poip_images').length ) {
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('a').each(function(){
					$('#poip_images').append( $(this).clone() );
				});
			}
			
			var current_carousel = carousel_elem.data('owlCarousel');
			
			if (!current_carousel || !carousel_elem.find('.owl-item').length || !$('.zoomContainer').length || document.readyState != "complete" ) {
				this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
				return;
			}
			
			var current_imgs = [];
			carousel_elem.find('a').each( function(){
				//if ( $.inArray($(this).attr('href'), current_imgs) == -1) {
					current_imgs.push($(this).attr('href'));
				//}
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			var shown_imgs = [];
			
			html = '';
			// correct order of images
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				
				var elem = $('#poip_images a[href="'+images[i]+'"]:first');
				if (elem.length) {
					html += '<div>'+ this_object.getElementOuterHTML(elem) +'</div>';
				}
				
			}
			
			carousel_elem.replaceWith('<div class="thumbnails__list-image owl-carousel" id="image-additional">'+html+'</div>');
			//current_carousel.addItem(html);
			//current_carousel.reinit();
			
			// get again after replacement
			carousel_elem = $('#image-additional');
			
			carousel_elem.owlCarousel({
				loop:true,
				margin:10,
				responsive:{
					0:{
						items:2
					},
					600:{
						items:3
					},
					1000:{
						items:5
					}
				}
			})
			
			// elevateZoom destroy
			$.removeData($('#main-image'), 'elevateZoom');
			$('.zoomContainer').remove();
			$('.thumbnails__big-image .zoomWrapper:first').replaceWith($('.thumbnails__big-image .zoomWrapper img'));
			
			if (Kuler.image_zoom_type == 'outer_cloud' || Kuler.image_zoom_type == 'inner_cloud') {
				var zoom_params = {
					cursor: 'pointer',
					galleryActiveClass: 'active',
					imageCrossfade: true,
					lensShape: Kuler.lens_zoom_shape == 'rounded' ? 'round' : 'square'
				};
		
				if (Kuler.image_zoom_type == 'outer_cloud') {
					zoom_params.zoomWindowWidth = Kuler.zoom_window_width;
					zoom_params.zoomWindowHeight = Kuler.zoom_window_height;
				}
		
				if (Kuler.image_zoom_type == 'inner_cloud') {
					zoom_params.zoomType = 'inner';
				}
		
				$("#main-image").elevateZoom(zoom_params);
			}
		
			if (Kuler.image_lightbox) {
				$("#main-image").unbind('click');
				$("#main-image").bind("click", function(e) {
					var $this = $(this);
		
					var items = [{
						src: $this.data('zoomImage') || this.src
					}];
					
					for (var i in images) {
						if ( !images.hasOwnProperty(i) ) continue;
						if (items[0].src != images[i]) {
							items.push({
								src: images[i]
							});
						}
					}
		
					$.magnificPopup.open({
						items: items,
						gallery: {
							enabled: true
						},
						type: 'image',
						mainClass: 'mfp-fade'
					});
		
					e.preventDefault();
				});
			}
			
			if (poip_settings['img_hover']) {
				carousel_elem.find('a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
			
			
		}
		
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		$('#main-image').attr('data-zoom-image', img_click);
		$('#main-image').data('zoomImage', img_click);
	
		this_object.elevateZoomDirectChange(img_click);
		
		return true;
	}
	
	poip_product_custom.prototype.replace_getDocumentReadyState = function() {
		var this_object = this;
		
		return document.readyState == 'complete' && $('.zoomContainer').length;
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>