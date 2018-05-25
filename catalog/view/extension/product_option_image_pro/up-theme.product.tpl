<script type="text/javascript"><!--
	// 2016/03/24

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
	
	poip_product_custom.prototype.additional_makeInitActions = function() {
		var this_object = this;
		// for quickview
		if ( $('#product, .product-options, .product-info .options, .product-info').length == 0 ) {
			$(document).on('change', 'select[name^="'+option_prefix+'["], input[type=radio][name^="'+option_prefix+'["], input[type=checkbox][name^="'+option_prefix+'["]', function(){
				poip_option_value_selected(this);
			});
		}
	}
	
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
		
		var carousel_selector = '.image-additional-wrapper';
		var carousel_elem = $(carousel_selector);
			
		if ( carousel_elem.length ) {
			
			if ( !$('#poip_images').length ) {
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('a').each(function(){
					$('#poip_images').append( this_object.getElementOuterHTML($(this)) );
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
				current_imgs.push($(this).attr('href'));
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			var shown_imgs = [];
			var html = '';
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				
				var elem = $('#poip_images a[href="'+images[i]+'"]:first');
				if (elem.length) {
					html += '<li class="image-additional col-sm-12"><div>'+ this_object.getElementOuterHTML(elem) +'</div></li>';
					shown_imgs.push( elem.attr('href') );
				}
			}
			
			carousel_elem.replaceWith('<ul class="image-additional-wrapper thumbnails">'+html+'</ul>');
			
			carousel_elem = $(carousel_selector);
			carousel_elem.owlCarousel({
				items: 3,
				singleItem: false,
				pagination: true,
				navigation: true,
				navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>']
			});
			
			$('.cloud-zoom-wrap div.mousetrap').remove();
			$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
			
			if (poip_settings['img_hover']) {
				carousel_elem.find('li a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		}
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		this_object.cloudZoomClick(img_click);
		
		return true;
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>