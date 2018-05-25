<script type="text/javascript"><!--
	// 2016/03/03 // 2016/10/28

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.custom_init = function(){
		
	}
	
	// << ITS OWN FUNCTIONS
	
	poip_product_custom.prototype.custom_refreshPopup = function() {
	
		if ( $('#quickview_product .popup-gallery .thumbnails-carousel').length && !$('#quickview_product .popup-gallery .thumbnails-carousel').closest('html').is('.quickview') ) {
		
			$('#poip_popup').remove();
			$('#quickview_product').before('<div id="poip_popup" style="display:none;"></div>');
			
			var added_imgs = [];
			$('#quickview_product .popup-gallery .thumbnails-carousel a:not([disabled])').each(function(){
				
				if ( $.inArray($(this).attr('href'), added_imgs) == -1 ) {
					$('#poip_popup').append( $(this).clone() );
					added_imgs.push($(this).attr('href'));
				}
				
			});
		
			$('#poip_popup').magnificPopup({
				delegate: 'a.popup-image',
				type: 'image',
				tLoading: 'Loading image #%curr%...',
				mainClass: 'mfp-with-zoom',
				gallery: {
					enabled: true,
					navigateByImgClick: true,
					preload: [0,1] // Will preload 0 - before current, and 1 after the current image
				},
				image: {
					tError: '<a href="%url%">The image #%curr%</a> could not be loaded.',
					titleSrc: function(item) {
						return item.el.attr('title');
					}
				}
			});
			
			$('#quickview_product .popup-gallery a').off('click');
			$('#quickview_product .popup-gallery .thumbnails-carousel a, #ex1').off('click');
			$('#quickview_product .popup-gallery .thumbnails-carousel a, #ex1').on('click', function(e){
				
				e.preventDefault();
				e.stopPropagation();
				
				$('#poip_popup a[href="'+$(this).attr('href')+'"]').click();
				
			});
		}
	}
	
	// >> ITS OWN FUNCTIONS
	
	// << ADDITIONAL FUNCTIONS
	// without replacing or stopping original script execution, just addition
	

	poip_product_custom.prototype.additional_documentReady = function() {
		var this_object = this;
		
		this_object.custom_refreshPopup();
	}

	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm (prefixes replace_ and if_)

	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		clearTimeout(this_object.set_visible_images_timer_id);
		if (!counter) counter = 1;
		if (counter == 100) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		var carousel_selector = '.thumbnails-carousel';
		var carousel_elem = $(carousel_selector);
	
		if ( carousel_elem.length ) {
			
			if ( !$('#poip_images').length ) {
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('a').each(function(){
					$('#poip_images').append( $(this).clone() );
				});
			}
			
			var current_carousel = carousel_elem.data('owlCarousel');
			
			if ( this_object.set_visible_images_first_call ) {
				if (!current_carousel || !carousel_elem.find('.owl-item').length || document.readyState != "complete" ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
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
					html += '<div class="item">'+ this_object.getElementOuterHTML(elem) +'</div>';
				}
			}
			carousel_elem.replaceWith('<div class="thumbnails-carousel owl-carousel">'+html+'</div>');
			
			// get again after replacement
			carousel_elem = $(carousel_selector);
			
			carousel_elem.owlCarousel({
				autoPlay: 6000, //Set AutoPlay to 3 seconds
				navigation: true,
				navigationText: ['', ''],
				itemsCustom : [
					[0, 4],
					[450, 6],
					[550, 6],
					[768, 5],
					[1200, 6]
				],
			});
			
			if (poip_settings['img_hover']) {
				carousel_elem.find('a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		}
		this_object.set_visible_images_timer_id = false;
		this_object.set_visible_images_first_call = false;
	}

	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		var poip_img = this_object.getImageBySrc(img_click, 'popup');
		if ( poip_img ) {
		
			$('#quickview_product #ex1').attr('href', poip_img['popup']);
			$('#quickview_product #ex1 img').attr('src', poip_img['popup']);
			$('#quickview_product #ex1 img').attr('data-zoom-image', poip_img['popup']);
			
			this_object.custom_refreshPopup();
			
		}
		
		return true;
	}
	
	poip_product_custom.prototype.replace_getAdditionalImagesBlock = function() {
		var this_object = this;
		
		return $('#quickview_product .popup-gallery .thumbnails-carousel');
	}

	poip_product_custom.prototype.replace_useMainImageUpdatingOnMouseover = function() {
		return false;
	}

	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>