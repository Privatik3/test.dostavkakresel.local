<script type="text/javascript"><!--

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
	
	poip_product_custom.prototype.additional_useOldOCStyleInit = function() {
		return true;
	}
	
	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm (prefixes replace_ and if_)

	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		// first time - copy all images to hidden element
		if ( !$('#hidden-carousel').length ) {
		
			// count elements per item
			var images_per_item = Math.max(3, $('#image-additional').find('.item').first().find('a').length);
			
			$("#image-additional").after("<div style='display:none' id='hidden-carousel' images_per_item='"+images_per_item+"'></div>");
			
			$('#image-additional-carousel').find('a').each( function(){
				$('#hidden-carousel').append( this_object.getElementOuterHTML($(this)) );
			});
		};
			
		// add visible images to carousel
		var pg_html = "";
		var pg_added = [];
		var anchors_cnt = 0;
		var images_per_item = $('#hidden-carousel').attr('images_per_item');
		$('#hidden-carousel').find('a').each( function(){
			
			if ($.inArray( this.href, images) != -1 || $.inArray(decodeURIComponent(this.href), images) != -1) {
				if ($.inArray(this.href, pg_added) == -1) { 
				
					if (anchors_cnt%images_per_item==0) {
						if (anchors_cnt>0) pg_html = pg_html + "</div>";
						pg_html = pg_html + "<div class='item'>";
					}
				
					// show
					pg_html = pg_html + this_object.getElementOuterHTML($(this));
					pg_added.push(this.href);
					
					anchors_cnt++;
				}
			}
		});
		if (pg_html != "") {
			pg_html = pg_html + "</div>";
		}
		
		if (pg_html != $('#image-additional-carousel').html()) {
		
			$('#image-additional-carousel').html(pg_html);
			if ($('#image-additional-carousel').find('.item').length>1) {
				$("#image-additional").find(".carousel-control").show();
			} else {
				$("#image-additional").find(".carousel-control").hide();
			}
			
			$('#image-additional .item:first').addClass('active');
			
			if (poip_settings['img_hover']) {
				$("#image-additional-carousel a").click(function(event){
					event.preventDefault()
				});
				$("#image-additional").find('a').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				});
			}
			
		}
	}
	
	poip_product_custom.prototype.replace_updateZoomImage = function(img_click) {
		setTimeout(function(){
			$('div.image').find('#image').attr('data-zoom-image', img_click);
			$('.zoomWindowContainer').find('div').css({"background-image": 'url("'+img_click+'")'});
			if ($('div.zoomLens').css('background-image') != 'none') {
				$('div.zoomLens').css({"background-image": 'url("'+img_click+'")'});
			}
			if ($('div.image').find('#image').data('zoom-image')) {
				$('div.image').find('#image').data('zoom-image', img_click);
			}
		}, 100);
	}
	
	poip_product_custom.prototype.if_beforeColorboxReinit = function() {
		// for quickview
		$('.pav-colorbox').colorbox({
				width: '980px', 
				height: '80%',
				overlayClose: true,
				opacity: 0.5,
				iframe: true, 
		});
		
		// if used zoom, colorbox for images not used
		if ($('#image-additional').find('a[data-zoom-image][data-image]').length && $('.zoomWindowContainer').find('div').length) {
			$('#image-additional').find('a[data-zoom-image][data-image]').click(function (event) {
				event.preventDefault();
			});
			return true;
		}
		return false;
	}
	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>