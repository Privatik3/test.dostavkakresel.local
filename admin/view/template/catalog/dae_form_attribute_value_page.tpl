<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">        
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $dae_lang_heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid dae_attribute_value_page">
    <div class="alert alert-danger hidden" ><i class="fa fa-exclamation-circle"></i> <span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    
    <div class="alert alert-success hidden"><i class="fa fa-check-circle"></i> <span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>

    <div class="alert alert-info hidden"><i class="fa fa-check-circle"></i> <span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $dae_form_attribute_value_title; ?> "<?php echo $attribute['name'];?>"</h3>
      </div>
      <div class="panel-body" >
        <form class="form-horizontal" id="form-generic-attribute-value">
        <input type="hidden" name="attribute_id" value="<?php echo $attribute_id;?>">
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $dae_form_a_v_field_list;?></label>
            <div class="col-sm-5">
              <input type="text" class="form-control" name="list_attribute_values" placeholder="<?php echo $dae_form_a_v_field_list_place;?>">
            </div>
            <label class="col-sm-2 control-label"><?php echo $dae_form_a_v_field_split;?></label>
            <div class="col-sm-1">
              <input type="text" class="form-control" name="split" value="#">
            </div>
            <div class="col-sm-2 text-right">
              <button type="button" class="btn btn-primary dae-generic-attribute-value" data-toggle="tooltip" title="<?php echo $dae_form_a_v_generic;?>"><i class="fa fa-plus"></i></button>
              <button type="button" class="btn btn-danger dae-remove-attribute-values" data-toggle="tooltip" title="<?php echo $dae_form_a_v_remove_all;?>"><i class="fa fa-minus"></i></button>
              
            </div>
          </div>
        </form>              
              <table id="attribute-value" class="table table-hover">
                <thead>
                    <tr>
                      <td style="width:10px;">#</td>
                      <td style="width:20px;"><?php echo $dae_lang_default;?></td>
                      <td class="text-left" style="width:40px;"><?php echo $dae_lang_entry_image_value; ?></td>
                      <td class="text-left required"><?php echo $dae_lang_entry_text_value; ?></td>
                      <?php if(!empty($settings['dae_form_view_url'])){?>
                        <td><?php echo $dae_lang_text_a_v_url; ?></td>
                      <?php } ?>
                      <?php if(!empty($settings['dae_form_view_description'])){?>
                        <td><?php echo $dae_entry_attribute_value_description; ?></td>
                      <?php } ?>
                      <?php if(!empty($settings['dae_value_category'])){?>
                        <td><?php echo $dae_favp_attribute_value_category; ?></td>
                      <?php } ?>
                      <td style="width: 130px;">&nbsp;</td>
                    </tr>
                </thead>
                <tbody>
                <?php $dae_f_a_v_row = 0; ?>
                <?php foreach ($attribute_values as $values) { ?>
                
                  <tr id="attribute-value-row<?php echo $dae_f_a_v_row; ?>" data-attribute_id="<?php echo $values['attribute_id']; ?>" data-attribute_value_id="<?php echo $values['dae_attribute_value_id']; ?>"  data-row="<?php echo $dae_f_a_v_row; ?>">
                    <input type="hidden" name="dae_attribute_value[<?php echo $dae_f_a_v_row; ?>][dae_attribute_value_id]" value="<?php echo $values['dae_attribute_value_id']; ?>" />
                    <td>#<?php echo $values['dae_attribute_value_id'];?></td>
                    <td class="text-center dae_a_v_default">
                      <?php if (isset($values['default']) && $values['default']==1){ ?>
                      <i class="fa fa-check"></i>
                      <?php } ?>
                    </td>
                    <td class="text-center dae_a_v_img" >
                      <img src="<?php echo $values['thumb_image']; ?>" alt="" title="" data-placeholder="<?php echo $dae_lang_entry_text_value; ?>"  style="width:30px;" />
                    </td>
                    <td class="text-left dae_a_v_text">
                      <?php foreach ($languages as $language) { ?>
                      <span>
                        <img src="<?php echo $language['path_image']; ?>" title="<?php echo $language['name']; ?>" />
                      </span>
                      <span class="dae_a_v_text_language_<?php echo $language['language_id'];?>"><?php echo isset($values['description'][$language['language_id']]['text'])?$values['description'][$language['language_id']]['text'] : ''; ?>
                      </span><br>
                      <?php } ?>
                    </td>
                    <?php if(!empty($settings['dae_form_view_url'])){?>
                    <td class="text-left dae_a_v_url">
                      <?php echo isset($values['url']) ? $values['url'] : ''; ?>
                    </td>
                    <?php } ?>
                    <?php if(!empty($settings['dae_form_view_description'])){?>
                    <td class="text-left dae_a_v_description">
                      <?php foreach ($languages as $language) { ?>
                      <span>
                        <img src="<?php echo $language['path_image']; ?>" title="<?php echo $language['name']; ?>" />
                      </span>
                      <span class="dae_a_v_description_language_<?php echo $language['language_id'];?>"><?php echo isset($values['description'][$language['language_id']]['description']) ? $values['description'][$language['language_id']]['description'] : ''; ?>
                      </span><br>
                      <?php } ?>
                    </td>
                    <?php } ?>
                    <?php if(!empty($settings['dae_value_category'])){?>
                      <td>

                      <?php 
                        if(isset($attribute_values_category[$values['dae_attribute_value_id']])){
                          foreach($attribute_values_category[$values['dae_attribute_value_id']] as $value){
                            echo $value['name'].'<br>';
                          }
                        } ?>
                      </td>
                    <?php } ?>
                    <td class="text-right">
                        <button type="button" data-toggle="tooltip" title="<?php echo $button_edit;?>" class="btn btn-primary dae-edit-attribute-value"><i class="fa fa-pencil"></i></button>
                        <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger dae-remove-attribute-value"><i class="fa fa-minus-circle"></i></button>                    
                    </td>
                  </tr>
                    <?php $dae_f_a_v_row++; ?>        
                  <?php } ?>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="7" class="text-right">
                      <button type="button" data-toggle="tooltip" title="<?php echo $button_option_value_add; ?>" class="btn btn-primary dae-add-attribute-value"><i class="fa fa-plus-circle"></i></button>
                    </td>
                  </tr>
                </tfoot>
              </table>
      </div>
    </div>
  </div>
</div>
  <div id="daeModalBox" class="modal fade">
    
  </div>
<script>
var dae_f_a_v_row = <?php echo $dae_f_a_v_row; ?>;
var attribute_id = <?php echo $attribute_id; ?>;
var dae_lang_entry_text_value = '<?php echo $dae_lang_entry_text_value; ?>';
var thumb_image_no_image = '<?php echo $thumb_image_no_image; ?>';
var token = '<?php echo $token;?>';
var work_row = 0;

function viewMessage(context, type, message){
  $(context+' .alert').addClass('hidden');
  $(context+' .alert-'+type+' span').html(message);
  $(context+' .alert-'+type).removeClass('hidden');
}
/*
* Удаление всех значений
*/
$('body').on('click', '.dae-remove-attribute-values', function(){  
  if(confirm("<?php echo $dae_form_a_v_confirm_remove_val_all;?>")){    
    $.ajax({
      url: 'index.php?route=catalog/devos_attribute_ext/deleteAttributeValues&token='+token,
      type: 'POST',
      dataType: 'json',
      data: 'attribute_id='+attribute_id,
      success: function(json) {
       $('table#attribute-value tbody tr').remove();  
      }
    });
    
  }
  
});
/*
* Удаление строки со значением
*/
$('body').on('click', '.dae-remove-attribute-value', function(){
  if(confirm("<?php echo $dae_form_a_v_confirm_remove_val;?>")){
    var dae_attribute_value_id = $(this).closest('tr').data('attribute_value_id')
    work_row = $(this).closest('tr').data('row'); 
    $.ajax({
      url: 'index.php?route=catalog/devos_attribute_ext/deleteAttributeValue&token='+token,
      type: 'POST',
      dataType: 'json',
      data: {'attribute_value_id':dae_attribute_value_id,'attribute_id':attribute_id},
      success: function(json) {
       $('tr#attribute-value-row'+work_row).remove();  
      }
    });
    
  }
  
});
function clearOtherCheckBox(this_){
  var this_checkbox = $(this_).find('.check_default');
  if($(this_checkbox).prop('checked')){    
    $('.check_default').not(this_checkbox).prop('checked', false);    
  }
}
/*
* Генерация значений из строки
*/
$('body').on('click','.dae-generic-attribute-value', function(){
  if(!$('input[name="list_attribute_values"]').val()){
    viewMessage('.dae_attribute_value_page','danger',"<?php echo $dae_form_a_v_empty_list_value; ?>");
    return false;
  }
  if(!$('input[name="split"]').val()){
    viewMessage('.dae_attribute_value_page','danger',"<?php echo $dae_form_a_v_empty_split;?>");
    return false;
  }
  $.ajax({
    url: 'index.php?route=catalog/devos_attribute_ext/genericAttributeValues&token='+token,
    type: 'POST',
    dataType: 'json',
    data: $('#form-generic-attribute-value').serialize(),
    success: function(json) {      
      for(var attribute_value_id in json.dae_attribute_values){
        addRowAttributeValue(dae_f_a_v_row, json.dae_attribute_values[attribute_value_id]);   
      }
      if(json.status == 1){
        $('input[name=list_attribute_values]').val('');
      }

    }
  });
});
$('body').on('click', '.dae-edit-attribute-value', function(){
  var dae_attribute_value_id = $(this).closest('tr').data('attribute_value_id')
  work_row = $(this).closest('tr').data('row'); 
  $.ajax({
    url: 'index.php?route=catalog/devos_attribute_ext/getFormAttributeValue&token='+token,
    type: 'GET',
    dataType: 'json',
    data: 'place=attribute&attribute_id='+attribute_id+'&only_one_value=1&dae_attribute_value_id='+dae_attribute_value_id,
    success: function(json) {
      $('#daeModalBox').html(json.body);
      $("#daeModalBox").modal('show');
    }
  });
});

$('body').on('click', '.dae-add-attribute-value', function(){
  var dae_attribute_value_id = 0;
  work_row = dae_f_a_v_row; 
  $.ajax({
    url: 'index.php?route=catalog/devos_attribute_ext/getFormAttributeValue&token='+token,
    type: 'GET',
    dataType: 'json',
    data: 'place=attribute&attribute_id='+attribute_id+'&only_one_value=1',
    success: function(json) {
      $('#daeModalBox').html(json.body);
      $("#daeModalBox").modal('show');
    }
  });
});
function addRowAttributeValue(row, data) {
  var insert = (row == dae_f_a_v_row);
  html = '';
  if(insert)
    html  = ' <tr id="attribute-value-row' + row + '" data-attribute_id="'+data['attribute_id']+'" data-attribute_value_id="'+data['dae_attribute_value_id']+'" data-row="'+row+'">'; 
  html += '   <input type="hidden" name="dae_attribute_value[' + row + '][dae_attribute_value_id]" value="'+data['dae_attribute_value_id']+'" />';
    html += ' <td>#' + data['dae_attribute_value_id'] + '</td>';
  html += '   <td class="text-center dae_a_v_default">';
  if (data['default'] > 0 ){
    <?php if(!isset($setting_attribute['type_edit']) || $setting_attribute['type_edit'] != 'multi'){?>
      //уберем отметку у остальных
      $('td.dae_a_v_default').html('');
    <?php } ?>  
    html += '   <i class="fa fa-check"></i>';
  }
  
  html += '   </td>';

  html += '   <td class="text-center dae_a_v_img">';
  html += '         <img src="' + data['thumb_image'] + '" alt="" title="" style="width:30px;" />';
  html += '   </td>';
  html += '   <td class="text-left dae_a_v_text">'; 
  <?php foreach ($languages as $language) { ?>
  html += '     <span>';
  html += '       <img src="<?php echo $language['path_image']; ?>" title="<?php echo $language['name']; ?>" />';
  html += '     </span>';
  html += '     <span class="dae_a_v_text_language_<?php echo $language['language_id'];?>">';
  html += data['description'][<?php echo $language['language_id']?>]['text'];
  html += '     </span><br>';
  <?php } ?>
  html += '   </td>';

<?php if(!empty($settings['dae_form_view_url'])){?>
  html += '   <td class="text-left dae_a_v_url">';    
  html += data['url'];
  html += '   </td>';
  <?php } ?>
  
<?php if(!empty($settings['dae_form_view_description'])){?>
  html += '   <td class="text-left dae_a_v_description">';
  <?php foreach ($languages as $language) { ?>
    html += '   <span>';
    html += '     <img src="<?php echo $language['path_image']; ?>" title="<?php echo $language['name']; ?>" />';
    html += '   </span>';
    html += '   <span class="dae_a_v_description_language_<?php echo $language['language_id'];?>">';
    html += data['description'][<?php echo $language['language_id'];?>]['description'];
    html += '   </span><br>';
  <?php } ?>
  html += '  </td>';    
<?php } ?>
<?php if(!empty($settings['dae_value_category'])){?>
  html += '<td>';
  for(var i in data['attribute_values_category']){
    html += data['attribute_values_category'][i]['name']+'<br>';
  }
  html += '</td>';
<?php } ?>
  html += '  <td class="text-right">';
  html += '    <button type="button" data-toggle="tooltip" title="<?php echo $button_edit;?>" class="btn btn-primary dae-edit-attribute-value"><i class="fa fa-pencil"></i></button>';
  html += '    <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger dae-remove-attribute-value"><i class="fa fa-minus-circle"></i></button>';
  html += '  </td>';
  if(insert){
    html += '</tr>';  
    $('#attribute-value tbody').append(html);
    dae_f_a_v_row++;
  }else{
    $('#attribute-value tbody tr#attribute-value-row'+row).html(html);
  }
}
</script>
<?php echo $footer; ?>