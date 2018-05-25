<script type="text/javascript"><!--
	// Flooring theme by Ares // 2016/04/08 // 2016/10/07

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;

	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		clearTimeout(this_object.set_visible_images_timer_id);
		if (!counter) counter = 1;
		if (counter == 50) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
	
		if ( !$('#poip_images').length ) {
			$('#default_gallery').before('<div id="poip_images" style="display:none;"></div>');
			this_object.getAdditionalImagesBlock().each(function(){
				$('#poip_images').append( this_object.getElementOuterHTML($(this)) );
			});
		}
		
		// for second gallery (used for mobile devices)
		if ( !$('#poip_images_gallery').length ) {
			$('#full_gallery').before('<div id="poip_images_gallery" style="display:none;"></div>');
			$('#full_gallery a').each(function(){
				$('#poip_images_gallery').append( this_object.getElementOuterHTML($(this)) );
			});
		}
		
		var current_imgs = [];
		this_object.getAdditionalImagesBlock().find('a').each( function(){
			current_imgs.push($(this).attr('data-image'));
		});
		
		if ( current_imgs.toString() == images.toString() ) {
			this_object.set_visible_images_timer_id = false;
			return; // nothing to change
		}
	
		var new_html = '';
		for ( var i in images ) {
			if ( !images.hasOwnProperty(i) ) continue;
			var elem_img = $('#poip_images a[data-image="'+images[i]+'"]:first');
			if ( elem_img.length ) {
				new_html+= this_object.getElementOuterHTML(elem_img.parent());
			}
		}
	
		/*
		var shown_imgs = [];
		var new_html = '';
		$('#poip_images').find('a').each( function(){
			if ( $.inArray( $(this).attr('data-image'), images) != -1 && $.inArray( $(this).attr('data-image'), shown_imgs) == -1) {
				new_html+= this_object.getElementOuterHTML($(this).parent());
				shown_imgs.push($(this).attr('data-image'));
			}
		});
		*/
		
		$('#default_gallery div.image-thumb').html('<ul id="image-additional" class="image-additional">'+new_html+'</ul>');
		
		$('#image-additional').bxSlider({
				mode: 'vertical',
				pager: false,
				controls: true,
				slideMargin: 13,
				minSlides: 4,
				maxSlides: 4,
				slideWidth: 88,
				nextText: '<i class="fa fa-chevron-down"></i>',
				prevText: '<i class="fa fa-chevron-up"></i>',
				infiniteLoop: false,
				adaptiveHeight: true,
				moveSlides: 1
		});
		
		// elevateZoom destroy
		//$.removeData($("#gallery_zoom"), 'elevateZoom');
		//$('.zoomContainer').remove();
		//$("#gallery_zoom").elevateZoom({gallery:'image-additional', cursor: 'pointer',zoomType : 'inner', galleryActiveClass: 'active', imageCrossfade: true});
		
		
		
		// refill second gallery (for mobile devices)
		var second_new_html = '';
		for ( var i in images ) {
			if ( !images.hasOwnProperty(i) ) continue;
			var elem_img = $('#poip_images_gallery a[href="'+images[i]+'"]:first');
			if ( elem_img.length ) {
				second_new_html+= '<li>'+this_object.getElementOuterHTML(elem_img)+'</li>';
			}
		}
		
		/*
		var second_shown_imgs = [];
		var second_new_html = '';
		$('#poip_images_gallery').find('a').each( function(){
			if ( $.inArray( $(this).attr('href'), images) != -1 && $.inArray( $(this).attr('href'), second_shown_imgs) == -1) {
				second_new_html+= '<li>'+this_object.getElementOuterHTML($(this))+'</li>';
				second_shown_imgs.push($(this).attr('href'));
			}
		});
		*/
		$('#full_gallery').html('<ul id="gallery">'+second_new_html+'</ul>');
		
		$('#gallery').bxSlider({
				pager: false,
				controls: true,
				minSlides: 1,
				maxSlides: 1,
				infiniteLoop: false,
				moveSlides: 1
		});
		
		// for mobile
		//myPhotoSwipe = $("#gallery a").photoSwipe({ enableMouseWheel: false , enableKeyboard: false, captionAndToolbarAutoHideDelay:0 });
		
		// main image click rebind
		$('#image-additional').find('li:first-child a').addClass('active');
		$('#product-image').off("click");
		$('#product-image').on("click", function (e) {
				var imgArr = [];
				$('#image-additional').find('a').each(function () {
						img_src = $(this).data("image");

						//put the current image at the start
						if (img_src == $('#product-image').find('img').attr('src')) {
								imgArr.unshift({
										href: '' + img_src + '',
										title: $(this).find('img').attr("title")
								});
						}
						else {
								imgArr.push({
										href: '' + img_src + '',
										title: $(this).find('img').attr("title")
								});
						}
				});
				$.fancybox(imgArr);
				return false;
		});
		
		// additional images click rebind
		$('#image-additional').find('[data-image]').click(function (e) {
				e.preventDefault();
				$('#image-additional').find('.active').removeClass('active');
				var img = $(this).data('image');
				$(this).addClass('active');
				$('#product-image').find('.inner img').each(function () {
						$(this).attr('src', img);
				})
		})
		
		if (poip_settings['img_hover']) {
			$('#image-additional').find('a').mouseover(function(){
				this_object.eventAdditionalImageMouseover(this);
			});
		}
		
		this_object.set_visible_images_timer_id = false;
		
	}
	
	poip_product_custom.prototype.replace_getAdditionalImagesBlock = function() {
		return $('#image-additional li');
	}
	
	

	var poip_product = new poip_product_custom();

//--></script>