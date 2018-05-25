<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h4 class="modal-title"><?php echo $dae_form_attribute_group_title;?></h4>

    </div>

    <div class="modal-body">
      <div class="alert alert-danger hidden" ><i class="fa fa-exclamation-circle"></i><span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      
      <div class="alert alert-success hidden"><i class="fa fa-check-circle"></i><span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>

      <div class="alert alert-info hidden"><i class="fa fa-check-circle"></i><span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <form method="post" action='<?php echo $action_form;?>' enctype="multipart/form-data" id="dae-form-attribute-group" class="form-horizontal">
        <input type="hidden" name="attribute_group_id" value="<?php echo $attribute_group_id;?>">
        <div class="form-group required">
          <label class="col-sm-4 control-label"><?php echo $dae_form_attribute_group_entry_name; ?></label>
          <div class="col-sm-8">
            <?php foreach ($languages as $language) { ?>
            <div class="input-group">
			  <span class="input-group-addon">
			    <img src="<?php echo $language['path_image']; ?>" title="<?php echo $language['name']; ?>" />
			  </span>
              <input type="text" name="attribute_group_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo           isset($attribute_group_description[$language['language_id']]) ? $attribute_group_description[$language['language_id']]['name'] : ''; ?>"           placeholder="<?php echo $dae_form_attribute_group_entry_name; ?>" class="form-control" />
            </div>
            <?php if (isset($error_name[$language['language_id']])) { ?>
            <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
            <?php } ?>
            <?php } ?>
          </div>

        </div>
        <div class="form-group">
          <label class="col-sm-4 control-label"><?php echo $dae_sort_order; ?></label>
          <div class="col-sm-8">
            <input type="text" name="sort_order" value="<?php echo isset($attribute_group['sort_order'])?$attribute_group['sort_order']:0; ?>" placeholder="<?php echo $dae_sort_order; ?>" idinput-sort-order" class="form-control" />
          </div>
          </div>
      </form>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
      <button type="button" class="btn btn-primary" onclick="daeSendFormAttributeGroup();" >Сохранить изменения</button>
    </div>
  </div>
</div>
<script>
var attribute_group_id = <?php echo $attribute_group_id;?>;
function daeSendFormAttributeGroup(){
  $.ajax({
    url: $('#dae-form-attribute-group').attr('action'),
    type: "POST",
    data: $('#dae-form-attribute-group').serialize(),
    dataType: 'json',      
    success: function(json) {
      if($('ul').is('#dae-attribute-group')){
        var html = '';
        if(attribute_group_id == 0){
          html  = '<li class="" data-attribute_group_id="'+json.attribute_group_id+'" id="dae_attribute_group_'+json.attribute_group_id+'">';
          html += '  <a data-toggle="tab" href="#tab-dae-attribute'+json.attribute_group_id+'">';
          html += '    <i class="fa fa-sort" aria-hidden="true" style="cursor: move;"></i> ';
          html += '    <i class="fa fa-pencil" onclick="daeViewFormAttributeGroup('+  json.attribute_group_id+');"></i> ';
          html += '    <i class="fa fa-minus-circle" onclick="daeDeleteAttributeGroup('+  json.attribute_group_id+');"></i> ';
          html += '    <span id="attribute_group_name'+json.attribute_group_id+'">'+json.attribute_group_name+'</span> ';
          html += '    (<span id="attribute_group_count_value'+json.attribute_group_id+'">0</span>)';
          html += '  </a>';
          html += '</li>';
          $('ul#dae-attribute-group li.dae-add-attribute-group').before(html);
          html =  '<div id="tab-dae-attribute'+json.attribute_group_id+'" class="tab-pane fade">';
          html += '<button type="button" class="btn btn-primary" onclick="daeViewFormAttribute(0);"><i class="fa fa-plus"></i> <?php echo $dae_form_attribute_title;?></button>';
          html += '  <div class="table-responsive">';
          html += '    <table class="table table-hover">';
          html += '      <thead>';
          html += '        <tr>';
          html += '          <td class="text-left">&nbsp;</td>';
          html += '          <td class="text-left">'+dae_entry_name_attribute+'</td>';
          html += '          <td class="text-right">'+dae_sort_order+'</td>';
          html += '          <td class="text-right">'+dae_column_action+'</td>';
          html += '        </tr>';
          html += '      </thead>';
          html += '      <tbody>';
          html += '        <tr class="empty_attributes"><td colspan="3" class="text-center">'+text_no_results+'</td></tr>';
          html += '      </tbody>';
          html += '    </table>';
          html += '  </div>';
          html += '</div>';
          $('div.dae-attribute-list-for-group').append(html);
        }else{
          $('span#attribute_group_name'+json.attribute_group_id).html(json.attribute_group_name);
        }
      }
      //$("#daeModalBox .alert-success span").html(json.message);
      //$("#daeModalBox .alert-success").removeClass('hidden');
      $("#daeModalBox").modal('hide');
    }
  });
}
</script>