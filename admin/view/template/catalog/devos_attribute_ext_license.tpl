<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<h1><?php echo $dae_lang_heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if ($success) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>		
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><?php echo $dae_lang_text_form_license; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action_license; ?>" method="post" enctype="multipart/form-data" id="form-license-update" name="form-license-update" class="form-horizontal">
			<?php if(!empty($license)){ ?>				
					<div class="col-sm-9"><p><strong><?php echo $dae_lang_license_update_help; ?></strong></p></div>					
			<?php } else { ?>				
					<div class="col-sm-9"><p><strong><?php echo $dae_lang_license_help; ?></strong></p></div>					
			<?php } ?>	
					<div class="col-sm-3">				
						<button type="submit" form="form-license" id="buttom-form-license" data-toggle="tooltip" title="<?php echo $dae_license_button_save; ?>" class="btn btn-primary" name="activate"><?php echo $dae_license_button_save; ?></button>
					</div>
				</form>
			
			</div>
		</div>
		
	</div>
</div>
<?php echo $footer; ?>