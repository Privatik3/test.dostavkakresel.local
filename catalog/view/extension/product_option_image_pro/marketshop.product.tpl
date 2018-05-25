<script type="text/javascript"><!--

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
		
		var shown_img = [];
		this_object.getAdditionalImagesBlock().find('a').each( function(){
		
			var current_href = $(this).attr('href');
			if ( (!current_href || current_href == '#') ) {
				if ($(this).attr('data-zoom-image')) {
					current_href = $(this).attr('data-zoom-image');
				} else {
					current_href = false;
				}
				if (current_href) {
					if ( $.inArray( current_href, images) != -1 && $.inArray( current_href, shown_img) == -1 ) {
						$(this).show();
						shown_img.push(current_href);
					} else {
						$(this).hide();
					}
				}
			}
		});
		
		<?php if(isset($marketshop_cloud_zoom_gallery) && $marketshop_cloud_zoom_gallery== 1) { ?>
			//////pass the images to swipebox
			
			var swipebox_images = [];
			
			$("#zoom_01").unbind("click");
			$("#zoom_01").bind("click", function(e) {
				
				// order like in gallery
				var ez_list =   $('#zoom_01').data('elevateZoom').getGalleryList();
				for (var i in ez_list) {
					if ( $.inArray(ez_list[i].href, shown_img) != -1 ) {
						swipebox_images.push(ez_list[i]);
					}
				}
				$.swipebox(swipebox_images);	
				
				//$.swipebox(ez.getGalleryList());
				return false;
			});
		<?php } ?>
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		setTimeout(function(){
			this_object.getAdditionalImagesBlock().find('a').each(function(){
				if ($(this).attr('data-zoom-image') == img_click) {
					// progress freezing
					$('#zoom_01').parent().find('div[style*="progress.gif"]').remove();

					var ez =   $('#zoom_01').data('elevateZoom');
					ez.swaptheimage($(this).attr('data-image'), $(this).attr('data-zoom-image'));

					// it looks like because of theme bug there may be few zooming divs, let's switch image directly
					if ( $('.zoomContainer').length > 1 ) {
						$('.zoomContainer .zoomWindowContainer div').css({"background-image": 'url("'+$(this).attr('data-zoom-image')+'")'});
					}
					return false;
				}
			});
		}, 100);
		
		return true;
	}
	
	poip_product_custom.prototype.replace_getAdditionalImageMouseoverHref = function(image_a) {
		var this_object = this;
		
		var href = '';
		if ($(image_a).is('img')) {
			href = $(image_a).attr('src');
			
		} else if ( $(image_a).attr('data-zoom-image') ) {
			href = $(image_a).attr('data-zoom-image') ;
		} else {
			href = ($(image_a).attr('href') && $(image_a).attr('href')!='#') ? $(image_a).attr('href') : $(image_a).attr('data-image') ;
		}
		
		return href;
	}
		
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>