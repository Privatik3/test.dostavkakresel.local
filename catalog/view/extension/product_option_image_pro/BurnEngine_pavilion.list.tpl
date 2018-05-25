<?php
/* Product Option Image PRO module  */ 
if ( !empty($poip_installed) ) {  ?>
	<script  type = "text/javascript" ><!--
		
		var poip_list_custom = function(){
			poip_list_default.call(this);
		}
		poip_list_custom.prototype = Object.create(poip_list_default.prototype);
		poip_list_custom.prototype.constructor = poip_list_custom;
			
			
		// to show current image in hover block too
		poip_list_custom.prototype.controlHoveredImage = function() {
			$('.tb_products').on('mouseover', '.tb_item_hovered', function(){
				if ($(this).find('.product-thumb .image img').attr('src')!=$(this).siblings('.product-thumb').find('.image img').attr('src')) {
					$(this).find('.product-thumb .image img').attr('src', $(this).siblings('.product-thumb').find('.image img').attr('src'));
					$(this).find('.product-thumb .image a').attr('href', $(this).siblings('.product-thumb').find('.image a').attr('href'));
				}
			});
		}
		
		poip_list_custom.prototype.afterOptionImagesShowing = function() {
			this.controlHoveredImage();
		}
		
		poip_list_custom.prototype.readyRun = function() { // redefinition
			var this_object = this;
			$(document).ready(function(){
				var poip_products_inputs = $('.tb_products input[type="hidden"][class^="product-id_"]');
				if (poip_products_inputs.length) {
					var poip_products_ids = [];
					poip_products_inputs.each(function(){
						var poip_product_id = $(this).attr('class').substr(11);
						if (poip_product_id && $.inArray(poip_product_id,poip_products_ids)==-1) {
							poip_products_ids.push(poip_product_id);
						}
					});
					if (poip_products_ids.length) {
						this_object.getProductListImages(poip_products_ids);
					}
				}
			});
		}
		
		poip_list_custom.prototype.showProductListImages = function(json) { // redefinition
			var this_object = this;
			
			for (var poip_product_id in json['products']) {
			
				var current_a_elem = $('.tb_products input[type="hidden"][class="product-id_'+poip_product_id+'"]').siblings('.product-thumb').find('.image a:first');
				var current_class_image_id = current_a_elem.find('img').attr('data-poip_id');
				var product_href = current_a_elem.attr('href');
				
				var html = '';
				
				var poip_data = json['products'][poip_product_id];
				
				if (poip_data) {
				
					for (var product_option_id in poip_data) {
						html+='';
						for (var product_option_value_id in poip_data[product_option_id]) {
							var option_image = poip_data[product_option_id][product_option_value_id];
							
							var title = (typeof(option_image['title'])!='undefined' && option_image['title']) ? option_image['title'] : '';
							
							html+='<a onmouseover="poip_show_thumb(this);" ';
							html+=' href="'+product_href+(product_href.indexOf('?')==-1?'?':'&amp;')+'poip_ov='+product_option_value_id+'"';
							html+=' style="display:inline-block; background-image:url(\''+option_image['icon']+'\'); width:40px; height:40px;  background-size: cover;"';
							html+=' title="'+title+'"';
							html+=' data-thumb="'+option_image['thumb']+'"';
							html+=' data-image_id="'+current_class_image_id+'">';
							html+=' ';
							//html+='<img src="'+option_image['icon']+'" alt="'+title+'">';
							html+='</a>';
						}
					}
					
				}
				
				if (html) {
					
					html='<div data-poip_id="poip_img" style="  text-align: center; margin-top: 3px; ">'+html+'</div>';
					
					
					html='<div class="description">'+html+'</div>';
					$('.tb_products input[type="hidden"][class="product-id_'+poip_product_id+'"]').each(function(){
						if ($(this).closest('.tb_item_hovered').length == 0 ) {
							$(this).siblings('.product-thumb').find('.image:first').after(html);
							//$(this).before(html);
						}
					});
				}
			}
		}
		
		
		var poip_list = new poip_list_custom();
		//poip_list.init();
		
	//--></script>
<?php } ?>	