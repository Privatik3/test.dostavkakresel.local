<form id="form-layout<?php echo $product_id; ?>">
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
    <td class="left"><?php echo $text_store; ?></td>
    <td class="left"><?php echo $text_layout; ?></td>
   </tr>
  </thead>
  <tbody>
   <tr>
    <td class="left"><?php echo $text_default; ?></td>
    <td class="left">
     <select name="layout[0][layout_id]">
      <option value=""></option>
      <?php foreach($layouts as $layout) { ?>
      <?php if (isset ($data[0]) && $data[0] == $layout['layout_id']) { ?>
      <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
      <?php } ?>
      <?php } ?>
     </select>
    </td>
   </tr>
  </tbody>
  <?php foreach($stores as $store) { ?>
  <tbody>
   <tr>
    <td class="left"><?php echo $store['name']; ?></td>
    <td class="left">
     <select name="layout[<?php echo $store['store_id']; ?>][layout_id]">
      <option value=""></option>
      <?php foreach($layouts as $layout) { ?>
      <?php if (isset($data[$store['store_id']]) && $data[$store['store_id']] == $layout['layout_id']) { ?>
      <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
      <?php } ?>
      <?php } ?>
     </select>
    </td>
   </tr>
  </tbody>
  <?php } ?>
  <tfoot>
   <tr>
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