<form id="form-attribute<?php echo $product_id; ?>">
 <?php if ($product_id == -1) { ?>
 <div class="alert alert-info text-center"><?php echo $notice_empty_field; ?></div>
 <p></p>
 <span class="be-help"><label><input name="none[<?php echo $link; ?>]" type="checkbox" /> <?php echo $text_not_contain; ?> > <?php echo ${'text_' . $link}; ?></label></span> <br />
 <span class="be-help"><label><input name="has[<?php echo $link; ?>]" type="checkbox" value="1" /> <?php echo $text_strictly_selected; ?></label></span>
 <span class="be-help"><label><input name="count[<?php echo $link; ?>]" type="checkbox" value="1" /> <?php echo $text_with_regard_number; ?></label></span>
 <p></p>
 <?php } ?>
 <?php if ($product_id > 0) { ?>
 <table class="be-form">
  <tr>
   <td width="1%"><img src="<?php echo $product_image; ?>" /></td>
   <td width="99%"><h3><?php echo $product_name; ?></h3></td>
  </tr>
 </table>
 <?php } ?>
 
 <div class="be-scrollhead">
  <table class="be-list">
   <col width="50" /><col width="20%" /><col width="20%" /><col />
   <thead>
    <tr>
     <td class="center"></td>
     <td class="left"><?php echo $text_group; ?></td>
     <td class="left"><?php echo $text_name; ?></td>
     <td class="left"><?php echo $text_value; ?></td>
    </tr>
   </thead>
  </table>
 </div>
 
 <div class="be-scrollcontent">
  <table class="be-list" id="table-attribute<?php echo $product_id; ?>">
   <col width="50" /><col width="20%" /><col width="20%" /><col />
   <?php $attribute_row = 0; ?>
   <?php if ($data) { ?>
   <?php foreach ($data as $attribute) { ?>
  <tbody>
   <tr>
    <td class="center"><a onclick="removeTableRow(this);" class="btn btn-danger btn-xs" title="<?php echo $button_remove; ?>"><i class="fa fa-minus"></i></a></td>
    <td class="left">
     <select name="attribute_group[<?php echo $attribute_row; ?>]" onchange="loadAttribute(<?php echo $product_id; ?>, <?php echo $attribute_row; ?>);">
      <option value="0"><?php echo $text_none; ?></option>
      <?php foreach ($attributes as $attribute_1) { ?>
      <?php if (isset ($attribute_1['attributes'][$attribute['attribute_id']])) { ?>
      <option value="<?php echo $attribute_1['attribute_group_id']; ?>" selected="selected"><?php echo $attribute_1['attribute_group_name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $attribute_1['attribute_group_id']; ?>"><?php echo $attribute_1['attribute_group_name']; ?></option>
      <?php } ?>
      <?php } ?>
     </select>
    </td>
    <td class="left attribute_box<?php echo $attribute_row; ?>">
     <input type="hidden" name="attribute[<?php echo $attribute_row; ?>][attribute_id]" value="<?php echo $attribute['attribute_id']; ?>" />
     <input type="text" name="attribute[<?php echo $attribute_row; ?>][name]" value="<?php echo $attribute['name']; ?>" />
    </td>
    <td class="left">
     <?php foreach ($languages as $language) { ?>
     <?php $value = ''; ?>
     <?php if (isset ($attribute['attribute_description'][$language['language_id']])) { ?>
     <?php $value = $attribute['attribute_description'][$language['language_id']]['text']; ?>
     <?php } ?>
     <a class="btn btn-primary btn-xs value" data-language_id="<?php echo $language['language_id']; ?>"><i class="fa fa-download"></i></a>&nbsp;
     <input name="attribute[<?php echo $attribute_row; ?>][attribute_description][<?php echo $language['language_id']; ?>][text]" value="<?php echo $value; ?>" />
     <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> &nbsp;&nbsp;&nbsp;
     <?php } ?>
    </td>
   </tr>
  </tbody>
  <?php $attribute_row++; ?>
  <?php } ?>
  <?php } else { ?>
  <tbody class="no_results">
   <tr>
    <td class="center" colspan="4"><div class="alert alert-warning" align="center"><?php echo $text_no_results; ?></div></td>
   </tr>
  </tbody>
  <?php } ?>
  </table>
 </div>
 
 <div class="be-scrollfoot">
  <table class="be-list">
   <col width="50" /><col />
  <tfoot>
   <tr>
    <td class="center"><a onclick="addAttribute(<?php echo $product_id; ?>)" class="btn btn-success btn-xs" title="<?php echo $button_insert; ?>"><i class="fa fa-plus"></i></a></td>
    <td class="center" colspan="3">
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
     <a class="btn btn-primary" onclick="editLink('<?php echo $link; ?>', 'add', <?php echo $product_id; ?>);"><?php echo $button_insert_sel; ?></a>
     <a class="btn btn-primary" onclick="editLink('<?php echo $link; ?>', 'del', <?php echo $product_id; ?>);"><?php echo $button_delete_sel; ?></a>
     <a class="btn btn-primary" onclick="editLink('<?php echo $link; ?>', 'upd', <?php echo $product_id; ?>);"><?php echo $text_edit; ?></a>
     <?php } ?>
     <?php if ($product_id > 0) { ?>
     <a class="btn btn-primary" onclick="listProductLink('<?php echo $product_id; ?>', '<?php echo $link; ?>', 'prev');" title="<?php echo $button_prev; ?>"><i class="fa fa-chevron-left"></i></a>
     <a class="btn btn-primary" onclick="listProductLink('<?php echo $product_id; ?>', '<?php echo $link; ?>', 'next');" title="<?php echo $button_next; ?>" style="margin-right:50px;"><i class="fa fa-chevron-right"></i></a>
     <a class="btn btn-success" onclick="editLink('<?php echo $link; ?>', 'upd', <?php echo $product_id; ?>);"><?php echo $button_save; ?></a>
     <a class="btn btn-danger" onclick="$('#dialogLink').modal('hide');" title="<?php echo $button_close; ?>">&times;</a>
     <?php } ?>
    </td>
   </tr>
   <tr>
    <td class="center"><a onclick="getTemplates('attribute', <?php echo $product_id; ?>);" class="btn btn-success btn-sm" data-toggle="tooltip" title="<?php echo $text_load_template; ?>"><i class="fa fa-download"></i></a></td>
    <td colspan="3" class="left">
     <input name="template_name" type="text" size="64" value="" />
     <a onclick="saveTemplate('attribute', <?php echo $product_id; ?>);" class="btn btn-success btn-sm" data-toggle="tooltip" title="<?php echo $text_save_template; ?>"><i class="fa fa-save"></i></a></td>
   </tr>
  </tfoot>
 </table>
 </div>
</form>
<script type="text/javascript"><!--
if (typeof attribute_row == 'undefined') {
	var attribute_row = [];
}

attribute_row[<?php echo $product_id; ?>] = <?php echo $attribute_row; ?>;

if (typeof attributeAutocomplete != 'function') {
	function attributeAutocomplete(product_id, row) {
		var input = $('#form-attribute' + product_id + ' #table-attribute' + product_id + ' input[name=\'attribute[' + row + '][name]\']');
		var input_id = $('#form-attribute' + product_id + ' #table-attribute' + product_id + ' input[name=\'attribute[' + row + '][attribute_id]\']');
		
		input.autocomplete({
			source: function(request, response) {
				xhr = $.ajax({dataType:'json', url:'index.php?route=catalog/attribute/autocomplete&token=' + token + '&filter_name=' + encodeURIComponent(request),
					success: function(json) {
						response($.map(json, function(item) { return { category:item['attribute_group'], label:item['name'], value:item['attribute_id'] }}));
					}
				});
			}, 
			'select': function(item) {
				input.val(item['label']);
				input_id.val(item['value']);
			}
		});
	}
}

if (typeof addAttribute != 'function') {
	function addAttribute(product_id) {
		var html = '';
		
		html += '<tbody>';
		html += ' <tr>';
		html += '  <td class="center"><a onclick="removeTableRow(this);" class="btn btn-danger btn-xs" title="<?php echo $button_remove; ?>"><i class="fa fa-minus"></i></a></td>';
		html += '  <td class="left">';
		html += '   <select name="attribute_group[' + attribute_row[product_id] + ']" onchange="loadAttribute(' + product_id + ', ' + attribute_row[product_id] + ');">';
		html += '    <option value="0"><?php echo $text_none; ?></option>';
		<?php foreach ($attributes as $attribute) { ?>
		html += '    <option value="<?php echo $attribute["attribute_group_id"]; ?>"><?php echo $attribute["attribute_group_name"]; ?></option>';
		<?php } ?>
		html += '   </select>';
		html += '  </td>';
		html += '  <td class="left attribute_box' + attribute_row[product_id] + '">';
		html += '   <input type="text" name="attribute[' + attribute_row[product_id] + '][name]" value="" />';
		html += '   <input type="hidden" name="attribute[' + attribute_row[product_id] + '][attribute_id]" value="" />';
		html += '  </td>';
		html += '  <td class="left">';
		<?php foreach ($languages as $language) { ?>
		html += '   <a class="btn btn-primary btn-xs value" data-language_id="<?php echo $language["language_id"]; ?>"><i class="fa fa-download"></i></a>&nbsp; ';
		html += '   <input name="attribute[' + attribute_row[product_id] + '][attribute_description][<?php echo $language["language_id"]; ?>][text]" /> ';
		html += '   <img src="language/<?php echo $language["code"]; ?>/<?php echo $language["code"]; ?>.png" title="<?php echo $language["name"]; ?>" /> &nbsp;&nbsp;&nbsp; ';
		<?php } ?>
		html += '  </td>';
		html += ' </tr>';
		html += '</tbody>';
		
		$('#form-attribute' + product_id + ' #table-attribute' + product_id + ' tbody.no_results').remove();
		$('#form-attribute' + product_id + ' #table-attribute' + product_id + '').append(html).parent('.be-scrollcontent').scrollTop(99999);
		
		attributeAutocomplete(product_id, attribute_row[product_id]);
		
		attribute_row[product_id]++;
	}
}

if (typeof loadAttribute != 'function') {
	function loadAttribute(product_id, row) {
		var data = 'row=' + row + '&attribute_group_id=' + $('#form-attribute' + product_id + ' #table-attribute' + product_id + ' select[name=\'attribute_group[' + row + ']\']').val();
		
		xhr = $.ajax({type:'GET', dataType:'html', data:data, url: 'index.php?route=batch_editor/data/loadAttribute&token=' + token,
			beforeSend: function() {
				$('#form-attribute' + product_id + ' #table-attribute' + product_id + ' td.attribute_box' + row).html('<i class="fa fa-spinner fa-spin"></i>');
			},
			success: function(html) {
				$('#form-attribute' + product_id + ' #table-attribute' + product_id + ' td.attribute_box' + row).html(html);
			}
		});
	}
}

$('#form-attribute<?php echo $product_id; ?> #table-attribute<?php echo $product_id; ?> tbody').each(function (row, element) {
	attributeAutocomplete(<?php echo $product_id; ?>, row);
});

$(document).ready(function(e) {
	$('#form-attribute<?php echo $product_id; ?> #table-attribute<?php echo $product_id; ?>').delegate('.value', 'click', function() {
		var html = '';
		var replacement = $(this).next();
		var current_value = replacement.val();
		
		if (replacement.is('input')) {
			var attribute_id = $(this).parent().prev().find('[name*=\'[attribute_id]\']').val();
			var language_id = $(this).attr('data-language_id');
			
			xhr = $.ajax({type:'POST', dataType:'json', data:'attribute_id=' + attribute_id + '&language_id=' + language_id, url:'index.php?route=batch_editor/data/getAttributeValue&token=' + token,
				beforeSend: function() {},
				success: function(json) {
					if (json.length) {
						html += '<select name="' + replacement.attr('name') + '" style="width:' + replacement.outerWidth() + 'px">';
						
						$.each(json, function(index, value) {
							if (value['text'] == current_value) {
								html += '<option value="' + value['text'] + '" selected="selected">' + value['text'] + '</option>';
							} else {
								html += '<option value="' + value['text'] + '">' + value['text'] + '</option>';
							}
						});
						
						html += '</select>';
					} else {
						html += '<input name="' + replacement.attr('name') + '" />';
					}
					
					replacement.replaceWith(html);
				}
			});
		} else {
			replacement.replaceWith('<input name="' + replacement.attr('name') + '" value="' + current_value + '" />');
		}
	});
});
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