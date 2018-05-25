<script type="text/javascript"><!--
	// 2016/06/24 // 2016/10/28

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
	
		var carousel_selector = '.thumbnails .owl-carousel';
		var carousel_elem = $(carousel_selector);
	
		if ( carousel_elem.length ) {
			
			if ( !$('#poip_images').length ) {
				$('.thumbnails:first').before('<div id="poip_images" style="display:none;"></div>');
				//carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('a').each(function(){
					$('#poip_images').append( $(this).clone() );
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
					//if ( $.inArray($(this).attr('href'), current_imgs) == -1) {
						current_imgs.push($(this).attr('href'));
					//}
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
			var mfp_items = [];
			
			html = '';
			// correct order of images
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				var elem = $('#poip_images a[href="'+images[i]+'"]:first');
				if (elem.length) {
					
					mfp_items.push({src: elem.attr('href')});
					
					// new owlCarousel version
					current_carousel.addItem(''+ this_object.getElementOuterHTML(elem) + '');
				}
			}
			
			//current_carousel.addItem(html);
			// new owlCarousel version
			current_carousel.reinit();

			if (poip_settings['img_hover']) {
				carousel_elem.find('a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		}
		
		$('.thumbnails.image-thumb a.thumbnail').off('click');
		$('.thumbnails.image-thumb a.thumbnail').on('click', function(e){
			e.preventDefault();
			$('.thumbnails .owl-carousel a[href="'+$(this).attr('href')+'"]').click();
		});
			
		this_object.set_visible_images_timer_id = false;
	}

	poip_product_custom.prototype.replace_getMainImage = function() {
		return $('.thumbnails.image-thumb a.thumbnail img');
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>