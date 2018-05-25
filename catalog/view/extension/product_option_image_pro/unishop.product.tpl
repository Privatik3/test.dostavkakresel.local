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
		
		this_object.getAdditionalImagesBlock().find('img:first').each(function(){
			if ( !$(this).parent().is('a') ) {
				$(this).closest('div').hide();
			}
		});
	
		var shown_img = [];
		this_object.getAdditionalImagesBlock().find('a').each( function(){
			var href = $(this).attr('href');
			if ( $.inArray( href, images) != -1 && $.inArray( href, shown_img) == -1) {
				$(this).closest('div').show();
				$(this).attr('data-poip-visible', true);
				shown_img.push( href );
			} else {
				$(this).closest('div').hide();
				$(this).removeAttr('data-poip-visible');
			}
		});
		
		if ( $('.thumbnails').data('magnificPopup') ) {
			$('.thumbnails').data('magnificPopup').delegate = 'a[data-poip-visible]';
		}
	}
	
	
	// returns result of jQuery call ( $(...) ) or FALSE
	poip_product_custom.prototype.if_getMainImage = function() {
		return $('.thumbnails li:first .thumbnail img');
	}
	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>