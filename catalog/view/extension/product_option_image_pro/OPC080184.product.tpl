<script type="text/javascript"><!--
	// Kids Market

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
		
		if (!counter) counter = 1;
		if (counter == 100) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		if ( $('#carousel').length ) { // old version
			if ( !$('#poip_images').length ) {
				$('#carousel').before('<div id="poip_images" style="display:none;"></div>');
				var added_img = [];
				$('#carousel li').each(function(){
					if ( $.inArray($(this).find('img').attr('data-large'), added_img) == -1 ) {
						$('#poip_images').append( $(this).clone() );
						added_img.push($(this).find('img').attr('data-large'));
					}
				});
			}
			
			// second hidden list
			if ( !$('#poip_slider').length ) {
				$('#slider').before('<div id="poip_slider" style="display:none;"></div>');
				var added_img = [];
				$('#slider li').each(function(){
					if ( $.inArray($(this).find('a').attr('href'), added_img) == -1 ) {
						$('#poip_slider').append( $(this).clone() );
						added_img.push($(this).find('a').attr('href'));
					}
				});
			}
			
			if ( !$('#carousel .flex-viewport').length ) {
				this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
				return;
			}
				
			var current_imgs = [];
			$('#carousel').find('img').each( function(){
				current_imgs.push($(this).attr('data-large'));
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}
			
			var flexslider = $('#carousel').data('flexslider');
			var elems_cnt = flexslider.count;
			for (var i = 0; i<elems_cnt; i++ ) {
				flexslider.removeSlide(i);
				$('#carousel .flex-viewport li:first').remove();
			}
			
			var flexslider2 = $('#slider').data('flexslider');
			var elems_cnt = flexslider2.count;
			for (var i = 0; i<elems_cnt; i++ ) {
				flexslider2.removeSlide(i);
				$('#slider li:first').remove();
			}
			
			var shown_imgs = [];
			
			var html = '';
			var slides = [];
			
			$('#poip_images img').each(function(){
				if ( $.inArray($(this).attr('data-large'), images) != -1 && $.inArray($(this).attr('data-large'), shown_imgs) == -1 ) {
				
					html+= this_object.getElementOuterHTML($(this).parent());
					flexslider.addSlide( $(this).parent().clone() );
					shown_imgs.push( $(this).attr('data-large') );
					
					if ( $('#poip_slider a[href="'+$(this).attr('data-large')+'"]').length ) {
						flexslider2.addSlide( '<li>'+this_object.getElementOuterHTML($('#poip_slider a[href="'+$(this).attr('data-large')+'"]'))+'</li>' );
					}
				}
			});
			
			flexslider2.doMath();
			flexslider2.currentSlide = 1;
			$('#slider').flexslider(0);
			
			$('#carousel img').click(function(){
				var img = $(this).attr('data-large');
				var cnt = 0;
				$('#slider li a').each(function(){
					if ( $(this).attr('href') == img ) {
						return false;
					}
					cnt++
				});
				
				$('#slider').flexslider(cnt);
				
			});
			
			
			$.removeData($(".jqzoom"), 'elevateZoom');
			$('.zoomContainer').remove();
			
			var device_view = 'window';
			if(($(window).width()/$('.thumbnail  .img-responsive').width()) < 2 ) {
				device_view = 'inner';
			}
			var mmos_zoom_config = { 
				gallery: curent_id,
						cursor: 'pointer',
						imageCrossfade: true,
						zoomType: device_view,
						zoomWindowFadeIn: 500,
						zoomWindowFadeOut: 750,
				scrollZoom : true,
						responsive : true,
						zoomWindowWidth: 500 ,
						zoomWindowHeight: 500 ,
						borderSize : 0 ,
						borderColour : "#ffffff"
			};
			$("#slider .jqzoom").elevateZoom(mmos_zoom_config);
			
			$("#slider a[rel^='prettyPhoto']").prettyPhoto({
				animation_speed: 'normal',
				slideshow: 5000 ,
				autoplay_slideshow: 1 ,
				opacity: 0.8 ,
				show_title: 0 ,
				allow_resize: 1 ,
				default_width: 600 ,
				default_height: 800 ,
				counter_separator_label: '/',
				theme: 'light_rounded',
				modal: false,
				overlay_gallery: true,
			});
			
		} else { // new version
			
			if ( $('#additional-carousel').length ) {
			
				if ( !$('#poip_images').length ) {
					$('#additional-carousel').parent().before('<div id="poip_images" style="display:none;"></div>');
					var added_img = [];
					$('#additional-carousel a').each(function(){
						//$('#poip_images').append( $(this).parent().parent().clone() );
						if ( $.inArray($(this).attr('href'), added_img) == -1 ) {
							$('#poip_images').append( $(this).clone() );
							added_img.push($(this).attr('href'));
						}
					});
				}
				
				if ( this_object.set_visible_images_first_call ) {
					if ( !$('#additional-carousel .slider-wrapper').length ) {
						this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
						return;
					}
					this_object.set_visible_images_first_call = false;
				}
				
				var current_imgs = [];
				$('#additional-carousel a').each( function(){
					current_imgs.push($(this).attr('href'));
				});
				
				if ( current_imgs.toString() == images.toString() ) {
					this_object.set_visible_images_timer_id = false;
					return; // nothing to change
				}
				
				var shown_imgs = [];
				
				html = '';
				$('#poip_images a').each(function(){
					if ( $.inArray($(this).attr('href'), images) != -1 && $.inArray($(this).attr('href'), shown_imgs) == -1 ) {
						//current_carousel.addItem('<div>'+ poip_outerHTML($(this)) +'</div>');
						//html += ''+ poip_outerHTML($(this).parent().parent()) +'';
						html += '<div class="slider-item"><div class="product-block"><li>'+ this_object.getElementOuterHTML($(this)) +'</li></div></div>';
						shown_imgs.push( $(this).attr('href') );
					}
				});
				
				if ( shown_imgs.length > <?php echo isset($sliderFor) ? $sliderFor : 0; ?> ) { // carousel
					html = '<div id="additional-carousel" class="image-additional product-carousel">'+html+'</div>';
					html = '<div class="customNavigation"> <span class="btn prev">&nbsp;</span> <span class="btn next">&nbsp;</span> </div> '+html;
					html+= '<span class="additional_default_width" style="display:none; visibility:hidden"></span>';
					$('#additional-carousel').parent().html(html);
					
					var myObject = 'additional';
					if(widthClassOptions[myObject])
						var myDefClass = widthClassOptions[myObject];
					else
						var myDefClass= 'grid_default_width';
					var slider = $("#additional-carousel");
					
					slider.sliderCarousel({
						defWidthClss : myDefClass,
						subElement   : '.slider-item',
						subClass     : 'product-block',
						firstClass   : 'first_item_tm',
						lastClass    : 'last_item_tm',
						slideSpeed : 200,
						paginationSpeed : 800,
						autoPlay : false,
						stopOnHover : false,
						goToFirst : true,
						goToFirstSpeed : 1000,
						goToFirstNav : true,
						pagination : false,
						paginationNumbers: false,
						responsive: true,
						responsiveRefreshRate : 200,
						baseClass : "slider-carousel",
						theme : "slider-theme",
						autoHeight : true
					});
					
					var nextButton = slider.parent().find('.next');
					var prevButton = slider.parent().find('.prev');
					nextButton.click(function(){
						slider.trigger('slider.next');
					});
					prevButton.click(function(){
						slider.trigger('slider.prev');
					});
					
				} else { // no carousel
					html = '<div id="additional-carousel" class="image-additional ">'+html+'</div>';
					html+= '<span class="additional_default_width" style="display:none; visibility:hidden"></span>';
					$('#additional-carousel').parent().html(html);
				}
				
				if (poip_settings['img_hover']) {
					$('#additional-carousel a').mouseover(function(){
						this_object.eventAdditionalImageMouseover(this);
					}); 
				}
				
				
				$('#additional-carousel a').attr('data-poip-visible', true);
				if ( $('.thumbnails').data('magnificPopup') ) {
					$('.thumbnails').data('magnificPopup').delegate = 'a[data-poip-visible]';
				}
				
			}	
			
		}	

		//$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		// nothing
		return true;
	}
	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		return false;
	}
	
	// returns result of jQuery call ( $(...) ) or FALSE
	poip_product_custom.prototype.if_getMainImage = function() {
		var this_object = this;
		
		return $('.product-image.thumbnails li.image:first a.thumbnail:first img').first();
	}
	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>