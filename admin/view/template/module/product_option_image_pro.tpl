<?php
//  Product Option Image PRO / Изображения опций PRO
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru
?>
<?php echo $header; ?><?php echo $column_left; ?>
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
    <?php if (isset($updated) && $updated) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $updated; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
		<?php if (isset($success) && $success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
		
		<?php
    
      function show_checkbox($modules, $name, $title, $help, $onclick='') {
        
        $html = '<div class="form-group">';
        $html.= '<label class="col-sm-2 control-label" for="'.$name.'" >';
        if ($help != '') {
          $html.= '<span data-toggle="tooltip" title="" data-original-title="'.$help.'">'.$title.'</span></label>';
        } else {
          $html.= ''.$title.'</label>';
        }
        $html.= '<div class="col-sm-10" >';
        $html.= '<div class="checkbox">';
        $html.= '<label><input type="checkbox" style="float: left" id="'.$name.'" name="poip_module['.$name.']" value="1" '.((isset($modules[$name]) && $modules[$name]) ? 'checked' : '').' '.($onclick!=''?' onclick="'.$onclick.'()"':'').'>';
        $html.= '</label></div>';
        $html.= '</div>';
        $html.= '</div>'."\n";
        echo $html;
      }
      
      function show_select($modules, $name, $title, $help, $values) {
        
        $html = '<div class="form-group">';
        $html.= '<label class="col-sm-2 control-label" for="'.$name.'" >';
         if ($help != '') {
          $html.= '<span data-toggle="tooltip" title="" data-original-title="'.$help.'">'.$title.'</span></label>';
        } else {
          $html.= ''.$title.'</label>';
        }
        $html.= '<div class="col-sm-10" >';
        $html.= '<select name="poip_module['.$name.']" id="'.$name.'" class="form-control">';
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
		
		<div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
				
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab-settings" data-toggle="tab"><?php echo $entry_settings; ?></a></li>
					<li><a href="#tab-import" data-toggle="tab"><?php echo $entry_import; ?></a></li>
					<li><a href="#tab-export" data-toggle="tab"><?php echo $entry_export; ?></a></li>
					<li><a href="#tab-about" data-toggle="tab" id="tab-about-button"><?php echo $entry_about; ?></a></li>
				</ul>
				
				<div class="tab-content">
					<div class="tab-pane active" id="tab-settings">
						
						<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-ro" class="form-horizontal">
				
						<?php /* <div style="margin-bottom: 30px;"><?php echo $module_description; ?></div> */ ?>
						
							<?php
								foreach ($settings_names as $setting_name) {
									
									if ( in_array('entry_'.$setting_name.'_v0', $settings_values) ) { // select
										
										$select_values = array();
										for ($i=0; $i<9; $i++) {
											if ( in_array('entry_'.$setting_name.'_v'.$i, $settings_values) ) {
												$select_values[$i] = ${"entry_".$setting_name."_v".$i};
											}
										}
										show_select($modules, $setting_name, ${'entry_'.$setting_name}, ${'entry_'.$setting_name.'_help'}, $select_values);
										
									} else { // checkbox
									
										show_checkbox($modules, $setting_name, ${'entry_'.$setting_name}, ${'entry_'.$setting_name.'_help'});
										
									}
									
								}
							?>
							
							<div class="form-group" >
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $entry_custom_theme_id_help; ?>"><?php echo $entry_custom_theme_id; ?></span></label>
								<div class="col-sm-10" >
									<input type="text" class="form-control" name="poip_module[custom_theme_id]" value="<?php if (isset($modules['custom_theme_id'])) echo $modules['custom_theme_id']; ?>">
								</div>
							</div>
				
						</form>
					</div>
				
					<div class="tab-pane form-horizontal" id="tab-import">
						<div class="form-group" ><div class="col-sm-12" ><?php echo $entry_import_description; ?></div></div>
						
						<?php if ($PHPExcelExists) { ?>
						
              <div class="form-group" >
									
                <label class="col-sm-2 control-label"></label>
                
                <div class="col-sm-10" >
                
                  <label class="radio">
                    <input type="radio" name="import_delete_before" value="0" checked><?php echo $entry_import_nothing_before; ?>
                  </label>
                  <label class="radio">
                    <input type="radio" name="import_delete_before" value="1"><?php echo $entry_import_delete_before; ?>
                  </label>
                  
                </div>	
               
              </div>
            
							<div class="form-group" style="min-height: 50px;">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-10" >
									<button type="button" id="button-upload" data-toggle="tooltip" title="" class='btn btn-primary' data-original-title="<?php echo $button_upload; ?>"><?php echo $button_upload; ?></button>
									<span class="help-block"><?php echo $button_upload_help ?></span>
								</div>
							</div>
							
							
						<?php } else { ?>
							<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $PHPExcelNotFound.$PHPExcelPath; ?></div>
						<?php } ?>
						
            <?php /*
            <div class="form-group" style="margin-top: 30px;" id="import_result"></div>
            */ ?>
						
						<div class="form-group" ><div class="col-sm-10" id="import_result_text"></div></div>
					</div>
					
					<div class="tab-pane" id="tab-export">
						
						<div style="margin-bottom: 30px;"><?php echo $entry_export_description; ?></div>
						
						<?php if ($PHPExcelExists) { ?>
							
							<form id="form_export" action="<?php echo $action_export; ?>" method="post" target="export_frame">
							</form>
						
							<div class="form-group">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-10" >
									<button type="button" id="button-export" onclick="$('#form_export').submit();" data-toggle="tooltip" title="" class='btn btn-primary' data-original-title="<?php echo $button_export; ?>"><?php echo $button_export; ?></button>
								</div>
							</div>
							
							
						<?php } else { ?>
							<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $PHPExcelNotFound.$PHPExcelPath; ?></div>
						<?php } ?>
						
						
						<iframe name="export_frame" src="" id="export_frame" style="display: none"></iframe>
							
					</div>
					
					<div class="tab-pane" id="tab-about">
							
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
				&nbsp;
				<hr >
				<span class="help-block"><?php echo sprintf($module_info, $module_version); ?><span id="module_page"><?php echo $module_page; ?></span></span><span class="help-block" style="font-size: 80%; line-height: 130%;"><?php echo $module_copyright; ?></span>
					
      </div>
    </div>
  </div>
</div>
	

<script type="text/javascript"><!--
$('#button-upload').on('click', function() {
	
	$('#form-upload').remove();
	
	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');
	
	timer = setInterval(function() {
    
    if ( !$('#form-upload input[name="file"]').length ) {
      clearInterval(timer);
      return;
    }
    
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);
      
      var form_data = new FormData($('#form-upload')[0]);
      
      form_data.append("import_delete_before", $('input:radio[name="import_delete_before"]:checked').val() );
			
			$.ajax({
				url: 'index.php?route=module/product_option_image_pro/import&token=<?php echo $token; ?>',
				type: 'post',		
				dataType: 'json',
				data: form_data,
				cache: false,
				contentType: false,
				processData: false,		
				beforeSend: function() {
					$('#button-upload').button('loading');
				},
				complete: function() {
					$('#button-upload').button('reset');
				},	
				success: function(json) {
					
          $('#import_result_text').html("<?php echo $entry_server_response; ?>: "+json);
          			
					if (json['success']) {
						alert(json['success']);
					}
        
          if (json['error']) {
            $('#import_result_text').html('Error: '+json['error']);
          } else {
            $('#import_result_text').html('<?php echo $entry_import_result; ?>: '+json['rows']+'/'+json['images']+'/'+json['skipped']);
          }
          
				},			
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
      
      $('#form-upload').remove();
      
		}
	}, 500);
});
//--></script>


<script type="text/javascript"><!--

	function check_for_updates() {
		
		$.ajax({
			url: window.location.protocol+'//update.liveopencart.com/upd.php',
			type: 'post',
			data: {module:'poip2', version:'<?php echo $module_version; ?>', lang: '<?php echo $config_admin_language; ?>'},
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