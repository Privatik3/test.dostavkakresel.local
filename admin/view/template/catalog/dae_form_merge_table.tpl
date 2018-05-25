<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="button" form="form-view" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary" id="submit-form-view"><i class="fa fa-save"></i></button>
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
  <div class="container-fluid">
    
    <div class="alert alert-danger hidden" ><i class="fa fa-exclamation-circle"></i><span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    
    <div class="alert alert-success hidden"><i class="fa fa-check-circle"></i><span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>

    <div class="alert alert-info hidden"><i class="fa fa-check-circle"></i><span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $dae_lang_a_merge; ?></h3>
      </div>
      <div class="panel-body">
		<form action="<?php echo $action_save_merge_table; ?>" method="post" enctype="multipart/form-data" id="form-view" name="form-view" class="form-horizontal">
		  <div class="table-responsive">
			<table class="table table-bordered table-hover">
			  <thead>
				<tr>
				  <th rowspan="3" style="width:40px;"><?php echo $dae_lang_entry_image_value;?></th>
				  <th rowspan="3"><?php echo $dae_lang_column_name_attribute;?></th>
				  <th colspan="3" class="text-center"><?php echo $dae_lang_text_attr_view;?></th>
				  
				  <th rowspan="3" class="text-center"><?php echo $dae_lang_text_attr_style;?></th>
				  <th rowspan="3"><?php echo $dae_lang_text_attribute_html;?></th>
				</tr>
				<tr>									
				  <th class="text-center">
				  	<label class="control-label">
				  	  <span title="" data-toggle="tooltip" data-original-title="<?php echo $dae_lang_help_attr_view_category;?>">
				  	    <?php echo $dae_lang_text_attr_view_category;?>								
				  	  </span>
				  	</label>
				  </th>
				  <th class="text-center">
				    <label class="control-label">
				      <span title="" data-toggle="tooltip" data-original-title="<?php echo $dae_lang_help_attr_view_product;?>">
				        <?php echo $dae_lang_text_attr_view_product;?>
				      </span>
				    </label>
				  </th>
				  <th class="text-center">
				  	<label class="control-label">
				  		<span title="" data-toggle="tooltip" data-original-title="<?php echo $dae_lang_help_attr_view_def_product;?>"><?php echo $dae_lang_text_attr_view_def_product;?>				  			
				  		</span>
				  	</label>
				  </th>
				</tr>
				<tr>
				  <td class="text-center"><input type="checkbox" class="select-all" data-critery="view_catalog" value="" /></td>
				  <td class="text-center"><input type="checkbox" class="select-all" data-critery="view_product" value="" /></td>
				  <td class="text-center"><input type="checkbox" class="select-all" data-critery="view_default" value="" /></td>
				</tr>	
			  </thead>
			  <tbody>
			  <?php foreach ($attributes as $attribute_group) { ?>				  
			    <tr>
			      <td colspan="7"><strong><?php echo $attribute_group['attribute_group']; ?></strong></td>								
				</tr>	
				<?php foreach ($attribute_group['attributes'] as $attribute) { ?>
				<tr>
				  <td style="text-align:center;">
				    <a href="" id="thumb-image<?php echo $attribute['attribute_id'] ?>" data-toggle="image" class="img-thumbnail">
				      <img src="<?php echo (!empty($settings_attributes[$attribute['attribute_id']]['thumb_attribute_image']))?$settings_attributes[$attribute['attribute_id']]['thumb_attribute_image']:$thumb_attribute_image; ?>" alt="" title="" data-placeholder="<?php echo $dae_lang_text_attribute_image; ?>" width="30"/>
				    </a>
					<input type="hidden" name="setting_attribute[<?php echo $attribute['attribute_id'];?>][attribute_image]" value="<?php echo (!empty($settings_attributes[$attribute['attribute_id']]['attribute_image']))?$settings_attributes[$attribute['attribute_id']]['attribute_image']:''; ?>" id="input-image<?php echo $attribute['attribute_id'] ?>" />
			      </td>
				  <td><?php echo $attribute['name'];?></td>
				  <td class="text-center">
				    <input type="checkbox" name="setting_attribute[<?php echo $attribute['attribute_id'];?>][view_catalog]" value="1" <?php echo (!empty($settings_attributes[$attribute['attribute_id']]['view_catalog']))?'checked':''; ?> class="view_catalog"/>
				  </td>
				  <td class="text-center">
					<input type="checkbox" name="setting_attribute[<?php echo $attribute['attribute_id'];?>][view_product]" value="1" <?php echo (!empty($settings_attributes[$attribute['attribute_id']]['view_product']))?'checked':''; ?> class="view_product" />
				  </td>
				  <td class="text-center">
				    <input type="checkbox" name="setting_attribute[<?php echo $attribute['attribute_id'];?>][view_product_tab]" value="1" <?php echo (isset($settings_attributes[$attribute['attribute_id']]['view_product_tab']) && $settings_attributes[$attribute['attribute_id']]['view_product_tab'] == 1)?'checked':''; ?> class="view_default" />
				  </td>
				  <td class="text-center">
					<select name="setting_attribute[<?php echo $attribute['attribute_id'];?>][type_edit]" class="form-control">
                  		<option value="autocomp" <?php if (empty($settings_attributes[$attribute['attribute_id']]['type_edit']) || $settings_attributes[$attribute['attribute_id']]['type_edit'] == 'autocomp') { ?> selected="selected" <?php } ?> ><?php echo $dae_attr_form_type_autocomp;?></option>
                  		<option value="default" <?php if (isset($settings_attributes[$attribute['attribute_id']]['type_edit']) && $settings_attributes[$attribute['attribute_id']]['type_edit'] == 'default') { ?> selected="selected" <?php } ?> ><?php echo $dae_attr_form_type_default;?></option>
                  		<option value="multi" <?php if (isset($settings_attributes[$attribute['attribute_id']]['type_edit']) && $settings_attributes[$attribute['attribute_id']]['type_edit'] == 'multi') { ?> selected="selected" <?php } ?> ><?php echo $dae_attr_form_type_multi;?></option>
                	</select>
				  </td>
				  <td>
					<input type="text" class="form-control" name="setting_attribute[<?php echo $attribute['attribute_id'];?>][attribute_html]" value="<?php echo (!empty($settings_attributes[$attribute['attribute_id']]['attribute_html']))?$settings_attributes[$attribute['attribute_id']]['attribute_html']:'';?>"/>
				  </td>
				</tr>
				<?php } ?>
			  <?php } ?>
			  </tbody>			
			</table>
		  </div>
		</form>
      </div>
    </div>
  </div>
</div>
<script>
	$(window).ready(function(){
		
		$('.select-all').click(function(){
			var critery = $(this).data('critery');

			if($(this).prop('checked')){
				$('.'+critery).prop('checked', true);
	
			}else{
				$('.'+critery).prop('checked', false);
			}
		});
		$('#submit-form-view').click(function(){
			$('.alert-info span').text('<?php echo $dae_text_wait;?>');
			$('.alert-info').removeClass('hidden');
			$('.alert-info').addClass('show');
			var url = $('#form-view').attr('action');
			$.ajax({
				url: url,
				type: "POST",
				data: $('#form-view').serialize(),
				dataType: 'json',
				success: function(json) {
					$('.alert-success').removeClass('hidden');
					$('.alert-success').addClass('show');
					$('.alert-success span').text(json.message);

					$('.alert-info').addClass('hidden');
					$('.alert-info').removeClass('show');
				}				
			});
		});
	});
</script>
<?php echo $footer; ?>