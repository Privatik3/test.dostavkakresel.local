<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-fabrickchoice" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-fabrickchoice" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="select-options"><?php echo $entry_option_select; ?></label>
            <div class="col-sm-10">
              <div id="options" class="well well-sm" style="height: 150px; overflow: auto;">
              <?php if ($options) { ?>
                <?php foreach ($options as $option) { ?>
                <div id="option-<?php echo $option['option_id']; ?>"><i class="fa fa-plus-circle"></i> <?php echo $option['name']; ?><input type="hidden" value="<?php echo $option['option_id']; ?>"></div>
                <?php } ?>
              <?php } ?>
              </div>
              <div id="fc-option" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php if ($fabrickchoice_fc_option) { ?>
                  <?php foreach ($fabrickchoice_fc_option as $option) { ?>
                    <div id="fc-option-<?php echo $option['option_id']?>"><i class="fa fa-minus-circle"></i> <?php echo $option['name']?><input type="hidden" name="fabrickchoice_fc_option[]" value="<?php echo $option['option_id']?>"></div>
                  <?php } ?>
                <?php } ?>
              </div>
            </div>
          </div>
	        <div class="form-group">
		        <label class="col-sm-2 control-label" for="input-tag"><?php echo $entry_tag; ?></label>
		        <div class="col-sm-10">
			        <input type="text" name="fabrickchoice_tag" id="input-tag" placeholder="<?php echo $entry_tag; ?>" value="<?php echo $fabrickchoice_tag; ?>" class="form-control"/>
		        </div>
	        </div>
	        <div class="form-group">
		        <label class="col-sm-2 control-label" for="input-greates"><?php echo $entry_greates; ?></label>
		        <div class="col-sm-10">
			        <select name="fabrickchoice_greates" id="input-greates" class="form-control">
				        <?php if ($fabrickchoice_greates) { ?>
					        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					        <option value="0"><?php echo $text_disabled; ?></option>
				        <?php } else { ?>
					        <option value="1"><?php echo $text_enabled; ?></option>
					        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				        <?php } ?>
			        </select>
		        </div>
	        </div>
	        <div class="form-group required">
		        <label class="col-sm-2 control-label" for="input-image-width"><?php echo $entry_image; ?></label>
		        <div class="col-sm-10">
			        <div class="row">
				        <div class="col-sm-6">
					        <input type="text" name="fabrickchoice_image_width" value="<?php echo $fabrickchoice_image_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-width" class="form-control" />
				        </div>
				        <div class="col-sm-6">
					        <input type="text" name="fabrickchoice_image_height" value="<?php echo $fabrickchoice_image_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
				        </div>
			        </div>
			        <?php if ($error_image) { ?>
				        <div class="text-danger"><?php echo $error_image; ?></div>
			        <?php } ?>
		        </div>
	        </div>
	        <div class="form-group required">
		        <label class="col-sm-2 control-label" for="input-thumb-width"><?php echo $entry_thumb; ?></label>
		        <div class="col-sm-10">
			        <div class="row">
				        <div class="col-sm-6">
					        <input type="text" name="fabrickchoice_thumb_width" value="<?php echo $fabrickchoice_thumb_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-thumb-width" class="form-control" />
				        </div>
				        <div class="col-sm-6">
					        <input type="text" name="fabrickchoice_thumb_height" value="<?php echo $fabrickchoice_thumb_width; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
				        </div>
			        </div>
			        <?php if ($error_thumb) { ?>
				        <div class="text-danger"><?php echo $error_thumb; ?></div>
			        <?php } ?>
		        </div>
	        </div>
	        <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="fabrickchoice_status" id="input-status" class="form-control">
                <?php if ($fabrickchoice_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script>
    $('#options').on('click', '.fa-plus-circle', function () {

      var value_id = $(this).siblings('input').val();
      var value_name = $(this).closest('div').text();
      var html = '<div id="fc-option-' + value_id + '"><i class="fa fa-minus-circle"></i> ' + value_name + '<input type="hidden" name="fabrickchoice_fc_option[]" value="' + value_id + '"></div>';

      $('#fc-option').append(html);
      $(this).closest('div').remove();
    });

    $('#fc-option').on('click', '.fa-minus-circle', function () {

      var option_id = $(this).siblings('input').val();
      var option_name = $(this).closest('div').text();

      var html = '<div id="option-' + option_id + '"><i class="fa fa-plus-circle"></i> ' + option_name + '<input type="hidden" value="' + option_id +'"></div>';

      $('#options').append(html);
      $(this).closest('div').remove();
    });
  </script>
</div>
<?php echo $footer; ?>