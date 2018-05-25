<script type="text/javascript"><!--
	// 2016/06/22 // 2016/10/28

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.custom_init = function(){
		
	}
	
	// << ITS OWN FUNCTIONS
	
	poip_product_custom.prototype.custom_ZoomSwitch = function(img_click) {
		$('.zoomWindowContainer').find('div').css({"background-image": 'url("'+img_click+'")'});
	}
	
	// >> ITS OWN FUNCTIONS
	
	// << ADDITIONAL FUNCTIONS
	// without replacing or stopping original script execution, just addition

	poip_product_custom.prototype.additional_endOfEventAdditionalImageMouseover = function() {
		var this_object = this;
		
		$(image_a).closest('#additional-img').find('.owl-item a.active').removeClass('active');
		$(image_a).closest('a').addClass('active');
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
		
		var carousel_selector = '#additional-img';
		var carousel_elem = $(carousel_selector);
	
		if ( carousel_elem.length ) {
			
			if ( !$('#poip_images').length ) {
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('a').each(function(){
					$('#poip_images').append( $(this).clone() );
				});
			}
			
			var current_carousel = carousel_elem.data('owlCarousel');
			
			if ( this_object.set_visible_images_first_call ) {
				if (!current_carousel || !carousel_elem.find('.owl-item').length || document.readyState != "complete" ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
			}
			
			var current_imgs = [];
			carousel_elem.find('a').each( function(){
				//if ( $.inArray($(this).attr('data-image'), current_imgs) == -1) {
					current_imgs.push($(this).attr('data-image'));
				//}
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			var shown_imgs = [];
			
			html = '';
			var popup_images = [];
			// correct order of images
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				var elem = $('#poip_images a[data-image="'+images[i]+'"]:first');
				if (elem.length) {
					html += ''+ this_object.getElementOuterHTML(elem) +'';
					popup_images.push({src: images[i]});
				}
			}
			
			carousel_elem.replaceWith('<div class="additional-img ctrl-b" id="additional-img">'+html+'</div>');
			carousel_elem = $(carousel_selector);
			
			var cnt_index = 0;
			carousel_elem.find('a').each( function(){
				$(this).attr('data-index', cnt_index);
				cnt_index++;
			} );
			
			carousel_elem.owlCarousel({
				stagePadding: 1,
				items: 5,
				margin:1,
				nav:true,
				dots: false,
				slideBy: 1,
				navText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>']
			});

			$('.main-img').magnificPopup({
				items: popup_images,
				gallery: { enabled: true, preload: [0,2] },
				type: 'image',
				mainClass: 'mfp-fade',
				callbacks: {
					open: function() {
						var activeIndex = parseInt($('.additional-img .img.active').attr('data-index'));
						if (activeIndex) {
							var magnificPopup = $.magnificPopup.instance;
							magnificPopup.goTo(activeIndex);
						}
					}
				}
			});

			
			if (poip_settings['img_hover']) {
				carousel_elem.find('a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		}
		
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		this_object.custom_ZoomSwitch(img_click);
		
		return true;
	}
	
	poip_product_custom.prototype.replace_getAdditionalImagesBlock = function() {
		return $('#additional-img');
	}
	
	poip_product_custom.prototype.if_setMainImage = function(main, popup) {
		var this_object = this;
	
		this_object.getMainImage().attr('src', popup);
		this_object.getMainImage().closest('a').attr('href', popup);
		
		return true;
	}
	
	poip_product_custom.prototype.replace_getMainImage = function() {
		return $('.main-img img');
	}
	
	poip_product_custom.prototype.replace_getAdditionalImageMouseoverHref = function(image_a) {
		
		var href = '';
		if ($(image_a).is('img')) {
			href = $(image_a).attr('src');
			
		} else if ( $(image_a).attr('data-zoom-image')) {
			href = $(image_a).attr('data-zoom-image') ;
		} else {
			href = ($(image_a).attr('href') && $(image_a).attr('href')!='#') ? $(image_a).attr('href') : $(image_a).attr('data-image') ;
		}
		
		return href;
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>