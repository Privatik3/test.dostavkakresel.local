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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $dae_lang_auto_load_m; ?></h3>
      </div>
      <div class="panel-body">
		<form action="<?php echo $action_generate_value; ?>" method="post" enctype="multipart/form-data" id="form" name="form" class="form-horizontal">
		  <div class="col-sm-9">
		  	<?php echo $dae_tab_attribute_value_generate_description;?>
		  </div>
		  <div class="col-sm-3">
		  	<button type="button" id="attribute-value-generate" class="btn btn-primary"><?php echo $dae_button_attribute_value_generate;?></button>
		  </div>
		  <div class="col-sm-12">
		  	<span id="generate-status"></span>				
		  </div>
		</form>
      </div>
    </div>
  </div>
</div>
<script>
	$(window).ready(function(){
		var url = $('#form').attr('action');
		$('#attribute-value-generate').click(function(){
			$('.alert-info span').text('<?php echo $dae_text_wait;?>');
			$('.alert-info').removeClass('hidden');
			$('.alert-info').addClass('show');
			$.ajax({
				url: url,
				dataType: 'json',			
				success: function(json) {
					
					var text='';

					$('.alert-success').removeClass('hidden');
					$('.alert-success').addClass('show');
					$('.alert-success span').text(json.message);

					$('.alert-info').addClass('hidden');
					$('.alert-info').removeClass('show');

					var length = json.data.length;
					if(length ==0)
						text = '<p><strong>' + json.message + '</strong></p>';
					for (var i = 0; i < length; i++) {						
					  text += '<div class="col-md-2">' + json.data[i].name + ': ' + json.data[i].count + '</div>';
					  // Do something with element i.
					}
					/*$.map(json, function(item) {
						text = item['message'];
						
					});*/
					$('span#generate-status').html(text);
				}
			});
		});
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