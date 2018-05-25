<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h4 class="modal-title"><?php echo $dae_form_attribute_title;?></h4>

    </div>

    <div class="modal-body">
      <div class="alert alert-danger hidden" ><i class="fa fa-exclamation-circle"></i> <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      
      <div class="alert alert-success hidden"><i class="fa fa-check-circle"></i> <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>

      <div class="alert alert-info hidden"><i class="fa fa-check-circle"></i> <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      
          <form action="<?php echo $action_form;?>" method="post" enctype="multipart/form-data" id="dae-form-attribute" class="form-horizontal">
          <input type="hidden" name="place" value="<?php echo $place;?>">
          <input type="hidden" name="attribute_id" value="<?php echo $attribute_id;?>">
            <div class="form-group required">
              <label class="col-sm-4 control-label"><?php echo $dae_entry_name; ?></label>
              <div class="col-sm-8">
                <?php foreach ($languages as $language) { ?>
                <div class="input-group">
				  <span class="input-group-addon">
				    <img src="<?php echo $language['path_image']; ?>" title="<?php echo $language['name']; ?>" />
				  </span>
                  <input type="text" name="attribute_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo   isset($attribute_description[$language['language_id']]) ? $attribute_description[$language['language_id']]['name'] : $default_name; ?>" placeholder="<?php   echo $dae_entry_name_attribute; ?>" class="form-control" />
                </div>
                <?php if (isset($error_name[$language['language_id']])) { ?>
                <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                <?php } ?>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-4 control-label" ><?php echo $dae_attr_form_short_name; ?></label>
              <div class="col-sm-8">
                <?php foreach ($languages as $language) { ?>
                <div class="input-group">
                  <span class="input-group-addon">
                    <img src="<?php echo $language['path_image']; ?>" title="<?php echo $language['name']; ?>" />
                  </span>
                  <input type="text" class="form-control" name="setting_attribute[description][<?php echo $language['language_id']; ?>][short_name]" 
                  value="<?php echo (isset($attribute_settings['description']) && isset($attribute_settings['description'][$language['language_id']])
                  )?$attribute_settings['description'][$language['language_id']]['short_name']:''; ?>"/>   
                </div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-4 control-label" for="input-attribute-group"><?php echo $dae_entry_group; ?></label>
              <div class="col-sm-8">
                <select name="attribute_group_id" id="input-attribute-group" class="form-control">
                  <?php foreach ($attribute_groups as $attribute_group) { ?>
                  <?php if (isset($attribute['attribute_group_id']) && $attribute_group['attribute_group_id'] == $attribute['attribute_group_id']) { ?>
                  <option value="<?php echo $attribute_group['attribute_group_id']; ?>" selected="selected"><?php echo $attribute_group['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $attribute_group['attribute_group_id']; ?>"><?php echo $attribute_group['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-4 control-label" for="input-attribute-group"><?php echo $dae_sort_order; ?></label>
              <div class="col-sm-8">
                <input type="text" name="sort_order" value="<?php echo isset($attribute['sort_order'])?$attribute['sort_order']:0; ?>" placeholder="<?php echo $dae_sort_order; ?>" id="  input-sort-order" class="form-control" />
              </div>
            </div>

            <div class="form-group">
              <div class="checkbox col-sm-4">
                <label class="">
                  <input type="checkbox"  name="setting_attribute[view_catalog]" value="1" <?php echo (isset($attribute_settings['view_catalog']) && $attribute_settings['view_catalog']==1)?'checked':''; ?>/> <?php echo $dae_attr_form_view_catalog;?>
                </label>
              </div>
              <div class="checkbox col-sm-4">
                <label class="">
                  <input type="checkbox"  name="setting_attribute[view_product]" value="1" <?php echo (isset($attribute_settings['view_product']) && $attribute_settings['view_product']==1)?'checked':''; ?>/> <?php echo $dae_attr_form_view_product;?>
                </label>
              </div>  
              <div class="checkbox col-sm-4">
                <label class="">
                  <input type="checkbox"  name="setting_attribute[view_product_tab]" value="1" <?php echo (isset($attribute_settings['view_product_tab']) && $attribute_settings['view_product_tab']==1)?'checked':''; ?>/> <?php echo $dae_attr_form_view_product_tab;?>
                </label>
              </div>  
            </div>
            <div class="form-group">
              <label class="col-sm-4 control-label" for="setting_attribute[type_edit]"><?php echo $dae_attr_form_type;?></label>
              <div class="col-sm-8">
                <select name="setting_attribute[type_edit]" class="form-control">
                  <option value="autocomp" <?php if (empty($attribute_settings['type_edit']) || $attribute_settings['type_edit'] == 'autocomp') { ?> selected="selected" <?php } ?> ><?php echo $dae_attr_form_type_autocomp;?></option>
                  <option value="default" <?php if (isset($attribute_settings['type_edit']) && $attribute_settings['type_edit'] == 'default') { ?> selected="selected" <?php } ?> ><?php echo $dae_attr_form_type_default;?></option>
                  <option value="multi" <?php if (isset($attribute_settings['type_edit']) && $attribute_settings['type_edit'] == 'multi') { ?> selected="selected" <?php } ?> ><?php echo $dae_attr_form_type_multi;?></option>
                </select>
              </div>
            </div>
            

            <div class="form-group">
              <label class="col-sm-4 control-label"><?php echo $dae_lang_text_attribute_tooltip;?></label>
              <div class="col-sm-8">
                <?php foreach ($languages as $language) { ?>
                <div class="input-group">
                  <span class="input-group-addon">
                    <img src="<?php echo $language['path_image']; ?>" title="<?php echo $language['name']; ?>" />
                  </span>
                  <input type="text" class="form-control" name="setting_attribute[description][<?php echo $language['language_id']; ?>][tooltip]" value="<?php echo (isset($attribute_settings['description']) && isset($attribute_settings['description'][$language['language_id']]))?$attribute_settings['description'][$language['language_id']]['tooltip']:'';?>"/>   
                </div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">                    
              <label class="col-sm-4 control-label" for="setting_attribute[attribute_html]"><?php echo $dae_lang_text_attribute_html;?></label>
              <div class="col-sm-8">
                  <input type="text" class="form-control" name="setting_attribute[attribute_html]" value="<?php echo (!empty($attribute_settings['attribute_html']))?$attribute_settings['attribute_html']:'';?>"/>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-4 control-label" for="input-image"><?php echo $dae_lang_text_attribute_image; ?></label>
                      <div class="col-sm-8">
                        <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $attribute_settings['thumb_attribute_image']; ?>" alt="" title="" data-placeholder="<?php echo $dae_lang_text_attribute_image; ?>" style="height:30px;"/></a>
                        <input type="hidden" name="setting_attribute[attribute_image]" value="<?php echo (!empty($attribute_settings['attribute_image']))?$attribute_settings['attribute_image']:''; ?>" id="input-image" />
                      </div>
            </div> 
          </form>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
      <button type="button" class="btn btn-primary" onclick="daeSendFromAttribute();" >Сохранить изменения</button>
    </div>
  </div>
</div>
<script>
 var attribute_group_id = '';
//$(document).ready(function(){
  var attribute_id = '<?php echo $attribute_id;?>';
  if(attribute_id == 0)
    $('#input-attribute-group [value="'+$('ul#dae-attribute-group li.active').data('attribute_group_id')+'"]').attr("selected", "selected"); 
  attribute_group_id = $('select#input-attribute-group').val();
//});

function daeSendFromAttribute(){  

  $.ajax({
    url: $('#dae-form-attribute').attr('action'),
    type: "POST",
    data: $('#dae-form-attribute').serialize(),
    dataType: 'json',      
    success: function(json) {
      var html = '';
      if(json.error == 1){
        $('div.modal-body .alert-danger span').html(json.error_warning);
        $('div.modal-body .alert-danger').removeClass('hidden');
      }else{
        if($('ul').is('#dae-attribute-group')){//если форма открылась на странице со списком
            html  = ' <tr id="dae_attribute_'+json.attribute.attribute_id+'">';
            html += '   <td class="text-center" style="cursor: move;"><i class="fa fa-sort" aria-hidden="true"></i></td>';
            html += '   <td class="text-left">';
            html +=       '<span class="attribute_name">'+json.attribute.name+'</span>';
            <?php if(!empty($settings['dae_view_attr_id'])){?>
            html +=       ' #'+json.attribute.attribute_id;
            <?php } ?>
            html +='      <br><span style="color:#aaa;" id="dae_attribute_values_'+json.attribute.attribute_id+'"></span>';
            html +='    </td>';
            html += '   <td class="text-right">'+json.attribute.sort_order+'</td>';
            html += '   <td class="text-right">';
            html += '<a href="index.php?route=catalog/devos_attribute_ext/getTableAttributeValue&attribute_id='+json.attribute.attribute_id+'&token='+token+'" type="button" data-toggle="tooltip" title="<?php echo $dae_lang_button_list_attr; ?>" class="btn btn-primary"><i class="fa fa-list"></i></a>';
            //html += '     <button type="button" data-toggle="tooltip" title="<?php echo $dae_lang_button_list_attr; ?>" class="btn btn-primary" onclick="daeViewFormValue('+json.attribute.attribute_id+');"><i class="fa fa-list"></i></button>';
            html += '     <button type="button" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary" onclick="daeViewFormAttribute('+json.attribute.attribute_id+');"><i class="fa fa-pencil"></i></button>';
            html += '     <button type="button" data-toggle="tooltip" title="<?php echo $button_replase; ?>" class="btn btn-primary" onclick="daeViewFormCorrection('+json.attribute.attribute_id+');"><i class="fa fa-retweet"></i></button>';
            html += '     <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="daeDeleteAttribute('+json.attribute.attribute_id+');"><i class="fa fa-trash-o"></i></button>';
            html += '   </td>';
            html += ' </tr>';
          if(json.operation == 'add'){ 
            if($('div#tab-dae-attribute'+json.attribute.attribute_group_id+' table tbody tr').is('.empty_attributes'))
              $('div#tab-dae-attribute'+json.attribute.attribute_group_id+' table tbody tr.empty_attributes').remove();
            daeReplaseCountForAG(json.attribute.attribute_group_id,1);
            $('div#tab-dae-attribute'+json.attribute.attribute_group_id+' table tbody').append(html);
          }else{
            var row = $('tr#dae_attribute_'+json.attribute.attribute_id);
            if(attribute_group_id == json.attribute.attribute_group_id){//если группа не менялась
                //обновим название и сортировку                
                $(row).find('td:eq(1) span.attribute_name').html(json.attribute.name);
                $(row).find('td:eq(2)').html(json.attribute.sort_order);
            }else{//есил менялась
                //удалим текущую
                $(row).remove();
                $('div#tab-dae-attribute'+json.attribute.attribute_group_id+' table tbody tr.empty_attributes').remove(); 
                $('div#tab-dae-attribute'+json.attribute.attribute_group_id+' table tbody').append(html);
                daeReplaseCountForAG(json.attribute.attribute_group_id,1);
                daeReplaseCountForAG(attribute_group_id,-1);
                /*var count_agr = $('div#tab-dae-attribute'+attribute_group_id+' table tbody').length;

                if(count_agr == 1){
                  html = '<tr class="empty_attributes"><td colspan="3" class="text-center">'+text_no_results+'</td></tr>';
                  $('div#tab-dae-attribute'+attribute_group_id+' table tbody').append(html);
                }*/
                //добавим на нужной вкладе
            }
          }

        }else{//если форма вызвалась с карточки товара
          //devos_attributes = json.devos_attributes;
          object_dae.setAttributeSettings(json.attribute_id, json.devos_attribute_settings) ;         
          //добавим атрибут в форму к товару  

          if(focus_select_row > -1){
            getFieldAttributeName(focus_select_row).val(json.attribute.name);
            object_dae.removeSelectAttribute(getFieldAttributeId(focus_select_row).val());
            getFieldAttributeId(focus_select_row).val(json.attribute_id);
            object_dae.setSelectAttribute(json.attribute_id);            
            loadAttributeValue(json.attribute_id, focus_select_row);
          }
        }
        //$("#daeModalBox .alert-success span").html(json.message);
        //$("#daeModalBox .alert-success").removeClass('hidden');
        $("#daeModalBox").modal('hide');
      }  
    }
  });
}
</script>