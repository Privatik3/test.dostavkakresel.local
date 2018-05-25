<div class="modal-dialog" id="form_load_attr_from_cat">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h4 class="modal-title"><?php echo $dae_form_load_attr_from_cat_title;?></h4>
    </div>    
    <div class="modal-body">
      <select class="form-control" id="select_devos_category">
        <option value="0">-</option>
        <?php foreach ($devos_categories_attributes as $devos_category_attributes) { ?>
          <option value="<?php echo $devos_category_attributes['category_id'];?>" ><?php echo $devos_category_attributes['category_name'];?></option>
        <?php } ?>
        </select>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
      <button type="button" class="btn btn-primary" onclick="dae_add_attributes_for_category();" >Добавить</button>
    </div>
  </div>
</div>

<script>
var devos_categories_attributes = <?php echo json_encode($devos_categories_attributes); ?>;
function dae_add_attributes_for_category(){
  var category_id = $('select#select_devos_category').val();
  var attribute_id =0;
  var attribute_name ='';
  if(category_id > 0){
    /*if(category_id in devos_categories_attributes)    
      addAttributeForCategory(category_id);
    else*/
      daeLoadAttributeFromCategory(category_id);
    viewSuccessAlert('<?php echo $success_add_attributes;?>', '#form_load_attr_from_cat .modal-body');
  }else{
    viewDangerAlert('<?php echo $success_no_add_attributes;?>', '#form_load_attr_from_cat .modal-body');
  }
  /*setTimeout(function(){
    $('#form_load_attr_from_cat .alert-success').addClass('hidden');
    $('#form_load_attr_from_cat .alert-danger').addClass('hidden');}
    ,1000);*/
}
</script>