<form id="form-recurring<?php echo $product_id; ?>">
 <?php if ($product_id == -1) { ?>
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
 <table class="be-list">
  <thead>
   <tr>
    <td class="center" width="1"><i class="fa fa-minus"></i></td>
    <td class="left"><?php echo $text_recurring; ?></td>
    <td class="left"><?php echo $text_customer_group; ?></td>
   </tr>
  </thead>
  <?php $recurring_row = 0; ?>
  <?php if ($data) { ?>
  <?php foreach ($data as $value) { ?>
  <tbody>
   <tr>
    <td class="center"><a class="btn btn-danger btn-xs" onclick="removeTableRow(this);" title="<?php echo $button_remove; ?>"><i class="fa fa-minus"></i></a></td>
    <td class="left">
     <select name="recurring[<?php echo $recurring_row; ?>][recurring_id]">
      <?php foreach ($recurring_id as $recurring) { ?>
      <?php if ($recurring['recurring_id'] == $value['recurring_id']) { ?>
      <option value="<?php echo $recurring['recurring_id']; ?>" selected="selected"><?php echo $recurring['name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $recurring['recurring_id']; ?>"><?php echo $recurring['name']; ?></option>
      <?php } ?>
      <?php } ?>
     </select>
    </td>
    <td class="left">
     <select name="recurring[<?php echo $recurring_row; ?>][customer_group_id]">
      <?php foreach ($customer_groups as $customer_group) { ?>
      <?php if ($customer_group['customer_group_id'] == $value['customer_group_id']) { ?>
      <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
      <?php } ?>
      <?php } ?>
     </select>
    </td>
   </tr>
  </tbody>
  <?php $recurring_row++; ?>
  <?php } ?>
  <?php } else { ?>
  <tbody class="no_results">
   <tr>
    <td class="center" colspan="3"><div class="alert alert-warning" align="center"><?php echo $text_no_results; ?></div></td>
   </tr>
  </tbody>
  <?php } ?>
  <tfoot>
   <tr>
    <td class="center"><a class="btn btn-success btn-xs" onclick="addReccuringRow(<?php echo $product_id; ?>);" title="<?php echo $button_insert; ?>"><i class="fa fa-plus"></i></a></td>
    <td class="center" colspan="2">
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
  </tfoot>
 </table>
</form>
<script type="text/javascript"><!--
if (typeof recurring_row == 'undefined') {
	var recurring_row = [];
}

recurring_row[<?php echo $product_id; ?>] = <?php echo $recurring_row; ?>;

if (typeof addRecurringRow == 'undefined') {
	function addReccuringRow(product_id) {
		$('#form-recurring' + product_id + ' .be-list .no_results').remove();
		
		var html = '';
		
		html += '<tbody>';
		html += ' <tr>';
		html += '  <td class="center"><a class="btn btn-danger btn-xs" onclick="removeTableRow(this);" title="<?php echo $button_remove; ?>"><i class="fa fa-minus"></i></a></td>';
		html += '  <td class="left">';
		html += '   <select name="recurring[' + recurring_row[product_id] + '][recurring_id]">';
		<?php foreach ($recurring_id as $recurring) { ?>
		html += '    <option value="<?php echo $recurring["recurring_id"]; ?>"><?php echo $recurring["name"]; ?></option>';
		<?php } ?>
		html += '   </select>';
		html += '  </td>';
		html += '  <td class="left">';
		html += '   <select name="recurring[' + recurring_row[product_id] + '][customer_group_id]">';
		<?php foreach ($customer_groups as $customer_group) { ?>
		html += '    <option value="<?php echo $customer_group["customer_group_id"]; ?>"><?php echo $customer_group["name"]; ?></option>';
		<?php } ?>
		html += '   </select>';
		html += '  </td>';
		html += ' </tr>';
		html += '</tbody>';
		
		$('#form-recurring' + product_id + ' .be-list tfoot').before(html);
		
		recurring_row[product_id]++;
	}
}
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