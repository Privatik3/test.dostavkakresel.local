<script type="text/javascript"><!--
	// 2016/03/29 // 2016/04/14 // 2016/10/08

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.custom_init = function(){
		
	}
	
	// << ITS OWN FUNCTIONS
	poip_product_custom.prototype.custom_refreshPopup = function(){
		
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
	
		
	// << REPLACEMENT OF EXISTING FUNCTIONS
	// >> REPLACEMENT OF EXISTING FUNCTIONS
	
	
	// << ADDITIONAL ACTIONS
	// without replacing or stopping original script execution, just addition
	
	// >> ADDITIONAL ACTIONS 
	
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		clearTimeout(this_object.set_visible_images_timer_id);
		if (!counter) counter = 1;
		if (counter == 100) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
	
		<?php if ( !empty($theme_options) && ($images || $theme_options->get( 'product_image_zoom' ) != 2) && $theme_options->get( 'position_image_additional' ) != 2 ) { ?>
	
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
					this_object.set_visible_images_first_call = false;
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
				
				// old version of owlCarousel used, only complete carousel replacing will work
				/*
				var elems_cnt = current_carousel.itemsAmount;
				for (var i = 1; i<=elems_cnt; i++ ) {
					current_carousel.removeItem();
				}
				*/
				
				//$('.image-additional.owl-carousel .owl-wrapper').html('');
				//current_carousel.reinit();
				
				var shown_imgs = [];
				
				html = '';
				// correct order of images
				for (var i in images) {
					if ( !images.hasOwnProperty(i) ) continue;
					var elem = $('#poip_images a[href="'+images[i]+'"]:first');
					if (elem.length) {
						html += '<div class="item">'+ this_object.getElementOuterHTML(elem) +'</div>';
						//current_carousel.addItem('<div>'+ this_object.getElementOuterHTML($(this)) +'</div>');
					}
				}
				
				carousel_elem.replaceWith('<div class="thumbnails-carousel owl-carousel">'+html+'</div>');
				//current_carousel.addItem(html);
				//current_carousel.reinit();
				
				// get again after replacement
				carousel_elem = $(carousel_selector);
				
				carousel_elem.owlCarousel({
					autoPlay: 6000, //Set AutoPlay to 3 seconds
					navigation: true,
					navigationText: ['', ''],
					itemsCustom : [
						[0, 4],
						[450, 5],
						[550, 6],
						[768, 3],
						[1200, 3]
					],
					<?php if($page_direction[$config->get( 'config_language_id' )] == 'RTL') { ?>
						direction: 'rtl'
					<?php } ?>
				});
				
				/*
				$('.thumbnails a, .thumbnails-carousel a').click(function() {
					var smallImage = $(this).attr('data-zoom-image');
					//var smallImage = $(this).attr('data-image');
					var largeImage = $(this).attr('data-zoom-image');
					var ez =   $('#image').data('elevateZoom');	
					$('#ex1').attr('href', largeImage);  
					ez.swaptheimage(smallImage, largeImage); 
					z_index = $(this).index('.thumbnails a, .thumbnails-carousel a');
					return false;
				});
				*/
				
				if (poip_settings['img_hover']) {
					carousel_elem.find('a').mouseover(function(){
						this_object.eventAdditionalImageMouseover(this);
					}); 
				}
			}
			
		<?php } else { ?>
			// simple
		
			var shown_img = [];
			this_object.getAdditionalImagesBlock().find('a').each( function(){
				if ( $.inArray( $(this).attr('href'), images) != -1 && $.inArray( $(this).attr('href'), shown_img) == -1) {
					$(this).closest('li').show();
					$(this).attr('data-poip-visible', true);
					shown_img.push($(this).attr('href'));
				} else {
					$(this).closest('li').hide();
					$(this).removeAttr('data-poip-visible');
				}
			});
			
			if ( $('.popup-gallery').data('magnificPopup') ) {
				$('.popup-gallery').data('magnificPopup').delegate = 'a.popup-image[data-poip-visible]';
			}
		<?php } ?>
		
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.if_afterSetProductOptionValue = function(option_element) {
		var this_object = this;
	
		if ( $(options[i]).parent().parent().is('.radio-type-button2, .radio-type-button') && $(options[i]).siblings('span').length ) {
			$(options[i]).siblings('span').click();
			return true;
		}
		return false;
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		if ( !empty($theme_options) && ($images || $theme_options->get( 'product_image_zoom' ) != 2) && $theme_options->get( 'position_image_additional' ) != 2 ) { ?>
			this_object.elevateZoomDirectChange(img_click, 100);
			
			this_object.custom_refreshPopup();
		}
	}
	
	poip_product_custom.prototype.replace_getAdditionalImagesBlock = function() {
		
		//if ( poip_theme_name == 'fastor' && $('#quickview_product .popup-gallery .thumbnails-carousel').length ) {
		//	return $('#quickview_product .popup-gallery .thumbnails-carousel');
		
		return $('.product-info .popup-gallery .thumbnails');
	}
	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		return false;
	}
	

	var poip_product = new poip_product_custom();

//--></script>