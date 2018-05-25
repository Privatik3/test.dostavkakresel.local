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
		
		// like opencart default OC2 default but without "if ($('li.image-additional').length)" condition
		
		var shown_img = [];
		this_object.getAdditionalImagesBlock().find('a').each( function(){
			if ( $.inArray( $(this).attr('href'), images) != -1 && $.inArray( $(this).attr('href'), shown_img) == -1) {
				$(this).show();
				shown_img.push($(this).attr('href'));
			} else {
				$(this).hide();
			}
		});
		
	}
	
	poip_product_custom.prototype.replace_getAdditionalImagesBlock = function() {
		return $('.images-additional');
	}
	
	poip_product_custom.prototype.replace_getMainImage = function() {
		return $('.main-image img');
	}
		
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>