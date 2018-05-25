<script type="text/javascript"><!--

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.custom_init = function(){
		
	}
	
	// << REPLACEMENT OF EXISTING FUNCTIONS
	// >> REPLACEMENT OF EXISTING FUNCTIONS
	
	
	// << ADDITIONAL ACTIONS 
	
	poip_product_custom.prototype.additional_makeInitActions = function() {
		var this_object = this;
		
		$('#product input:radio.image_radio').siblings('img').click(function(){
			var elem = $(this);
			setTimeout( function(){
				elem.siblings('input:radio.image_radio').change();
			}, 100);
		});
	}
	
	// >> ADDITIONAL ACTIONS 
	
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		if (!counter) counter = 1;
		if (counter == 100) return;
	
		if ( $('#content .wrapper').length ) {
		
			// for thumbs
			if ( !$('#poip_images').length ) {
				var added_imgs = [];
				$('#content .wrapper').before('<div id="poip_images" style="display:none;"></div>');
				$('#content .wrapper img').each(function(){
					if ( $.inArray($(this).attr('src'), added_imgs) == -1 ) {
						$('#poip_images').append( $(this).clone() );
						added_imgs.push( $(this).attr('src') );
					}
				});
			}
			
			// for hidden big images
			if ( !$('#poip_images_zoom').length ) {
				var added_imgs = [];
				$('#content .single-product').before('<div id="poip_images_zoom" style="display:none;"></div>');
				$('#content .single-product img').each(function(){
					if ( $.inArray($(this).attr('src'), added_imgs) == -1 ) {
						$('#poip_images_zoom').append( $(this).clone() );
						added_imgs.push( $(this).attr('src') );
					}
				});
			}
			
			var it_was_first_call = false;
			if ( this_object.set_visible_images_first_call ) {
				if ( !$('#content .wrapper .slick-list').length || document.readyState != "complete" ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images_param, counter+1); } , 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
				it_was_first_call = true;
			}
			
			var images = []; // theme uses thumbs
			for (var i in images_param) { // save original order
				if ( !images_param.hasOwnProperty(i) ) continue;
				for (var j in poip_images) {
					if ( !poip_images.hasOwnProperty(j) ) continue;
					if ( poip_images[j]['popup'] == images_param[i] ) {
						images.push(poip_images[j]['thumb']);
						break;
					}
				}
			}
			
			if (!it_was_first_call) {
				var current_imgs = [];
				$('#content .single-product img').each( function(){
					current_imgs.push($(this).attr('src')); // push all elements, even if image is duplicated
				});
				
				if ( current_imgs.toString() == images.toString() ) {
					this_object.set_visible_images_timer_id = false;
					return; // nothing to change
				}
			}
			
			// << change thumbs carousel
			
			var elems_cnt = $('#content .wrapper img').length;
			for (var i = 1; i<=elems_cnt; i++ ) {
				$('#content .wrapper .slick-slider').slick('removeSlide',0);
			}
			
			var shown_imgs = [];
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
			
				$('#poip_images img').each(function(){
					if ( $(this).attr('src') == images[i] && $.inArray($(this).attr('src'), shown_imgs) == -1 ) {
						$('#content .wrapper .slick-slider').slick('addSlide', '<div class="carousel-item">'+this_object.getElementOuterHTML($(this))+'</div>' );
						shown_imgs.push( $(this).attr('src') );
						return false;
					}
				});
			}
			
			// >> change thumbs carousel
			
			// << change hidded zoom images carousel
			
			var elems_cnt = $('#content .single-product img').length;
			for (var i = 1; i<=elems_cnt; i++ ) {
				$('#content .single-product').slick('removeSlide',0);
			}
			
			var shown_imgs = [];
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
			
				$('#poip_images_zoom img').each(function(){
				
					if ( $(this).attr('src') == images[i] && $.inArray($(this).attr('src'), shown_imgs) == -1 ) {
						$('#content .single-product').slick('addSlide', '<div class="carousel-item">'+this_object.getElementOuterHTML($(this))+'</div>' );
						
						shown_imgs.push( $(this).attr('src') );
						return false;
					}
				});
			}
			
			// >> change hidded zoom images carousel
			
			CloudZoom.quickStart();
			
			if (poip_settings['img_hover']) {
				$('#content .wrapper img').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
			
		}
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.replace_updateZoomImage = function(img_click) {
		var this_object = this;
		
		var elem = $('#content .content-image .carousel-item img:visible:first');
		if (elem.length) {
			var html = this_object.getElementOuterHTML(elem);
			var pos1 = html.indexOf("zoomImage: '");
			var pos2 = html.indexOf("', autoInside");
			if (pos1 && pos2 && pos2 > pos1) {
				var html1 = html.substr(0,pos1+12);
				var html2 = html.substr(pos2);
				
				html = html1 + img_click + html2;
				elem.replaceWith(html);
				CloudZoom.quickStart();
			}
		}
		return;	
	}
	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		return false;
	}
	
	poip_product_custom.prototype.replace_setMainImage = function(main, popup) {
		$('#content .content-image .carousel-item img:visible:first').attr('src', main);
	}

	var poip_product = new poip_product_custom();

//--></script>