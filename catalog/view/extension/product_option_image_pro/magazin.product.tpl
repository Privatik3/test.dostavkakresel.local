<script type="text/javascript"><!--
	// 2016/04/29 // 2016/10/25

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
	
	poip_product_custom.prototype.additional_addMainImageInitialHrefToArray = function(images) {
		if ( images.length == 0 && this_object.std_href ) {
	   	images.push(poip_std_href);
		}
		return images;
	}
	
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
	
		// theme has two carousels 
		var carousel_selector1 = '#one-image';
		var carousel_selector2 = '#image-additional';
		var carousel_elem1 = $(carousel_selector1);
		var carousel_elem2 = $(carousel_selector2);
	
		if ( carousel_elem1.length ) {
			
			var current_carousel1 = carousel_elem1.data('owlCarousel');
			var current_carousel2 = carousel_elem2.data('owlCarousel');
			
			if ( !$('#poip_images1').length ) {
				carousel_elem1.before('<div id="poip_images1" style="display:none;"></div>');
				// there's separate img and a
				carousel_elem1.find('img:not([id="image"])').each(function(){
					$('#poip_images1').append( $(this).clone() );
				});
				carousel_elem1.find('a').each(function(){
					$('#poip_images1').append( $(this).clone() );
				});
			}
			if ( !$('#poip_images2').length ) {
				carousel_elem2.before('<div id="poip_images2" style="display:none;"></div>');
				carousel_elem2.find('img').each(function(){
					$('#poip_images2').append( $(this).clone() );
				});
			}
			
			var it_was_first_call = false;
			
			if ( this_object.set_visible_images_first_call ) {
				if ( !current_carousel1 || !carousel_elem1.find('.owl-item').length || !current_carousel2 || !carousel_elem2.find('.owl-item').length || document.readyState != "complete" ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
				it_was_first_call = true;
			}
			
			var current_imgs = [];
			carousel_elem1.find('a').each( function(){
				//if ( $.inArray($(this).attr('href'), current_imgs) == -1) {
					current_imgs.push($(this).attr('href'));
				//}
			});
			
			if ( !it_was_first_call && current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			// clear both carousels
			var elems_cnt = current_carousel1.itemsAmount;
			for (var i = 1; i<=elems_cnt; i++ ) {
				current_carousel1.removeItem();
			}
			var elems_cnt = current_carousel2.itemsAmount;
			for (var i = 1; i<=elems_cnt; i++ ) {
				current_carousel2.removeItem();
			}
			
			var shown_imgs = [];
			
			html1 = '';
			html2 = '';
			// correct order of images
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				
				var current_img = this_object.getImageBySrc(images[i], 'popup');
				
				var elem_a1 = $('#poip_images1 a[href="'+current_img['popup']+'"]:first');
				var elem_img1 = $('#poip_images1 img[data-zoom-image="'+current_img['popup']+'"]:first');
				var elem_img2 = $('#poip_images2 img[src="'+current_img['thumb']+'"]:first');
				
				if ( elem_a1.length && elem_img1.length && elem_img2.length ) {
					html1 += '<div class="item">'+ this_object.getElementOuterHTML(elem_img1) + this_object.getElementOuterHTML(elem_a1) +'</div>';
					//html1 += '<div class="item">'+ this_object.getElementOuterHTML(elem_a1) + this_object.getElementOuterHTML(elem_img1) +'</div>';
					html2 += '<div class="item">'+ this_object.getElementOuterHTML(elem_img2) +'</div>';
				}
			}
			
			current_carousel1.addItem(html1);
			current_carousel2.addItem(html2);
			current_carousel1.reinit();
			current_carousel2.reinit();
			
			$(".zoom-image #one-image img").elevateZoom({
				zoomType : "inner",
				cursor: "crosshair",
				gallery:'gallery_01', 
				cursor: 'crosshair', 
				galleryActiveClass: "active", 
				imageCrossfade: true,
			});
			
			if (poip_settings['img_hover']) {
				carousel_elem2.find('img').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		}
			
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.replace_updateZoomImage = function(img_click) {
		var this_object = this;
		
		var poip_img = this_object.getImageBySrc(img_click, 'popup');
		$('#image-additional img[src="'+poip_img['thumb']+'"]').click();
	}
	
	poip_product_custom.prototype.replace_getMainImage = function() {
		this_object.std_href = $('#one-image a').attr('href');
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>