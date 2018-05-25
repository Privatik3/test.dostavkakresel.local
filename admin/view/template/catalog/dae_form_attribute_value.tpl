
<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h4 class="modal-title"><?php echo $dae_form_attribute_value_title;?></h4>

    </div>

    <div class="modal-body dae_form_attribute_value">
      <div class="alert alert-danger hidden" ><i class="fa fa-exclamation-circle"></i> <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      
      <div class="alert alert-success hidden"><i class="fa fa-check-circle"></i> <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>

      <div class="alert alert-info hidden"><i class="fa fa-check-circle"></i> <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php $value_row=0; ?>
          <form action="<?php echo $action_form;?>" method="post" enctype="multipart/form-data" id="dae-form-attribute-value" class="form-horizontal">
            <input type="hidden" name="attribute_id" value="<?php echo $attribute_id;?>">
            <input type="hidden" name="place" value="<?php echo $place;?>">
            <input type="hidden" name="dae_attribute_value[dae_attribute_value_id]" value="<?php echo $attribute_values['dae_attribute_value_id']; ?>" />
            <input type="hidden" name="dae_attribute_value[attribute_id]" value="<?php echo $attribute_values['attribute_id']; ?>" />
            <input type="hidden" name="update_value_in_product" value="0" id="update_value_in_product">
                      <div class="form-group col-sm-12"> 
                       <div class="col-sm-3">  
                       <a href="" id="thumb-image<?php echo $value_row; ?>" data-toggle="image" class="img-thumbnail">
                          <img src="<?php echo $attribute_values['thumb_image']; ?>" alt="" title="" data-placeholder="<?php echo $dae_lang_entry_text_value; ?>"  style="width:30px;" />
                        </a>
                        <input type="hidden" name="dae_attribute_value[image]" value="<?php echo $attribute_values['image']; ?>" id="input-image<?php echo $value_row; ?>" />
                      </div>
                        <div class="col-sm-9">             
                          <input type="text" name="dae_attribute_value[url]" value="<?php echo isset($attribute_values['url']) ? $attribute_values['url'] : ''; ?>" placeholder="<?php echo $dae_lang_text_a_v_url; ?>" class="form-control" data-original-title="<?php echo $dae_lang_text_a_v_url; ?>" data-toggle="tooltip"/>              
                        </div>
                      </div>
                  
                      
                    
                      <?php if(count($languages)>1){?>
                        <ul class="nav nav-tabs" id="language">
                        <?php $i=0;?>
                        <?php foreach ($languages as $language) { ?>
                          <li class="<?php echo ($i==0)?'active':''?>"><a href="#language_<?php echo $language['language_id']; ?>_<?php echo $value_row; ?>" data-toggle="tab"><img src="<?php echo $language['path_image']; ?>" title="<?php echo $language['name']; ?>"  /> <?php echo $language['name']; ?></a></li>
                          <?php $i++;?>
                        <?php } ?>
                        </ul>
                      <?php } ?>
                      <div class="tab-content" style="background:#fff;">
                      <?php $i=0;?>          
                      <?php foreach ($languages as $language) { ?>
                        <div class="tab-pane <?php echo ($i==0)?'active':''?>" id="language_<?php echo $language['language_id']; ?>_<?php echo $value_row; ?>">
                          <div class="form-group">                         
                            <div class="col-sm-12 input_attribute_value">             
                              <input type="text" name="dae_attribute_value[description][<?php echo $language['language_id']; ?>][text]" value="<?php echo isset($attribute_values['description'][$language['language_id']]['text']) ? $attribute_values['description'][$language['language_id']]['text'] : ''; ?>" placeholder="<?php echo $dae_lang_entry_attribute_value; ?>" class="form-control text-value"  data-original-title="<?php echo $dae_lang_entry_attribute_value; ?>" data-toggle="tooltip"/>
                              <input type="hidden" name="dae_attribute_value[description][<?php echo $language['language_id']; ?>][old_text]" value="<?php echo isset($attribute_values['description'][$language['language_id']]['text']) ? $attribute_values['description'][$language['language_id']]['text'] : ''; ?>" />       
                            </div>   
                          </div>
                   
                          <div class="form-group">
                            <div class="col-sm-12">             
                              <textarea name="dae_attribute_value[description][<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $dae_entry_attribute_value_description; ?>" class="form-control" data-original-title="<?php echo $dae_entry_attribute_value_description; ?>" data-toggle="tooltip"><?php echo isset($attribute_values['description'][$language['language_id']]['description']) ? $attribute_values['description'][$language['language_id']]['description'] : ''; ?></textarea>
                            </div>
                          </div>     
                         
                        </div>
                        <?php $i++;?>                   
                      <?php } ?>
                      </div>
                    <div class="col-sm-12">
                      <div class="form-group"> 
                        <div class="checkbox" >
                          <label class="col-sm-12">
                            <input type="checkbox" class="check_default"  name="dae_attribute_value[default]" value="1" <?php echo (isset($attribute_values['default']) && $attribute_values['default']==1)?'checked':''; ?>/> <?php echo $dae_lang_default;?>
                          </label>
                        </div>  
                      </div>
          </div>
                      <?php //if(!empty($settings['dae_value_category'])){ ?>
            <div class="col-sm-12">
                      <div class="form-group">                      
                        
                          <label class="control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_fav_label_value_category_help;?>"><?php echo $dae_fav_label_value_category;?></span></label>                          
                        
                        <div id="value_category">          
                          <input type="text" name="category_" value="" placeholder="" class="form-control" autocomplete="off">
                          <div id="dae_box_value_category" class="well well-sm" style="height: 150px; overflow: auto;margin-bottom: 0px;">

                            <?php foreach($values_category as $value){ ?>
                              <div id="dae_box_value_category<?php echo $value['category_id'];?>"><i class="fa fa-minus-circle"></i> <?php echo $value['name'];?><input type="hidden" name="value_category[]" value="<?php echo $value['category_id'];?>" /></div>
                            <?php } ?>
                          </div>
                        </div>
                      </div>
            </div>
                    
                      <?php //} ?>
                    
          </form>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
      <button type="button" class="btn btn-primary" onclick="dae_save_form_attribute_value();" >Сохранить изменения</button>
    </div>
  </div>
</div>
<script>

var attribute_id = <?php echo $attribute_id; ?>;
var dae_lang_entry_text_value = '<?php echo $dae_lang_entry_text_value; ?>';
var thumb_image_no_image = '<?php echo $thumb_image_no_image; ?>';
var view_message_confirm_update_value_in_product = false;

function dae_save_form_attribute_value(){
  //проверим, было ли изменено значение, чтобы предложить заменить его в товарах

  <?php foreach ($languages as $language) { ?>
    //проверка на непустое значение
    if(!$('input[name="dae_attribute_value[description][<?php echo $language['language_id']; ?>][text]"]').val()){
      viewMessage('.dae_form_attribute_value', 'danger', "<?php echo $dae_form_a_v_error_empty_value;?>");
      return false;
    }
  //проверка на измененное значение
  if(view_message_confirm_update_value_in_product == false 
    && $('input[name="dae_attribute_value[description][<?php echo $language['language_id']; ?>][old_text]"]').val()
    && $('input[name="dae_attribute_value[description][<?php echo $language['language_id']; ?>][text]"]').val() !== $('input[name="dae_attribute_value[description][<?php echo $language['language_id']; ?>][old_text]"]').val()){
      view_message_confirm_update_value_in_product = true;
  }
  <?php } ?>
  if(view_message_confirm_update_value_in_product){
    if(confirm("Значение атрибута изменено. Заменить в товарах?")){
      $('#update_value_in_product').val(1);
    }
  }
  viewMessage('.dae_form_attribute_value', 'info', "<?php echo $dae_text_wait;?>");
  $.ajax({
    url: $('#dae-form-attribute-value').attr('action'),
    type: "POST",
    data: $('#dae-form-attribute-value').serialize(),
    dataType: 'json',      
    success: function(json) {
      viewMessage('.dae_form_attribute_value', 'success', "<?php echo $dae_text_success;?>");
      //поведение после сохранения на странице Атрибутов
      if(json.place == 'attribute'){
        addRowAttributeValue(work_row, json.dae_attribute_value);
      }
      //поведение после сохранения на странице Товара
      
      if(json.place == 'product'){
        console.log(json.dae_attribute_value);
        //for (var dae_attribute_value_id in json.dae_attribute_value){
          for (var language_id in json.dae_attribute_value['description']){ //выведем на экран все элементы  
            //for (var attribute_value_id in json.devos_attributes_values[dae_attribute_value_id]['description'][language_id]){ //выведем на экран все элементы
              attribute_value = json.dae_attribute_value['description'][language_id]['text'];
              //console.log(attribute_value + ' '+focus_select_row);
              $('input[name=\'product_attribute['+focus_select_row+'][product_attribute_description]['+language_id+'][text]\']').val(attribute_value);
              
            //}
          }
        //}
      }
      $("#daeModalBox").modal('hide');
    }
  });  
}
$(document).ready(function(){
//автозавершение категорий
  $('input[name="category_"]').autocomplete({
      'source': function(request, response) {
        $.ajax({
          url: 'index.php?route=catalog/devos_attribute_ext/autocompleteCategory&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
          dataType: 'json',     
          success: function(json) {
            response($.map(json, function(item) {
              return {
                label: item['name'],
                value: item['category_id']
              }
            }));
          }
        });
      },
      'select': function(item) {
        $('input[name="category_"]').val('');
        
        $('#dae_box_value_category' + item['value']).remove();
        
        $('#dae_box_value_category').append('<div id="dae_box_value_category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="value_category[]" value="' + item['value'] + '" /></div>'); 
        
      }
    });
        /*
    * Удаление списков
    */
    $('form').on('click','.fa-minus-circle',  function() {
      $(this).parent().remove();
    });
});
</script>