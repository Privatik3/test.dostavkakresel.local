<form id="form-option<?php echo $product_id; ?>">
 <?php if ($product_id == -1) { ?>
 <div class="alert alert-info text-center"><?php echo $notice_empty_field; ?></div>
 <p><span class="be-help"><label><input name="none[<?php echo $link; ?>]" type="checkbox" /> <?php echo $text_not_contain; ?> > <?php echo ${'text_' . $link}; ?></label></span></p>
 <?php } ?>
 <?php if ($product_id > 0) { ?>
 <table class="be-form">
  <tr>
   <td width="1%"><img src="<?php echo $product_image; ?>" /></td>
   <td width="99%"><h3><?php echo $product_name; ?></h3></td>
  </tr>
 </table>
 <?php } ?>
 <div class="col-sm-2">
  <ul id="option" class="nav nav-pills nav-stacked">
   <?php $option_row = 0; ?>
   <?php if ($data) { ?>
   <?php foreach ($data['product_options'] as $product_option) { ?>
   <li><a href="#tab-option-<?php echo $product_id; ?>-<?php echo $option_row; ?>" id="option-<?php echo $option_row; ?>" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$(this).parents('li:first').remove(); $('#form-option<?php echo $product_id; ?> #tab-option-<?php echo $product_id; ?>-<?php echo $option_row; ?>').remove(); $('#form-option<?php echo $product_id; ?> #option a:first').tab('show');"></i>&nbsp;<?php echo $product_option['name']; ?></a></li>
   <?php $option_row++; ?>
   <?php } ?>
   <?php } ?>
   <li><input type="text" name="option_input" class="form-control" /></li>
  </ul>
 </div>
 
 <?php $colspan = 6; ?>
 <?php if ($base_price) { ?>
 <?php $colspan++; ?>
 <?php } ?>
 <?php if ($customer_group_id) { ?>
 <?php $colspan++; ?>
 <?php } ?>
 <?php if ($optsku) { ?>
 <?php $colspan++; ?>
 <?php } ?>
 
 <?php $option_row = 0; ?>
 <?php $option_value_row = 0; ?>
 <div class="col-sm-10">
 <div class="tab-content">
 <?php if ($data) { ?>
 <?php foreach ($data['product_options'] as $product_option) { ?>
 <div id="tab-option-<?php echo $product_id; ?>-<?php echo $option_row; ?>" class="tab-pane">
  <input type="hidden" name="option[<?php echo $option_row; ?>][product_option_id]" value="<?php echo $product_option['product_option_id']; ?>" />
  <input type="hidden" name="option[<?php echo $option_row; ?>][name]" value="<?php echo $product_option['name']; ?>" />
  <input type="hidden" name="option[<?php echo $option_row; ?>][option_id]" value="<?php echo $product_option['option_id']; ?>" />
  <input type="hidden" name="option[<?php echo $option_row; ?>][type]" value="<?php echo $product_option['type']; ?>" />
  <table class="be-form">
   <tr>
    <td><?php echo $text_required; ?></td>
    <td><select name="option[<?php echo $option_row; ?>][required]">
      <?php if ($product_option['required']) { ?>
      <option value="1" selected="selected"><?php echo $text_yes; ?></option>
      <option value="0"><?php echo $text_no; ?></option>
      <?php } else { ?>
      <option value="1"><?php echo $text_yes; ?></option>
      <option value="0" selected="selected"><?php echo $text_no; ?></option>
      <?php } ?>
     </select></td>
   </tr>
   <?php if ($product_option['type'] == 'text') { ?>
   <tr>
    <td><?php echo $text_value; ?></td>
    <td><input type="text" name="option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['value']; ?>" /></td>
   </tr>
   <?php } ?>
   <?php if ($product_option['type'] == 'textarea') { ?>
   <tr>
    <td><?php echo $text_value; ?></td>
    <td><textarea name="option[<?php echo $option_row; ?>][option_value]" cols="40" rows="5"><?php echo $product_option['value']; ?></textarea></td>
   </tr>
   <?php } ?>
   <?php if ($product_option['type'] == 'file') { ?>
   <tr style="display: none;">
    <td><?php echo $text_value; ?></td>
    <td><input type="text" name="option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['value']; ?>" /></td>
   </tr>
   <?php } ?>
   <?php if ($product_option['type'] == 'date') { ?>
   <?php if ($product_option['value'] == '0000-00-00') { ?>
   <?php $product_option['value'] = ''; ?>
   <?php } ?>
   <tr>
    <td><?php echo $text_value; ?></td>
    <td><input type="text" name="option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['value']; ?>" class="date" /></td>
   </tr>
   <?php } ?>
   <?php if ($product_option['type'] == 'datetime') { ?>
   <?php if ($product_option['value'] == '0000-00-00 00:00') { ?>
   <?php $product_option['value'] = ''; ?>
   <?php } ?>
   <tr>
    <td><?php echo $text_value; ?></td>
    <td><input type="text" name="option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['value']; ?>" class="datetime" /></td>
   </tr>
   <?php } ?>
   <?php if ($product_option['type'] == 'time') { ?>
   <?php if ($product_option['value'] == '00:00') { ?>
   <?php $product_option['value'] = ''; ?>
   <?php } ?>
   <tr>
    <td><?php echo $text_value; ?></td>
    <td><input type="text" name="option[<?php echo $option_row; ?>][option_value]" value="<?php echo $product_option['value']; ?>" class="time" /></td>
   </tr>
   <?php } ?>
  </table>
  <?php if (in_array ($product_option['type'], $option_type)) { ?>
  <table id="option-value-<?php echo $option_row; ?>" class="be-list">
   <thead>
    <tr>
     <td class="center" width="1"></td>
     <td class="left"><?php echo $text_value; ?></td>
     <td class="right"><?php echo $text_quantity; ?></td>
     <td class="left"><?php echo $text_subtract; ?></td>
     <td class="right"><?php echo $text_price; ?></td>
     <?php if ($base_price) { ?>
     <td class="left"><?php echo $text_base_price; ?></td>
     <?php } ?>
     <td class="right"><?php echo $text_point; ?></td>
     <td class="right"><?php echo $text_weight; ?></td>
     <?php if ($customer_group_id) { ?>
     <td class="right"><?php echo $text_customer_group; ?></td>
     <?php } ?>
     <?php if ($optsku) { ?>
     <td class="right"><?php echo $text_optsku; ?></td>
     <?php } ?>
    </tr>
   </thead>
   <?php foreach ($product_option['product_option_value'] as $product_option_value) { ?>
   <tbody id="option-value-row-<?php echo $option_value_row; ?>">
    <tr>
     <td class="center"><a onclick="$(this).parents('tbody:first').remove();" class="btn btn-danger btn-xs" title="<?php echo $button_remove; ?>"><i class="fa fa-minus"></i></a></td>
     <td class="left">
      <select name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][option_value_id]">
       <?php if (isset ($data['option_values'][$product_option['option_id']])) { ?>
       <?php foreach ($data['option_values'][$product_option['option_id']] as $option_value) { ?>
       <?php if ($option_value['option_value_id'] == $product_option_value['option_value_id']) { ?>
       <option value="<?php echo $option_value['option_value_id']; ?>" selected="selected"><?php echo $option_value['name']; ?></option>
       <?php } else { ?>
       <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
       <?php } ?>
       <?php } ?>
       <?php } ?>
      </select>
      <input type="hidden" name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][product_option_value_id]" value="<?php echo $product_option_value['product_option_value_id']; ?>" />
     </td>
     <td class="right"><input type="text" name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][quantity]" value="<?php echo $product_option_value['quantity']; ?>" size="10" /></td>
     <td class="left">
      <select name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][subtract]">
       <?php if ($product_option_value['subtract']) { ?>
       <option value="1" selected="selected"><?php echo $text_yes; ?></option>
       <option value="0"><?php echo $text_no; ?></option>
       <?php } else { ?>
       <option value="1"><?php echo $text_yes; ?></option>
       <option value="0" selected="selected"><?php echo $text_no; ?></option>
       <?php } ?>
      </select></td>
     <td class="right">
      <select name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price_prefix]">
       <?php foreach ($option_price_prefix as $price_prefix) { ?>
       <?php if ($product_option_value['price_prefix'] == $price_prefix['value']) { ?>
       <option value="<?php echo $price_prefix['value']; ?>" selected="selected"><?php echo $price_prefix['name']; ?></option>
       <?php } else { ?>
       <option value="<?php echo $price_prefix['value']; ?>"><?php echo $price_prefix['name']; ?></option>
       <?php } ?>
       <?php } ?>
      </select>
      <input type="text" name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price]" value="<?php echo $product_option_value['price']; ?>" size="15" />
      <?php if ($base_price) { ?>
     <td class="left"><input type="text" name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][base_price]" value="<?php echo $product_option_value['base_price']; ?>" size="15" /></td>
     <?php } ?>
     </td>
     <td class="right">
      <select name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][points_prefix]">
       <?php if ($product_option_value['points_prefix'] == '+') { ?>
       <option value="+" selected="selected">+</option>
       <?php } else { ?>
       <option value="+">+</option>
       <?php } ?>
       <?php if ($product_option_value['points_prefix'] == '-') { ?>
       <option value="-" selected="selected">-</option>
       <?php } else { ?>
       <option value="-">-</option>
       <?php } ?>
      </select>
      <input type="text" name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][points]" value="<?php echo $product_option_value['points']; ?>" size="10" />
     </td>
     <td class="right">
      <select name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight_prefix]">
       <?php if ($product_option_value['weight_prefix'] == '+') { ?>
       <option value="+" selected="selected">+</option>
       <?php } else { ?>
       <option value="+">+</option>
       <?php } ?>
       <?php if ($product_option_value['weight_prefix'] == '-') { ?>
       <option value="-" selected="selected">-</option>
       <?php } else { ?>
       <option value="-">-</option>
       <?php } ?>
      </select>
      <input type="text" name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][weight]" value="<?php echo $product_option_value['weight']; ?>" size="15" />
     </td>
     <?php if ($customer_group_id) { ?>
     <td class="right">
      <select name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][customer_group_id]">
       <?php foreach ($customer_group_id as $array) { ?>
       <?php if ($array['customer_group_id'] == $product_option_value['customer_group_id']) { ?>
       <option value="<?php echo $array['customer_group_id']; ?>" selected="selected"><?php echo $array['name']; ?></option>
       <?php } else { ?>
       <option value="<?php echo $array['customer_group_id']; ?>"><?php echo $array['name']; ?></option>
       <?php } ?>
       <?php } ?>
      </select>
     </td>
     <?php } ?>
     <?php if ($optsku) { ?>
     <td class="right"><input type="text" name="option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][optsku]" value="<?php echo $product_option_value['optsku']; ?>" size="15" /></td>
     <?php } ?>
    </tr>
   </tbody>
   <?php $option_value_row++; ?>
   <?php } ?>
   <tfoot>
    <tr>
     <td class="center"><a onclick="addOptionValue(<?php echo $product_id; ?>, <?php echo $option_row; ?>);" class="btn btn-success btn-xs" title="<?php echo $button_insert; ?>"><i class="fa fa-plus"></i></a></td>
     <td colspan="<?php echo $colspan; ?>"></td>
    </tr>
   </tfoot>
  </table>
  <select id="option-values-<?php echo $option_row; ?>" style="display:none;">
   <?php if (isset ($data['option_values'][$product_option['option_id']])) { ?>
   <?php foreach ($data['option_values'][$product_option['option_id']] as $option_value) { ?>
   <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
   <?php } ?>
   <?php } ?>
  </select>
  <?php } ?>
 </div>
 <?php $option_row++; ?>
 <?php } ?>
 <?php } ?>
 </div>
 </div>
 <br style="margin-top:20px; clear:both;" />
 <table class="be-list">
  <tfoot>
   <tr>
    <td class="center">
     <?php if ($product_id > -1) { ?>
     <input id="product-copy-data-product_name-<?php echo $product_id; ?>" type="text" />
     <input id="product-copy-data-product_id-<?php echo $product_id; ?>" type="hidden" />
     <a class="btn btn-primary btn-sm" onclick="copyProductData('<?php echo $product_id; ?>', '<?php echo $link; ?>');" title="<?php echo $button_copy; ?>" style="margin-right:50px;"><i class="fa fa-copy"></i></a>
     <?php } ?>
     <?php if ($product_id == -1) { ?>
     <a class="btn btn-primary" onclick="setLinkFilter('<?php echo $link; ?>');"><?php echo $button_add_to_filter; ?></a>
     <a class="btn btn-danger" onclick="delLinkFilter('<?php echo $link; ?>');"><?php echo $button_remove_from_filter; ?></a>
     <?php } ?>
     <?php if ($product_id == 0) { ?>
     <a class="btn btn-primary" onclick="editLink('<?php echo $link; ?>', 'insert_option', <?php echo $product_id; ?>);"><?php echo $button_insert; ?></a>
     <a class="btn btn-primary" onclick="editLink('<?php echo $link; ?>', 'delete_option', <?php echo $product_id; ?>);"><?php echo $button_delete_option; ?></a>
     <a class="btn btn-primary" onclick="editLink('<?php echo $link; ?>', 'delete_option_value', <?php echo $product_id; ?>);"><?php echo $button_delete_option_value; ?></a>
     <a class="btn btn-primary" onclick="editLink('<?php echo $link; ?>', 'update', <?php echo $product_id; ?>);"><?php echo $button_update; ?></a>
     <?php } ?>
     <?php if ($product_id > 0) { ?>
     <a class="btn btn-primary" onclick="listProductLink('<?php echo $product_id; ?>', '<?php echo $link; ?>', 'prev');" title="<?php echo $button_prev; ?>"><i class="fa fa-chevron-left"></i></a>
     <a class="btn btn-primary" onclick="listProductLink('<?php echo $product_id; ?>', '<?php echo $link; ?>', 'next');" title="<?php echo $button_next; ?>" style="margin-right:50px;"><i class="fa fa-chevron-right"></i></a>
     <a class="btn btn-success" onclick="editLink('<?php echo $link; ?>', 'update', <?php echo $product_id; ?>);"><?php echo $button_save; ?></a>
     <a class="btn btn-danger" onclick="$('#dialogLink').modal('hide');" title="<?php echo $button_close; ?>">&times;</a>
     <?php } ?>
    </td>
   </tr>
  </tfoot>
 </table>
</form>
<script type="text/javascript"><!--
if (typeof option_row == 'undefined') {
	var option_row = [];
}

option_row[<?php echo $product_id; ?>] = <?php echo $option_row; ?>;

if (typeof option_value_row == 'undefined') {
	var option_value_row = [];
}

option_value_row[<?php echo $product_id; ?>] = <?php echo $option_value_row; ?>;

if (typeof addOptionValue != 'function') {
	function addOptionValue(product_id, row) {
		var html = '';
		
		html += '<tbody id="option-value-row-' + option_value_row[product_id] + '">';
		html += ' <tr>';
		html += '  <td class="center"><a onclick="$(this).parents(\'tbody:first\').remove();" class="btn btn-danger btn-xs" title="<?php echo $button_remove; ?>"><i class="fa fa-minus"></i></a></td>';
		html += '  <td class="left">';
		html += '   <select name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][option_value_id]">' + $('#option-values-' + row).html() + '</select>';
		html += '   <input type="hidden" name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][product_option_value_id]" value="" />';
		html += '  </td>';
		html += '  <td class="right"><input type="text" name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][quantity]" value="" size="10" /></td>';
		html += '  <td class="left">';
		html += '   <select name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][subtract]">';
		html += '    <option value="1"><?php echo $text_yes; ?></option>';
		html += '    <option value="0"><?php echo $text_no; ?></option>';
		html += '   </select>';
		html += '  </td>';
		html += '  <td class="right">';
		html += '   <select name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][price_prefix]">';
		<!--<?php foreach ($option_price_prefix as $price_prefix) { ?>-->
		html += '    <option value="<?php echo $price_prefix["value"]; ?>"><?php echo $price_prefix["name"]; ?></option>';
		<!--<?php } ?>-->
		html += '   </select>';
		html += '   <input type="text" name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][price]" value="" size="15" />';
		html += '  </td>';
		<!--<?php if ($base_price) { ?>-->
		html += '  <td class="left"><input type="text" name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][base_price]" value="" size="15" /></td>';
		<!--<?php } ?>-->
		html += '  <td class="right">';
		html += '   <select name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][points_prefix]">';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '   </select>';
		html += '   <input type="text" name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][points]" value="" size="10" />';
		html += '  </td>';
		html += '  <td class="right">';
		html += '   <select name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][weight_prefix]">';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '   </select>';
		html += '   <input type="text" name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][weight]" value="" size="15" />';
		html += '  </td>';
		
		<!--<?php if ($customer_group_id) { ?>-->
		html += '  <td class="right">';
		html += '   <select name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][customer_group_id]">';
		<!--<?php foreach ($customer_group_id as $array) { ?>-->
		html += '    <option value="<?php echo $array["customer_group_id"]; ?>"><?php echo $array["name"]; ?></option>';
		<!--<?php } ?>-->
		html += '   </select>';
		html += '  </td>';
		<!--<?php } ?>-->
		
		<!--<?php if ($optsku) { ?>-->
		html += '  <td class="right"><input type="text" name="option[' + row + '][product_option_value][' + option_value_row[product_id] + '][optsku]" value="" size="15" /></td>';
		<!--<?php } ?>-->
		
		html += ' </tr>';
		html += '</tbody>';
		
		$('#form-option' + product_id + ' #option-value-' + row + ' tfoot').before(html);
		
		option_value_row[product_id]++;
	}
}

$('#form-option<?php echo $product_id; ?> input[name=\'option_input\']').autocomplete({
	source: function(request, response) {
		xhr = $.ajax({dataType:'json', url:'index.php?route=catalog/option/autocomplete&token=' + token + '&filter_name=' + encodeURIComponent(request),
			success: function(json) {
				response($.map(json, function(item) { return { category:item['category'], label:item['name'], value:item['option_id'], type:item['type'], option_value:item['option_value'] }}));
			}
		});
	},
	'select': function(item) {
		var html = '';
		
		html += '<div id="tab-option-<?php echo $product_id; ?>-' + option_row[<?php echo $product_id; ?>] + '" class="tab-pane">';
		html += ' <input type="hidden" name="option[' + option_row[<?php echo $product_id; ?>] + '][product_option_id]" value="" />';
		html += ' <input type="hidden" name="option[' + option_row[<?php echo $product_id; ?>] + '][name]" value="' + item['label'] + '" />';
		html += ' <input type="hidden" name="option[' + option_row[<?php echo $product_id; ?>] + '][option_id]" value="' + item['value'] + '" />';
		html += ' <input type="hidden" name="option[' + option_row[<?php echo $product_id; ?>] + '][type]" value="' + item['type'] + '" />';
		html += ' <table class="be-form">';
		html += '  <tr>';
		html += '   <td><?php echo $text_required; ?></td>';
		html += '   <td>';
		html += '    <select name="option[' + option_row[<?php echo $product_id; ?>] + '][required]">';
		html += '     <option value="1"><?php echo $text_yes; ?></option>';
		html += '     <option value="0"><?php echo $text_no; ?></option>';
		html += '    </select>';
		html += '   </td>';
		html += '  </tr>';
		
		if (item['type'] == 'text') {
			html += '  <tr>';
			html += '   <td><?php echo $text_value; ?></td>';
			html += '   <td><input type="text" name="option[' + option_row[<?php echo $product_id; ?>] + '][option_value]" value="" /></td>';
			html += '  </tr>';
		}
		
		if (item['type'] == 'textarea') {
			html += '  <tr>';
			html += '   <td><?php echo $text_value; ?></td>';
			html += '   <td><textarea name="option[' + option_row[<?php echo $product_id; ?>] + '][option_value]" cols="40" rows="5"></textarea></td>';
			html += '  </tr>';
		}
		
		if (item['type'] == 'file') {
			html += ' <tr style="display: none;">';
			html += '  <td><?php echo $text_value; ?></td>';
			html += '  <td><input type="text" name="option[' + option_row[<?php echo $product_id; ?>] + '][option_value]" value="" /></td>';
			html += ' </tr>';
		}
		
		if (item['type'] == 'date') {
			html += ' <tr>';
			html += '  <td><?php echo $text_value; ?></td>';
			html += '  <td><input type="text" name="option[' + option_row[<?php echo $product_id; ?>] + '][option_value]" value="" class="date" /></td>';
			html += ' </tr>';
		}
		
		if (item['type'] == 'datetime') {
			html += '  <tr>';
			html += '   <td><?php echo $text_value; ?></td>';
			html += '   <td><input type="text" name="option[' + option_row[<?php echo $product_id; ?>] + '][option_value]" value="" class="datetime" /></td>';
			html += '  </tr>';
		}
		
		if (item['type'] == 'time') {
			html += '  <tr>';
			html += '   <td><?php echo $text_value; ?></td>';
			html += '   <td><input type="text" name="option[' + option_row[<?php echo $product_id; ?>] + '][option_value]" value="" class="time" /></td>';
			html += '  </tr>';
		}
		
		html += ' </table>';
		
		<?php if ($product_id > -1) { ?>
		if ($.inArray(item.type, ['<?php echo implode ("','", $option_type); ?>']) > -1) {
			html += ' <table class="be-list" id="option-value-' + option_row[<?php echo $product_id; ?>] + '">';
			html += '  <thead>'; 
			html += '   <tr>';
			html += '    <td class="center" width="1"></td>';
			html += '    <td class="left"><?php echo $text_value; ?></td>';
			html += '    <td class="right"><?php echo $text_quantity; ?></td>';
			html += '    <td class="left"><?php echo $text_subtract; ?></td>';
			html += '    <td class="right"><?php echo $text_price; ?></td>';
			<!--<?php if ($base_price) { ?>-->
			html += '    <td class="left"><?php echo $text_base_price; ?></td>';
			<!--<?php } ?>-->
			html += '    <td class="right"><?php echo $text_point; ?></td>';
			html += '    <td class="right"><?php echo $text_weight; ?></td>';
			<!--<?php if ($customer_group_id) { ?>-->
			html += '    <td class="right"><?php echo $text_customer_group; ?></td>';
			<!--<?php } ?>-->
			<!--<?php if ($optsku) { ?>-->
			html += '    <td class="right"><?php echo $text_optsku; ?></td>';
			<!--<?php } ?>-->
			html += '   </tr>';
			html += '  </thead>';
			html += '  <tfoot>';
			html += '   <tr>';
			html += '    <td class="left"><a onclick="addOptionValue(<?php echo $product_id; ?>, ' + option_row[<?php echo $product_id; ?>] + ');" class="btn btn-success btn-xs" title="<?php echo $button_insert; ?>"><i class="fa fa-plus"></i></a></td>';
			html += '    <td colspan="<?php echo $colspan; ?>"></td>';
			html += '   </tr>';
			html += '  </tfoot>';
			html += ' </table>';
			html += ' <select id="option-values-' + option_row[<?php echo $product_id; ?>] + '" style="display: none;">';
			
			for (i = 0; i < item['option_value'].length; i++) {
				html += '  <option value="' + item['option_value'][i]['option_value_id'] + '">' + item['option_value'][i]['name'] + '</option>';
			}
			
			html += ' </select>';
			html += '</div>';
		}
		<?php } ?>
		
		$('#form-option<?php echo $product_id; ?> .tab-content').append(html);
		
		$('#form-option<?php echo $product_id; ?> #option > li:last-child').before('<li><a href="#tab-option-<?php echo $product_id; ?>-' + option_row[<?php echo $product_id; ?>] + '" id="option-' + option_row[<?php echo $product_id; ?>] + '" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$(this).parents(\'li:first\').remove(); $(\'#form-option<?php echo $product_id; ?> #tab-option-<?php echo $product_id; ?>-' + option_row[<?php echo $product_id; ?>] + '\').remove(); $(\'#form-option<?php echo $product_id; ?> #option a:first\').tab(\'show\');"></i>&nbsp;' + item['label'] + '</a></li>');
		
		$('#form-option<?php echo $product_id; ?> #option a[href=\'#tab-option-<?php echo $product_id; ?>-' + option_row[<?php echo $product_id; ?>] + '\']').tab('show');
		
		creatDateTime();
		
		option_row[<?php echo $product_id; ?>]++;
		
		return false;
	}
});

$('#form-option<?php echo $product_id; ?> #option a:first').tab('show');

creatDateTime();
//--></script>

<?php if ($product_id == -1) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#dialog-<?php echo $link; ?>').find('.modal-header').append('<?php echo ${"text_" . $link}; ?>');
});
//--></script>
<?php } ?>

<?php if ($product_id > 0) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#dialogLink').find('.modal-header').append('<?php echo ${"text_" . $link}; ?>');
});
//--></script>
<?php } ?>

<?php if ($product_id > -1) { ?>
<script type="text/javascript"><!--
autocompleteProductCopyData('<?php echo $product_id; ?>');
//--></script>
<?php } ?>