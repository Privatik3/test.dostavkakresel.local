<script type="text/javascript"><!--
	//2016/03/13 // 2016/10/25

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
	
	poip_product_custom.prototype.additional_endOfEventAdditionalImageMouseover = function(image_a) {
		$(image_a).closest('#thumb-slider').find('li a').removeClass('active');
		$(image_a).addClass('active');	
	}
	
	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		clearTimeout(this_object.set_visible_images_timer_id);
		if (!counter) counter = 1;
		if (counter == 100) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		var carousel_selector = '#thumb-slider';
		var carousel_elem = $(carousel_selector);
	
		if ( carousel_elem.length ) {
			
			if ( !$('#poip_images').length ) {
				carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				carousel_elem.find('a').each(function(){
					$('#poip_images').append( $(this).clone() );
				});
			}
			
			if ( this_object.set_visible_images_first_call ) {
				if ( !carousel_elem.find('.lslide').length || document.readyState != "complete" ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
			}
			
			var current_imgs = [];
			carousel_elem.find('a').each( function(){
				current_imgs.push($(this).attr('data-image'));
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			// lightSlider carousel, let's replace it completely
			
			var shown_imgs = [];
			
			html = '';
			// correct order of images
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				
				var elem = $('#poip_images a[data-image="'+images[i]+'"]:first');
				if (elem.length) {
					html += '<li class="owl2-item">'+ this_object.getElementOuterHTML(elem) +'</li>';
					//current_carousel.addItem('<div>'+ this_object.getElementOuterHTML($(this)) +'</div>');
				}
				
			}
			
			html = '<div id="thumb-slider" class="thumb-vertical-outer col-xs-3">'
				+'<div id="thumb-slider-next" class="slider-btn lSNext"><i class="fa fa-chevron-up"></i></div>'
				+'<ul class="thumb-vertical previews-list ">'
				+html
				+'</ul>'
				+'<div id="thumb-slider-prev" class="slider-btn lSPrev"><i class="fa fa-chevron-down"></i></div>'
				+'</div>';
			
			carousel_elem.replaceWith(html);
			// get again after replacement
			carousel_elem = $(carousel_selector);
			
			var a_cnt = 0;
			carousel_elem.find('li a').each(function(){
				$(this).attr('data-index', a_cnt);
				a_cnt++;
			});
			
			var thumbslider = carousel_elem.find('.thumb-vertical').lightSlider({
				item: 4,
				autoWidth: false,
				vertical:true,
				slideMargin: 0,
				verticalHeight:440,
							pager: false,
				controls: false,
							prevHtml: '<i class="fa fa-angle-up"></i>',
							nextHtml: '<i class="fa fa-angle-down"></i>',
				responsive: [
					{
						breakpoint: 1199,
						settings: {
							verticalHeight: 360,
							item: 4,
						}
					},
					{
						breakpoint: 1024,
						settings: {
							verticalHeight: 480,
							item: 4,
							
						}
					},
					{
						breakpoint: 768,
						settings: {
							verticalHeight: 330,
							item: 3,
						}
					}
				]
			});
			
			//Call JQuery lightSlider - Go to previous slide
			if( images.length >= 4){
				$('#thumb-slider-prev').click(function(){
					thumbslider.goToPrevSlide();
				});
				$('#thumb-slider-next').click(function(){
					thumbslider.goToNextSlide();
				});
			}else{
				$('#thumb-slider .slider-btn').hide();
			}
			
			$("#thumb-slider .owl2-item").each(function() {
				$(this).find("[data-index='0']").addClass('active');
			});
			
			var mfp_items = [];
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				mfp_items.push( {src: images[i] } );
			}
			
			// ZOOM
			<?php if (isset($soconfig_pages) && isset($soconfig_pages['product_enablezoom'] ) && $soconfig_pages['product_enablezoom'] == 1) { ?>
				
				var zoomCollection = '.large-image img';
				
				$.removeData(zoomCollection, 'elevateZoom');
				$.removeData(zoomCollection, 'zoomImage');
				$('.zoomContainer').remove();
				
				$( zoomCollection ).elevateZoom({
					<?php if( $soconfig_pages['product_zoommode'] != 'basic' ) { ?>
					zoomType        : "<?php echo isset($soconfig_pages['product_zoommode']) ? $soconfig_pages['product_zoommode'] : '';?>",
					<?php } ?>
					lensSize    :"<?php echo isset($soconfig_pages['product_zoomlenssize']) ? $soconfig_pages['product_zoomlenssize'] : '';?>",
					easing:true,
					
					gallery:'thumb-slider',
					cursor: 'pointer',
					galleryActiveClass: "active"
				});
				$('.large-image').magnificPopup({
					items: mfp_items,
					gallery: { enabled: true, preload: [0,2] },
					type: 'image',
					mainClass: 'mfp-fade',
					callbacks: {
						open: function() {
							var activeIndex = parseInt($('#thumb-slider .img.active').attr('data-index'));
							var magnificPopup = $.magnificPopup.instance;
							magnificPopup.goTo(activeIndex);
						}
					}
				});
				
			<?php } else { ?>
			
				$('.owl2-item').magnificPopup({
					items: mfp_items,
					navText: ['',''],
					gallery: { enabled: true, preload: [0,2] },
					type: 'image',
					mainClass: 'mfp-fade',
					callbacks: {
						open: function() {
							$cur = this.st.el;
							var activeIndex = parseInt($('#thumb-slider .img.active').attr('data-index'));
							var magnificPopup = $.magnificPopup.instance;
							magnificPopup.goTo(activeIndex);
						}
					}
				});
	
			<?php } ?>
			
			if (poip_settings['img_hover']) {
				carousel_elem.find('a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		}
		
		this_object.set_visible_images_timer_id = false;
		this_object.set_visible_images_first_call = false;
	}
	
	poip_product_custom.prototype.replace_updateZoomImage = function(img_click) {
		var this_object = this;
		var main_image = this_object.getMainImage();
		if ( main_image.attr('data-zoom-image') ) {
			this_object.getMainImage().attr('data-zoom-image', img_click);
			this_object.getMainImage().data('zoomImage', img_click);
		
			this_object.elevateZoomDirectChange(img_click, 100);
		}
	}
	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		return false;
	}
	
	poip_product_custom.prototype.replace_getMainImage = function() {
		return $('.large-image img');
	}

	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>