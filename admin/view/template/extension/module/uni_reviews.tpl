<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="uni_reviews" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="uni_reviews" class="form-horizontal">
		<table id="module" style="background:#fcfcfc; border:solid 1px #ddd">
			<tr>
				<td><?php echo $entry_name; ?></td>
				<td>
					<input type="text" name="name" value="<?php echo (isset($name) ? $name : '') ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
					<?php if ($error_name) { ?><div class="text-danger"><?php echo $error_name; ?></div><?php } ?>
				</td>
			</tr>
				<td><?php echo $entry_order_type; ?></td>
				<td>
					<select name="uni_reviews[order_type]" id="input-order-type" class="form-control">
						<option value="last" <?php echo(isset($uni_reviews['order_type']) && $uni_reviews['order_type'] === 'last' ? 'selected' : '') ?> ><?php echo $text_order_last; ?></option>
						<option value="random" <?php echo(isset($uni_reviews['order_type']) && $uni_reviews['order_type'] === 'random' ? 'selected' : '') ?> ><?php echo $text_order_random; ?></option>
					</select>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_header; ?></td>
				<td>
					<?php foreach ($languages as $language) { ?>
						<div class="input-group">
							<?php if(VERSION >= 2.2) { ?>
								<span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
							<?php } else { ?>
								<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
							<?php } ?>
							<input type="text" name="uni_reviews[module_header][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($uni_reviews['module_header'][$language['language_id']]) ? $uni_reviews['module_header'][$language['language_id']] : ''); ?>" placeholder="<?php echo $entry_header; ?>" id="input-header" class="form-control" />
						</div>
		                <?php if (isset($error_header[$language['language_id']]) && $error_header[$language['language_id']]) { ?><div class="text-danger"><?php echo $error_header[$language['language_id']]; ?></div><?php } ?>
					<?php } ?>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_limit; ?></td>
				<td>
					<input type="text" name="uni_reviews[limit]" value="<?php echo isset($uni_reviews['limit']) ? $uni_reviews['limit'] : 10; ?>" class="form-control" />
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_text_limit; ?></td>
	            <td>
					<input type="text" name="uni_reviews[text_limit]" value="<?php echo isset($uni_reviews['text_limit']) ? $uni_reviews['text_limit'] : 100; ?>" class="form-control" />
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_category_sensitive; ?></td>
				<td>
					<label><input type="checkbox" name="uni_reviews[category_sensitive]" value="1" <?php echo isset($uni_reviews['category_sensitive']) ? 'checked' : ''; ?> /><span></span></label>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_show_all_button; ?></td>
				<td>
					<label><input type="checkbox" name="uni_reviews[show_all_button]" value="1" <?php echo isset($uni_reviews['show_all_button']) ? 'checked' : ''; ?> /><span></span></label>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_show_all_button_link; ?></td>
				<td>
					<label><input type="checkbox" name="uni_reviews[show_all_button_link]" value="1" <?php echo isset($uni_reviews['show_all_button_link']) ? 'checked' : ''; ?> /><span></span></label>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_status; ?></td>
				<td>
				<select name="status" id="input-status" class="form-control">
					<?php if ($status) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				</select>
				</td>
			</tr>
          </table>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>