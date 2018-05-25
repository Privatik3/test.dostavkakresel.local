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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $dae_service_header; ?></h3>
      </div>
      <div class="panel-body">
		<table class="table">
			<tbody>
				<tr>
		  			<td>
		  				<label class="col-sm-6 control-label"><?php echo $dae_service_error_module;?><span data-toggle="tooltip" data-original-title="<?php echo $dae_service_error_module_help;?>"></span></label>
		  			</td>
		  			<td id="result_error_module">
					  	<?php if($service_error_module_result == 0){ ?>
					  		<span class="label label-success"><?php echo $dae_service_status_ok;?></span>
					  	<?php }else{ ?>
					  		<span class="label label-danger"><?php echo $dae_service_status_error;?>: <?php echo $service_error_module_result;?></span>
					  	<?php } ?>
					</td>
		  			<td>
		  				<?php if($service_error_module_result > 0){ ?>
							<button type="button" class="btn btn-primary" id="run_error_module"><?php echo $dae_service_run;?></button>
						<?php } ?>
		  			</td>
				</tr>
				<tr>
		  			<td>
		  				<label class="col-sm-6 control-label"><?php echo $dae_service_remove_attribute;?><span data-toggle="tooltip" data-original-title="<?php echo $dae_service_remove_attribute_help;?>"></span></label>
		  			</td>
		  			<td id="result_remove_attribute">
					  	<?php if($service_remove_attribute_result == 0){ ?>
					  		<span class="label label-success"><?php echo $dae_service_status_ok;?></span>
					  	<?php }else{ ?>
					  		<span class="label label-danger"><?php echo $dae_service_status_error;?>: <?php echo $service_remove_attribute_result;?></span>
					  	<?php } ?>
					</td>
		  			<td>
		  				<?php if($service_remove_attribute_result > 0){ ?>
							<button type="button" class="btn btn-primary" id="run_remove_attribute"><?php echo $dae_service_run;?></button>
						<?php } ?>
		  			</td>
				</tr>
				<tr>
		  			<td>
		  				<label class="col-sm-6 control-label"><?php echo $dae_service_empty_value;?><span data-toggle="tooltip" data-original-title="<?php echo $dae_service_empty_value_help;?>"></span></label>
		  			</td>
		  			<td id="result_empty_value">
		  				<?php $flag_error = false; ?>
		  				<?php foreach($languages as $key => $language){ ?>
					  		<?php if(!isset($service_empty_value_result[$language['language_id']]) || $service_empty_value_result[$language['language_id']]  == 0){ ?>
					  			<?php echo $language['name'];?> <span class="label label-success"><?php echo $dae_service_status_ok;?></span><br>
					  		<?php }else{ ?>
					  			<?php $flag_error = true; ?>
					  			<?php echo $language['name'];?> <span class="label label-danger"><?php echo $dae_service_status_error;?>: <?php echo $service_empty_value_result[$language['language_id']];?></span><br>
					  		<?php } ?>
					  	<?php } ?>
					</td>
		  			<td>
		  				<?php if($flag_error){ ?>
							<button type="button" class="btn btn-primary" id="remove_empty_value"><?php echo $dae_service_remove_empty_value;?></button>
							<a href="/admin/index.php?route=catalog/devos_attribute_ext/getProductEmptyValueAttribute&token=<?php echo $token;?>" class="btn btn-primary" ><?php echo $dae_service_more_empty_value;?></a>
						<?php } ?>
		  			</td>
				</tr>
			</tbody>
		</table>
      </div>
    </div>
  </div>
</div>
<script>
	var token = '<?php echo $token;?>';
	$(window).ready(function(){
		//удаление ошибочных данных в модуле
		$('#run_error_module').click(function(){
			$('#result_error_module').html('<?php echo $dae_text_wait;?>');
			$.ajax({
				url: '/admin/index.php?route=catalog/devos_attribute_ext/runServices&token='+token,
				type: "POST",
				data: {'action':'deleteErrorInModule'},
				dataType: 'json',
				success: function(json) {
					if(json.error == 1)
						$('#result_error_module').html('<span class="label label-danger"><?php echo $dae_service_status_error;?>: '+json.result+'</span>');
					else
						$('#result_error_module').html('<span class="label label-success"><?php echo $dae_service_status_ok;?></span>');
					  		
				}				
			});
		});
		//очистка product_attribute от удаленных атрибутов
		$('#run_remove_attribute').click(function(){
			$('#result_remove_attribute').html('<?php echo $dae_text_wait;?>');
			$.ajax({
				url: '/admin/index.php?route=catalog/devos_attribute_ext/runServices&token='+token,
				type: "POST",
				data: {'action':'deleteErrorAttribute'},
				dataType: 'json',
				success: function(json) {
					if(json.error == 1)
						$('#result_remove_attribute').html('<span class="label label-danger"><?php echo $dae_service_status_error;?>: '+json.result+'</span>');
					else
						$('#result_remove_attribute').html('<span class="label label-success"><?php echo $dae_service_status_ok;?></span>');
					  		
				}				
			});
		});
		//очистка product_attribute от атрибутов с пустыми значениями
		$('#remove_empty_value').click(function(){
			if(confirm("<?php echo $dae_service_confirm_remove_empty_value;?>")){
			$('#result_empty_value').html('<?php echo $dae_text_wait;?>');
				$.ajax({
					url: '/admin/index.php?route=catalog/devos_attribute_ext/runServices&token='+token,
					type: "POST",
					data: {'action':'removeEmptyValue'},
					dataType: 'json',
					success: function(json) {
						var html = '';
						<?php foreach($languages as $key => $language){ ?>
					  		if(!(<?php echo $language['language_id'];?> in json.result) || json.result[<?php echo $language['language_id'];?>] == 0){ 
					  			html += '<?php echo $language['name'];?> <span class="label label-success"><?php echo $dae_service_status_ok;?></span><br>';
					  		}else{
					  			html += '<?php echo $language['name'];?> <span class="label label-danger"><?php echo $dae_service_status_error;?>: '+json.result[<?php echo $language['language_id'];?>]+'</span><br>';
					  		}
						<?php } ?>
						$('#result_empty_value').html(html);
					}				
				});
			}
		});
	});
</script>
<?php echo $footer; ?>