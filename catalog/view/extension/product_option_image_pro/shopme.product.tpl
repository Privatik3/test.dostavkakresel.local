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

	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		var image_changed = false;
		$('div.image-additional').find('a.cloud-zoom-gallery').each( function () {
		
			if ($(this).attr('href') == img_click) {
				$(this).find('img').click();
				image_changed = true;
				return false;
			} else if ( img_click.indexOf($(this).attr('href')) != -1 ) {
				$(this).find('img').click();
				image_changed = true;
				return false;
			}
			
		});
		
		return image_changed;
	}
	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>