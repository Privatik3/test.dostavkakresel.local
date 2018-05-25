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
      
      <form action="<?php echo $action_save;?>" method="post" id="dae-form-product-tab-settings" class="form-horizontal">
        <div class="form-group">
          <div class="checkbox col-sm-12">
            <label class="">
              <input type="checkbox"  name="setting_attribute[dae_product_tab][view_button_add_attribute_group]" value="1" <?php echo (!empty($settings_product_tab['view_button_add_attribute_group']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $dae_button_add_attribute_group); ?>
            </label>
          </div>
        </div>
        <div class="form-group">
          <div class="checkbox col-sm-12">
            <label class="">
              <input type="checkbox"  name="setting_attribute[dae_product_tab][view_button_add_attribute]" value="1" <?php echo (!empty($settings_product_tab['view_button_add_attribute']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $dae_button_add_attribute); ?>
            </label>
          </div>
        </div>
        <div class="form-group">
          <div class="checkbox col-sm-12">
            <label class="">
              <input type="checkbox"  name="setting_attribute[dae_product_tab][view_button_add_attribute_category]" value="1" <?php echo (!empty($settings_product_tab['view_button_add_attribute_category']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $devos_button_add_attribute_category); ?>
            </label>
          </div>
        </div>
        <div class="form-group">
          <div class="checkbox col-sm-12">
            <label class="">
              <input type="checkbox"  name="setting_attribute[dae_product_tab][view_button_add_attribute_list]" value="1" <?php echo (!empty($settings_product_tab['view_button_add_attribute_list']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $devos_button_add_attribute_list); ?>
            </label>
          </div>
        </div>
        <div class="form-group">
          <div class="checkbox col-sm-12">
            <label class="">
              <input type="checkbox"  name="setting_attribute[dae_product_tab][view_button_clear_attribute]" value="1" <?php echo (!empty($settings_product_tab['view_button_clear_attribute']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $dae_lang_button_clear_attribute); ?>
            </label>
          </div>
        </div>

        <div class="form-group hidden">
          <div class="col-sm-12">
            <label><?php echo $dae_pt_settings_value_source;?></label>
          </div>
          <div class="col-sm-4">
            <div class="radio">
              <label><input type="radio" name="setting_attribute[dae_product_tab][source_value]" value="module" <?php echo (isset($settings_product_tab['source_value']) && $settings_product_tab['source_value']== 'module')?'checked':''; ?>> <?php echo $dae_pt_settings_value_module; ?></label>
            </div>
          </div>
          <div class="col-sm-4"> 
            <div class="radio">
              <label><input type="radio" name="setting_attribute[dae_product_tab][source_value]" value="product" <?php echo (isset($settings_product_tab['source_value']) && $settings_product_tab['source_value']== 'product')?'checked':''; ?>"> <?php echo $dae_pt_settings_value_product; ?></label>
            </div>
          </div>
          <div class="col-sm-4"> 
            <div class="radio">
              <label><input type="radio" name="setting_attribute[product_tab][source_value]" value="product_category" <?php echo (isset($settings_product_tab['source_value']) && $settings_product_tab['source_value']== 'product_category')?'checked':''; ?>"> <?php echo $dae_pt_settings_value_product_category; ?></label>
            </div>
          </div>
        </div>            
      </form>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
      <button type="button" class="btn btn-primary" id="dae-submit-form-product-tab-settings" >Сохранить изменения</button>
    </div>
  </div>
</div>
<script>
$('body').on('click', '#dae-submit-form-product-tab-settings', function(){
$('#dae_button_add_attribute_group').toggle($('#dae-form-product-tab-settings input[name *= view_button_add_attribute_group]').prop('checked'));

  $.ajax({
    url: $('#dae-form-product-tab-settings').attr('action'),
    type: "POST",
    data: $('#dae-form-product-tab-settings').serialize(),
    dataType: 'json',      
    success: function(json) {
      var html = '';
      if(json.error == 1){
        $('div.modal-body .alert-danger span').html(json.error_warning);
        $('div.modal-body .alert-danger').removeClass('hidden');
      }else{
        //на основании формы - покажем или спрячем кнопки
        var buttons = ["button_add_attribute_group", "button_add_attribute", "button_add_attribute_category", "button_add_attribute_list", "button_clear_attribute"];
        for (var i=0; i<buttons.length; i++){
          if($('#dae-form-product-tab-settings input[name *= "[view_'+buttons[i]+']"]').prop('checked'))
            $('#dae_'+buttons[i]).removeClass('hidden'); 
          else 
            $('#dae_'+buttons[i]).addClass('hidden');
        }
        
        $("#daeModalBox").modal('hide');
        
      }  
    }
  });
});
</script>