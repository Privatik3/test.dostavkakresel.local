<script type="text/javascript"><!--
	// Fashion Store - OPC1000

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
	
	poip_product_custom.prototype.additional_addMainImageInitialHrefToArray = function(images) {
		if ( images.length == 0 && this_object.std_href ) {
	   	images.push(poip_std_href);
		}
		return images;
	}
	
	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm (prefixes replace_ and if_)

	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		if (!counter) counter = 1;
		if (counter == 50) return;
		
		var carousel_elem = $('.product-info .owl-carousel');
	
		if ( carousel_elem.length ) {
			
			if ( !$('#poip_images').length ) {
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('a').each(function(){
					$('#poip_images').append( $(this).clone() );
				});
			}
			
			var current_carousel = carousel_elem.data('owlCarousel');
			
			if (!current_carousel || !carousel_elem.find('.owl-item').length ) {
				setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
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
			
			var elems_cnt = current_carousel.itemsAmount;
			for (var i = 1; i<=elems_cnt; i++ ) {
				current_carousel.removeItem();
			}

			var shown_imgs = [];
			var html = '';
			$('#poip_images a').each(function(){
				if ( $.inArray($(this).attr('href'), images) != -1 && $.inArray($(this).attr('href'), shown_imgs) == -1 ) {
					html += '<div>'+ this_object.getElementOuterHTML($(this)) +'</div>';
					shown_imgs.push( $(this).attr('href') );
				}
			});
			current_carousel.addItem(html);
			current_carousel.reinit();
		}
	}
	
	poip_product_custom.prototype.replace_getMainImage = function() {
		return $('.product-info .owl-carousel a:first');
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>