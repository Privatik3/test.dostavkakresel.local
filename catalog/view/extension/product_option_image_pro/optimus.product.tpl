<script type="text/javascript"><!--
	// 2016/09/30 // 2016/11/21 // flexslider 

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
		
		if ( $('.product-view .flexslider').length ) { //
			
			var carousel_selector = '.product-view .flexslider';
			var carousel_elem = $(carousel_selector);
			
			if ( !$('#poip_images').length ) {
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('img').each(function(){
					$('#poip_images').append( $(this).parent().clone() ); // parent - <li>
				});
			}
			
			var flexslider = carousel_elem.data('flexslider');
			var images_main = [];
			for (var i in images) {
				var poip_img = this_object.getImageBySrc(images[i], 'popup');
				if (poip_img) {
					images_main.push(poip_img['main']);
				}
			}
			
			if ( this_object.set_visible_images_first_call ) {
				if ( !carousel_elem.find('.flex-viewport').length || !flexslider ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
			} else {
				var current_imgs = [];
				carousel_elem.find('a').each( function(){
					current_imgs.push($(this).attr('href')); // all images including duplicates
				});
				if ( current_imgs.toString() == images_main.toString() ) {
					this_object.set_visible_images_timer_id = false;
					return; // nothing to change
				}
			}
			
			var elems_cnt = flexslider.count;
			for (var i = 0; i<elems_cnt; i++ ) {
				flexslider.removeSlide(i);
				carousel_elem.find('.flex-viewport li:first').remove();
			}
			
			var shown_imgs = [];
			for (var i in images_main) {
				if ( !images_main.hasOwnProperty(i) ) continue;
				var img_elem = $('#poip_images img[src="'+images_main[i]+'"]').first();
				if (img_elem.length) {
					flexslider.addSlide( img_elem.parent().clone() );
				}
			}
			
			carousel_elem.flexslider(0);
			
			if ( $('.cloudzoom').data('CloudZoom') ) {
				setTimeout( function(){
					$('.cloudzoom').data('CloudZoom').destroy();
					$('.cloudzoom, .cloudzoom-gallery').CloudZoom();
				}, 10);	
			}
			
			if (poip_settings['img_hover']) {
				carousel_elem.find('img').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		
		}
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		if ( $('.product-view .flexslider').length ) {
			poip_cloud_zoom_click(img_click, $('.cloudzoom'), $('.product-view .flexslider img'));
			return true;
		}
		
	}
	
	// returns result of jQuery call ( $(...) ) or FALSE
	poip_product_custom.prototype.if_getMainImage = function() {
		return $('.large-image img');
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>