<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-review" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1><br />
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-review" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-type"><?php echo $entry_type; ?></label>
            <div class="col-sm-10">
              <input type="text" name="type" value="<?php echo $type; ?>" placeholder="<?php echo $entry_type; ?>" id="input-type" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></span></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
            </div>
          </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-phone"><?php echo $entry_phone; ?></span></label>
            <div class="col-sm-10">
              <input type="text" name="phone" value="<?php echo $phone; ?>" placeholder="<?php echo $entry_phone; ?>" id="input-phone" class="form-control" />
            </div>
          </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-mail"><?php echo $entry_mail; ?></span></label>
            <div class="col-sm-10">
              <input type="text" name="mail" value="<?php echo $mail; ?>" placeholder="<?php echo $entry_mail; ?>" id="input-mail" class="form-control" />
            </div>
          </div>
		  <?php if($product_name && $product_href) { ?>
		   <div class="form-group">
            <label class="col-sm-2 control-label" for="input-mail"><?php echo $entry_product; ?></span></label>
            <div class="col-sm-10">
              <a href="<?php echo $product_href; ?>" style="display:inline-block;height:26px;margin-top:9px;text-decoration:underline" target="_blank"><?php echo $product_name; ?> <i class="fa fa-clone" aria-hidden="true"></i></a>
            </div>
          </div>
		  <?php } ?>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-comment"><?php echo $entry_comment; ?></label>
            <div class="col-sm-10">
              <textarea name="comment" cols="60" rows="8" placeholder="<?php echo $entry_comment; ?>" id="input-comment" class="form-control"><?php echo $comment; ?></textarea>
            </div>
          </div>
		   <div class="form-group">
            <label class="col-sm-2 control-label" for="input-admin_comment"><?php echo $entry_admin_comment; ?></label>
            <div class="col-sm-10">
              <textarea name="admin_comment" cols="60" rows="8" placeholder="<?php echo $entry_admin_comment; ?>" id="input-admin_comment" class="form-control"><?php echo $admin_comment; ?></textarea>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
				<select name="status" id="input-status" class="form-control">
					<option value="1" <?php if ($status == 1) { ?>selected="selected"<?php } ?>><?php echo $text_status_1; ?></option>
					<option value="2" <?php if ($status == 2) { ?>selected="selected"<?php } ?>><?php echo $text_status_2; ?></option>
					<option value="3" <?php if ($status == 3) { ?>selected="selected"<?php } ?>><?php echo $text_status_3; ?></option>
				</select>
            </div>
          </div>
		  <input type="hidden" name="date_added" value="<?php echo $date_added; ?>" />
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>