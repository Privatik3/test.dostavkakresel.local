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
		
		var poip_image = this_object.getImageBySrc(img_click, 'popup');
		$('.thumbnails .zoomIn a.zoomit').attr('href', img_click);
		$('.thumbnails .zoomIn a.zoomit img').attr('src', poip_image['main']);
		
		return true;
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>