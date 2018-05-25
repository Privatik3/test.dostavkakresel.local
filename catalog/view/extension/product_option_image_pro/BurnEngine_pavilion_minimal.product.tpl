<script type="text/javascript"><!--
	// Pavilion (BurnEngine) // 2016/08/02 // 2016/10/28

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
		
		if ( $('#product_images').length ) {
			
			if ( !$('#poip_images').length ) {
				$('#product_images').before('<div id="poip_images" style="display:none;"></div>');
				var added_img = [];
				$('#product_images').siblings('.thumbnails').find('li a').each(function(){
					if ( $.inArray($(this).attr('href'), added_img) == -1 ) {
						$('#poip_images').append( $(this).clone() );
						added_img.push($(this).attr('href'));
					}
				});
			}
			
			if (!this_object.set_visible_images_first_call) {
				var current_imgs = [];
				$('#product_images').siblings('.thumbnails').find('li a').each(function(){
					current_imgs.push($(this).attr('href'));
				});
				
				if ( current_imgs.toString() == images.toString() ) {
					this_object.set_visible_images_timer_id = false;
					return; // nothing to change
				}
			}
			
			if ( this_object.set_visible_images_first_call ) { 
				if ( !$('#product_images .tb_thumbs_wrap ul li').length ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
			}
			
			
			
			var shown_imgs = [];
			html = '';
			for (var i in images) {
				var elem = $('#poip_images a[href="'+images[i]+'"]:first');
				if (elem.length) {
					html+= '<li '+(i>0 ? 'class="image-additional"' : '')+'>'+this_object.getElementOuterHTML(elem)+'</li>';
				}
			}

			$('#product_images').siblings('.thumbnails').html(html);
			
			if (typeof(poip_BurnEngineCallback)!='function') {
				$('#content').append('<input type="hidden" id="poip_temp_input">');
				$('#poip_temp_input').change();
				$('#poip_temp_input').remove();
			}
			
			if ( typeof(poip_BurnEngineCallback)=='function') {
				poip_BurnEngineCallback();
			}
			if ( typeof(poip_BurnEngineZoomPreview)=='function') {
				poip_BurnEngineZoomPreview();
			}
			
			if (poip_settings['img_hover']) {
				$('#product_images').off('mouseover', '.mSSlide img', function(){
					this_object.eventAdditionalImageMouseover(this);
				});
				$('#product_images').on('mouseover', '.mSSlide img', function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
			
		}	
		this_object.set_visible_images_timer_id = false;
	}

	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		var poip_img = this_object.getImageBySrc(img_click, 'popup');
		$('#product_images .mSSlide img[src="'+poip_img['thumb']+'"]').click();
		
		return true;
	}

	poip_product_custom.prototype.replace_useMainImageUpdatingOnMouseover = function() {
		return false;
	}

	poip_product_custom.prototype.if_refreshPopupImagesBody = function() {
		return true;
	}
	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>