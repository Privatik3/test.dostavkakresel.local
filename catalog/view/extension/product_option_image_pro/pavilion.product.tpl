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
	
		
	// << REPLACEMENT OF EXISTING FUNCTIONS
	// >> REPLACEMENT OF EXISTING FUNCTIONS
	
	
	// << ADDITIONAL ACTIONS
	// without replacing or stopping original script execution, just addition
	
	poip_product_custom.prototype.additional_documentReady = function() {
		var this_object = this;
		
		$("[name^="+this_object.option_prefix+"\\[]:first").change();
	}
	
	// >> ADDITIONAL ACTIONS 
	
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		if (!counter) counter = 1;
		if (counter == 50) return;
		
		if (!$('.fotorama').length || !$('.fotorama').data('fotorama')) {
			setTimeout(function () {
				this_object.replace_setVisibleImages(images, counter+1);
			}, 100);
			return;
		}
		
		var photorama_data = [];
		
		for (var i in images) {
			photorama_data.push({img: images[i], thumb: this_object.getImageBySrc(images[i], 'popup')['thumb']});
		}
		
		$('.fotorama').data('fotorama').load(photorama_data);
		
		// fullscreen gallery
		$('#product .tbGoFullscreen').off('click');
		$('#product .tbGoFullscreen').on('click', function(){
			if (!$(this).hasClass('tbKeyPressed')) {
				lightbox_gallery('PageContentProductSystem_tbW0yqLP2t', photorama_data, $('.fotorama').data('fotorama').activeIndex);
			}
			$(this).addClass('tbKeyPressed');
		});
	}
	
	poip_product_custom.prototype.replace_turnOnAdditionalImagesMouseover = function(){
		var this_object = this;
	
		$('#product').on('mouseover', '.fotorama__thumb img.fotorama__img', function() {
			if ( $('.fotorama').length && $('.fotorama').data('fotorama') ) {
				for (var i in $('.fotorama').data('fotorama').data) {
					var fotorama_img = $('.fotorama').data('fotorama').data[i];
					if (fotorama_img['thumb'] == $(this).attr('src')) {
						$('.fotorama').data('fotorama').show(i);
						return;
					}
				}
			}
		});
	}
	
	poip_product_custom.prototype.replace_setMainImage = function(main, popup, counter) {
		var this_object = this;
	
		$('#product meta[itemprop=image]').attr('content', popup);
	
		if (!counter) counter = 1;
		if (counter == 10) return;
		
		if (!$('.fotorama').length || !$('.fotorama').data('fotorama')) {
			setTimeout(function () {
				this_object.replace_setMainImage(main, popup, counter+1)
			}, 100);
			return;
		}
		
		for (var i in $('.fotorama').data('fotorama').data) {
			var f_data = $('.fotorama').data('fotorama').data[i];
			
			if (f_data['img']==popup) {
				$('.fotorama').data('fotorama').show(i);
				return;
			}
			
		}
	}
	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		return false;
	}

	var poip_product = new poip_product_custom();

//--></script>