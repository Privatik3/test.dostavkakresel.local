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
		
		if (!counter) counter = 1;
		if (counter == 50) return;
		
		if ( !$('#poip_images').length ) {
			$('div.product-more-views').before('<div id="poip_images" style="display:none;"></div>');
			$('div.product-more-views li').each(function(){
				$('#poip_images').append( $(this).clone() );
				//$('#poip_images').append( this_object.getElementOuterHTML($(this)) );
			});
		}
		
		if ( !$('div.jcarousel-container').length ) {
			setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
			return;
		}
		
		var current_imgs = [];
		$('div.product-more-views ul li').find('img').each( function(){
			current_imgs.push($(this).attr('src'));
		});
		
		if ( current_imgs.toString() == images.toString() ) {
			this_object.set_visible_images_timer_id = false;
			return; // nothing to change
		}
		
		
		$('div.product-more-views').html('<ul class="jcarousel jcarousel-skin-previews"></ul>');
		
		var shown_imgs = [];
		$('#poip_images img').each(function(){
			if ( $.inArray($(this).attr('src'), images) != -1 && $.inArray($(this).attr('src'), shown_imgs) == -1 ) {
				$('div.product-more-views ul').append( $(this).parent().clone() );
				shown_imgs.push( $(this).attr('src') );
			}
		});
		
		var elevateZoom = $(".elevate-zoom img.elevatezoom");
		var imageCloudZoom = $('.product-image img.cloudzoom');
		
		if (elevateZoom.length) {
			var PreviewSliderHeight = function () {
				var big_image_height = elevateZoom.height();
				var preview_image_height = $(".elevate-gallery").find('li:first-child').height();
				var slider_height = Math.round(big_image_height / preview_image_height) * preview_image_height;
				$(".jcarousel-skin-previews").find('.jcarousel-clip-vertical').css({
						"min-height": slider_height + "px"
				});
			};
		} else if (imageCloudZoom.length) {
		
			var cloudGalleryOuter = $('.product-more-views:not(.elevate-gallery) ul');
		
			var PreviewSliderHeight = function () {
				var big_image_height = imageCloudZoom.height();
				var preview_image_height = cloudGalleryOuter.find('li:first-child').height();
				var slider_height = Math.round(big_image_height / preview_image_height) * preview_image_height;
				$(".jcarousel-skin-previews").find('.jcarousel-clip-vertical').css({
						"min-height": slider_height + "px"
				});
			};
		}
		
		if (PreviewSliderHeight) {
		
			$('div.product-more-views ul').jcarousel({
				vertical: true,
				scroll: 3,
				buttonNextHTML: '<a class="btn"><i class="icon-up"></i></a>',
				buttonPrevHTML: '<a class="btn"><i class="icon-down"></i></a>',
				itemLoadCallback: PreviewSliderHeight
			});
			
			if ($('.cloudzoom-gallery').length) {
				$('.cloudzoom-gallery').CloudZoom();
			}
			
		}
		
		if (poip_settings['img_hover']) {
			$('div.product-more-views ul li img').mouseover(function(){
				this_object.eventAdditionalImageMouseover(this);
			});
		}
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		$('div.product-more-views ul li img').each(function(){
			if ( $(this).attr('src') == img_click ) {
				$(this).click();
				return false;
			}
		});
		
		return true;
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>