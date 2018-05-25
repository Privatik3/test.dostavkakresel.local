<script type="text/javascript"><!--
	// shopstore // 2016/03/19 // 2016/11/04

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
		
		clearTimeout(this_object.set_visible_images_timer_id);
		if (!counter) counter = 1;
		if (counter == 100) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		var carousel_selector = '.image-additional-carousel';
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
				//if ( $.inArray($(this).attr('href'), current_imgs) == -1) {
					current_imgs.push($(this).attr('href'));
				//}
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}

			var shown_imgs = [];
			
			html = '';
			// correct order of images
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				var elem = $('#poip_images a[href="'+images[i]+'"]:first');
				if (elem.length) {
					html += '<div>'+ this_object.getElementOuterHTML(elem) +'</div>';
					//current_carousel.addItem('<div>'+ this_object.getElementOuterHTML($(this)) +'</div>');
				}
			}
			
			carousel_elem.replaceWith('<div class="image-additional-carousel thumbnails all-carousel">'+html+'</div>');
			//current_carousel.addItem(html);
			//current_carousel.reinit();
			
			// get again after replacement
			carousel_elem = $(carousel_selector);
			
			//data-index renum
			var index_cnt = 0;
			carousel_elem.find('a img').each(function(){
				
				$(this).attr('data-index', index_cnt);
				index_cnt++;
			});
			
			if ( images.length > 4 ) {
			 carousel_elem.owlCarousel({
					loop:true,
					autoplay:false,
					dots:false,
					navText:["<",">"],
					margin: 10,
					responsiveClass:true,
					responsive:{
						0:{
							items:2,
							nav:true
						},
						600:{
							items:2,
							nav:true
						},
						1000:{
							items:4,
							nav:true
						}
					}
				});
			} else {
				carousel_elem.owlCarousel({
					loop:false,
					autoplay:false,
					dots:false,
					nav:false,
					responsiveClass:true,
					responsive:{
						0:{
							items:2,
							nav:false
						},
						600:{
							items:2,
							nav:false
						},
						1000:{
							items:4,
							nav:false
						}
					}
				});
			}
			
			
			var items2 = [];
			for ( var i in images ) {
				if ( !images.hasOwnProperty(i) ) continue;
				items2.push( {src: images[i] } );
			}
			
			$('.product-info .image-additional-carousel .dataitem').magnificPopup({
				mainClass: 'mfp-fade',
				items: items2,
				gallery: {
					enabled:true
				},
				type: 'image',
				callbacks : {
					open: function() {
						this.goTo(Number($(this.st.el).find('img').attr('data-index')));
						$('.magnify-lens').hide();
					}
				}
			});

			
			$('.product-info .thumbnails-one').replaceWith( this_object.getElementOuterHTML($('.product-info .thumbnails-one')) );
			$('.product-info .thumbnails-one a').click(function(e){
				e.preventDefault();
				
				$('.product-info .image-additional-carousel div.owl-item:not(.cloned) .dataitem[href="'+$(this).attr('href')+'"]').click();
				
			});
			

			if (poip_settings['img_hover']) {
				carousel_elem.find('a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		}
		
		this_object.set_visible_images_timer_id = false;
	}
	
	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>