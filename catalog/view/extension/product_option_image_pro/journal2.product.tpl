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
	
	poip_product_custom.prototype.additional_makeInitActions = function() {
		var this_object = this;
		
		if ( $('div.option').find('input:radio').length && $('div.option').find('li[data-value]').length ) {
			$('div.option').find('li[data-value]').click(function(){
				$(this).parents('div.option').find('input:radio[value='+$(this).attr('data-value')+']').change();
			});
		}
		if ( $('div.option').find('select').length && $('div.option').find('li[data-value]').length ) {
			$('div.option').find('li[data-value]').click(function(){
				$(this).parents('div.option').find('select').change();
			});
		}
		
	}
	
	poip_product_custom.prototype.additional_useOldOCStyleInit = function() {
		return true;
	}
	
	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm (prefixes replace_ and if_)

	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		var block_gallery = $("#product-gallery");
	
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
			if ( (img_href == '#' || !img_href) && $(this).attr('data-image') ) img_href = $(this).attr('data-image');
			
			if ($.inArray( img_href, images) != -1 || $.inArray(decodeURIComponent(img_href), images) != -1 || (img_src && $.inArray( img_src, thumbs) != -1 ) ) {
				if ($.inArray(img_href, pg_added) == -1) { // to not have double images
					// show
					pg_html = pg_html + this_object.getElementOuterHTML($(this));
					pg_added.push(img_href);
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
				
				<?php if ( isset($poip_journal2_settings) && ($poip_journal2_settings['product_page_gallery_carousel_arrows'] == 'hover' || $poip_journal2_settings['product_page_gallery_carousel_arrows'] == 'always')) { ?>
					block_gallery.find('.owl-buttons').addClass('side-buttons');
				<?php } ?>
			}
			
			block_gallery.css('height', '');
			
			// journal2 may use other gallery instead of colorbox
			<?php if (isset($poip_journal2_settings) && $poip_journal2_settings['product_page_gallery'] === '1') { ?>
				var ig_added = [];
				
				// not used in quickview
				if (typeof(poip_journal2_quickview) == 'undefined' || !poip_journal2_quickview) {
					$('.product-info .image-gallery a').each(function(){
						// spec symbols like space %20
						if (($.inArray( this.href, images) != -1 || $.inArray(decodeURIComponent(this.href), images) != -1) && $.inArray(this.href, ig_added) == -1) {
							// show
							$(this).attr('rel', 'poip-visible');
							ig_added.push(this.href);
						} else { // hide
							$(this).attr('rel', '');
						}
						
					});
					
					// original click event in journal2 places later. fix it with mouseover
					$('.gallery-text').off('mousedown');
					$('.gallery-text').on('mousedown', function() {
						$('.gallery-text').off('click');
						$('.gallery-text').on('click', function () {
							if ( !$('#swipebox-overlay').length ) {
								$('.product-info .image-gallery a.swipebox[rel=poip-visible][href="'+$('#image').parent().attr('href')+'"]').first().click();
								return false;
							}
						});
					});
				}
			<?php } ?>
			
			/* additional images click */
			$('.product-info .image-additional a').click(function (e) {
					e.preventDefault();
					var thumb = $(this).find('img').attr('src');
					var image = $(this).attr('href');
					Journal.changeProductImage(thumb, image);
					return false;
			});
			
			//images_to_mouseover();
			if (poip_settings['img_hover']) {
				$('div.image-additional').find('a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				});
			}
			
		}
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		if ( $('div.zm-viewer').length) {
			// not found in additional images, change image direclty
			for (var i in poip_images) {
				if (poip_images[i]['popup'] == img_click) {
					$('#image').data('imagezoom').changeImage(poip_images[i]['popup'], poip_images[i]['popup']);
					break;
				}
			}
			return true;
		} else {
			return false;
		}
	}
	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		// poip_journal2_quickview - global
		if ( typeof(poip_journal2_quickview) !== 'undefined' && poip_journal2_quickview ) {
			return false;
		} else {
			return true;
		}
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>