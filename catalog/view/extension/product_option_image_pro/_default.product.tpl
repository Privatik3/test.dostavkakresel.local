<script type="text/javascript"><!--

	//PREFIXES
	//additional_ - additional code
	//replace_ - replace standard code
	//if_ - replace standard code if returns true
	//custom_ - custom function to call inside custom theme object

	var poip_product_default = function() {
		this.init();
		if ( typeof(this.custom_init) == 'function') {
			this.custom_init();
		}
	}
	
	poip_product_default.prototype.init = function() {
		var this_object = this;
		
		this_object.set_visible_images_timer_id = false;
		this_object.set_visible_images_first_call = true;
		this_object.update_zoom_image_timer_id = false;
		this_object.function_event_option_value_select_is_still_working = false;
		this_object.function_event_option_value_select_timer_id = 0;
		
		// determine option name prefix
		this_object.option_prefix = "option";
		if ($('[name^="option_oc["]').length) {
			this_object.option_prefix = "option_oc";
		}
		this_object.option_prefix_length = this_object.option_prefix.length;
		
		// usage of colorbox
		this_object.use_refresh_colorbox = this_object.useColorboxRefreshing();
		
				
		// get standard main image data		
		this_object.std_src = this_object.getMainImage().attr('src');
		this_object.std_href = this_object.getMainImage().closest('a').attr('href');
		
		if ( typeof(this_object.additional_setMainImageInitialHref) == 'function' ) {
			this_object.additional_setMainImageInitialHref();
		}
				
		// main product image may be included to the list, we should take it in account
		if ( typeof(this_object.additional_useAddInitialMainImageToPoipImages) != 'function' || this_object.additional_useAddInitialMainImageToPoipImages() ) {
			this_object.getAdditionalImagesBlock().find('a').each(function() {
				var img_src = '';
				if ( $(this).attr('data-zoom-image') ) {
					img_src = $(this).attr('data-zoom-image');
				} else if ( $(this).attr('data-image') ) {
					img_src = $(this).attr('data-image');
				} else if ( $(this).attr('href') && $(this).attr('href').substr(0,1) != "#" ) {
					img_src = $(this).attr('href');
				}
				if (img_src) {
					if ( !this_object.getImageBySrc(img_src, 'popup') && !this_object.getImageBySrc(img_src, 'main') ) {
						poip_images.unshift({"product_id":"<?php echo $product_id; ?>","product_image_id":["-1"],"popup":"","main":"","thumb":""});
						poip_images[0].popup = img_src;
						poip_images[0].main = img_src;
						poip_images[0].thumb = img_src;
					}
				}
			});
		}
		
		if ( typeof(this_object.additional_useOldOCStyleInit) == 'function' && this_object.additional_useOldOCStyleInit() ) {
		
			// old style
			
			this_object.checkEventsForSelects(true);
			
			$('div.options').click(function(){
				this_object.checkEventsForSelects();
			});
			
			$("input[type=radio][name^="+this_object.option_prefix+"\\[]").each(function (i) {
				$(this).change(function(){
					this_object.eventOptionValueSelect(this);
				})
			});
			
			if ( typeof(this_object.additional_makeInitActions) == 'function' ) {
				this_object.additional_makeInitActions();
			}
			
			$("input[type=checkbox][name^="+this_object.option_prefix+"\\[]").each(function (i) {
				$(this).change(function(){
					this_object.eventOptionValueSelect(this);
				})
			})
			
			if (poip_settings['img_hover']) {
				if ( typeof(this_object.replace_turnOnAdditionalImagesMouseover) == 'function' ) {
					this_object.replace_turnOnAdditionalImagesMouseover();
				} else { // standard way
					// more compatible
					this_object.getAdditionalImagesBlock().on('mouseover', 'a' ,function(){
						this_object.eventAdditionalImageMouseover(this);
					});
				}
			}
	
			
			$(document).ready(function(){
			
				this_object.setVisibleImages(this_object.getBasicVisibleImages());
				this_object.refreshPopupImages();
			
				if ( typeof(this_object.additional_documentReady) == 'function' ) {
					this_object.additional_documentReady();
				}
				
				this_object.setDefaultOptionsByURL();
				
			});
		} else {
	
			// new style
			if ( $.magnificPopup ) {
				this_object.getAdditionalImagesBlock().find('a').each(function(){
					if ( this_object.hrefIsVideo( $(this).attr('href') ) ) {
						if ( !$(this).hasClass('mfp-iframe') ) {
							$(this).addClass('mfp-iframe');
						}
					}
				});
			}
			
			$('#product, .product-options, .product-info .options, .product-info').on('change', 'select[name^="'+this_object.option_prefix+'["], input[type=radio][name^="'+this_object.option_prefix+'["], input[type=checkbox][name^="'+this_object.option_prefix+'["]', function(){
				this_object.eventOptionValueSelect(this);
			});
			
			
			if ( typeof(this_object.additional_makeInitActions) == 'function' ) {
				this_object.additional_makeInitActions();
			}
			
			if (poip_settings['img_hover']) {
				if ( typeof(this_object.replace_turnOnAdditionalImagesMouseover) == 'function' ) {
					this_object.replace_turnOnAdditionalImagesMouseover();
				} else { // standard way
					// more compatible
					this_object.getAdditionalImagesBlock().on('mouseover', 'a' ,function(){
						this_object.eventAdditionalImageMouseover(this);
					});
				}
			}
			
			$(document).ready(function(){
			
				this_object.setVisibleImages(this_object.getBasicVisibleImages());
				this_object.refreshPopupImages();
				
				if ( typeof(this_object.additional_documentReady) == 'function' ) {
					this_object.additional_documentReady();
				}
				
				this_object.setDefaultOptionsByURL();
				
			});
		}
	}
	
	poip_product_default.prototype.getProductOptionIdByName = function(name) {
		var this_object = this;
		return name.substr(this_object.option_prefix_length+1, name.indexOf(']')-(this_object.option_prefix_length+1) )
	}
	
	// checkbox_variant : 1 - without checkbox, 2 - only checkbox
	poip_product_default.prototype.getSelectedOptionValues = function(checkbox_variant, product_option_id) {
		var this_object = this;
	
		var values = [];
		
		var select_string = "";
		if (!checkbox_variant || checkbox_variant==1) {
			select_string += 'select[name^="'+this_object.option_prefix+'["], input[type=radio][name^="'+this_object.option_prefix+'["]:checked';
		}
		if (!checkbox_variant || checkbox_variant==2) {
			select_string += (select_string=='' ? '' : ', ') + 'input[type=checkbox][name^="'+this_object.option_prefix+'["]:checked';
		}
		
		$(select_string).each(function () {
			var current_product_option_id = this_object.getProductOptionIdByName($(this).attr('name'));
			if ( (!product_option_id && $.inArray(current_product_option_id, poip_product_option_ids) != -1)
			|| (product_option_id && product_option_id == current_product_option_id) ) {
				if ($(this).val()) {
					values.push($(this).val());
				}
			}
		});
		return values;
	}
	
	poip_product_default.prototype.addToArrayIfNotExists = function(val, arr) { // object always by link
		if ( $.inArray(val, arr) == -1 ) {
			arr.push(val);
		}
	}
	
	poip_product_default.prototype.getBasicVisibleImages = function(all_pov_images) {
		var this_object = this;
		
		// images which should be visible before options filter applying
		var global_visible_images = [];
		var images_by_settings = [];
		var selected_values = this_object.getSelectedOptionValues(); 
		for (var i=0; i<poip_images.length; i++) {
			if (poip_images[i]['product_image_id']) { // стандартное доп.изображение
				this_object.addToArrayIfNotExists(poip_images[i]['popup'], global_visible_images);
			} else {
				for (var product_option_id in poip_options_settings) {
					if (poip_options_settings[product_option_id]['img_use'] == 1 || all_pov_images) { // вкл изображения всех значений
						this_object.addToArrayIfNotExists(poip_images[i]['popup'], global_visible_images);
					} else if (poip_options_settings[product_option_id]['img_use'] == 2) { // вкл изображения только выбранных значений
						for (var j=0; j<selected_values.length; j++) {
							if ($.inArray(selected_values[j], poip_images[i]['product_option_value_id'])!=-1) {
								this_object.addToArrayIfNotExists(poip_images[i]['popup'], global_visible_images);
							}
						}
					}
				}
			}
		}
		
		if ( typeof(this_object.additional_addMainImageInitialHrefToArray) == 'function' ) {
			global_visible_images = this_object.additional_addMainImageInitialHrefToArray(global_visible_images);
		}
		
		return global_visible_images;
	}
	
	poip_product_default.prototype.getAraysIntersection = function(arr1, arr2) {
		var match = [];
		$.each(arr1, function (i, val1) {
			if ($.inArray(val1, arr2) != -1 && $.inArray(val1, match) == -1) {
				match.push(val1);
			}
		});
		return match;
	}
	
	poip_product_default.prototype.changeAvailableImages = function(product_option_id) {
		var this_object = this;
	
		if ($.inArray(product_option_id, poip_product_option_ids)==-1) {
			return;
		}
		
		var global_visible_images = this_object.getBasicVisibleImages();
		var current_visible_images = global_visible_images.slice();
		
		var images_for_main_image = this_object.getBasicVisibleImages(true);
		
		for (var i in poip_product_option_ids) {
			
			if (!poip_product_option_ids.hasOwnProperty(i)) continue;
		
			var current_product_option_id = poip_product_option_ids[i];
			var current_product_option_selected_values = this_object.getSelectedOptionValues(0, current_product_option_id);
			
			var images_to_show = [];
			for (var j in poip_images) {
				if (poip_images[j]['product_option_value_id'] && poip_images[j]['product_option_value_id'].length) {
					for (var copsv_i in current_product_option_selected_values) {
						if ($.inArray(current_product_option_selected_values[copsv_i], poip_images[j]['product_option_value_id']) !== -1
						&& $.inArray(poip_images[j]['popup'], images_to_show) == -1 ) {
							images_to_show.push(poip_images[j]['popup']);
						}
					}
				}
			}
				
			if (poip_options_settings[current_product_option_id]['img_limit'] && poip_options_settings[current_product_option_id]['img_use']
			&& current_product_option_selected_values.length ) {	
				if ( images_to_show.length ) {
					current_visible_images = this_object.getAraysIntersection(current_visible_images, images_to_show);
				}
			}
			if ( images_to_show.length ) {
				images_for_main_image = this_object.getAraysIntersection(images_for_main_image, images_to_show);
			}
		}
		if (current_visible_images.length == 0) {
			current_visible_images = global_visible_images;
		}
		
		this_object.setVisibleImages(current_visible_images);

		if (images_for_main_image.length == 0) {
			images_for_main_image = this_object.getBasicVisibleImages(true);
		}
		
		return images_for_main_image;
	}
	
	poip_product_default.prototype.refreshPopupImages = function() {
		var this_object = this;
	
		if ( typeof(this_object.replace_refreshPopupImages) == 'function' ) {
			return this_object.replace_refreshPopupImages();
		}
	
		if ( typeof(this_object.if_refreshPopupImages) == 'function' ) {
			if ( this_object.if_refreshPopupImages() ) {
				return;
			}
		}
		
		if (!poip_settings['img_gal']) {
			if ( $('li.image-additional').length ) { // OC 2.0 new-style default
				
				// exclude main image from gallery (main image should be present in additional images already)
				$('.thumbnails').magnificPopup({
					type:'image',
					delegate: '.image-additional a',
					gallery: {
						enabled:true
					}
				});
				this_object.getMainImage().off('click');
				//this_object.getMainImage().off('click', this_object.eventMainAImgClick);
				this_object.getMainImage().on('click', function(event) {
					this_object.eventMainAImgClick(event, this);
				});
				//this_object.getMainImage().on('click', this_object.eventMainAImgClick);
			}
			return;
		}
		
		
		if ( typeof(this_object.if_refreshPopupImagesBody) == 'function' && this_object.if_refreshPopupImagesBody() ) {
			// nothing
		} else if ( $('li.image-additional').length ) { // OC 2.0 new-style default
			// OC 2.0 DEFAULT instead of colorbox in OC 1.X
			
			if ( typeof($.magnificPopup) != 'undefined' ) {
				$('.thumbnails').magnificPopup({
					type:'image',
					delegate: '.image-additional a:visible',
					gallery: {
						enabled:true
					}
				});
			}
			
			this_object.getMainImage().off('click');
			//this_object.getMainImage().off('click', this_object.eventMainAImgClick);
			this_object.getMainImage().on('click', function(event) { this_object.eventMainAImgClick(event, this); } );
			
		} else { // OC 1.X and OC 2.0 old-style themes
			this_object.refreshColorboxImages();
		}
	}
	
	poip_product_default.prototype.eventMainAImgClick = function(event, element) {
		var this_object = this;
		
		if ( typeof(this_object.if_eventMainAImgClick) == 'function' ) {
			return this_object.if_eventMainAImgClick(event, element);
		}
		
		event.preventDefault();
		
		var main_href = $(element).parent().attr('href');
		var img_cnt = 0;
		this_object.getAdditionalImagesBlock().find('a').each(function(){
			if ($(this).attr('href') == main_href) {
				$(this).click();
				return;
			}
			img_cnt++;
		});
	}
	
	poip_product_default.prototype.sortImagesBySelectedOptions = function(images_param) {
		var this_object = this;
	
		var images = [];
		var values = this_object.getSelectedOptionValues();
		
		for (var j in values) {
			if ( !values.hasOwnProperty(j) ) continue;
		
			if (poip_images_by_options && poip_images_by_options[values[j]] && poip_images_by_options[values[j]].length) {
				for (var i in poip_images_by_options[values[j]]) {
					if ( !poip_images_by_options[values[j]].hasOwnProperty(i) ) continue;
				
					if (poip_images_by_options[values[j]][i]['image']) {
						var image = this_object.getImageBySrc(poip_images_by_options[values[j]][i]['image'],'image');
						if (image && image['popup'] && $.inArray(image['popup'], images_param) != -1 && $.inArray(image['popup'], images) == -1) {
							images.push(image['popup']);
						}
					}	
				}
			}
		}
		
		for (var i in images_param) {
			if ( !images_param.hasOwnProperty(i) ) continue;
		
			if ( $.inArray(images_param[i], images) == -1 ) {
				images.push(images_param[i]);
			}
		}
	
		return images;
	}
	
	// fn_svi
	poip_product_default.prototype.setVisibleImages = function(images_param) {
		var this_object = this;
	
		var images = this_object.sortImagesBySelectedOptions(images_param);
		
		if ( typeof(this_object.replace_setVisibleImages) == 'function' ) {
			return this_object.replace_setVisibleImages(images);
		}
		
		
		// << DEFAULT OC 2.0 STYLE
		if ( $('li.image-additional').length ) { // OC 2.0 default
			var shown_img = [];
			this_object.getAdditionalImagesBlock().find('a').each( function(){
				var href = $(this).attr('href');
				if ( !href ) {
					href = $(this).attr('data-image');
				}
				if ( $.inArray( href, images) != -1 && $.inArray( href, shown_img) == -1) {
					$(this).show();
					shown_img.push(href);
				} else {
					$(this).hide();
				}
			});
			return;
		}
		// >> DEFAULT OC 2.0 STYLE
		
		// << originally theme 422 compatibility, currently common
		if ($('div[class=image-additional]').find('ul[id=image-additional]').length) {
		
			// make inages list copy
			if ( !$('#image-additional-copy').length ) {
				$('div[class=image-additional]').after("<div id=\"image-additional-copy\" style=\"display: none;\">"+$('div[class=image-additional]').find('ul[id=image-additional]').html()+"</div>");
			}
			
			// check is image list update needed
			var new_html = '';
			var new_images = [];
			$('#image-additional-copy').find('a').each( function(){
				if ($.inArray( $(this).attr('data-image'), images) != -1 || $.inArray(decodeURIComponent($(this).attr('data-image')), images) != -1) {
					// anchors have parents = "li"
					new_html += "<li>"+$(this).parent().html()+"</li>";
					new_images.push($(this).attr('data-image'));
				}
				//else {
				//	$(this).hide();
				//}
			});
			
			// there may be double images, so make groupping
			var images_changed = $('#image-additional').find('a').length != new_images.length;
			var same_images_count = 0;
			if (!images_changed) {
				$('#image-additional').find('a').each( function(){
					if ($.inArray( $(this).attr('data-image'), images) != -1 || $.inArray(decodeURIComponent($(this).attr('data-image')), images) != -1) {
						same_images_count++;
					}
				});
				images_changed = same_images_count != new_images.length;
			}
			
			if (images_changed) {	
				
				$('div[class=image-additional]').html("<ul id=\"image-additional\">"+new_html+"</ul>");
				
				if ($('#image-additional').find('a').length) {
					setTimeout( function () {
						$('#image-additional').bxSlider({
							pager:false,
							controls:true,
							slideMargin:10,
							minSlides: 3,
							maxSlides: 3,
							slideWidth:70,
							infiniteLoop:false,
							moveSlides:1
						});
						
						$("#zoom_01").elevateZoom({gallery:'image-additional', cursor: 'pointer', galleryActiveClass: 'active', imageCrossfade: true}); 
						//pass the images to Fancybox
						$("#zoom_01").bind("click", function(e) {  
							var ez =   $('#zoom_01').data('elevateZoom');	
							$.fancybox(ez.getGalleryList());
							return false;
						});
						
					}, 0);
				}
			}
			return;
		}
		// >> theme 422 compatibility
		
		// << originally lexus superstore compatibility, currently some themes
		if ($('div.image-additional').find('div.item').find('a').length) {
			var shown_img = [];
			$('div.image-additional').find('div.item').find('a').each( function(){
			
				if (($.inArray( this.href, images) != -1 || $.inArray(decodeURIComponent(this.href), images) != -1) && $.inArray( this.href, shown_img) == -1) {
					$(this).show();
					shown_img.push(this.href);
				} else {
					$(this).hide();
					
				}
			});
			return;
		}
		// >> lexus superstore compatibility
		
		// << DEFAULT OC 1.X STYLE
		var shown_img = [];
		this_object.getAdditionalImagesBlock().find('a').each( function(){
		
			var current_href = $(this).attr('href');
			if ( (!current_href || current_href == '#') ) {
				if ($(this).attr('data-zoom-image')) {
					current_href = $(this).attr('data-zoom-image');
				} else {
					current_href = false;
				}
				if (current_href) {
					if ( $.inArray( current_href, images) != -1 && $.inArray( current_href, shown_img) == -1 ) {
						$(this).show();
						shown_img.push(current_href);
					} else {
						$(this).hide();
					}
				}
			}
		});
		// >> DEFAULT OC 1.X STYLE
		
	}
	
	poip_product_default.prototype.elevateZoomDirectChange = function(img_click, timeout, elem_img, update_src) {
		var this_object = this;
	
		if ( typeof(elem_img)!='undefined' && elem_img.is('img') ) {
			var poip_img = this_object.getImageBySrc(img_click, 'popup');
			if ( elem_img.attr('data-zoom-image') ) {
				elem_img.attr('data-zoom-image', poip_img['popup']);
			}
			if ( elem_img.attr('data-image') ) {
				elem_img.attr('data-image', poip_img['main']);
			}
			if ( update_src ) {
				elem_img.attr('src', poip_img[update_src]);
			}
		}
		
		if ( timeout ) {
			setTimeout(function(){
				this_object.elevateZoomDirectChange(img_click, 0, elem_img)
				//$('.zoomContainer .zoomWindowContainer div').css({"background-image": 'url("'+img_click+'")'});
			}, timeout);
		} else {
			$('.zoomContainer').find('.zoomWindowContainer').find('div').css({"background-image": 'url("'+img_click+'")'});
		}
	}
	
	poip_product_default.prototype.elevateZoomClickImage = function(img_click) {
		var this_object = this;
	
		var have_elevate_zoom = false;
		
		//$('#image-additional').find('li').find('a').each( function () {
		this_object.getAdditionalImagesBlock().find('a').each( function () {
			if ($(this).attr('data-image') == img_click || $(this).attr('data-zoom-image') == img_click) {
				have_elevate_zoom = true;
			}
		});
		
		if (have_elevate_zoom) {
	
			setTimeout( function() {
				this_object.getAdditionalImagesBlock().find('a').each( function () {
					if ($(this).attr('data-image') == img_click || $(this).attr('data-zoom-image') == img_click) {
						//$(this).find('img').click();
						$(this).click();
						return false;
					}
				});
				
				
				if ( typeof(this_object.additional_afterElevateZoomClickImage) == 'function' ) {
					this_object.additional_afterElevateZoomClickImage();
				}
				
			}, 100);
		}
		return have_elevate_zoom;
	}
	
	
	
	poip_product_default.prototype.cloudZoomClick = function(img_click, elem_check_param, additional_images_param) {
		var this_object = this;
			
		if ( typeof(elem_check_param) != 'undefined' && elem_check_param ) {
			elem = elem_check_param;
		} else {
			elem = $('#zoom1');
		}
		if ( typeof(additional_images_param) != 'undefined' && additional_images_param ) {
			additional_images = additional_images_param;
		} else {
			additional_images = $('.image-additional a[href]');
		}
		if ( elem.data('zoom') || elem.data('CloudZoom') ) {
			setTimeout(function(){
				additional_images.each(function(){
					if ($(this).is('img') && $(this).parent().is('a')) {
						var current_a = $(this).parent();
					} else {
						var current_a = $(this);
					}
					if ( current_a.is('img') ) {
						img_src = current_a.attr('src');
						poip_img = this_object.getImageBySrc(img_src, 'main');
						if (!poip_img) {
							poip_img = this_object.getImageBySrc(img_src, 'popup');
						}
						if (!poip_img) {
							poip_img = this_object.getImageBySrc(img_src, 'thumb');
						}
						if (poip_img) {
							href = poip_img['popup'];
						} else {
							href = img_src;
						}
					} else {
						href = current_a.attr('href');
					}
					
					if ( img_click == href ) {
						$(this).click();
						return false;
					}
				});
			}, 200);
		}
	}
	
	// << theme lexus superstore & journal2
	poip_product_default.prototype.autoZoomSwitch = function(img_click) {
		$('.image a #image').attr('data-zoom-image', img_click);
		$('.zoomWindowContainer').find('div').css({"background-image": 'url("'+img_click+'")'});
		if ($('.image a #image').data('zoom-image')) {
			$('.image a #image').data('zoom-image', img_click);
		}
	}
	// >> theme lexus superstore
	
	poip_product_default.prototype.getDocumentReadyState = function() {
		var this_object = this;

		if ( typeof(this_object.replace_getDocumentReadyState) == 'function' ) {
			return this_object.replace_getDocumentReadyState();
		}

		return document.readyState == 'complete';
	}
	
	poip_product_default.prototype.updateZoomImage = function(img_click, call_cnt) {
		var this_object = this;
	
		if ( this_object.update_zoom_image_timer_id ) {
			clearTimeout(this_object.update_zoom_image_timer_id);
		}
	
		if ( !this_object.getDocumentReadyState() ) {
			if ( typeof(call_cnt) == 'undefined' ) {
				call_cnt = 1;
			}  
			if ( call_cnt <= 100 ) {
				this_object.update_zoom_image_timer_id = setTimeout(function(){
					this_object.updateZoomImage(img_click, call_cnt+1)
				}, 100);
			}
			return;
		}
		
		
		if ( typeof(this_object.replace_updateZoomImage) == 'function' ) {
			return this_object.replace_updateZoomImage(img_click);
		}
		
		if ( typeof(this_object.if_updateZoomImage) == 'function' ) {
			if ( this_object.if_updateZoomImage(img_click) ) {
				return;
			}
		}
		
		
		// << elevatezoom compatibility / some old style themes
		if ( this_object.elevateZoomClickImage(img_click) ) return;
		// >> elevatezoom compatibility  / some old style themes
		
		// << some cloud-zoom-gallery themes compatibility
		$('div.image-additional').find('a.cloud-zoom-gallery').each( function () {
			if ($(this).attr('href') == img_click) {
				$(this).find('img').click();
				return false;
			}
		});
		// >> some cloud-zoom-gallery themes compatibility
		
		// << originally came from lexus superstore & pav fashion, but works for many themes
		if ($('.image a #image').attr('data-zoom-image') && $('.zoomWindowContainer').length && $('.zoomWindowContainer').find('div').length) {
			this_object.autoZoomSwitch(img_click);
			return; 
		} else if ($('.image a #image').attr('data-zoom-image')) {
			setTimeout(function () { this_object.autoZoomSwitch(img_click); }, 100);
			return;
		}
		// >> originally came from lexus superstore & pav fashion, but works for many themes
		
		// << originally came from start theme, but maybe works for other themes
		$('#image-additional').find('a[data-zoom-image]').each( function () { 
			if ($(this).attr('href') == img_click) {
				$(this).click();
				return;
			}
		});
		// >> originally came from start theme, but maybe works for other themes
		
	}
	
	poip_product_default.prototype.setMainImage = function(main, popup) {
		var this_object = this;

		if ( typeof(this_object.replace_setMainImage) == 'function' ) {
			return this_object.replace_setMainImage(main, popup);
		} else if ( typeof(this_object.if_setMainImage) == 'function' && this_object.if_setMainImage(main, popup) ) {
			// nothing 	
		} else {
			this_object.getMainImage().attr('src', main);
			this_object.getMainImage().closest('a').attr('href', popup);
		}
	}
	
	poip_product_default.prototype.refreshOptionImagesContainer = function(option, product_option_id) {
	
		if ( typeof(this_object.if_refreshOptionImagesContainer) == 'function' && this_object.if_refreshOptionImagesContainer(option, product_option_id) ) {
			return;
		}
	
		$('#option-images-'+product_option_id).remove();
		if (!$('#option-images-'+product_option_id).length) {
			if ($('#option-'+product_option_id).length) { // OC 1.X style
				$('#option-'+product_option_id).append('<div id="option-images-'+product_option_id+'"></div>');
			} else { // OC 2.0 style
				$(option).after('<div id="option-images-'+product_option_id+'" style="margin-top: 10px;"></div>');
			}
		}
	}
	
	poip_product_default.prototype.changeVisibleImages = function(option) {
		var this_object = this;
	
		var product_option_id = option.name.substr(this_object.option_prefix_length+1, option.name.indexOf(']')-(this_object.option_prefix_length+1) );
		
		if ($.inArray(product_option_id, poip_product_option_ids)==-1) {
			return;
		}
		
		images_to_show = this_object.changeAvailableImages(product_option_id);
		
		var value = option.value;
		var selected_values = this_object.getSelectedOptionValues();
		
		if (images_to_show.length==0 && value && $.inArray(value, selected_values)==-1 && poip_std_src && this_object.std_href) {
			this_object.setMainImage(poip_std_src, this_object.std_href);
		}
		
		var images_to_check = [];
		if ( value && $.inArray(value, selected_values) != -1 ) {
			for (var i=0;i<poip_images.length;i++) {
				if ( poip_images[i]['product_option_value_id'] && $.inArray(value, poip_images[i]['product_option_value_id']) != -1 && $.inArray(poip_images[i]['popup'], images_to_show) != -1 ) {
					images_to_check.push( images_to_show[$.inArray(poip_images[i]['popup'], images_to_show)] );
				}
			}
		}
		
		if ( !images_to_check.length ) {
			images_to_check = images_to_show;
		}
		
		// first time on options combination
		// if filtration is used, take first filtered image, else first option image
		var main_image_switched = false;
		
		if (images_to_check && ((poip_options_settings[product_option_id]['img_change'])
													|| (value && $.inArray(value, selected_values)==-1)) ) { //если отменили выбор опции, то тоже показываем первую из доступных картинок
		/*
		if (images_to_check && ((poip_options_settings[product_option_id]['img_limit'] && poip_options_settings[product_option_id]['img_use'])
													|| (value && $.inArray(value, selected_values)==-1)) ) { //если отменили выбор опции, то тоже показываем первую из доступных картинок
		*/
		//if (images_to_check && poip_options_settings[product_option_id]['img_limit'] && poip_options_settings[product_option_id]['img_use']) {
		
			for (var i=0;i<poip_images.length;i++) {
				if (images_to_check[0] == poip_images[i]['popup']) {
				
					this_object.setMainImage(poip_images[i]['main'], poip_images[i]['popup']);
					
					// << zoom compatibility
					this_object.updateZoomImage(poip_images[i]['popup']);
					// >> zoom compatibility
					
					var main_image_switched = true;
				}
			}
		}
		
		if (!main_image_switched) {
		
			// then on selected option images
			
			if (value && $.inArray(value, selected_values)!=-1) {
			
				// main image change
				if (poip_options_settings[product_option_id] && poip_options_settings[product_option_id]['img_change'] ) {
				
					if (poip_images_by_options[value]) {
					
						image = poip_images_by_options[value][0]['image'];
						
						for (var i=0;i<poip_images.length;i++) {
						
							if (image == poip_images[i]['image']) {

								this_object.setMainImage(poip_images[i]['main'], poip_images[i]['popup']);
								//this_object.getMainImage().attr('src', poip_images[i]['main']);
								//this_object.getMainImage().closest('a').attr('href', poip_images[i]['popup']);
								
								// << zoom compatibility
								this_object.updateZoomImage(poip_images[i]['popup']);
								// >> zoom compatibility
		
								break;
							}
						}
					}

				}
			}
		}
		
		// images showing under options
		if (poip_options_settings[product_option_id] && poip_options_settings[product_option_id]['img_option'] ) {
			if (!$('product_option_images'+product_option_id).length) {

				// checkbox may have many values
				if ($(option).prop('tagName')=='INPUT' && $(option).prop('type')=='checkbox' ) {
					var values = [];
					$('input[type=checkbox][name^='+this_object.option_prefix+'\\['+product_option_id+'\\]]:checked').each( function() {
						values.push($(this).val());
					});
				} else {
					var values = [value];
				}
				
				var new_style_img_opt = !$('#option-images-'+product_option_id).length && !$('#option-'+product_option_id).length;
				
				this_object.refreshOptionImagesContainer(option, product_option_id);
				
				$('#option-images-'+product_option_id).html('');
				for (var i=0; i<poip_images.length; i++) {
					for (var j=0; j<values.length; j++) {
						if (poip_images[i]['product_option_value_id'] && $.inArray(values[j], poip_images[i]['product_option_value_id']) != -1) {
							var html_image = '<a href="'+poip_images[i]['popup']+'" class="image-additional" style="margin: 5px;"><img src="'+poip_images[i]['thumb']+'" ></a>';
							$('#option-images-'+product_option_id).append(html_image);
						}
					}
				}
				
				// OC 2.0 new-style default
				if ( new_style_img_opt && $('#option-images-'+product_option_id+' a').length ) {
					$('#option-images-'+product_option_id).magnificPopup({
						type:'image',
						delegate: 'a',
						gallery: {
							enabled:true
						}
					});
				}
			}
		}
		
		if ( typeof(this_object.additional_afterChangeVisibleImages) == 'function' ) {
			this_object.additional_afterChangeVisibleImages();
		}
		
	}
	
	poip_product_default.prototype.getProductOptionImages = function(product_option_id) {
		var this_object = this;
		
		var images = [];
		
		for (var product_option_value_id in poip_images_by_options) {
			for (var i in poip_images_by_options[product_option_value_id]) {
				if (poip_images_by_options[product_option_value_id][i]['product_option_id'] == product_option_id) {
					images.push(poip_images_by_options[product_option_value_id][i]['image']);
				}
			}	
		}
		return images;
	}
	
	poip_product_default.prototype.getProductOptionValueImages = function(product_option_value_id) {
		var this_object = this;
		
		var images = [];
		for (var i in poip_images_by_options[product_option_value_id]) {
			images.push(poip_images_by_options[product_option_value_id][i]['image']);
		}	
		return images;
	}
	
	poip_product_default.prototype.getImageSrc = function(image, src) {
		var this_object = this;
		
		for (var i in poip_images) {
			if (poip_images[i]['image'] == image) {
				return poip_images[i][src];
			}
		}
		return '';
	}
	
	poip_product_default.prototype.getImageBySrc = function(image, src) {
		var this_object = this;
		
		for (var i in poip_images) {
			if (poip_images[i][src] == image) {
				return poip_images[i];
			}
		}
		return '';
	}
	
	poip_product_default.prototype.updateDependentThumbnails = function() {
		var this_object = this;
		
		for (var j in poip_product_option_ids) {
			
			var product_option_id = poip_product_option_ids[j];
			
			if (poip_options_settings[product_option_id] && poip_options_settings[product_option_id]['dependent_thumbnails']
					&& poip_options_settings[product_option_id]['img_first'] == 1 ) {
				
				var option_images = this_object.getProductOptionImages(product_option_id);
				
				for (var i in poip_product_option_ids) {
					if ( !poip_product_option_ids.hasOwnProperty(i) ) continue;
					
					if (poip_product_option_ids[i] == product_option_id) continue;
					var current_product_option_id = poip_product_option_ids[i];
					
					var current_product_option_selected_values = this_object.getSelectedOptionValues(0, current_product_option_id);
					
					var current_option_images = [];
					for (var poip_images_i in poip_images) {
						if (poip_images[poip_images_i]['product_option_value_id'] && poip_images[poip_images_i]['product_option_value_id'].length) {
							for (var copsv_i in current_product_option_selected_values) {
								if ($.inArray(current_product_option_selected_values[copsv_i], poip_images[poip_images_i]['product_option_value_id']) !== -1
									&& $.inArray(poip_images[poip_images_i]['image'], current_option_images) == -1 ) {
									current_option_images.push(poip_images[poip_images_i]['image']);
								}
							}
						}
					}
					option_images = this_object.getAraysIntersection(option_images, current_option_images);
				}
				
				if (option_images.length == 0) {
					option_images = this_object.getProductOptionImages(product_option_id);
				}
				
				// change options icons
				$('#product').find('input[type=radio][name="'+this_object.option_prefix+'['+product_option_id+']"], input[type=checkbox][name="'+this_object.option_prefix+'['+product_option_id+']"]').each(function(){
					option_value_images = this_object.getProductOptionValueImages($(this).val());
					if (option_value_images.length) {
						current_option_value_images	= this_object.getAraysIntersection(option_value_images, option_images);
						if (current_option_value_images.length) {
							$(this).next('img').attr('src', this_object.getImageSrc(current_option_value_images[0], 'option_thumb') );
						} else {
							$(this).next('img').attr('src', this_object.getImageSrc(option_value_images[0], 'option_thumb') );
						}
					}
				});
			}
		}
	}
	
	poip_product_default.prototype.eventOptionValueSelect = function (option) {
		var this_object = this;
	
		clearTimeout(this_object.function_event_option_value_select_timer_id);
	
		// not run twice parallel
		if ( this_object.function_event_option_value_select_is_still_working || this_object.set_visible_images_timer_id !== false) {
			this_object.function_event_option_value_select_timer_id = setTimeout(function(){
				this_object.eventOptionValueSelect(option);
			}, 100);
			return;
		}
		
		this_object.function_event_option_value_select_is_still_working = true;
	
		this_object.changeVisibleImages(option);
		
		this_object.refreshPopupImages();
		
		this_object.updateDependentThumbnails();
		
		this_object.function_event_option_value_select_is_still_working = false;
		
	}
	
	// return IMG element relevant to main image
	poip_product_default.prototype.getMainImage = function() {
		var this_object = this;
	
		if ( typeof(this_object.replace_getMainImage) == 'function' ) {
			return this_object.replace_getMainImage();
		}
		if ( typeof(this_object.if_getMainImage) == 'function' ) {
			// function should return result of jQuery call ( $(...) ) or FALSE
			var if_result = this_object.if_getMainImage();
			if ( if_result ) {
				return if_result;
			}
		}
			
		var oc2_main_img = $('ul.thumbnails li').not('.image-additional').find('a img');
		if ( oc2_main_img.length ) { // OC 2.0 default
			return oc2_main_img;
		}
	
		if (!$('#image').length) {
			if ($('#main-image').length) {
				return $('#main-image'); // originally for theme start, actually common
			}
			if ($('div.product-info div.image a img').length) {
				return $('div.product-info div.image a img'); // originally for theme cosyone, actually common
			}
			if ($('div.row-product a img[itemprop="image"]').length) {
				return $('div.row-product a img[itemprop="image"]'); // originally for theme moneymaker, actually common
			}
		}
		return $('#image'); // by standard default
	}
	
	poip_product_default.prototype.getElementOuterHTML =  function(elem) {
		str = $('<div>').append(elem.clone()).html();
		//str = $(document.createElement("div")).append(elem.clone()).html();
		return str;
	}
	
	// returns element/elements (div, ul, li etc, depend on theme) containing links to additional images (а)
	poip_product_default.prototype.getAdditionalImagesBlock = function() {
		var this_object = this;
		
		if ( typeof(this_object.replace_getAdditionalImagesBlock) == 'function' ) {
			return this_object.replace_getAdditionalImagesBlock();
			//var additional_images_block = this_object.replace_getAdditionalImagesBlock();
			//if (additional_images_block) {
			//	return additional_images_block;
			//}
		}
		if ( typeof(this_object.if_getAdditionalImagesBlock) == 'function' ) {
			// returns result of jQuery call ( $(...) ) or FALSE
			var if_result = this_object.if_getAdditionalImagesBlock();
			if ( if_result ) {
				return if_result;
			}
		}
		
		
		
		if ( $('li.image-additional').length ) { // OC 2.0 default
			return $('li.image-additional');
		}
	
		if ( !$('div.image-additional').length ) {
			$('div.product-info div.image').after('<div class="image-additional"></div>');
		}
	
		return $('div.image-additional');
	}
	
	poip_product_default.prototype.getRefreshColorboxImagesVisible = function() {
		var this_object = this;
		
		if ( typeof(this_object.replace_getRefreshColorboxImagesVisible) == 'function' ) {
			return this_object.replace_getRefreshColorboxImagesVisible();
		}
		
		return this_object.getAdditionalImagesBlock().find('a:visible[href!="#"]');
	}
	
	poip_product_default.prototype.getColorboxSettings = function() {
		
		if ( typeof(this_object.replace_getColorboxSettings) == 'function' ) {
			return this_object.replace_getColorboxSettings();
		}
		
		var colorbox_settings = false;
		try {
			var scripts = $('script:contains(".colorbox")');
			for (var i=0; i<scripts.length; i++) {
				var script_html  =$(scripts[i]).html();
				if (script_html.indexOf('$(\'.colorbox\').colorbox(') != -1 ) {
					var str_pos = script_html.indexOf('$(\'.colorbox\').colorbox(');
					var str = script_html.substr(str_pos+24);
					str_pos = str.indexOf('});');
					str = str.substr(0,str_pos+1);
					colorbox_settings = eval('('+str+')');
					break;
				}
			}
		} catch (e) {
			console.debug(e);
			colorbox_settings = false
		}
		
		if (!colorbox_settings || (typeof colorbox_settings) != 'object') {
			console.log('colorbox settings not found');
			colorbox_settings = {
				overlayClose: true,
				opacity: 0.5,
				rel: "colorbox"
			};
		}
		
	}
	
	poip_product_default.prototype.refreshColorboxImages = function() {
		var this_object = this;
	
		// OC 2.0 not uses colorbox in default theme
		if (!this_object.use_refresh_colorbox) return;
		
		if (poip_settings['img_gal']) {
			
			if ( typeof(this_object.if_refreshColorboxImages) == 'function' && this_object.if_refreshColorboxImages() ) {
				return;
			}
		
			$('#poip_colorbox').remove();
			
			this_object.getAdditionalImagesBlock().after('<div style="display: none" id="poip_colorbox"></div>');
			
			var colorbox_images = [];

			var visible_images = this_object.getRefreshColorboxImagesVisible();
			
			visible_images.each(function(){
				var img_href = $(this).attr('href') ;
				if ($.inArray( img_href, colorbox_images) == -1) {
					$('#poip_colorbox').append( this_object.getElementOuterHTML($(this)).replace('colorbox', 'poip_colorbox') );
					colorbox_images.push(img_href);
				}
			});
			
			
			/* add main image to gallery, even if it's not included in additional images */
			if ($.inArray(this_object.getMainImage().parent().attr('href'), colorbox_images) == -1) {
				$('#poip_colorbox').append( this_object.getElementOuterHTML(this_object.getMainImage().parent()).replace('colorbox', 'poip_colorbox') );
				colorbox_images.push(this_object.getMainImage().parent().attr('href'));
			}
			
			// for ava store and, possible, other templates, poip_colorbox should be additionally filled
			$('#poip_colorbox a[href!="#"], #poip_colorbox a[href="#"][data-image]').each(function(){
				if ( !$(this).hasClass('poip_colorbox') ) {
					$(this).addClass('poip_colorbox');
				}
				if ($(this).attr('href') == '#' && $(this).attr('data-image')) {
					$(this).attr('href', $(this).attr('data-image'));
				}
			});
			
			if (typeof($.colorbox) !== 'undefined') {
				$.colorbox.remove();
			}
			
			if ( typeof(this_object.if_beforeColorboxReinit) == 'function' && this_object.if_beforeColorboxReinit() ) {
				return;
			}
			
			if ($.colorbox) {
			
				colorbox_settings = this_object.getColorboxSettings();
			
				$('.poip_colorbox').colorbox(colorbox_settings);
			
				try {
					$('[id^=option-images-]').each( function() {
						
						colorbox_settings['rel'] = $(this).attr('id');
						// more compatible
						$(this).find('a').colorbox(colorbox_settings);
						
					});
				} catch(e) {
					console.debug(e);
					console.debug("colorbox under options gallery error");
				}
			
			}
			
			if ( typeof(this_object.if_triggerAfterColorboxReinit) == 'function' && this_object.if_triggerAfterColorboxReinit() ) {
				// nothing
			} else {
				$('.colorbox').unbind('click');
				//$('.colorbox').unbind('click', this_object.eventColorboxClick);
				$('.colorbox').bind( 'click', function(event) {
					this_object.eventColorboxClick(event, this);
				});
			}
			
		}
	}
	
	poip_product_default.prototype.eventColorboxClick = function(event, element) {
		var this_object = this;
	
		if ( typeof(this_object.replace_eventColorboxClick) == 'function' ) {
			return this_object.replace_eventColorboxClick(event, element);
		}
	
		event.preventDefault();
	
		var this_data = $(element);
		var poip_colorbox = $('a.poip_colorbox[href!="#"]');
		
		for (var i=0; i<poip_colorbox.length; i++) {
			if (this_data.attr('href') == poip_colorbox[i].href || this_data.attr('href') == decodeURIComponent(poip_colorbox[i].href)) {
				$(poip_colorbox[i]).trigger('click');
				break;
			}
		}
	}
	
	poip_product_default.prototype.hrefIsVideo = function(href) {
		var this_object = this;
	
		if ( href ) {
			if ( href.indexOf('https://www.youtube.com')==0 || href.indexOf('http://www.youtube.com')==0
			|| href.indexOf('https://youtube.com')==0 || href.indexOf('http://youtube.com')==0
			|| href.indexOf('https://www.vimeo.com')==0 || href.indexOf('http://www.vimeo.com')==0
			|| href.indexOf('https://vimeo.com')==0 || href.indexOf('http://vimeo.com')==0
			|| href.indexOf('www.youtube.com')==0
			|| href.indexOf('youtube.com')==0
			|| href.indexOf('www.vimeo.com')==0
			|| href.indexOf('vimeo.com')==0 ) {
				return true;
			}
		}
		return false;
	}
	
	poip_product_default.prototype.getAdditionalImageMouseoverHref = function(image_a) {
		var this_object = this;
		
		if ( typeof(this_object.replace_getAdditionalImageMouseoverHref) == 'function' ) {
			return this_object.replace_getAdditionalImageMouseoverHref(image_a);
		}
		
		var href = '';
		if ($(image_a).is('img')) {
			href = $(image_a).attr('src');
		} else {
			href = ($(image_a).attr('href') && $(image_a).attr('href')!='#') ? $(image_a).attr('href') : $(image_a).attr('data-image') ;
		}
		
		return href;
	}
	
	poip_product_default.prototype.eventAdditionalImageMouseover = function(image_a) {
		var this_object = this;
	
		var href = this_object.getAdditionalImageMouseoverHref(image_a);
		
		var data_image = $(image_a).attr('data-image');
		
		if ( this_object.hrefIsVideo(href) ) {
			return;
		}
		
		for (var i=0;i<poip_images.length;i++) {
		
			if ( (poip_images[i]['popup'] && poip_images[i]['popup'] == href) || (poip_images[i]['thumb'] && poip_images[i]['thumb'] == href)
			|| (poip_images[i]['popup'] && poip_images[i]['popup'] == data_image ) ) {
				
				if ( this_object.useMainImageUpdatingOnMouseover() ) {
					this_object.setMainImage(poip_images[i]['main'], poip_images[i]['popup']);
				}
				this_object.updateZoomImage(poip_images[i]['popup']);
		
				break;
			}
		}
		
		if ( typeof(this_object.additional_endOfEventAdditionalImageMouseover) == 'function' ) {
			this_object.additional_endOfEventAdditionalImageMouseover(image_a);
		}
		
		this_object.refreshPopupImages();
	}
	
	poip_product_default.prototype.setDefaultOptionsByURL = function(value) {
		var this_object = this;
		
		<?php
			if (isset($poip_ov) && $poip_ov) {
				echo "var poip_ov = '".(int)$poip_ov."';";
			} else {
				echo "var poip_ov = false;";
			}
		?>
		
		if (poip_ov) {
			this_object.setProductOptionValue(poip_ov);
		}
		
		// for Yandex sync module by Toporchillo
		var hash = window.location.hash;
		if (hash) {
			var hashpart = hash.split('#');
			var hashvals = hashpart[1].split('-');
			for (i=0; i<hashvals.length; i++) {
				if ( !hashvals.hasOwnProperty(i) ) continue;
				
				this_object.setProductOptionValue(hashvals[i]);
				
				/*
				$('div.options').find('select option[value="'+vals[i]+'"]').parent().find('option').removeAttr('selected');
				$('div.options').find('select option[value="'+vals[i]+'"]').attr('selected', true).parent().trigger('change');
				$('div.options').find('input[type="radio"][value="'+vals[i]+'"]').attr('checked', true).trigger('click');
				*/
			}
		}
		
	}
	
	poip_product_default.prototype.setProductOptionValue = function(value) {
		var this_object = this;
	
		var options = $('select[name^="'+this_object.option_prefix+'["]').children('option[value="'+value+'"]:not(:disabled)');
		for (var i=0; i<options.length;i++) {
			
			// Journal2 compatibility
			if ($('.option ul li[data-value='+$(options[i]).val()+']').length) {
				$('.option ul li[data-value='+$(options[i]).val()+']').click();
				return;
			}
		
			// Product Block Option compatibility
			if ( $('a[option-value='+value+']').length ) {
				$('a[option-value='+value+']').click();
				return;
			}
			
			$(options[i]).parent().val(value);
			$(options[i]).parent().trigger('change');
			
			return;
		}
		
		var options = $('input[type=radio][name^="'+this_object.option_prefix+'["][value="'+value+'"]:not(:disabled)');
		for (var i=0; i<options.length;i++) {
		
			// Journal2 compatibility
			if ($('.option ul li[data-value='+$(options[i]).val()+']').length) {
				$('.option ul li[data-value='+$(options[i]).val()+']').click();
				return;
			}
		
			// Product Block Option compatibility
			if ( $('a[option-value='+value+']').length ) {
				$('a[option-value='+value+']').click();
				return;
			}
			
			if ( typeof(this_object.if_afterSetProductOptionValue) == 'function' && this_object.if_afterSetProductOptionValue(options[i]) ) {
				return;
			}
		
			options[i].checked = true;
			$(options[i]).trigger('change');
			return;
		}
		
		var options = $('input[type=checkbox][name^="'+this_object.option_prefix+'["][value="'+value+'"]:not(:disabled)');
		for (var i=0; i<options.length;i++) {
			
			// Journal2 compatibility
			if ($('.option ul li[data-value='+$(options[i]).val()+']').length) {
				$('.option ul li[data-value='+$(options[i]).val()+']').click();
				return;
			}
			
			options[i].checked = true;
			$(options[i]).trigger('change');
			return;
		}
		
	}
	
	
	poip_product_default.prototype.externalOptionChange = function() {
		var this_object = this;
		
		if (poip_images_by_options) {
			for (var i in poip_images_by_options) {
				if (poip_images_by_options[i] && poip_images_by_options[i].length && poip_images_by_options[i][0]['product_option_id']) {
					var product_option_id = poip_images_by_options[i][0]['product_option_id'];
					$('select, input').filter('[name="'+this_object.option_prefix+'['+product_option_id+']"]').change();
					return;
				}
			}
		}
	}
	
	poip_product_default.prototype.checkEventsForSelects = function(first_time) {
		var this_object = this;

		$('select[name^="'+this_object.option_prefix+'["]').each(function () {
			var select_events = $(this).data('events');
			var found_poip = false;
			
			if (select_events && select_events.change) {
				for (var i=0; i<select_events.change.length; i++) {
					if ( (''+select_events.change[i].handler).indexOf('poip_option_value_selected') != -1 ) {
						found_poip = true;
						break;
					}
				}
			}
			
			if (!found_poip) {
				$(this).change( function(){this_object.eventOptionValueSelect(this);} );
				// event should be called, may be select value is reseted
				if (!first_time) {
					this_object.eventOptionValueSelect(this);
				}
			}
		});
	}
	
	// << MOST CHANGABLE FUNCTIONS
	
	poip_product_default.prototype.useColorboxRefreshing = function() {
		var this_object = this;
		
		if ( typeof(this_object.replace_useColorboxRefreshing) == 'function' ) {
			return this_object.replace_useColorboxRefreshing();
		}
		
		return false;
	}
	
	poip_product_default.prototype.useMainImageUpdatingOnMouseover = function() {
		var this_object = this;
		
		if ( typeof(this_object.replace_useMainImageUpdatingOnMouseover) == 'function' ) {
			return this_object.replace_useMainImageUpdatingOnMouseover();
		}
		
		return true;
	}
	
	// >> MOST CHANGABLE FUNCTIONS
	

--></script>

<script type="text/javascript"><!--
	var console=console||{"log":function(){},"debug":function(){}};
	var poip_options_settings = <?php echo json_encode($poip_product_settings); ?>;
	var poip_settings = <?php echo json_encode($poip_settings); ?>;
	var poip_images = <?php echo json_encode($poip_images); ?>;
	var poip_images_by_options = <?php echo json_encode($poip_images_by_options); ?>;
	var poip_product_option_ids = <?php echo json_encode($poip_product_option_ids); ?>;
	
	if ( typeof(poip_images2) != 'undefined' ) {
		poip_images = poip_images2;
	}
	
	var poip_theme_name = '<?php echo isset($poip_theme_name) ? $poip_theme_name : 'default'; ?>';
	
	
	
//--></script>  