<script type="text/javascript"><!--
	// Sebian by Novaworks

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.custom_init = function(){
		this_object.custom_zoom_switch_sebian_cloud_zoom_timer_id = false;
	}

	poip_product_custom.prototype.custom_cloudZoomSwitch = function(img_click) {
		var this_object = this;
		
		if (this_object.zoom_switch_sebian_cloud_zoom_timer_id) {
			clearTimeout(this_object.zoom_switch_sebian_cloud_zoom_timer_id);
		}
		
		if ($('#zoom1').data('zoom')) {
		
			this_object.custom_zoom_switch_cloud_zoom_timer_id = setTimeout(function(){
				if ( $('#image-additional-carousel .image-additional a').length ) {
					$('#image-additional-carousel .image-additional a').each(function(){
						if ( img_click == $(this).attr('href') ) {
							$(this).click();
							return false;
						}
					});
				} else {
					$('#zoom1').data('zoom').destroy();
					$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
				}
			}, 0);
		}
	}
	
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		if (!counter) counter = 1;
		if (counter == 50) return;
	
		if ( $('#image-additional-carousel').length ) {
		
			if ( !$('#poip_images').length ) {
				$('#image-additional-carousel').before('<div id="poip_images" style="display:none;"></div>');
				$('#image-additional-carousel li.image-additional').each(function(){
					$('#poip_images').append( $(this).clone() );
				});
			}
			
			var current_carousel = $('#image-additional-carousel').data('owlCarousel');
			
			if (!current_carousel || !$('#image-additional-carousel .owl-item').length ) {
				setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
				return;
			}
			
			var current_imgs = [];
			$('#image-additional-carousel li.image-additional a').each( function(){
				current_imgs.push($(this).attr('href'));
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			// old version of owlCarousel used, only complete carousel replacing will work
			/*
			var elems_cnt = current_carousel.itemsAmount;
			for (var i = 1; i<=elems_cnt; i++ ) {
				current_carousel.removeItem();
			}
			*/
		
			
			var shown_imgs = [];
			
			html = '';
			$('#poip_images a').each(function(){
				if ( $.inArray($(this).attr('href'), images) != -1 && $.inArray($(this).attr('href'), shown_imgs) == -1 ) {
					
					//current_carousel.addItem('<div>'+ this_object.getElementOuterHTML($(this)) +'</div>');
					html += this_object.getElementOuterHTML($(this).parent());
					//html += '<div>'+ this_object.getElementOuterHTML($(this)) +'</div>';
					//html += ''+ this_object.getElementOuterHTML($(this)) +'';
					
					shown_imgs.push( $(this).attr('href') );
					
				}
			});
			
			$('#image-additional-carousel').replaceWith('<div id="image-additional-carousel">'+html+'</div>');
			
			//$('#zoom1').replaceWith( this_object.getElementOuterHTML($('#zoom1')) );
			
			if ( $('#zoom1').data('zoom') ) {
				$('#zoom1').data('zoom').destroy();
				$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
			}
			
			$("#image-additional-carousel").owlCarousel({
				items : 5, //10 items above 1000px browser width
				itemsDesktop : [1000,4], //5 items between 1000px and 901px
				itemsDesktopSmall : [900,4], // 3 items betweem 900px and 601px
				itemsTablet: [600,3], //2 items between 600 and 0;
				itemsMobile : [320,1],
				navigation : true,
				pagination : false,
				slideSpeed : 600,
				navigationText : ["<i class=\"fa fa-angle-left\"></i>","<i class=\"fa fa-angle-right\"></i>"],
			});	
			
			/*
			current_carousel.addItem(html);
			current_carousel.reinit();
			*/
			
			if (poip_settings['img_hover']) {
				$('#image-additional-carousel .image-additional a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
			
			
		} else if ( $('#image-additional-carousel-quickview').length ) {
			
			if ( !$('#poip_images').length ) {
				$('#image-additional-carousel-quickview').before('<div id="poip_images" style="display:none;"></div>');
				$('#image-additional-carousel-quickview li.image-additional').each(function(){
					$('#poip_images').append( $(this).clone() );
				});
			}
			
			var current_carousel = $('#image-additional-carousel-quickview').data('owlCarousel');
			
			if (!current_carousel || !$('#image-additional-carousel-quickview .owl-item').length ) {
				setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
				return;
			}
			
			var current_imgs = [];
			$('#image-additional-carousel-quickview li.image-additional a').each( function(){
				current_imgs.push($(this).attr('href'));
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			// old version of owlCarousel used, only complete carousel replacing will work
			
			
			/*
			var elems_cnt = current_carousel.itemsAmount;
			for (var i = 1; i<=elems_cnt; i++ ) {
				current_carousel.removeItem();
			}
			*/
		
			
			var shown_imgs = [];
			
			html = '';
			$('#poip_images a').each(function(){
				if ( $.inArray($(this).attr('href'), images) != -1 && $.inArray($(this).attr('href'), shown_imgs) == -1 ) {
					
					//current_carousel.addItem('<div>'+ this_object.getElementOuterHTML($(this)) +'</div>');
					html += this_object.getElementOuterHTML($(this).parent());
					//html += '<div>'+ this_object.getElementOuterHTML($(this)) +'</div>';
					//html += ''+ this_object.getElementOuterHTML($(this)) +'';
					
					shown_imgs.push( $(this).attr('href') );
					
				}
			});
			
			$('#image-additional-carousel-quickview').replaceWith('<div id="image-additional-carousel-quickview">'+html+'</div>');
			
			//$('#zoom1').replaceWith( this_object.getElementOuterHTML($('#zoom1')) );
			
			/*
			if ( $('#zoom1').data('zoom') ) {
				$('#zoom1').data('zoom').destroy();
				$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
			}
			*/
			
			$("#image-additional-carousel-quickview").owlCarousel({
				items : 1,
				itemsDesktop : [1199,1],
				itemsDesktopSmall : [979,1],
				itemsTablet: [600,1], //2 items between 600 and 0;
				itemsMobile : [320,1],
				slideSpeed : 300,
				paginationSpeed : 300 
			});	
			
		}
		
	}
	
	// return true = exit original function
	poip_product_custom.prototype.if_refreshPopupImages = function() {
		return $('#image-additional-carousel-quickview').length;
	}
	
	
	
	poip_product_custom.prototype.replace_updateZoomImage = function(img_click) {
		var this_object = this;
		
		this_object.custom_cloudZoomSwitch(img_click);
		
	}

	var poip_product = new poip_product_custom();

//--></script>