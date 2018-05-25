<script type="text/javascript"><!--

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.custom_init = function(){
		
	}
	
	// << ITS OWN FUNCTIONS
	
	poip_product_custom.prototype.custom_photoboxMainImageClick = function(event, element) {
		var this_object = this;
		
		event.preventDefault();
	
		var this_data = $(element);
		var poip_box = $('div.images a:visible');
		
		for (var i=0; i<poip_box.length; i++) {
			if (this_data.attr('href') == $(poip_box[i]).attr('href') ) {
				$(poip_box[i]).trigger('click');
				break;
			}
		}
	}
	
	poip_product_custom.prototype.custom_eventFancyboxClick = function(event, element) {
		var this_object = this;
	
		event.preventDefault();
	
		var this_data = $(element);
		var poip_box = $('a.poip_fancybox');
		
		for (var i=0; i<poip_box.length; i++) {
			if (this_data.attr('href') == $(poip_box[i]).attr('href') ) {
				$(poip_box[i]).trigger('click');
				break;
			}
		}
	}
	
	// >> ITS OWN FUNCTIONS
	
	// << ADDITIONAL FUNCTIONS
	// without replacing or stopping original script execution, just addition
	
	poip_product_custom.prototype.additional_useOldOCStyleInit = function() {
		return true;
	}
	
	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm (prefixes replace_ and if_)


	poip_product_custom.prototype.replace_getAdditionalImagesBlock = function() {
		return $('div.row-product div.images');
	}

	
	poip_product_custom.prototype.if_refreshColorboxImages = function() {
		var this_object = this;
		
		<?php if ( $poip_moneymaker_settings['mmr_product_gallery_type']=='photobox' ) { ?>
				
			// use main gallery with options filter, main image click transferring to gallery image click
			
			//$('.photobox').data("_photobox").destroy(); - глючит
			
			// remove standard photobox if exists
			if ($('.photobox').data("_photobox")) {
				var _photobox = $('.photobox').data("_photobox");
				_photobox.selector.off('click.photobox', _photobox.target)
				$('.photobox').removeData('_photobox');
			}
				
			// remove our photobox if exists
			if ($('div.images .photobox').data("_photobox")) {
				var _photobox = $('div.images .photobox').data("_photobox");
				_photobox.selector.off('click.photobox', _photobox.target)
				$('div.images .photobox').removeData('_photobox');
			}	
				
			$('div.images .photobox').photobox('a:visible');
			
			this_object.getMainImage().parent().unbind('click');
			//this_object.getMainImage().parent().unbind('click', this_object.photoboxMainImageClick);
			this_object.getMainImage().parent().bind('click', function(event){
				this_object.photoboxMainImageClick(event, this);
			});
			
			return;
		<?php } ?>
		
		<?php if ( $poip_moneymaker_settings['mmr_product_gallery_type']=='fancybox' ) { ?>
			
			// make gallery copy, only with visible images, images clicks transfers to gallery
			
			$('#poip_fancybox').remove();
			this_object.getAdditionalImagesBlock().after('<div style="display: none" id="poip_fancybox"></div>');
			
			var fancybox_images = [];
			$('div.images a.fancybox:visible').each(function(){
				if ( $.inArray($(this).attr('href'), fancybox_images)==-1 ) {
					$('#poip_fancybox').append( this_object.getElementOuterHTML($(this)).replace('data-rel="fancybox"', 'data-rel="poip_fancybox"').replace('fancybox', 'poip_fancybox') );
					fancybox_images.push($(this).attr('href'));
				}
			});
			
			$(document).unbind("click.fb-start");
			
			$('.poip_fancybox').removeData('fancybox');
			$('.fancybox').removeData('fancybox');
			
			$('.poip_fancybox').fancybox({
				'padding'	:	20,
				'transitionIn'	:	'fade',
				'transitionOut'	:	'fade',
				'overlayOpacity' : 0.7,
				'overlayColor' : '#000',
				'opacity'		: true,
				'titleShow'		: false,
				'showNavArrows'		: true,
				onStart: function() { if(navigator.appVersion.indexOf("MSIE 8.")!=-1) {$("html, body").animate({scrollTop:0}, 'slow');}; },
				onComplete: function() {
					$("#fancybox-wrap").prepend("<div id='image-appendix'><div class='title hidden-xs'><?php echo $heading_title; ?></div><div class='btn-group btn-group-lg hidden-xs additional-buttons'><?php if (!$mmr_buyhide) { ?><button class='btn btn-primary' type='button' onclick='$(\"#image-appendix\").remove();$(\"#button-cart\").click();$.fancybox.close()'><i class='fa fa-shopping-cart'></i> <?php echo $button_cart; ?></button><input type='text' data-toggle='tooltip' class='form-control input-lg' name='quantities' size='2' value='<?php echo $minimum; ?>' title='<?php echo $text_qty; ?>' /><?php if ($mmr_qorder&&$poip_moneymaker_settings['mmr_quickorder_popup_button_disabled']!=1) { ?><a class='btn btn-default' onclick='$(\"#image-appendix\").remove();$.fancybox.close();$(\".btn-quickorder\").click();'><i class='fa fa-flip-horizontal fa-reply-all'></i> <span><?php echo $this->language->get('text_mmr_quickorder_button'); ?></span></a><?php } ?><?php } ?><?php if (!$poip_moneymaker_settings['mmr_common_btn_wishlist_hidden']) { ?><button type='button' data-toggle='tooltip' class='btn btn-default' title='<?php echo $button_wishlist; ?>' onclick='addToWishList(<?php echo $product_id; ?>);$.fancybox.close()'><i class='fa fa-heart'></i></button><?php } ?><?php if (!$poip_moneymaker_settings['mmr_common_btn_compare_hidden']) { ?><button type='button' data-toggle='tooltip' class='btn btn-default' title='<?php echo $button_compare; ?>' onclick='addToCompare(<?php echo $product_id; ?>);$.fancybox.close()'><i class='fa fa-bar-chart-o'></i></button><?php } ?></div></div>");
					$('input[name=\"quantities\"]').keyup(function(){document.getElementsByName('quantity')[0].value = $(this).val(); });
				},
				onCleanup: function() {
					$("#image-appendix").remove()
				}
			});
			
			$('.fancybox').unbind('click');
			//$('.fancybox').unbind('click', this_object.eventFancyboxClick);
			$('.fancybox').bind( 'click', function(event) {
				this_object.custom_eventFancyboxClick(event, this);
			});
			
			return;
		<?php } ?>	
		
	}
	
	poip_product_custom.prototype.replace_eventColorboxClick = function(event, element) {
		var this_object = this;
	
		event.preventDefault();
	
		var this_data = $(element).find('a');
		var poip_colorbox = $('a.poip_colorbox[href!="#"]');
		
		for (var i=0; i<poip_colorbox.length; i++) {
			if (this_data.attr('href') == poip_colorbox[i].href || this_data.attr('href') == decodeURIComponent(poip_colorbox[i].href)) {
				$(poip_colorbox[i]).trigger('click');
				break;
			}
		}
	}
	
	poip_product_custom.prototype.replace_getColorboxSettings = function() {
		var this_object = this;
		
		colorbox_settings = {
			next: "<button class='btn btn-default' type='button'><i class='fa fa-fw fa-chevron-right'></i></button>",
			previous: "<button class='btn btn-default' type='button'><i class='fa fa-fw fa-chevron-left'></i></button>",
			close: "<button class='btn btn-default' type='button'><i class='fa fa-fw fa-times'></i></button>",
			rel: "colorbox",
			onOpen: function() {
				$("#colorbox").prepend("<div id='image-appendix'><div class='title hidden-xs'>iPhone</div><div class='btn-group btn-group-lg hidden-xs additional-buttons'><button class='btn btn-primary' type='button'  onclick='$(\"#image-appendix\").remove();$(\"#button-cart\").click();'><i class='fa fa-shopping-cart'></i> Купить</button><input type='text' data-toggle='tooltip' class='form-control input-lg' name='quantities' size='2' value='1' title='Количество:' /><button type='button' data-toggle='tooltip' class='btn btn-default' title='в закладки' onclick='addToWishList(40);'><i class='fa fa-heart'></i></button><button type='button' data-toggle='tooltip' class='btn btn-default' title='сравнение' onclick='addToCompare(40);'><i class='fa fa-bar-chart-o'></i></button></div></div>");
				$('input[name=\"quantities\"]').keyup(function(){document.getElementsByName('quantity')[0].value = $(this).val(); });
			},
			onComplete: function() { if(navigator.appVersion.indexOf("MSIE 8.")!=-1) {$("html, body").animate({scrollTop:0}, 'slow');}; },
			onClosed: function() {
				$("#image-appendix").remove()
			}
		}
	}
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>