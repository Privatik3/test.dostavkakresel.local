<script type="text/javascript"><!--
	// 2016/03/24 // 2016/10/29

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
		
		clearTimeout(this_object.set_visible_images_timer_id);
		if (!counter) counter = 1;
		if (counter == 50) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		var carousel_selector = '#boss-image-additional-zoom';
		var carousel_elem = $(carousel_selector);
			
		if ( carousel_elem.length ) {
			
			if ( !$('#poip_images').length ) {
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('li').each(function(){
					$('#poip_images').append( this_object.getElementOuterHTML($(this)) );
				});
			}
			
			if ( this_object.set_visible_images_first_call ) {
				if (!carousel_elem.data('_cfs_isCarousel')) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
			}
			
			var current_imgs = [];
			carousel_elem.find('a').each( function(){
				current_imgs.push($(this).attr('href'));
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			var elems_cnt = carousel_elem.find('li').length;
			for (var i = 1; i<=elems_cnt; i++ ) {
				carousel_elem.trigger('removeItem', ['end']);
			}
			
			var shown_imgs = [];
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				
				var elem = $('#poip_images a[href="'+images[i]+'"]:first');
				if (elem.length) {
					carousel_elem.trigger('insertItem', [this_object.getElementOuterHTML(elem.parent()), 'end']);
					shown_imgs.push( elem.attr('href') );
					//html += '<div>'+ this_object.getElementOuterHTML(elem) +'</div>';
				}
				
			}

			$('#wrap div.mousetrap').remove();
			$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
			
			if (poip_settings['img_hover']) {
				carousel_elem.find('li a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
			
			if ( $.fn.fancybox ) { // boss zoom
				var gallerylist = [];
				
				for (var i in shown_imgs) {
					if ( !shown_imgs.hasOwnProperty(i) ) continue;
					
					gallerylist.push({
						href: shown_imgs[i],
						title: "<?php echo $heading_title; ?>"
					});
					
				}
				
				$("#bt_viewlarge").unbind('click');
				$("#bt_viewlarge").bind('click',function(){    
					$.fancybox.open(gallerylist);
					return false;
				});
			}
			
		}
		
		this_object.set_visible_images_timer_id = false;
	}
	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>