<script type="text/javascript"><!--
	// 2016/08/08 // 2016/10/28
	// flexslider quickview + owlCarousel product page

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
		if (counter == 100) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		if ( $('.product-view .flexslider').length ) { // quickview
			
			var carousel_selector = '.product-view .flexslider';
			var carousel_elem = $(carousel_selector);
			
			if ( !$('#poip_images').length ) {
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('a').each(function(){
					$('#poip_images').append( $(this).parent().clone() ); // parent - <li>
				});
			}
			
			var flexslider = carousel_elem.data('flexslider');
			
			if ( this_object.set_visible_images_first_call ) {
				if ( !carousel_elem.find('.flex-viewport').length || !flexslider ) {
					setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
				it_was_first_call = true;
			}
				
			var current_imgs = [];
			carousel_elem.find('a').each( function(){
				current_imgs.push($(this).attr('href')); // all images including duplicates
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			var elems_cnt = flexslider.count;
			for (var i = 0; i<elems_cnt; i++ ) {
				flexslider.removeSlide(i);
				carousel_elem.find('.flex-viewport li:first').remove();
			}
			
			var shown_imgs = [];
			$('#poip_images a').each(function(){
				if ( $.inArray($(this).attr('href'), images) != -1 && $.inArray($(this).attr('href'), shown_imgs) == -1 ) {
					flexslider.addSlide( $(this).parent().clone() );
					//flexslider.addSlide( this_object.getElementOuterHTML($(this).parent()) );
					shown_imgs.push( $(this).attr('href') );
				}
			});
			carousel_elem.flexslider(0);
			if ( $('#zoom1').data('zoom') ) {
				$('#zoom1').data('zoom').destroy();
				$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
			}
			
			if (poip_settings['img_hover']) {
				carousel_elem.find('a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		
		} else {
	
			var carousel_selector = '#gallery_01 .slider-items';
			var carousel_elem = $(carousel_selector);
		
			if ( carousel_elem.length ) {
				
				if ( !$('#poip_images').length ) {
					carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
					carousel_elem.find('a').each(function(){
						$('#poip_images').append( $(this).parent().clone() );
					});
				}
				
				var current_carousel = carousel_elem.data('owlCarousel');
				
				var it_was_first_call = false;
				if ( this_object.set_visible_images_first_call ) {
					if (!current_carousel || !carousel_elem.find('.owl-item').length || document.readyState != "complete" ) {
						this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
						return;
					}
					this_object.set_visible_images_first_call = false;
					it_was_first_call = true;
				}
				
				if (!it_was_first_call) {
					var current_imgs = [];
					carousel_elem.find('a').each( function(){
						current_imgs.push($(this).attr('href')); // push all elements, even if image is duplicated
					});
					
					if ( current_imgs.toString() == images.toString() ) {
						this_object.set_visible_images_timer_id = false;
						return; // nothing to change
					}
				}
				
				// for new owlCarousel version
				var elems_cnt = current_carousel.itemsAmount;
				for (var i = 1; i<=elems_cnt; i++ ) {
					current_carousel.removeItem();
				}

				var shown_imgs = [];
				//var mfp_items = [];
				
				html = '';
				// correct order of images
				for (var i in images) {
					if ( !images.hasOwnProperty(i) ) continue;
					var elem = $('#poip_images a[href="'+images[i]+'"]:first');
					if (elem.length) {
						current_carousel.addItem(''+ this_object.getElementOuterHTML(elem.parent()) + '');
					}
				}

				// new owlCarousel version
				current_carousel.reinit();

				if (jQuery('#product-zoom').length > 0) {
					jQuery('#product-zoom').elevateZoom({
						zoomType: "inner",
						cursor: "crosshair",
						zoomWindowFadeIn: 500,
						zoomWindowFadeOut: 750,
						gallery: 'gallery_01'
					});
				}
				
				if (poip_settings['img_hover']) {
					carousel_elem.find('a').mouseover(function(){
						this_object.eventAdditionalImageMouseover(this);
					}); 
				}
			}
		}
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		if ( $('.product-view .flexslider').length ) { // quickview
			this_object.cloudZoomClick(img_click, $('#zoom1'), $('.product-view .flexslider a[href]'));
		} else {
		
			$('.product-full #product-zoom').attr('data-zoom-image', img_click);
			$('.product-full #product-zoom').data('zoomImage', img_click);
			$('.product-full #product-zoom').attr('src', img_click);
		
			this_object.elevateZoomDirectChange(img_click, 100);
		}
		
		return true;
	}
	
	poip_product_custom.prototype.replace_getDocumentReadyState = function() {
		var this_object = this;
		
		return document.readyState == 'complete' && ($('.product-view .flexslider').length || $('.zoomContainer').length);
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>