<script type="text/javascript"><!--
	// VIVA theme

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		if ( !$('#poip_images').length ) {
			$('#default_gallery').before('<div id="poip_images" style="display:none;"></div>');
			this_object.getAdditionalImagesBlock().each(function(){
				$('#poip_images').append( this_object.getElementOuterHTML($(this)) );
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
	
		var shown_imgs = [];
		var new_html = '';
		$('#poip_images').find('a').each( function(){
			
			if ( $.inArray( $(this).attr('data-image'), images) != -1 && $.inArray( $(this).attr('data-image'), shown_imgs) == -1) {
				new_html+= this_object.getElementOuterHTML($(this).parent());
				shown_imgs.push($(this).attr('data-image'));
				
			}
			
		});
		
		$('#default_gallery div.image-thumb').html('<ul id="image-additional" class="image-additional">'+new_html+'</ul>');
		
		setTimeout( function () {
			$('#image-additional').bxSlider({
					mode: 'vertical',
					pager: false,
					controls: true,
					slideMargin: 13,
					minSlides: 4,
					maxSlides: 4,
					slideWidth: 88,
					nextText: '<i class="material-icons-expand_more"></i>',
					prevText: '<i class="material-icons-expand_less"></i>',
					infiniteLoop: false,
					adaptiveHeight: true,
					moveSlides: 1
			});
			
			
			/*
			// elevateZoom destroy
			$.removeData($("#gallery_zoom"), 'elevateZoom');
			$('.zoomContainer').remove();
			$("#gallery_zoom").elevateZoom({gallery:'image-additional', cursor: 'pointer',zoomType : 'inner', galleryActiveClass: 'active', imageCrossfade: true});
			*/
			
			var o = $('#image-additional');
			
			o.find('li:first-child a').addClass('active');

			$('#product-image').bind("click", function (e) {
				var imgArr = [];
				o.find('a').each(function () {
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


			o.find('[data-image]').click(function (e) {
					e.preventDefault();
					o.find('.active').removeClass('active');
					var img = $(this).data('image');
					$(this).addClass('active');
					$('#product-image').find('.inner img').each(function () {
							$(this).attr('src', img);
					})
			});
			
			
			$('#image-additional').find('a').mouseover(function(){
				this_object.eventAdditionalImageMouseover(this);
			});
		}, 0);
		
	}
	
	poip_product_custom.prototype.replace_getAdditionalImagesBlock = function() {
		return $('#image-additional li');
	}
	

	var poip_product = new poip_product_custom();

//--></script>