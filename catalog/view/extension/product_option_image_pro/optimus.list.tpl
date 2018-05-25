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
			
				if ( !poip_data.hasOwnProperty(product_option_id) ) {
					continue;
				}
			
				html+='';
				for (var poip_data_i in poip_data[product_option_id]) {
				
					if ( !poip_data[product_option_id].hasOwnProperty(poip_data_i) ) {
						continue;
					}
				
					var option_image = poip_data[product_option_id][poip_data_i];
					var product_option_value_id = option_image['product_option_value_id'];
					
					var title = (typeof(option_image['title'])!='undefined' && option_image['title']) ? option_image['title'] : '';
					
					html+='<a onmouseover="poip_show_thumb(this);" ';
					html+=' href="'+product_href+(product_href.indexOf('?')==-1?'?':'&amp;')+'poip_ov='+product_option_value_id+'"';
					html+=' style="display:inline-block; background-image:url(\''+option_image['icon']+'\'); width:40px; height:40px; background-size: cover;"';
					html+=' title="'+title+'"';
					html+=' data-thumb="'+option_image['thumb']+'"';
					html+=' data-image_id="'+current_class_image_id+'">';
					html+=' ';
					html+='</a>';
				}
			}
			
			if ( html ) {
			
				html='<div data-poip_id="poip_img" style="  text-align: center; margin-top: 3px;">'+html;
				html+='</div>';
				
				elem_image.parent().parent().after(html);
			}
			
		}
			
		
		var poip_list = new poip_list_custom();
	
	//--></script>
<?php } ?>	