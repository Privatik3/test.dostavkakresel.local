<script type="text/javascript"><!--
	// 2016/11/01 // 2016/11/21

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
		if (counter == 100) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		var shown_img = [];
		this_object.getAdditionalImagesBlock().find('a').each( function(){
			if ( $.inArray( $(this).attr('href'), images) != -1 && $.inArray( $(this).attr('href'), shown_img) == -1) {
				$(this).show();
				$(this).attr('data-poip-visible', true);
				shown_img.push($(this).attr('href'));
			} else {
				$(this).hide();
				$(this).removeAttr('data-poip-visible');
			}
		});
		
		// unbind theme hover
		$(".thumbnails").off( "mouseenter mouseleave" );
		
		if ( $('.thumbnails').data('magnificPopup') ) {
			$('.thumbnails').data('magnificPopup').delegate = 'a[data-poip-visible]';
		}
		
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.if_setMainImage = function(main, popup) {
		var this_object = this;
	
		this_object.getMainImage().attr('src', main);
		this_object.getMainImage().closest('a').attr('href', popup);
		this_object.getMainImage().attr('data-magnify-src', popup);
	
		return true;
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>