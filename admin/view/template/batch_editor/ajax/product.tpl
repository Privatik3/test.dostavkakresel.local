<?php if ($products) { ?>
<div class="pagination">
 <div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
 </div>
</div>
<table id="product" class="be-list">
 <thead>
  <tr class="sort">
   <td class="center" width="1">
    <input type="checkbox" onclick="selectRowAll(this);" />
    <input type="button" onclick="selectRowInv();" style="width:16px; height:16px; background:#666; cursor:pointer;" />
   </td>
   <td class="center" width="1"><a href="p.product_id" class="<?php echo ($sort == 'p.product_id') ? strtolower($order) : ''; ?>">ID</a></td>
   <?php foreach ($setting as $field => $parameter) { ?>
   <?php $class = ($parameter['table'] == 'pd' || $parameter['table'] == 'pt') ? 'language_' . $language_id : ''; ?>
   <?php if ($field == 'image') { ?>
   <td class="center <?php echo $class; ?>">
    <input name="<?php echo $field; ?>-visible" type="hidden" value="1" />
    <a href="<?php echo ${'sort_' . $field}; ?>" class="<?php echo ($sort == ${'sort_' . $field}) ? strtolower($order) : ''; ?>" title="<?php echo ${'text_' . $field}; ?>"><i class="fa fa-image fa-2x"></i></a>
   </td>
   <?php } else { ?>
   <td class="left <?php echo $class; ?>"><input name="<?php echo $field; ?>-visible" type="hidden" value="1" />
    <?php if (isset (${'sort_' . $field})) { ?>
    <a href="<?php echo ${'sort_' . $field}; ?>" class="<?php echo ($sort == ${'sort_' . $field}) ? strtolower($order) : ''; ?>"><?php echo ${'text_' . $field}; ?></a>
    <?php } else { ?>
    <?php echo ${'text_' . $field}; ?>
    <?php } ?>
   </td>
   <?php if ($field == 'name') { ?>
   <?php if ($option['column_categories']) { ?>
   <td class="left"><?php echo $text_category; ?></td>
   <?php } ?>
   <?php if ($option['column_attributes']) { ?>
   <td class="left"><?php echo $text_attribute; ?></td>
   <?php } ?>
   <?php if ($option['column_options']) { ?>
   <td class="left"><?php echo $text_option; ?></td>
   <?php } ?>
   <?php } ?>
   <?php } ?>
   <?php } ?>
  </tr>
  <?php if ($option['quick_filter']) { ?>
  <tr class="filter">
   <td class="center"><a onclick="resetQuickFilter();" class="btn btn-danger btn-xs" data-toggle="tooltip" title="<?php echo $button_reset; ?>"><i class="fa fa-repeat"></i></a></td>
   <td class="center">
    <?php $value = (isset ($post['product']['product_id']['value'])) ? $post['product']['product_id']['value'] : ''; ?>
    <input name="table[product][product_id][value]" type="text" value="<?php echo $value; ?>" />
   </td>
   <?php foreach ($setting as $field => $parameter) { ?>
   <td class="center"><?php if (isset ($list[$field])) { ?>
    <?php $value = (isset ($post['product'][$field]['value'][-1])) ? (int) $post['product'][$field]['value'][-1] : '*'; ?>
    <select name="table[product][<?php echo $field; ?>][value][-1]">
     <option value="*"></option>
     <?php foreach ($list[$field] as $data) { ?>
     <?php if (is_integer ($value) && $value == $data[$field]) { ?>
     <option value="<?php echo $data[$field]; ?>" selected="selected"><?php echo $data['name']; ?></option>
     <?php } else { ?>
     <option value="<?php echo $data[$field]; ?>"><?php echo $data['name']; ?></option>
     <?php } ?>
     <?php } ?>
    </select>
    <?php } else if ($parameter['type'] == 'tinyint') { ?>
    <?php $value = (isset ($post['product'][$field]['value'])) ? $post['product'][$field]['value'] : '*'; ?>
    <select name="table[product][<?php echo $field; ?>][value]">
     <?php if (preg_match ('/status/', $field)) { ?>
     <?php $text_1 = $text_enabled; ?>
     <?php $text_0 = $text_disabled; ?>
     <?php } else { ?>
     <?php $text_1 = $text_yes; ?>
     <?php $text_0 = $text_no; ?>
     <?php } ?>
     <?php if ($value == '*') { ?>
     <option value="*" selected="selected"></option>
     <option value="1"><?php echo $text_1; ?></option>
     <option value="0"><?php echo $text_0; ?></option>
     <?php } else if ($value) { ?>
     <option value="*"></option>
     <option value="1" selected="selected"><?php echo $text_1; ?></option>
     <option value="0"><?php echo $text_0; ?></option>
     <?php } else { ?>
     <option value="*"></option>
     <option value="1"><?php echo $text_1; ?></option>
     <option value="0" selected="selected"><?php echo $text_0; ?></option>
     <?php } ?>
    </select>
    <?php } else { ?>
    <?php $class = ($parameter['type'] == 'date' || $parameter['type'] == 'datetime') ? $parameter['type'] : ''; ?>
    <?php if ($parameter['table'] == 'p') { ?>
    <?php $value = (isset ($post['product'][$field]['value'])) ? $post['product'][$field]['value'] : ''; ?>
    <input name="table[product][<?php echo $field; ?>][value]" type="text" class="<?php echo $class; ?>" value="<?php echo $value; ?>" />
    <?php } else { ?>
    <?php $value = (isset ($post['product_description'][$field]['value'])) ? $post['product_description'][$field]['value'] : ''; ?>
    <input name="table[product_description][<?php echo $field; ?>][value]" type="text" class="<?php echo $class; ?>" value="<?php echo $value; ?>" />
    <?php } ?>
    <?php } ?>
   </td>
   <?php if ($field == 'name') { ?>
   <?php if ($option['column_categories']) { ?>
   <td class="center">
    <?php $name = (isset ($category[-1]['name'])) ? $category[-1]['name'] : ''; ?>
    <?php $value = (isset ($category[-1]['category_id'])) ? $category[-1]['category_id'] : ''; ?>
    <?php if ($option['category']) { ?>
    <input name="category[-1][name]" value="<?php echo $name; ?>" type="text" />
    <input name="category[-1][category_id]" value="<?php echo $value; ?>" type="hidden" />
    <?php } else { ?>
    <select name="category[-1][category_id]">
     <option value="*"></option>
     <?php foreach ($categories as $category) { ?>
     <?php if ($value == $category['category_id']) { ?>
     <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
     <?php } else { ?>
     <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
     <?php } ?>
     <?php } ?>
    </select>
    <?php } ?>
   </td>
   <?php } ?>
   <?php if ($option['column_attributes']) { ?>
   <td class="center">
    <?php $name = (isset ($attribute[-1]['name'])) ? $attribute[-1]['name'] : ''; ?>
    <?php $value = (isset ($attribute[-1]['attribute_id'])) ? $attribute[-1]['attribute_id'] : ''; ?>
    <input name="attribute[-1][name]" value="<?php echo $name; ?>" type="text" />
    <input name="attribute[-1][attribute_id]" value="<?php echo $value; ?>" type="hidden" />
   </td>
   <?php } ?>
   <?php if ($option['column_options']) { ?>
   <td class="center">
    <?php $name = (isset ($option[-1]['name'])) ? $option[-1]['name'] : ''; ?>
    <?php $value = (isset ($option[-1]['option_id'])) ? $option[-1]['option_id'] : ''; ?>
    <input name="option[-1][name]" value="<?php echo $name; ?>" type="text" />
    <input name="option[-1][option_id]" value="<?php echo $value; ?>" type="hidden" />
   </td>
   <?php } ?>
   <?php } ?>
   <?php } ?>
  </tr>
  <?php } ?>
 </thead>
 <?php foreach ($products as $product) { ?>
 <tbody>
  <?php $class = ($product['selected']) ? 'selected' : ''; ?>
  <tr class="selected_row-<?php echo $product['product_id']; ?> <?php echo $class; ?>">
   <td class="center"><?php if ($product['selected']) { ?>
    <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" />
    <?php } ?></td>
   <td class="left" width="1"><b><?php echo $product['product_id']; ?></b></td>
   <?php foreach ($setting as $field => $parameter) { ?>
   <?php if ($field == 'image') { ?>
   <td class="center" width="1">
    <div class="image">
     <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $text_edit; ?>" title="<?php echo $text_edit; ?>" height="<?php echo $option['image']['height']; ?>" width="<?php echo $option['image']['width']; ?>" />
     <input data-table="product" data-field="image" data-product_id="<?php echo $product['product_id']; ?>" type="hidden" value="<?php echo $product['image']; ?>" />
     <a class="btn btn-success btn-xs" onclick="getImageManager(this)" title="<?php echo $text_path; ?>"><i class="fa fa-upload"></i></a>&nbsp;<a class="btn btn-danger btn-xs" title="<?php echo $button_remove; ?>" onclick="if (!confirm('<?php echo $button_remove; ?>?')) { return false; } $(this).parent().find('img, input').prop({'src':no_image, 'value':''}).trigger('change');"><i class="fa fa-trash-o"></i></a>
    </div>
   </td>
   <?php } else if ($field == 'name') { ?>
   <td class="left product_name"><span class="input-name-<?php echo $product['product_id']; ?>"><?php echo $product['name']; ?></span><br />
    <div>
     <?php foreach($link as $_link => $value) { ?>
     <?php if (isset ($value['enable']['product'])) { ?>
     <a onclick="getLink(<?php echo $product['product_id']; ?>, '<?php echo $_link; ?>')"><?php echo ${'text_' . $_link}; ?></a><em class="<?php echo $_link; ?>_count_<?php echo $product['product_id']; ?>"></em>&nbsp;&nbsp;
     <?php } ?>
     <?php } ?>
    </div>
    <div class="em_div">
     <a class="btn btn-primary btn-xs" onclick="relatedToProduct(<?php echo $product['product_id']; ?>)" title="<?php echo $text_related_to_product; ?>" data-toggle="tooltip"><i class="fa fa-exchange"></i></a>
     <a class="btn btn-primary btn-xs" onclick="getTool(<?php echo $product['product_id']; ?>, 'image_manager');" title="<?php echo $text_image_manager; ?>" data-toggle="tooltip"><i class="fa fa-file"></i></a>
     <a class="btn btn-primary btn-xs" onclick="getTool(<?php echo $product['product_id']; ?>, 'image_google');" title="<?php echo $text_image_google; ?>" data-toggle="tooltip"><i class="fa fa-google"></i></a>
     <a class="btn btn-primary btn-xs" onclick="getTool(<?php echo $product['product_id']; ?>, 'image_bing');" title="<?php echo $text_image_bing; ?>" data-toggle="tooltip"><i class="fa fa-windows"></i></a>
     <a class="btn btn-primary btn-xs" href="index.php?route=catalog/product/edit&token=<?php echo $token; ?>&product_id=<?php echo $product['product_id']; ?>" target="_blank" title="<?php echo $text_edit; ?>" data-toggle="tooltip"><i class="fa fa-edit"></i></a>
     <a class="btn btn-primary btn-xs" href="<?php echo $product['product-url']; ?>" target="_blank" title="<?php echo $text_view; ?>" data-toggle="tooltip"><i class="fa fa-link"></i></a>
     <em class="date_added_<?php echo $product['product_id']; ?>"><?php echo $product['date_added']; ?></em><em class="date_modified_<?php echo $product['product_id']; ?>"><?php echo $product['date_modified']; ?></em>
    </div>
   </td>
   <?php if ($option['column_categories']) { ?>
   <td class="left column-product_to_category-<?php echo $product['product_id']; ?>"><div>
    </div></td>
   <?php } ?>
   <?php if ($option['column_attributes']) { ?>
   <td class="left column-product_attribute-<?php echo $product['product_id']; ?>"><div>
    </div></td>
   <?php } ?>
   <?php if ($option['column_options']) { ?>
   <td class="left column-product_option-<?php echo $product['product_id']; ?>"><div>
    </div></td>
   <?php } ?>
   <?php } else { ?>
   <?php $class = (!$product[$field]) ? 'attention' : ''; ?>
   <?php if (isset ($parameter['list'])) { ?>
   <?php $type = 'select'; ?>
   <?php } else { ?>
   <?php $type = 'input'; ?>
   <?php if ($field == 'quantity') { ?>
   <?php $class = (0 < $product['quantity']) ? 'quantity' : 'quantity_0'; ?>
   <?php } ?>
   <?php } ?>
   <?php if ($parameter['type'] == 'tinyint') { ?>
   <?php $type = 'select'; ?>
   <?php if ($field == 'status') { ?>
   <?php $class = ($product['status']) ? 'enabled' : 'disabled'; ?>
   <?php $product['status'] = ($product['status']) ? $text_enabled : $text_disabled; ?>
   <?php } else { ?>
   <?php $product[$field] = ($product[$field]) ? $text_yes : $text_no; ?>
   <?php } ?>
   <?php } ?>
   <td class="left <?php echo $class; ?> td_<?php echo $field; ?><?php echo $product['product_id']; ?>"><span class="<?php echo $type; ?>-<?php echo $field; ?>-<?php echo $product['product_id']; ?>"><?php echo $product[$field]; ?></span>
    <?php if ($field == 'price') { ?>
    <em class="em-product_special-<?php echo $product['product_id']; ?>"></em>
    <em class="em-product_discount-<?php echo $product['product_id']; ?>"></em>
    <?php } ?></td>
   <?php } ?>
   <?php } ?>
  </tr>
 </tbody>
 <?php } ?>
</table>
<div class="pagination">
 <div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
 </div>
</div>
<?php } else { ?>
<div class="alert alert-warning" align="center"><?php echo $text_no_results; ?></div>
<div align="center"><a class="btn btn-danger" onclick="getProduct('');"><?php echo $button_reset; ?></a></div>
<?php } ?>

<?php if ($option['quick_filter']) { ?>
<script type="text/javascript"><!--
$('#product .filter').bind('keypress', function(e) {
	if (e.keyCode == 13) { setFilter(1); }
});

$('#product .filter select').bind('change', function(e) {
	setFilter(1);
});

creatDateTime();
//--></script>

<?php if ($option['column_categories']) { ?>
<?php if ($option['category']) { ?>
<script type="text/javascript"><!--
$('#product .filter input[name=\'category[-1][name]\']').autocomplete({
	source: function(request, response) {
		xhr = $.ajax({dataType:'json', url:'index.php?route=batch_editor/data/autocomplete&token=' + token + '&autocomplete=category_id&keyword=' + encodeURIComponent(request),
			success: function(json) {
				response($.map(json, function(item) {
					return { label:item['name'], value:item['category_id'] }
				}));
			}
		});
	},
	'select': function(item) {
		var category = item['label'].split(' > ');
		
		$('#product .filter input[name=\'category[-1][name]\']').val(category[category.length - 1]);
		$('#product .filter input[name=\'category[-1][category_id]\']').val(item['value']);
		
		setFilter(1);
		getProduct('');
		
		return false;
	}
});

$('#product .filter input[name=\'category[-1][name]\']').bind('keypress', function(e) {
	if (e.keyCode == 13 && $(this).val() == '') { $('#product .filter input[name=\'category[-1][category_id]\']').val(''); }
});
//--></script>
<?php } ?>
<?php } ?>

<?php if ($option['column_attributes']) { ?>
<script type="text/javascript"><!--
$('#product .filter input[name=\'attribute[-1][name]\']').autocomplete({
	source: function(request, response) {
		xhr = $.ajax({dataType:'json', url:'index.php?route=catalog/attribute/autocomplete&token=' + token + '&filter_name=' + encodeURIComponent(request),
			success: function(json) {
				response($.map(json, function(item) {
					return {category:item['attribute_group'], label:item['name'], value:item['attribute_id'] }
				}));
			}
		});
	},
	'select': function(item) {
		$('#product .filter input[name=\'attribute[-1][name]\']').val(item['label']);
		$('#product .filter input[name=\'attribute[-1][attribute_id]\']').val(item['value']);
		
		setFilter(1);
		getProduct('');
		
		return false;
	}
});

$('#product .filter input[name=\'category[-1][name]\']').bind('keypress', function(e) {
	if (e.keyCode == 13 && $(this).val() == '') { $('#product .filter input[name=\'category[-1][category_id]\']').val(''); }
});
//--></script>
<?php } ?>

<?php if ($option['column_options']) { ?>
<script type="text/javascript"><!--
$('#product .filter input[name=\'option[-1][name]\']').autocomplete({
	source: function(request, response) {
		xhr = $.ajax({dataType:'json', url:'index.php?route=catalog/option/autocomplete&token=' + token + '&filter_name=' + encodeURIComponent(request),
			success: function(json) {
				response($.map(json, function(item) {
					return {category:item['category'], label:item['name'], value:item['option_id'] }
				}));
			}
		});
	},
	'select': function(item) {
		$('#product .filter input[name=\'option[-1][name]\']').val(item['label']);
		$('#product .filter input[name=\'option[-1][option_id]\']').val(item['value']);
		
		setFilter(1);
		getProduct('');
		
		return false;
	}
});

$('#product .filter input[name=\'category[-1][name]\']').bind('keypress', function(e) {
	if (e.keyCode == 13 && $(this).val() == '') { $('#product .filter input[name=\'category[-1][category_id]\']').val(''); }
});
//--></script>
<?php } ?>

<?php foreach ($setting as $field => $parameter) { ?>
<?php if ($parameter['type'] == 'char' || $parameter['type'] == 'varchar' || $parameter['type'] == 'text') { ?>
<?php if ($parameter['table'] == 'p') { ?>
<?php $table = 'product'; ?>
<?php } else { ?>
<?php $table = 'product_description'; ?>
<?php } ?>
<script type="text/javascript"><!--
$('#product .filter input[name=\'table[<?php echo $table; ?>][<?php echo $field; ?>][value]\']').autocomplete({
	'source': function(request, response) {
		xhr = $.ajax({dataType:'json', url:'index.php?route=batch_editor/data/autocompleteByTableField&token=' + token + '&table=<?php echo $table; ?>&field=<?php echo $field; ?>&language_id=' + $('input[name=\'filter_language_id\']:checked').val() + '&keyword=' + encodeURIComponent(request),
			success: function(json) {
				response($.map(json, function(item) {
					return { label:item['value'], value:item['key'] }
				}));
			}
		});
	},
	'select': function(item) {
		$('#product .filter input[name=\'table[<?php echo $table; ?>][<?php echo $field; ?>][value]\']').val(item['label']);
		setFilter(1);
		
		return false;
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--

$('#product tbody tr td:nth-child(1) :checkbox').click(function(e) {
	var lastRow = $('#product').data('lastRow');
	var thisRow = $(this).parents('tbody:first').index();
	
	if (lastRow !== undefined && e.shiftKey) {
		var start = (lastRow < thisRow) ? lastRow : thisRow;
		var end = (lastRow > thisRow) ? lastRow : thisRow;
		
		$('#product').find('tbody tr td:nth-child(1) :checkbox').slice(start, end).prop('checked', true).trigger('change');
	}
	
	$('#product').data('lastRow', thisRow);
});
//--></script>