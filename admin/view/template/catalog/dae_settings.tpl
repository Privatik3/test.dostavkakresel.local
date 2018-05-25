<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="button" form="form-view" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary" id="submit-form"><i class="fa fa-save"></i></button>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $dae_lang_text_form_attr_ext; ?></h3>
      </div>
      <div class="panel-body">
        <ul class="nav nav-tabs">
			<li class="active"><a href="#tab-settings-1" data-toggle="tab"><?php echo $dae_tab_settings_1; ?></a></li>
			<li><a href="#tab-settings-2" data-toggle="tab"><?php echo $dae_tab_settings_2; ?></a></li>
			<li><a href="#tab-settings-3" data-toggle="tab"><?php echo $dae_tab_settings_3; ?></a></li>			
			<li><a href="#tab-settings-4" data-toggle="tab"><?php echo $dae_tab_settings_4; ?></a></li>	
		</ul>
		<form action="<?php echo $action_save_setting; ?>" method="post" enctype="multipart/form-data" id="form" name="form" class="form-horizontal">

			<div class="tab-content">
				<div class="tab-pane active" id="tab-settings-1">
					<h4><?php echo $dae_settings_view_in_product_tab_header; ?></h4>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_view_product_tab]"><?php echo $dae_settings_view;?></label>
						<div class="col-sm-5">
							<label class="radio-inline">
								<input type="radio"  name="settings-name[dae_view_product_tab]" value="1" <?php echo (isset($settings['dae_view_product_tab']) && $settings['dae_view_product_tab']==1)?'checked':''; ?>/><?php echo $text_yes;?>
							</label>
							<label class="radio-inline">
								<input type="radio"  name="settings-name[dae_view_product_tab]" value="0" <?php echo (empty($settings['dae_view_product_tab']))?'checked':''; ?>/><?php echo $text_no;?>
							</label>	
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_separator_view_product_tab]"><?php echo $separator_name;?></label>
						<div class="col-sm-5">
							<input type="text" name="settings-name[dae_separator_view_product_tab]" class = "form-control" value="<?php echo (isset($settings['dae_separator_view_product_tab']))?$settings['dae_separator_view_product_tab']:'; ';?>">
						</div>
					</div>	
					
					<input type="hidden" name="settings-name[dae_count_view_product_tab]" value="<?php echo (isset($settings['dae_count_view_product_tab']))?$settings['dae_count_view_product_tab']:'0';?>">
						
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_template_product_tab]"><?php echo $skin_attr_view_pr_name;?></label>
						<div class="col-sm-5">
							<textarea name="settings-name[dae_template_product_tab]" class = "form-control" rows="5"><?php echo (isset($settings['dae_template_product_tab']))?$settings['dae_template_product_tab']:'';?></textarea>
						</div>
					</div>
					<h4><?php echo $dae_settings_view_in_product_header; ?></h4>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_view_product]"><?php echo $dae_settings_view;?></label>
						<div class="col-sm-5">
							<label class="radio-inline">
								<input type="radio"  name="settings-name[dae_view_product]" value="1" <?php echo (isset($settings['dae_view_product']) && $settings['dae_view_product']==1)?'checked':''; ?>/><?php echo $text_yes;?>
							</label>
							<label class="radio-inline">
								<input type="radio"  name="settings-name[dae_view_product]" value="0" <?php echo (empty($settings['dae_view_product']))?'checked':''; ?>/><?php echo $text_no;?>
							</label>	
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_separator_view_product]"><?php echo $separator_name;?></label>
						<div class="col-sm-5">
							<input type="text" name="settings-name[dae_separator_view_product]" class = "form-control" value="<?php echo (isset($settings['dae_separator_view_product']))?$settings['dae_separator_view_product']:'; ';?>">
						</div>
					</div>	
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_count_view_product]"><?php echo $count_view_attr_pr_name;?></label>
						<div class="col-sm-5">
							<input type="text" name="settings-name[dae_count_view_product]" class = "form-control" value="<?php echo (isset($settings['dae_count_view_product']))?$settings['dae_count_view_product']:'0';?>">
						</div>
					</div>	
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_template_product]"><?php echo $skin_attr_view_pr_name;?></label>
						<div class="col-sm-5">
							<textarea name="settings-name[dae_template_product]" class = "form-control" rows="5"><?php echo (isset($settings['dae_template_product']))?$settings['dae_template_product']:'';?></textarea>
						</div>
					</div>
				</div>		
				<div class="tab-pane"  id="tab-settings-2">
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_view_catalog]"><?php echo $view_catalog_name;?></label>
						<div class="col-sm-5">
							<label class="radio-inline">
								<input type="radio"  name="settings-name[dae_view_catalog]" value="1" <?php echo (isset($settings['dae_view_catalog']) && $settings['dae_view_catalog']==1)?'checked':''; ?>/><?php echo $text_yes;?>
							</label>
							<label class="radio-inline">
								<input type="radio"  name="settings-name[dae_view_catalog]" value="0" <?php echo (empty($settings['dae_view_catalog']))?'checked':''; ?>/><?php echo $text_no;?>
							</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_separator_view_catalog]"><?php echo $separator_name;?></label>
						<div class="col-sm-5">
							<input type="text" name="settings-name[dae_separator_view_catalog]" class = "form-control" value="<?php echo (isset($settings['dae_separator_view_catalog']))?$settings['dae_separator_view_catalog']:'; ';?>">
						</div>
					</div>	
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_count_view_catalog]"><?php echo $count_view_attr_name;?></label>
						<div class="col-sm-5">
							<input type="text" name="settings-name[dae_count_view_catalog]" class = "form-control" value="<?php echo (isset($settings['dae_count_view_catalog']))?$settings['dae_count_view_catalog']:'0';?>">
						</div>
					</div>	
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_template_catalog]"><?php echo $skin_attr_view_name;?></label>
						<div class="col-sm-5">
							<textarea name="settings-name[dae_template_catalog]" class = "form-control" rows="5"><?php echo (isset($settings['dae_template_catalog']))?$settings['dae_template_catalog']:'{a_name}: {a_v}';?></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_full_template_catalog]"><?php echo $skin_a_d_view_name;?></label>
						<div class="col-sm-5">
							<textarea name="settings-name[dae_full_template_catalog]" class = "form-control" rows="5"><?php echo (isset($settings['dae_full_template_catalog']))?$settings['dae_full_template_catalog']:'{attributes}';?></textarea>
						</div>
					</div>
				</div>
				<div class="tab-pane"  id="tab-settings-3">
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_value_separator]"><?php echo $value_separator_name;?></label>
						<div class="col-sm-5">
							<input type="text" name="settings-name[dae_value_separator]" class = "form-control" value="<?php echo (isset($settings['dae_value_separator']))?$settings['dae_value_separator']:', ';?>">						
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_replace_val_att]"><?php echo $replace_val_att_name;?></label>
						<div class="col-sm-5">
							<textarea name="settings-name[dae_replace_val_att]" class = "form-control" rows="5"><?php echo (isset($settings['dae_replace_val_att']))?$settings['dae_replace_val_att']:'';?></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_skip_replace_val_att]"><?php echo $skip_replace_val_att_name;?></label>
						<div class="col-sm-5">
							<textarea name="settings-name[dae_skip_replace_val_att]" class = "form-control" rows="5"><?php echo (isset($settings['dae_skip_replace_val_att']))?$settings['dae_skip_replace_val_att']:'';?></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_att_image_h]"><?php echo $dae_att_image_name;?></label>
						<div class="col-sm-2">
								<input name="settings-name[dae_att_image_h_c]" class = "form-control" value="<?php echo (!empty($settings['dae_att_image_h_c']))?$settings['dae_att_image_h_c']:'20';?>" />
						</div>	
						<div class="col-sm-2">	
							<input name="settings-name[dae_att_image_w_c]" class = "form-control" value="<?php echo (!empty($settings['dae_att_image_w_c']))?$settings['dae_att_image_w_c']:'20';?>" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="settings-name[dae_val_image_h_c]"><?php echo $dae_val_image_name;?></label>
						<div class="col-sm-2">
							<input name="settings-name[dae_val_image_h_c]" class = "form-control" value="<?php echo (!empty($settings['dae_val_image_h_c']))?$settings['dae_val_image_h_c']:'20';?>" />
						</div>	
						<div class="col-sm-2">	
							<input name="settings-name[dae_val_image_w_c]" class = "form-control" value="<?php echo (!empty($settings['dae_val_image_w_c']))?$settings['dae_val_image_w_c']:'20';?>" />
						</div>
					</div>
				</div>
				<div class="tab-pane"  id="tab-settings-4">
					<h3><?php echo $dae_settings_box_2;?></h3>
					<div class="col-sm-12">
						<div class="form-group">
							<div class="checkbox">
								<label class="col-sm-12">
									<input type="checkbox"  name="settings-name[dae_form_view_url]" value="1" <?php echo (isset($settings['dae_form_view_url']) && $settings['dae_form_view_url']==1)?'checked':''; ?>/> <?php echo $dae_settings_view_a_v_url;?>
								</label>
							</div>				
						</div>
					</div>
					<div class="col-sm-12">
						<div class="form-group">
							<div class="checkbox">
								<label>
									<input type="checkbox"  name="settings-name[dae_form_view_description]" value="1" <?php echo (isset($settings['dae_form_view_description']) && $settings['dae_form_view_description']==1)?'checked':''; ?>/> <?php echo $dae_settings_view_a_v_desc;?>
								</label>
							</div>
						</div>
					</div> 
					<h3><?php echo $dae_settings_tab_product;?></h3>
					<div class="col-sm-12">
						<div class="form-group">
							<div class="checkbox">
								<label class="control-label" >
									<input type="checkbox"  name="settings-name[dae_auto_load_attr_for_cat]" value="1" <?php echo (isset($settings['dae_auto_load_attr_for_cat']) && $settings['dae_auto_load_attr_for_cat']==1)?'checked':''; ?>/> 
									<span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_settings_auto_load_cat_help;?>"><?php echo $dae_settings_auto_load_cat;?></span>
								</label>
							</div>
						</div>
					</div>
					<div class="col-sm-12">
						<div class="form-group">
							<div class="checkbox">
								<label class="control-label" >
									<input type="checkbox"  name="settings-name[dae_value_category]" value="1" <?php echo (isset($settings['dae_value_category']) && $settings['dae_value_category']==1)?'checked':''; ?>/> 
									<span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_settings_value_category_help;?>"><?php echo $dae_settings_value_category;?></span>
								</label>
							</div>
						</div>
					</div>
					<div class="col-sm-12">
						<div class="form-group">
          					<div class="checkbox">
            					<label class="control-label">
              						<input type="checkbox"  name="settings-name[dae_product_tab][view_button_add_attribute_group]" value="1" <?php echo (!empty($settings['dae_product_tab']['view_button_add_attribute_group']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $dae_button_add_attribute_group); ?>
            					</label>
          					</div>
        				</div>
        			</div>
					<div class="col-sm-12">
						<div class="form-group">
          					<div class="checkbox">
            					<label class="control-label">
              						<input type="checkbox"  name="settings-name[dae_product_tab][view_button_add_attribute]" value="1" <?php echo (!empty($settings['dae_product_tab']['view_button_add_attribute']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $dae_button_add_attribute); ?>
            					</label>
          					</div>
        				</div>
        			</div>
					<div class="col-sm-12">
						<div class="form-group">
          					<div class="checkbox">
            					<label class="control-label">
              						<input type="checkbox"  name="settings-name[dae_product_tab][view_button_add_attribute_category]" value="1" <?php echo (!empty($settings['dae_product_tab']['view_button_add_attribute_category']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $devos_button_add_attribute_category); ?>
            					</label>
          					</div>
        				</div>
        			</div>
					<div class="col-sm-12">
						<div class="form-group">
          					<div class="checkbox">
            					<label class="control-label">
              						<input type="checkbox"  name="settings-name[dae_product_tab][view_button_add_attribute_list]" value="1" <?php echo (!empty($settings['dae_product_tab']['view_button_add_attribute_list']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $devos_button_add_attribute_list); ?>
            					</label>
          					</div>
        				</div>
        			</div>
					<div class="col-sm-12">
						<div class="form-group">
          					<div class="checkbox">
            					<label class="control-label">
              						<input type="checkbox"  name="settings-name[dae_product_tab][view_button_clear_attribute]" value="1" <?php echo (!empty($settings['dae_product_tab']['view_button_clear_attribute']))?'checked':''; ?>/> <?php printf($dae_pt_settings_view_button, $dae_lang_button_clear_attribute); ?>
            					</label>
          					</div>
        				</div>
        			</div>
					<!--<div class="col-sm-12">
						<div class="form-group row">
							<label class="control-label col-sm-3" for="settings-name[dae_view_checkbox_in_multy]"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_view_checkbox_in_multy_help;?>"><?php echo $dae_view_checkbox_in_multy;?></span></label>
							<div class="col-sm-1">
								<input name="settings-name[dae_view_checkbox_in_multy]" class = "form-control" value="<?php echo (isset($settings['dae_view_checkbox_in_multy']))?$settings['dae_view_checkbox_in_multy']:'0';?>">
							</div>
						</div>
					</div>-->
					<h3><?php echo $dae_settings_other;?></h3>
					
					<div class="col-sm-12 hidden">
						<div class="form-group">
							<div class="checkbox">
								<label>
									<input type="checkbox"  name="settings-name[dae_use_cache]" value="0" <?php echo (isset($settings['dae_use_cache']) && $settings['dae_use_cache']==1)?'checked':''; ?>/> <?php echo $dae_settings_use_cache;?>
								</label>
							</div>
						</div>
					</div>
					<div class="col-sm-12">
						<div class="form-group">
							<div class="checkbox">
								<label>
									<input type="checkbox"  name="settings-name[dae_load_sortable]" value="1" <?php echo (isset($settings['dae_load_sortable']) && $settings['dae_load_sortable']==1)?'checked':''; ?>/> <?php echo $dae_settings_load_sortable;?>
								</label>
							</div>
						</div>
					</div>
					<div class="col-sm-12">
						<div class="form-group">
							<div class="checkbox">
								<label class="control-label" >
									<input type="checkbox"  name="settings-name[dae_view_val_attr]" value="1" <?php echo (isset($settings['dae_view_val_attr']) && $settings['dae_view_val_attr']==1)?'checked':''; ?>/> 
									<span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_settings_view_val_attr_help;?>"><?php echo $dae_settings_view_val_attr;?></span>
								</label>
							</div>
						</div>
					</div>					
					<div class="col-sm-12">
						<div class="form-group">
							<div class="checkbox">
								<label class="control-label" >
									<input type="checkbox"  name="settings-name[dae_view_attr_id]" value="1" <?php echo (isset($settings['dae_view_attr_id']) && $settings['dae_view_attr_id']==1)?'checked':''; ?>/> 
									<span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_settings_view_attr_id_help;?>"><?php echo $dae_settings_view_attr_id;?></span>
								</label>
							</div>
						</div>
					</div>
					<div class="col-sm-12">
						<div class="form-group">
							<div class="checkbox">
								<label class="control-label" >
									<input type="checkbox"  name="settings-name[dae_view_attr_v_id]" value="1" <?php echo (isset($settings['dae_view_attr_v_id']) && $settings['dae_view_attr_v_id']==1)?'checked':''; ?>/> 
									<span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_settings_view_attr_v_id_help;?>"><?php echo $dae_settings_view_attr_v_id;?></span>
								</label>
							</div>
						</div>
					</div>
					<div class="col-sm-12 hide">
						<div class="form-group">
							<div class="checkbox">
								<label class="control-label" >
									<input type="checkbox"  name="settings-name[dae_load_info_server]" value="1" <?php echo (isset($settings['dae_load_info_server']) && $settings['dae_load_info_server']==1)?'checked':''; ?>/> 
									<span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_settings_load_info_server_help;?>"><?php echo $dae_settings_load_info_server;?></span>
								</label>
							</div>
						</div>
					</div>

					<div class="col-sm-12">
						<div class="form-group row">
							<label class="control-label col-sm-3" for="settings-name[dae_count_autocomplete_attribute]"><?php echo $dae_settings_count_attribute;?></label>
							<div class="col-sm-1">
								<input name="settings-name[dae_count_autocomplete_attribute]" class = "form-control" value="<?php echo (isset($settings['dae_count_autocomplete_attribute']))?$settings['dae_count_autocomplete_attribute']:'10';?>">
							</div>

						</div>
					</div>
					<div class="col-sm-12">
						<div class="form-group row">
							<label class="control-label col-sm-3" for="settings-name[dae_count_autocomplete_attribute_value]"><?php echo $dae_settings_count_attribute_value;?></label>
							<div class="col-sm-1">
								<input name="settings-name[dae_count_autocomplete_attribute_value]" class = "form-control" value="<?php echo (isset($settings['dae_count_autocomplete_attribute_value']))?$settings['dae_count_autocomplete_attribute_value']:'10';?>">
							</div>
						</div>
					</div>
				</div>
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
		$('#submit-form').click(function(){
			$('.alert-info span').text('<?php echo $dae_text_wait;?>');
			$('.alert-info').removeClass('hidden');
			$('.alert-info').addClass('show');
			var url = $('#form').attr('action');
			$.ajax({
				url: url,
				type: "POST",
				data: $('#form').serialize(),
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