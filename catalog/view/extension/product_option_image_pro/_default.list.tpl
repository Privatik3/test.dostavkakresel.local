<?php
/* Product Option Image PRO module  */ 
if ( !empty($poip_installed) ) {  ?>
	<script  type = "text/javascript" ><!--
		
		var poip_wait_server_call = false;
	
		var poip_list_default = function() {
			this.init();
		};
		
		poip_list_default.prototype.init = function() {
			var this_object = this;
			
			poip_wait_server_call = true; // global
			
			this_object.poip_jquery_timer = setInterval( function(){
				if (typeof($) != 'undefined' && typeof(this_object.readyRun) == 'function' ) {
					clearInterval(this_object.poip_jquery_timer);
					this_object.readyRun();
				}
			},100);
		}
		
		poip_list_default.prototype.getProductListImages = function(poip_products_ids) {
			var this_object = this;
			
			var params = {products_ids: poip_products_ids};
			$.ajax({
				type: 'POST',
				url: 'index.php?route=module/product_option_image_pro/get_products_list_images',
				data: params,
				dataType: 'json',
				//dataType: 'text',
				beforeSend: function() {},
				complete: function() {},
				success: function(json) {
					if (json && typeof(json['products'])!='undefined' && json['products']) {
						this_object.showProductListImages(json);
						// move to call of function afterOptionImagesShow
						if (typeof(this_object.afterOptionImagesShowing) == 'function') {
							this_object.afterOptionImagesShowing();
						}
						poip_wait_server_call = false; // global
					}
				},
				error: function(error) {
					console.log(error);
					poip_wait_server_call = false; // global
				}
			});
		}
		poip_list_default.prototype.getProductIdFromPOIPId = function(poip_id) {
			var parts = poip_id.split('_');
			if (parts.length) {
				return parts[parts.length-1];
			}
		}
		
		poip_list_default.prototype.readyRun = function() {
			var this_object = this;
			
			$(document).ready(function(){
			
				var poip_products_ids = [];
				$('img[data-poip_id]:not([data-poip-loaded])').each(function(){
					var poip_product_id = this_object.getProductIdFromPOIPId( $(this).attr('data-poip_id') );
					if (poip_product_id && $.inArray(poip_product_id,poip_products_ids)==-1) {
						poip_products_ids.push(poip_product_id);
					}
				});
				
				if (poip_products_ids.length) {
					this_object.getProductListImages(poip_products_ids);
				}
			});
		}
		
		poip_list_default.prototype.showProductListImages = function(json) {
			var this_object = this;
		
			for (var poip_product_id in json['products']) {
				
				var poip_data = json['products'][poip_product_id];
				
				if (poip_data) {
				
					$('img[data-poip_id$="_'+poip_product_id+'"]:not([data-poip-loaded])').each(function(){
						
						if ( poip_data && !$.isEmptyObject(poip_data) ) {
							this_object.showOneProductImages($(this), poip_data);
						}
						$(this).attr('data-poip-loaded', 'loaded');
					});
				}
			}
			
			if ( typeof(this_object.after_showProductListImages) == 'function' ) {
				this_object.after_showProductListImages(json);
			}
			
		}
		
	//--></script>
<?php } ?>