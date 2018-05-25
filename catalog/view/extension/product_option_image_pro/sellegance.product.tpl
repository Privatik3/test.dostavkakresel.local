<script type="text/javascript"><!--
	// 2016/02/25 // 2016/10/27

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
	

	poip_product_custom.prototype.additional_afterChangeVisibleImages = function() {
		var this_object = this;
		
		// if there's no carousel - popup update for main image
		var main_image_elem = $('#image');
		if ( main_image_elem.length ) {
			var current_img = this_object.getImageBySrc(main_image_elem.attr('src'), 'main');
			if ( current_img && current_img['popup'] ) {
				main_image_elem.siblings('a').attr('href', current_img['popup']);
			}
		}
	}

	poip_product_custom.prototype.additional_useOldOCStyleInit = function() {
		return true;
	}
	
	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm (prefixes replace_ and if_)
	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		clearTimeout(this_object.set_visible_images_timer_id);
		if (!counter) counter = 1;
		if (counter == 50) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		var carousel_elem1 = $('#sync1');
		var carousel_elem2 = $('#sync2');
	
		if ( carousel_elem1.length && carousel_elem2.length ) {
		
			// main image
			if ( !$('#poip_main_image').length ) {
				carousel_elem1.before('<div id="poip_main_image" style="display:none;"></div>');
				$('#poip_main_image').append( $('#image').clone().removeAttr('id') );
			}
			
			// main image carousel
			if ( !$('#poip_images1').length ) {
				carousel_elem1.before('<div id="poip_images1" style="display:none;"></div>');
				carousel_elem1.find('a').each(function(){
					$('#poip_images1').append( $(this).clone() );
				});
			}
			// small images carousel
			if ( !$('#poip_images2').length ) {
				carousel_elem2.before('<div id="poip_images2" style="display:none;"></div>');
				carousel_elem2.find('img').each(function(){
					$('#poip_images2').append( $(this).clone() );
				});
			}
			
			var current_carousel1 = carousel_elem1.data('owlCarousel');
			var current_carousel2 = carousel_elem2.data('owlCarousel');
			
			if ( this_object.set_visible_images_first_call ) {
				if ( document.readyState != "complete" || !current_carousel1 || !carousel_elem1.find('.owl-item').length || !current_carousel2 || !carousel_elem2.find('.owl-item').length ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); }, 100);
					return;
				}
			}
			
			var current_imgs = [];
			var current_imgs2 = [];
			carousel_elem1.find('a').each( function(){
				current_imgs.push($(this).attr('href'));
			});
			
			if ( current_imgs.toString() == images.toString() ) {
				this_object.set_visible_images_timer_id = false;
				return; // nothing to change
			}

			var shown_imgs = [];
			
			html1 = '';
			html2 = '';
			// correct order of images
			var img_cnt = 0;
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
				
				var current_img = this_object.getImageBySrc(images[i], 'popup');
				if ( current_img && current_img['main'] ) { // first carousel (main)
					img_cnt++;
					
					$('#poip_main_image img').attr('src', current_img['main']); // main image src set
					
					var elem1 = $('#poip_images1 a[href="'+current_img['main']+'"], #poip_images1 a[href="'+current_img['popup']+'"]').first();
					if (elem1.length) {
						html1 += '<div class="item">'+ (img_cnt==1 ? this_object.getElementOuterHTML($('#poip_main_image img').attr('id','image')) : '<img src="'+current_img['main']+'">') + this_object.getElementOuterHTML(elem1) +'</div>';
					}
				}
				
				if ( current_img && current_img['thumb'] ) { // secong carousel (small thumbs, additional images upder main)
					var elem2 = $('#poip_images2 img[src="'+current_img['thumb']+'"]:first');
					if (elem2.length) {
						html2 += '<div class="item">'+ this_object.getElementOuterHTML(elem2) +'</div>';
					}
				}
				
			}
			
			carousel_elem1.replaceWith('<div id="sync1" class="owl-carousel">'+html1+'</div>');
			carousel_elem2.replaceWith('<div id="sync2" class="owl-carousel">'+html2+'</div>');
			
			// get again after replacement
			sync1 = $('#sync1');
			sync2 = $('#sync2');
			
			sync1.owlCarousel({
				singleItem : true,
				slideSpeed : 1000,
				navigation: true,
				navigationText: ['<i class="fa fa-angle-left fa-5x"></i>', '<i class="fa fa-angle-right fa-5x"></i>'],
				pagination:false,
				afterAction : syncPosition,
				responsiveRefreshRate : 200,
			});
		 
			sync2.owlCarousel({
				items : 5,
				itemsDesktop      : [1199,4],
				itemsDesktopSmall     : [979,3],
				itemsTablet       : [768,3],
				itemsMobile       : [479,3],
				pagination:false,
				navigation: true,
				navigationText: ['<i class="fa fa-angle-left fa-5x"></i>', '<i class="fa fa-angle-right fa-5x"></i>'],
				responsiveRefreshRate : 100,
				afterInit : function(el){
					el.find(".owl-item").eq(0).addClass("synced");
				}
			});
			
			function syncPosition(el){
				var current = this.currentItem;
				$("#sync2")
					.find(".owl-item")
					.removeClass("synced")
					.eq(current)
					.addClass("synced")
				if($("#sync2").data("owlCarousel") !== undefined){
					center(current)
				}
			}
		 
			$("#sync2").on("click", ".owl-item", function(e){
				e.preventDefault();
				var number = $(this).data("owlItem");
				sync1.trigger("owl.goTo",number);
			});
		 
			function center(number){
				var sync2visible = sync2.data("owlCarousel").owl.visibleItems;
				var num = number;
				var found = false;
				for(var i in sync2visible){
					if(num === sync2visible[i]){
						var found = true;
					}
				}
		 
				if(found===false){
					if(num>sync2visible[sync2visible.length-1]){
						sync2.trigger("owl.goTo", num - sync2visible.length+2)
					}else{
						if(num - 1 === -1){
							num = 0;
						}
						sync2.trigger("owl.goTo", num);
					}
				} else if(num === sync2visible[sync2visible.length-1]){
					sync2.trigger("owl.goTo", sync2visible[1])
				} else if(num === sync2visible[0]){
					sync2.trigger("owl.goTo", num-1)
				}
				
			}
			
			$("#sync1 a[rel^='magnificPopup']").magnificPopup({
				type:'image',
				gallery:{
					enabled:true
				}
			});
			
			if (poip_settings['img_hover']) {
				sync2.find('img').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
		}
		
		this_object.set_visible_images_timer_id = false;
		this_object.set_visible_images_first_call = false;
	}
	
	poip_product_custom.prototype.replace_updateZoomImage = function(img_click) {
		var this_object = this;
		
		// only for carousel
		var img_cnt = 0;
		$('#sync1 a').each(function(){
			if ( $(this).attr('href') == img_click ) {
				$('#sync1').trigger("owl.goTo",img_cnt);
				return false;
			}
			img_cnt++;
		});
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>