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
		
		var block_gallery = $("ul.image_carousel");
	
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
			}
			
			$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
		
			$(".cloud-zoom-gallery").click(function() {
				$("#zoom-btn").attr('href', $(this).attr('href'));
				$("#zoom-btn").attr('title', $(this).attr('title'));
			
			});
			
		}
	}
	
	poip_product_custom.prototype.replace_getRefreshColorboxImagesVisible = function(image_a) {
		return $('div.image-additional ul.image_carousel a[href!="#"]');
	}

	poip_product_custom.prototype.if_triggerAfterColorboxReinit = function() {
		var this_object = this;
		
		if ( $('#zoom-btn').length ) {
			// in cosyone depending on settings zoom may be enabled, then popup only on plus "+"
			$('#zoom-btn').unbind('click');
			$('#zoom-btn').click(function(event){
				event.preventDefault();
				var poip_colorbox = $('a.poip_colorbox[href!="#"]');
				for (var i=0; i<poip_colorbox.length; i++) {
					if ($(this).attr('href') == poip_colorbox[i].href || $(this).attr('href') == decodeURIComponent(poip_colorbox[i].href)) {
						$(poip_colorbox[i]).trigger('click');
						break;
					}
				}
			});
			return true;
		}
		return false;
	}	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>