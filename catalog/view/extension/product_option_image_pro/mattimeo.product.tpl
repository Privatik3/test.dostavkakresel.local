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
	
	poip_product_custom.prototype.additional_useOldOCStyleInit = function() {
		return true;
	}
	
	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm (prefixes replace_ and if_)
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		var block_gallery = $("#add-gallery");	
		
		// first time - copy all images to hidden element
		if ( !$('#hidden-carousel').length ) {
			block_gallery.after("<div style='display:none' id='hidden-carousel'></div>");
			this_object.getAdditionalImagesBlock().find('a').each( function(){
				$('#hidden-carousel').append( this_object.getElementOuterHTML($(this)) );
			});
		}
		
		var thumbs = [];
		for (var images_i in images) {
			if ( !images.hasOwnProperty(images_i) ) continue;
			var poip_img = this_object.getImageBySrc(images[images_i], 'popup');
			thumbs.push(poip_img['thumb']);
		}
		
		// add visible images to carousel
		var pg_html = "";
		var pg_added = [];
		$('#hidden-carousel').find('a').each( function(){
			
			var img_href = $(this).attr('href');
			var img_src = $(this).find('img').attr('src');
			if ( (img_href == '#' || !img_href) && $(this).attr('data-zoom-image') ) img_href = $(this).attr('data-zoom-image');
			
			if ($.inArray( img_href, images) != -1 || $.inArray(decodeURIComponent(img_href), images) != -1 || (img_src && $.inArray( img_src, thumbs) != -1 ) ) {
				if ($.inArray(img_href, pg_added) == -1) { // to not have double images
					// show
					pg_html = pg_html + this_object.getElementOuterHTML($(this));
					pg_added.push(img_href);
					//pg_html = pg_html + this_object.getElementOuterHTML($(this).parent());
				}
			}
		});
		
		// when carousel for additional images is turned on
		if (block_gallery.data('owlCarousel')) {
			var pg_opts = block_gallery.data('owlCarousel').options;
		}
		
		if (pg_html != block_gallery.html()) {
			block_gallery.html(pg_html);
			
			// when carousel for additional images is turned on
			if (block_gallery.data('owlCarousel')) {
				block_gallery.data('owlCarousel').reinit(pg_opts);
				
			}
			
			<?php if ( $poip_mattimeo_settings['product_zoom'] == '1') { ?> // опциональная галерея вместо колорбокса
				
				$('.left .image').html($('.left .image').html());
				
				$('.image-additional a').click(function(){ 
					$('.image-additional a').removeClass('active');
					$(this).addClass('active'); // some calls changed, whats why one div should be deleted from carousel
					$('.product-info .image img').attr('src', $(this).attr('data-image'));
				});
				$('.image-additional a:first').addClass('active');
				// zoom
				// elevateZoom destroy
				$.removeData($("#main-image"), 'elevateZoom');
				$('.zoomContainer').remove();
				$("#main-image").elevateZoom({
					gallery:'add-gallery',  
					galleryActiveClass: 'active',
					zoomType: "inner",
					cursor: "pointer"
				});
				
				var mattimeo_data_index = 0;
				$('.image-additional a').each(function(){
					$(this).attr('data-index',mattimeo_data_index);
					mattimeo_data_index++;
				});
				
				var popupSettings = {items: []
														,gallery: { enabled: true, preload: [0,2] }
														,type: 'image'
														,mainClass: 'mfp-fade'
														};
				if ($('.image-additional div a').length) {
					popupSettings['callbacks'] = {
						open: function() {
							var activeIndex = parseInt($('.image-additional a.active').attr('data-index'));
							var magnificPopup = $.magnificPopup.instance;
							magnificPopup.goTo(activeIndex);
						}
					};
					
					$('.image-additional div a').each(function(){
						popupSettings['items'].push({src: $(this).attr('data-zoom-image')});
					});
				}
				
				$('.left .image a').magnificPopup(popupSettings);
				
			<?php } ?>
			
		}
	}
	
	poip_product_custom.prototype.replace_updateZoomImage = function(img_click) {
		var this_object = this;
		
		setTimeout(function(){
			$('div.image-additional a').each(function(){
				if ($(this).attr('data-zoom-image') == img_click) {
					$(this).find('img').click();
					return false;
				}
			});
		}, 100);
	}
	
	poip_product_custom.prototype.if_setMainImage = function(main, popup) {
		var this_object = this;
	
		<?php if ( $poip_mattimeo_settings['product_zoom']==1 ) { ?>
			return true;
		<?php } ?>
		return false;
	}
	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		
		<?php if ( $poip_mattimeo_settings['product_zoom'] == '1' ) { ?> // optional gallery instead of colorbox
			return false; 
		<?php } ?>
		
		return true;
	}
	
	poip_product_custom.prototype.replace_getAdditionalImageMouseoverHref = function(image_a) {
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