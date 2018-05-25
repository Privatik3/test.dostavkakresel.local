<?php
/* Product Option Image PRO module  */ 
if ( !empty($poip_installed) ) {  ?>
	<script  type = "text/javascript" ><!--
		
		var poip_list_custom = function(){
			poip_list_default.call(this);
		}
		poip_list_custom.prototype = Object.create(poip_list_default.prototype);
		poip_list_custom.prototype.constructor = poip_list_custom;
			
		
		poip_list_custom.prototype.showOneProductImages = function(elem_image, poip_data) {
					
			var current_a_elem = elem_image.closest('a');
			var current_class_image_id = current_a_elem.find('img').attr('data-poip_id');
			var product_href = current_a_elem.attr('href');
		
			var html = '';
		
			for (var product_option_id in poip_data) {
				html+='';
				for (var poip_data_i in poip_data[product_option_id]) {
					var option_image = poip_data[product_option_id][poip_data_i];
					var product_option_value_id = option_image['product_option_value_id'];
					
					var title = (typeof(option_image['title'])!='undefined' && option_image['title']) ? option_image['title'] : '';
					
					html+='<a onmouseover="poip_show_thumb(this);" ';
					html+=' href="'+product_href+(product_href.indexOf('?')==-1?'?':'&amp;')+'poip_ov='+product_option_value_id+'"';
					html+=' style="padding-left:6px; padding-top:2px; margin:0px; width:25px; height:25px; "';
					html+=' title="'+title+'"';
					html+=' data-thumb="'+option_image['thumb']+'"';
					html+=' data-image_id="'+current_class_image_id+'">';
					html+=' <img style="width:24px; height:24px;" src="'+option_image['icon']+'"></a>';
					html+='</a>';
				}
			}
			if ( html ) {
				html='<div data-poip_id="poip_img" style="z-index: 5; margin-top: 5px; position: relative; ">'+html+'</div>';
				
				elem_image.closest('.image').after(html);
			}
			
		}
		
		
		poip_list_custom.prototype.after_showProductListImages = function(json) {
			
			var this_object = this;
		
			// add empty divs to make height of product blocks the same
			for (var poip_product_id in json['products']) {
				
				$('img[data-poip_id$="_'+poip_product_id+'"]').each( function(){
					
					if ( !$(this).closest('.image').siblings('[data-poip_id="poip_img"]').length ) {
					
						var max_height = 0;
						$(this).closest('.carousel-product, .section-product, .main-products').first().find('[data-poip_id="poip_img"]').each(function(){
							max_height = Math.max( max_height, $(this).height() );
						});
						
						if ( max_height ) {
							var html='<div data-poip_id="poip_img" style="z-index: 5; margin-top: 5px; position: relative; height: '+max_height+'px;"> </div>';
							$(this).closest('.image').after(html);
						}
					}
				});
			}
		}
			
		
		var poip_list = new poip_list_custom();
	
	//--></script>
<?php } ?>	