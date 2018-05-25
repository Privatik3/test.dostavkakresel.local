<script type="text/javascript"><!--
	// 2016/09/21 // 2016/10/28

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
		
		var carousel_selector = '.product-images-carousel ul';
		var carousel_elem = $(carousel_selector);
		
		var carousel_selector_mobile = '#singleGallery';
		var carousel_elem_mobile = $(carousel_selector_mobile);
	
		if ( carousel_elem.length ) {
		
			// for thumbs
			if ( !$('#poip_images').length ) {
				var added_imgs = [];
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('a').each(function(){
					if ( $.inArray($(this).attr('data-image'), added_imgs) == -1 ) {
						$('#poip_images').append( $(this).clone() );
						added_imgs.push( $(this).attr('data-image') );
					}
				});
			}
			
			if ( !$('#poip_images_mobile').length ) {
				var added_imgs = [];
				carousel_elem_mobile.before('<div id="poip_images_mobile" style="display:none;"></div>');
				carousel_elem_mobile.find('li img').each(function(){
					if ( $.inArray($(this).attr('src'), added_imgs) == -1 ) {
						$('#poip_images_mobile').append( $(this).clone() );
						added_imgs.push( $(this).attr('src') );
					}
				});
			}
			
			if ( this_object.set_visible_images_first_call ) {
				if ( !carousel_elem.find('.slick-list').length || !carousel_elem.is('.slick-slider')
						|| (carousel_elem_mobile.length && (!carousel_elem_mobile.find('.slick-list').length || !carousel_elem_mobile.is('.slick-slider')) ) // only if carousel_elem_mobile exists
						|| document.readyState != "complete" ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); } , 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
			} else {
				var current_imgs = [];
				$('#content .single-product img').each( function(){
					current_imgs.push($(this).attr('src')); // push all elements, even if image is duplicated
				});
				
				if ( current_imgs.toString() == images.toString() ) {
					this_object.set_visible_images_timer_id = false;
					return; // nothing to change
				}
			}
			
			var elems_cnt = carousel_elem.find('a').length;
			for (var i = 1; i<=elems_cnt; i++ ) {
				carousel_elem.slick('slickRemove',0);
			}
			
			var elems_cnt = carousel_elem_mobile.find('li img').length;
			for (var i = 1; i<=elems_cnt; i++ ) {
				carousel_elem_mobile.slick('slickRemove',0);
			}
			
			var shown_imgs = [];
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
			
				var poip_img_elem = $('#poip_images a[data-image="'+images[i]+'"]:first');
				
				if ( poip_img_elem.length && $.inArray(poip_img_elem.attr('data-image'), shown_imgs) == -1 ) {
					//carousel_elem.slick('addSlide', ''+this_object.getElementOuterHTML($(this))+'' );
					carousel_elem.slick('slickAdd', '<li>'+this_object.getElementOuterHTML(poip_img_elem)+'</li>' );
					shown_imgs.push( $(this).attr('data-image') );
				}
			}
			
			var shown_imgs = [];
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
			
				var poip_img_elem = $('#poip_images_mobile img[src="'+images[i]+'"]:first');
				
				if ( poip_img_elem.length && $.inArray(poip_img_elem.attr('src'), shown_imgs) == -1 ) {
					carousel_elem_mobile.slick('slickAdd', '<li>'+this_object.getElementOuterHTML(poip_img_elem)+'</li>' );
					shown_imgs.push( $(this).attr('src') );
				}
			}
			
			if (poip_settings['img_hover']) {
				carousel_elem.find('img').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
			
			carousel_elem.find('a').click(function(e){
				e.preventDefault();
			});
			
		}
		this_object.set_visible_images_timer_id = false;
	}

	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		this_object.elevateZoomDirectChange(img_click, 0, $('.product-main-image .product-zoom, .product-main-image.no-zoom img:first'), 'popup');
		
		// mobile slider switch
		var slick_img_parent = $('#singleGallery li img[src="'+img_click+'"]').parent();
		
		setTimeout(function(){
			if ( slick_img_parent.length && slick_img_parent.index() >= 0 ) {
				$('#singleGallery').slick('slickGoTo', slick_img_parent.index());
			}
		}, 10);
		
		return true;
	}
	
	
	poip_product_custom.prototype.if_refreshPopupImagesBody = function() {
		return true;
	}
	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>