<script type="text/javascript"><!--
	// 2016/03/09 // 2016/10/29

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
			
		if ( $('#boss-image-additional-zoom').length ) {
			
			if ( !$('#poip_images').length ) {
				$('#boss-image-additional-zoom').before('<div id="poip_images" style="display:none;"></div>');
				$('#boss-image-additional-zoom li').each(function(){
					$('#poip_images').append( this_object.getElementOuterHTML($(this)) );
				});
			}
			
			if ( this_object.set_visible_images_first_call ) {
				if (!$('#boss-image-additional-zoom').data('_cfs_isCarousel')) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
			}
			
			var current_imgs = [];
			$('#boss-image-additional-zoom').find('a').each( function(){
				//if ( $.inArray($(this).attr('href'), current_imgs) == -1) {
					current_imgs.push($(this).attr('href'));
				//}
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			var elems_cnt = $('#boss-image-additional-zoom li').length;
			for (var i = 1; i<=elems_cnt; i++ ) {
				$('#boss-image-additional-zoom').trigger('removeItem', ['end']);
			}
			
			var shown_imgs = [];
			$('#poip_images a').each(function(){
				if ( $.inArray($(this).attr('href'), images) != -1 && $.inArray($(this).attr('href'), shown_imgs) == -1 ) {
					$('#boss-image-additional-zoom').trigger('insertItem', [this_object.getElementOuterHTML($(this).parent()), 'end']);
					shown_imgs.push( $(this).attr('href') );
				}
			});
			
			$('#wrap div.mousetrap').remove();
			$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
			
			if (poip_settings['img_hover']) {
				$('#boss-image-additional-zoom li a').mouseover(function(){
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