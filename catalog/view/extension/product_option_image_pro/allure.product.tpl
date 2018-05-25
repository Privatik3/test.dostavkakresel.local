<script type="text/javascript"><!--

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		if (!counter) counter = 1;
		if (counter == 50) return;
		
		if ( !$('#poip_images').length ) {
			$('div.image-additional').before('<div id="poip_images" style="display:none;"></div>');
			$('div.image-additional li').each(function(){
				$('#poip_images').append( $(this).clone() );
				//$('#poip_images').append( this_object.getElementOuterHTML($(this)) );
			});
		}
		
		if ( !$('div.image-additional .flex-viewport').length ) {
			setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
			return;
		}
			
		var current_imgs = [];
		$('div.image-additional').find('a').each( function(){
			current_imgs.push($(this).attr('href'));
		});
		
		if ( current_imgs.toString() == images.toString() ) {
			this_object.set_visible_images_timer_id = false;
			return; // nothing to change
		}
		
		
		var flexslider = $('.image-additional').data('flexslider');
		
		var elems_cnt = flexslider.count;
		for (var i = 0; i<elems_cnt; i++ ) {
			flexslider.removeSlide(i);
			$('div.image-additional .flex-viewport li:first').remove();
		}
		
		var shown_imgs = [];
		$('#poip_images a').each(function(){
			if ( $.inArray($(this).attr('href'), images) != -1 && $.inArray($(this).attr('href'), shown_imgs) == -1 ) {
				flexslider.addSlide( $(this).parent().clone() );
				//flexslider.addSlide( this_object.getElementOuterHTML($(this).parent()) );
				shown_imgs.push( $(this).attr('href') );
			}
		});
		
		$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
	}
	
	

	
	poip_product_custom.prototype.replace_useColorboxRefreshing = function() {
		return false;
	}
	
	
	var poip_product = new poip_product_custom();

//--></script>