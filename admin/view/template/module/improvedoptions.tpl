<?php

//  Improved options / Расширенные опции
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

?>
<?php echo $header; ?><?php echo $column_left; ?>

<?php

	function show_checkbox($name, $data) {
		
		$current_entry = $data['entry_'.$name];
		$current_settings = $data['modules'];
		
		
		echo '<div class="form-group">';
		echo '<label class="col-sm-2 control-label" for="'.$name.'">'.$current_entry.'</label>';
		echo '<div class="col-sm-10">';
		echo '<div class="checkbox">';
		echo '<label>';
		echo '<input type="checkbox" id="'.$name.'" name="improvedoptions_settings['.$name.']" '.(isset($current_settings[$name]) && $current_settings[$name] ? 'checked' : '').'>';
		echo '</label>';
		echo '</div>';
		echo '</div>';
		echo '</div>';
		
	}
	
	function show_select($name, $data) {
		
		$current_entry = $data['entry_'.$name];
		$help = '';
		if (isset($data['entry_'.$name.'_help'])) {
			$help =	isset($data['entry_'.$name.'_help']);
		}
		$modules = $data['modules'];
		
		$values = array();
		$value_cnt = 0;
		while ( isset($data['entry_'.$name.'_'.$value_cnt]) ) {
			$values[$value_cnt] = $data['entry_'.$name.'_'.$value_cnt];
			$value_cnt++;
		}
		
		
		$html = '<div class="form-group">';
		$html.= '<label class="col-sm-2 control-label" for="'.$name.'" >';
		 if ($help != '') {
			$html.= '<span data-toggle="tooltip" title="" data-original-title="'.$help.'">'.$current_entry.'</span></label>';
		} else {
			$html.= ''.$current_entry.'</label>';
		}
		$html.= '<div class="col-sm-10" >';
		$html.= '<select name="improvedoptions_settings['.$name.']" id="'.$name.'" class="form-control">';
		$vals_cnt = 0;
		foreach ($values as $val=>$text) {
			$selected = ($vals_cnt==0 && !isset($modules[$name])) || (isset($modules[$name]) && $modules[$name]==$val);
			$html.= '<option value="'.$val.'" '.($selected?'selected':'').'>'.$text.'</option>';
			$vals_cnt++;
		}
		
		$html.= '</select>';
		$html.= '</div>';
		$html.= '</div>'."\n";
		echo $html;
	}

?>


<div id="content">
	
	<div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-liveprice" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $module_name; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
	<div class="container-fluid">
    <?php if (isset($error_warning) && $error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
		
		<?php if (isset($success) && $success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
		<div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
				
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab-settings" data-toggle="tab"><?php echo $entry_settings; ?></a></li>
					<li><a href="#tab-about" data-toggle="tab" id="tab-about-button"><?php echo $entry_about; ?></a></li>
				</ul>
				
				<div class="tab-content">
          <div class="tab-pane active" id="tab-settings" style="min-height: 300px;">
				
				
				
						<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-liveprice" class="form-horizontal">
						
							<fieldset>
								<legend>
									<?php echo $entry_additional_fields; ?>
								</legend>
								
							<?php
							
								// $data before oc2.2 ; $this->data - from oc2.2)
								show_select('sku_for_options', (!empty($data) ? $data : $this->data) );
								show_select('model_for_options', (!empty($data) ? $data : $this->data) );
								show_select('upc_for_options', (!empty($data) ? $data : $this->data) );
								show_select('reward_for_options', (!empty($data) ? $data : $this->data) );
								show_checkbox('description_for_options', (!empty($data) ? $data : $this->data) );
							
							?>
							
							</fieldset>
							
							<div class="form-group"></div>
							
							<fieldset>
								<legend>
									<?php echo $entry_additional_features; ?>
								</legend>
								
							<?php
							
								show_select('auto_selection', (!empty($data) ? $data : $this->data) );
								//show_checkbox('step_by_step', $data);
								
							
							?>
							
							</fieldset>
						
						<?php /*
							<div class="form-group">
								<label class="col-sm-2 control-label" for="sku_for_options"><?php echo $entry_sku_for_options; ?></label>
								<div class="col-sm-10">
									<input type="checkbox" id="sku_for_options" name="inprovedoptions_settings[sku_for_options]">
									<!--
									<select id="discount_quantity" name="improvedoptions_settings[discount_quantity]" class="form-control">
										<option value="0" <?php if ($liveprice_settings['discount_quantity']==0) echo "selected"; ?> ><?php echo $text_discount_quantity_0; ?></option>
										<option value="1" <?php if ($liveprice_settings['discount_quantity']==1) echo "selected"; ?> ><?php echo $text_discount_quantity_1; ?></option>
										<option value="2" <?php if ($liveprice_settings['discount_quantity']==2) echo "selected"; ?> ><?php echo $text_discount_quantity_2; ?></option>
									</select>
								
									
									<span class="help-block" style="display: none;" id="text_relatedoptions_notify"><?php echo $text_relatedoptions_notify; ?></span>
									-->
								
								</div>
							</div>
							
						*/ ?>  
							
						</form>
					</div>
					
					<div class="tab-pane" id="tab-about" style="min-height: 300px;">	
						
						<div id="module_description">
							<?php echo $module_description; ?>
						</div>
						<hr>
						<?php echo $text_conversation; ?>
						<hr>
						<br>
						<h4><?php echo $entry_we_recommend; ?></h4><br>
						<div id="we_recommend">
							<?php echo $text_we_recommend; ?>
						</div>	
							
					</div>
					
				</div>			
						
				<hr>
				<span class="help-block"><?php echo sprintf($module_info, $module_version); ?><span id="module_page"><?php echo $module_page; ?></span><span class="help-block" style="font-size: 80%; line-height: 130%;"><?php echo $module_copyright; ?></span>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript"><!--

	function check_for_updates() {
		
		$.ajax({
			url: window.location.protocol+'//update.liveopencart.com/upd.php',
			type: 'post',
			data: {module:'io2', version:'<?php echo $module_version; ?>', lang: '<?php echo $config_admin_language; ?>'},
			dataType: 'json',
	
			success: function(data) {
				
				if (data) {
					
					if (data['recommend']) {
						$('#we_recommend').html(data['recommend']);
					}
					if (data['update']) {
						$('#tab-about-button').append('&nbsp;&nbsp;<font style="color:red;font-weight:normal;"><?php echo addslashes($text_update_alert); ?></font>');
						$('#module_description').after('<hr><div class="alert alert-info" role="alert">'+data['update']+'</div>');
					}
					if (data['product_pages']) {
						$('#module_page').html(data['product_pages']);
					}
				}
			}
		});
		
	}

	check_for_updates();

//--></script>


<?php echo $footer; ?>