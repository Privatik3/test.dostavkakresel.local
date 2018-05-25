<script type="text/javascript"><!--

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.custom_init = function(){
		
	}
	
	// << ITS OWN FUNCTIONS
	
	poip_product_custom.prototype.custom_popupRefresh() {
		var this_object = this;
		
		$('#poip_popup').remove();
		$('#quickview_product .popup-gallery').append('<div id="poip_popup" style="display:none;"></div>');
		
		var added_imgs = [];
		$('#quickview_product .popup-gallery .thumbnails a:not([disabled])').each(function(){
			
			if ( $.inArray($(this).attr('href'), added_imgs) == -1 && $(this).attr('href') != $('#quickview_product .popup-gallery a#ex1').attr('href') ) {
				$('#poip_popup').append( $(this).clone() );
				added_imgs.push($(this).attr('href'));
			}
			
		});
	
		$('#quickview_product .popup-gallery').magnificPopup({
			delegate: 'a#ex1, #poip_popup a',
			type: 'image',
			tLoading: 'Loading image #%curr%...',
			mainClass: 'mfp-img-mobile',
			gallery: {
				enabled: true,
				navigateByImgClick: true,
				preload: [0,1] // Will preload 0 - before current, and 1 after the current image
			},
			image: {
				tError: '<a href="%url%">The image #%curr%</a> could not be loaded.',
				titleSrc: function(item) {
					return item.el.attr('title');
				}
			}
		});
		
		$('#quickview_product .popup-gallery .thumbnails a').off('click');
		$('#quickview_product .popup-gallery .thumbnails a').on('click', function(e){
			
			e.preventDefault();
			
			$('#poip_popup a[href="'+$(this).attr('href')+'"]').click();
			
		});
	
	}
	
	// >> ITS OWN FUNCTIONS
	
	// << ADDITIONAL ACTIONS 

	
	poip_product_custom.prototype.additional_documentReady = function() {
		var this_object = this;
		
		this_object.custom_popupRefresh();
	}
	
	poip_product_custom.prototype.additional_afterElevateZoomClickImage = function() {
		var this_object = this;
		
		this_object.custom_popupRefresh();
	}
	
	// >> ADDITIONAL ACTIONS 
	
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		var shown_imgs = [];
		$('#quickview_product .popup-gallery .thumbnails ul li a').each(function(){
			
			if ( $.inArray($(this).attr('href'), images) != -1 && $.inArray($(this).attr('href'), shown_imgs) == -1 ) {
				$(this).closest('li').show();
				$(this).attr('disabled', false);
				shown_imgs.push($(this).attr('href'));
				
			} else {
				$(this).closest('li').hide();
				$(this).attr('disabled', true);
			}
			
		});
	}
	
	poip_product_custom.prototype.replace_updateZoomImage = function(img_click) {
		var this_object = this;
		
		var poip_img = this_object.getImageBySrc(img_click, 'popup');
		if ( poip_img ) {
		
			$('#quickview_product #ex1').attr('href', poip_img['popup']);
			$('#quickview_product #ex1 img').attr('src', poip_img['main']);
			$('#quickview_product #ex1 img').attr('data-zoom-image', poip_img['popup']);
			
			this_object.custom_popupRefresh();
		}
	}
	
	poip_product_custom.prototype.replace_getAdditionalImagesBlock = function() {
		return $('#quickview_product .popup-gallery .thumbnails');
	}
	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		return false;
	}
	
	poip_product_custom.prototype.replace_setMainImage = function(main, popup) {
		// do nothing
	}
	
	poip_product_custom.prototype.replace_useMainImageUpdatingOnMouseover = function() {
		return false;
	}
	

	var poip_product = new poip_product_custom();

//--></script>