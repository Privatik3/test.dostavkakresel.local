<script type="text/javascript"><!--
	// Pavilion (BurnEngine) // 2016/05/23 // 2016/10/06

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	
	// << REPLACEMENT OF EXISTING FUNCTIONS
	// >> REPLACEMENT OF EXISTING FUNCTIONS
	
	
	// << ADDITIONAL ACTIONS 
	
	poip_product_custom.prototype.additional_makeInitActions = function() {
		var this_object = this;
		
		this_object.burn_engine_click_timer_id = false;
		$('.main').on('click', '.options label', function () {
			clearTimeout(this_object.burn_engine_click_timer_id);
			var elem = $(this);
			this_object.burn_engine_click_timer_id = setTimeout( function(){
				var inputs = $(elem).find('input:radio, input:checkbox');
				if (inputs.length) {
					this_object.eventOptionValueSelect(inputs[0]);
				}
			}, 50);
		});
	}
	
	poip_product_custom.prototype.additional_setMainImageInitialHref = function(){
		var this_object = this;
		
		<?php if (!empty($popup)) { ?>
			this_object.std_href = '<?php echo $popup; ?>';
		<?php } ?>

	}
	
	poip_product_custom.prototype.additional_addMainImageInitialHrefToArray = function(images) {
		var this_object = this;
		
		if ( images.length == 0 && this_object.std_href ) {
	   	images.push(poip_std_href);
		}
		return images;
	}
	
	// >> ADDITIONAL ACTIONS 
	
	poip_product_custom.prototype.replace_refreshPopupImages = function() {
		// nothing
	}
	
	poip_product_custom.prototype.replace_useMainImageUpdatingOnMouseover = function() {
		return false;
	}
	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		return false;
	}
	
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
				if ( !$('#product_images .tb_thumbs_wrap ul li').length  ) {
				//if ( !$('#product_images .tb_thumbs_wrap ul li').length || !$('#product_images .tb_zoom_box img').length || !$('#product_images .tb_zoom_box img').attr('src') ) {
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
			
			//$('#product_images .tb_zoom_click').html('');
			
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
	
	poip_product_custom.prototype.replace_updateZoomImage = function(img_click) {
		var this_object = this;
		
		var poip_img = this_object.getImageBySrc(img_click, 'popup');
		$('#product_images .mSSlide img[src="'+poip_img['thumb']+'"]').click();
		
	}
	
	poip_product_custom.prototype.if_afterSetProductOptionValue = function(option_element) {
		
		if (!$(option_element).is(':visible') && $(option_element).parent().is('label')) {
			$(option_element).prop('checked', true);
			$(option_element).parent().click();
			return true;
		}
		return false;
	}
	
	
	
	
	

	var poip_product = new poip_product_custom();

//--></script>