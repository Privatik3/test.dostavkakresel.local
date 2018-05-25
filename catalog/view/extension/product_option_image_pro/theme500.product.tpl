<script type="text/javascript"><!--
	// Cycling Equipment

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
			//if ( $.inArray($(this).attr('data-image'), current_imgs) == -1) {
				current_imgs.push($(this).attr('data-image'));
			//}
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
		
		$('#default_gallery div.image-thumb').html('<ul id="image-additional">'+new_html+'</ul>');
		
		
		$('#image-additional').bxSlider({
			mode: 'vertical',
			pager: false,
			controls: true,
			slideMargin: 13,
			minSlides: 6,
			maxSlides: 6,
			slideWidth: 88,
			nextText: '<i class="fa fa-chevron-down"></i>',
			prevText: '<i class="fa fa-chevron-up"></i>',
			infiniteLoop: false,
			adaptiveHeight: true,
			moveSlides: 1
		});
		
		
		$('#image-additional').find('[data-image]').click(function (e) {
			e.preventDefault();
			var img = $(this).data('image');
			
			$('#gallery_zoom').attr('src', img);
			$('#gallery_zoom').attr('data-zoom-image', img);
			$('.zoomContainer .zoomWindowContainer div').css({"background-image": 'url("'+img+'")'});
			
				
		})
		
		$('#image-additional').find('a').mouseover(function(){
			this_object.eventAdditionalImageMouseover(this);
		});
		
	}
	
	poip_product_custom.prototype.replace_getAdditionalImagesBlock = function() {
		return $('#image-additional li');
	}

	var poip_product = new poip_product_custom();

//--></script>