<?php $summernote = array (); ?>
<form id="form-description<?php echo $product_id; ?>">
 <?php if ($product_id > 0) { ?>
 <table class="be-form">
  <tr>
   <td width="1%"><img src="<?php echo $product_image; ?>" /></td>
   <td width="99%"><h3><?php echo $product_name; ?></h3></td>
  </tr>
 </table>
 <?php } ?>
 <ul class="nav nav-tabs">
  <?php foreach ($languages as $language) { ?>
  <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
</li>
  <?php } ?>
 </ul>
 <div class="tab-content">
  <?php foreach ($languages as $language) { ?>
  <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
   <table class="be-form">
    <?php foreach ($table as $field => $parameter) { ?>
    <tr>
     <td width="17%"><?php echo ${'text_' . $field}; ?>
      <?php if ($field == 'name') { ?>
      <span class="be-required">*</span>
      <?php } ?></td>
     <td width="83%"><?php $form_value = ''; ?>
      <?php if (isset ($data[$language['language_id']][$field])) { ?>
      <?php $form_value = $data[$language['language_id']][$field]; ?>
      <?php } ?>
      <?php if ($parameter['type'] == 'text') { ?>
      <?php if ($field == 'description') { ?>
      <textarea id="<?php echo $link; ?>_<?php echo $language['language_id']; ?>_<?php echo $field; ?>"><?php echo $form_value; ?></textarea>
      <textarea name="<?php echo $link; ?>[<?php echo $language['language_id']; ?>][<?php echo $field; ?>]" style="display:none;"><?php echo $form_value; ?></textarea>
      <?php $summernote[] = "description_" . $language['language_id'] . "_" . $field; ?>
      <?php } else { ?>
      <textarea name="<?php echo $link; ?>[<?php echo $language['language_id']; ?>][<?php echo $field; ?>]" style="width:98%; height:50px;"><?php echo $form_value; ?></textarea>
      <?php } ?>
      <?php } else { ?>
      <?php $size = 0; ?>
      <?php if (isset ($parameter['size'])) { ?>
      <?php $size = $parameter['size']; ?>
      <?php } ?>
      <?php if (isset ($parameter['size_1'])) { ?>
      <?php $size = ($parameter['size'] + $parameter['size_1'] + 1); ?>
      <?php } ?>
      <?php if ($size) { ?>
      <input type="text" name="description[<?php echo $language['language_id']; ?>][<?php echo $field; ?>]" maxlength="<?php echo $size; ?>" size="120" value="<?php echo $form_value; ?>" />
      <?php } else { ?>
      <input type="text" name="description[<?php echo $language['language_id']; ?>][<?php echo $field; ?>]" size="120" value="<?php echo $form_value; ?>" />
      <?php } ?>
      <?php } ?>
     </td>
    </tr>
    <?php } ?>
   </table>
  </div>
  <?php } ?>
 </div>
 <table class="be-list">
  <tfoot>
   <tr>
    <td class="center">
     <?php if ($product_id > -1) { ?>
     <input id="product-copy-data-product_name-<?php echo $product_id; ?>" type="text" />
     <input id="product-copy-data-product_id-<?php echo $product_id; ?>" type="hidden" />
     <a class="btn btn-primary btn-sm" onclick="copyProductData('<?php echo $product_id; ?>', '<?php echo $link; ?>');" title="<?php echo $button_copy; ?>" style="margin-right:50px;"><i class="fa fa-copy"></i></a>
     <?php } ?>
     <a class="btn btn-primary" onclick="listProductLink('<?php echo $product_id; ?>', '<?php echo $link; ?>', 'prev');" title="<?php echo $button_prev; ?>"><i class="fa fa-chevron-left"></i></a>
     <a class="btn btn-primary" onclick="listProductLink('<?php echo $product_id; ?>', '<?php echo $link; ?>', 'next');" title="<?php echo $button_next; ?>" style="margin-right:50px;"><i class="fa fa-chevron-right"></i></a>
     <a class="btn btn-success" onclick="summernoteToTextarea('<?php echo $product_id; ?>'); editLink('description', 'upd', '<?php echo $product_id; ?>');"><?php echo $button_save; ?></a>
     <a class="btn btn-danger" onclick="$('#dialogLink').modal('hide');" title="<?php echo $button_close; ?>">&times;</a></td>
   </tr>
  </tfoot>
 </table>
</form>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#form-description<?php echo $product_id; ?> .nav-tabs li:first').addClass('active');
	$('#form-description<?php echo $product_id; ?> .tab-pane:first').addClass('active');
	
	<!--<?php foreach ($summernote as $summernote_id) { ?>-->
	$('#form-description<?php echo $product_id; ?> #<?php echo $summernote_id; ?>').summernote({height:300, focus:true});
	<!--<?php } ?>-->
});

function summernoteToTextarea(product_id) {
	<!--<?php foreach ($summernote as $summernote_id) { ?>-->
	$('#form-description' + product_id + ' #<?php echo $summernote_id; ?>').parent().find('textarea').html($('#form-description' + product_id + ' #<?php echo $summernote_id; ?>').summernote('code'));
	<!--<?php } ?>-->
}
//--></script>

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