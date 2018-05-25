<style type="text/css">
#table-search_replace<?php echo $product_id; ?> thead td {
	background-color:#EFEFEF;
}
</style>

<form id="form-search_replace<?php echo $product_id; ?>">
 <table class="be-list">
  <thead>
   <tr>
    <td class="left" width="1"></td>
    <td class="left"><?php echo $text_template; ?>:</td>
    <td class="left" width="15%"><?php echo $text_apply_to; ?>:</td>
    <td class="left" width="50"><?php echo $text_languages; ?>:</td>
   </tr>
  </thead>
  <tfoot>
   <tr>
    <td class="left" rowspan="3"></td>
    <td class="center" valign="top" rowspan="3">
     <div style="height:260px; overflow-y:scroll; margin:-5px;">
     <table class="be-list" id="table-search_replace<?php echo $product_id; ?>" style="margin:0px; border:none;">
      <thead>
       <tr>
        <td class="center"></td>
        <td class="left"><?php echo $text_what; ?>:</td>
        <td class="left" colspan="2"><?php echo $text_on_what; ?>:</td>
       </tr>
      </thead>
      <tfoot>
       <tr>
        <td class="center" width="1" height="23"><a class="btn btn-success btn-xs" onclick="addSearchReplaceRow(<?php echo $product_id; ?>);" title="<?php echo $text_add; ?>"><i class="fa fa-plus"></i></a></td>
        <td class="center" colspan="3"></td>
       </tr>
      </tfoot>
     </table>
     </div>
    </td>
   </tr>
   <tr>
    <td class="left">
     <b><?php echo $text_main; ?></b>
     <div class="be-scrollbox">
      <?php foreach ($apply_to['p'] as $field) { ?>
      <div><label><input name="search_replace[apply_to][p][]" type="checkbox" value="<?php echo $field; ?>" /> <?php echo ${'field_' . $field}; ?></label></div>
      <?php } ?>
     </div>
    </td>
    <td class="left" rowspan="2">
     <?php foreach ($languages as $language) { ?>
     <label>
      <?php if ($language['language_id'] == $language_id) { ?>
      <input name="search_replace[language_id]" type="radio" value="<?php echo $language['language_id']; ?>" checked="checked" />
      <?php } else { ?>
      <input name="search_replace[language_id]" type="radio" value="<?php echo $language['language_id']; ?>" />
      <?php } ?>
      <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" />
     </label><br />
     <?php } ?>
    </td>
   </tr>
   <tr>
    <td class="left">
     <b><?php echo $text_description; ?></b>
     <div class="be-scrollbox">
      <?php foreach ($apply_to['pd'] as $field) { ?>
      <div><label><input name="search_replace[apply_to][pd][]" type="checkbox" value="<?php echo $field; ?>" /> <?php echo ${'field_' . $field}; ?></label></div>
      <?php } ?>
     </div>
    </td>
   </tr>
   <tr>
    <td class="center" colspan="5"><a class="btn btn-success" onclick="editTool(<?php echo $product_id; ?>, 'search_replace', 'upd');"><?php echo $text_replace; ?></a></td>
   </tr>
   <tr>
    <td class="center"><a onclick="getTemplates('search_replace', <?php echo $product_id; ?>);" class="btn btn-success btn-sm" data-toggle="tooltip" title="<?php echo $text_load_template; ?>"><i class="fa fa-download"></i></a></td>
    <td colspan="5" class="left">
     <input name="template_name" type="text" size="64" value="" />
     <a onclick="saveTemplate('search_replace', <?php echo $product_id; ?>);" class="btn btn-success btn-sm" data-toggle="tooltip" title="<?php echo $text_save_template; ?>"><i class="fa fa-save"></i></a>
    </td>
   </tr>
  </tfoot>
 </table>
</form>
<script type="text/javascript"><!--
var search_replace_row = 0;

function addSearchReplaceRow(product_id) {
	var html = '';
	
	html += '<tbody>';
	html += ' <tr>';
	html += '  <td class="center" width="1"><a class="btn btn-danger btn-xs" onclick="$(this).parents(\'tbody:first\').remove();" title="<?php echo $text_delete; ?>"><i class="fa fa-minus"></i></a></td>';
	html += '  <td class="left" width="45%"><textarea name="search_replace[what][' + search_replace_row + ']" style="height:23px; width:98%;" ></textarea></td>';
	html += '  <td class="left" width="1">';
	html += '   <select name="search_replace[type][' + search_replace_row + ']" onchange="selectSearchReplace(this, ' + search_replace_row + ');" >';
	html += '    <option value="text"><?php echo $text_text; ?></option>';
	html += '    <option value="data"><?php echo $text_data; ?></option>';
	html += '   </select>';
	html += '  </td>';
	html += '  <td class="left"><textarea name="search_replace[on_what][' + search_replace_row + ']" style="height:23px; width:98%;" ></textarea></td>';
	html += ' </tr>';
	html += '</tbody>';
	html += '';
	
	$('#table-search_replace' + product_id).append(html);
	
	search_replace_row++;
}

function selectSearchReplace($this, $row) {
	var html = '';
	
	if ($($this).val() == 'text') {
		html = '<textarea name="search_replace[on_what][' + $row + ']" style="height:23px; width:98%;" ></textarea>';
	} else {
		html += '<select name="search_replace[on_what][' + $row + ']">';
		<!--<?php foreach ($fields as $field) { ?>-->
		html += ' <option value="<?php echo $field; ?>">{<?php echo ${"field_" . $field}; ?>}</option>';
		<!--<?php } ?>-->
		html += '</select>';
	}
	
	$($this).parent('td').next('td').html(html);
}
//--></script>