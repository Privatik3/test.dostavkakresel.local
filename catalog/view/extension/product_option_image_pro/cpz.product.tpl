<script type="text/javascript"><!--
	// customly modified theme (similar to tt_huge)

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
		
		if (!counter) counter = 1;
		if (counter == 100) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
	
		if ( $('.image-additional').length ) {
			
			if ( !$('#poip_images').length ) {
				$('.image-additional').before('<div id="poip_images" style="display:none;"></div>');
				$('.image-additional a').each(function(){
					$('#poip_images').append( $(this).clone() );
				});
			}
			
			var current_carousel = $('.image-additional.owl-carousel').data('owlCarousel');
			if ( this_object.set_visible_images_first_call ) {
				if (!current_carousel || !$('.image-additional.owl-carousel .owl-item').length || !$('.zoomContainer').length ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
			}
			
			
			var current_imgs = [];
			$('.image-additional').find('a').each( function(){
				//if ( $.inArray($(this).attr('href'), current_imgs) == -1) {
					current_imgs.push($(this).attr('data-zoom-image'));
				//}
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			
			var elems_cnt = current_carousel.itemsAmount;
			for (var i = 1; i<=elems_cnt; i++ ) {
				current_carousel.removeItem();
			}
			
			//$('.image-additional.owl-carousel .owl-wrapper').html('');
			//current_carousel.reinit();
			
			var shown_imgs = [];
			
			html = '';
			$('#poip_images a').each(function(){
				if ( $.inArray($(this).attr('data-zoom-image'), images) != -1 && $.inArray($(this).attr('data-zoom-image'), shown_imgs) == -1 ) {
					
					//current_carousel.addItem('<div>'+ this_object.getElementOuterHTML($(this)) +'</div>');
					html += '<div>'+ this_object.getElementOuterHTML($(this)) +'</div>';
					//html += ''+ this_object.getElementOuterHTML($(this)) +'';
					
					shown_imgs.push( $(this).attr('data-zoom-image') );
					
				}
			});
			
			current_carousel.addItem(html);
			current_carousel.reinit();
			
			// elevateZoom destroy
			$.removeData($(".thumbnails-image img"), 'elevateZoom');
			$('.zoomContainer').remove();
			$(".thumbnails-image img").elevateZoom({
				zoomType : "window",
				cursor: "crosshair",
				gallery:'gallery_01', 
				cursor: 'crosshair', 
				galleryActiveClass: "active", 
				imageCrossfade: true,
				zoomWindowFadeIn: 500, 
				zoomWindowFadeOut: 500, 
				lensFadeIn: 500, 
				lensFadeOut: 500,
				zoomWindowHeight: 450,
				zoomWindowWidth: 450,
				borderSize: 1,
			});
			
			//$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
			
			if (poip_settings['img_hover']) {
				$('.image-additional a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
			
		}
		
		this_object.set_visible_images_timer_id = false;
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>