<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <a onclick="$('#form_2').submit();" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></a>
		<a href="<?php echo $cancel_mod; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-primary"><i class="fa fa-reply"></i></a>
	  </div>
      <h1><?php echo $lang['heading_title']; ?></h1>
	  <div></div>
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
    <div class="panel-heading"><h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $lang['heading_title']; ?></h3></div>
    <div class="panel-body">		
    <div class="buttons" style="text-align:right;margin:0 0 5px;">
		<a href="<?php echo $insert; ?>" data-toggle="tooltip" title="<?php echo $lang['button_add']; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
		<a onclick="$('#form').submit();" data-toggle="tooltip" class="btn btn-danger" title="<?php echo $lang['button_remove']; ?>"><i class="fa fa-trash-o"></i></a>
	</div>
    <div class="content"  <?php if($module_id) { echo 'style="display:none"'; } ?>>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="table-responsive">
        <table class="table table-bordered table-hover module-list">
          <thead>
            <tr>
            <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
            <td class="left">
			<?php if ($sort == 'id.title') { ?>
				<a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?></a>
            <?php } else { ?>
                <a href="<?php echo $sort_title; ?>"><?php echo $lang['entry_link_text']; ?></a>
            <?php } ?>
			</td> 
            <td class="left">
			<?php if ($sort == 'i.sort_order') { ?>
                <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_link; ?></a>
            <?php } else { ?>
                <a href="<?php echo $sort_sort_order; ?>"><?php echo $lang['entry_link_url']; ?></a>
            <?php } ?>
			</td>
			<td class="left">
			<?php if ($sort == 'id.title') { ?>
                <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
            <?php } else { ?>
                <a href="<?php echo $sort_title; ?>"><?php echo $lang['entry_link_order']; ?></a>
            <?php } ?>
			</td>
			<td class="right"><?php echo $text_status; ?></td>
            <td class="right"><?php echo $lang['entry_link_action']; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($uni_custom_menus) { ?>
            <?php foreach ($uni_custom_menus as $uni_custom_menu) { ?>
            <tr>
            <td style="text-align: center;">
			<?php if ($uni_custom_menu['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $uni_custom_menu['menu_id']; ?>" checked="checked" />
            <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $uni_custom_menu['menu_id']; ?>" />
            <?php } ?>
			</td>
            <td class="left"><?php echo $uni_custom_menu['name']; ?></td>
            <td class="left"><?php echo $uni_custom_menu['link']; ?></td>
            <td class="right"><?php echo $uni_custom_menu['sort_order']; ?></td>
			<td class="right"><?php if($uni_custom_menu['status']) { ?><?php echo $text_enabled; ?><?php } else { ?><?php echo $text_disabled; ?><?php } ?></td>
            <td class="right">
			<?php foreach ($uni_custom_menu['action'] as $action) { ?>
                <a href="<?php echo $action['href']; ?>"data-toggle="tooltip" title="<?php echo $lang['button_edit']; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
            <?php } ?>
			</td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="6"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
	</div>
    </form>
    <div class="pagination"><?php echo $pagination; ?></div>
    </div>
	
	<div class="tab-content">
    <form action="<?php echo $action_mod; ?>" method="post" enctype="multipart/form-data" id="form_2">
        <div class="table-responsive">
        <table class="table table-bordered table-hover module-list">
			<thead>
            <tr>
				<td class="left"><?php echo $lang['entry_module_name']; ?></td>
				<td class="left"><?php echo $lang['entry_module_heading']; ?></td>
				<td class="left"><?php echo $lang['entry_module_items']; ?></td>
            </tr>
			</thead>
			<tbody>
            <tr>
			<td><input type="text" name="name" value="<?php if(isset($name)) { echo $name; } ?>" class="form-control" /></td>
			<td class="left">
			<?php foreach ($languages as $language) { ?>
			<div class="input-group">
			<span class="input-group-addon">
			<?php if(VERSION >= 2.2) { ?>
					<img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" />
				<?php } else { ?>
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
				<?php } ?>
			</span>
			<input type="text" name="uni_custom_menu_module[<?php echo $language['language_id']; ?>][head]" value="<?php if(isset($uni_custom_menu_module[$language['language_id']]['head'])) { echo $uni_custom_menu_module[$language['language_id']]['head']; } ?>" class="form-control" />
			</div>
			<?php } ?>
			</td>
			<td>
			<div class="well well-sm" style="min-width:150px; height:100px; overflow: auto;">
			<?php if ($uni_custom_menus1) { ?>
				<?php foreach ($uni_custom_menus1 as $uni_custom_menu) { ?>
					<div>
				<?php if(isset($uni_custom_menu_module['in_module'])) {$in_module = $uni_custom_menu_module['in_module'];} else {$in_module = array();} ?>
				<?php if (in_array($uni_custom_menu['menu_id'], $in_module)) { ?>
					<input type="checkbox" name="uni_custom_menu_module[in_module][]" value="<?php echo $uni_custom_menu['menu_id']; ?>" id="<?php echo $uni_custom_menu['menu_id']; ?>" checked="checked" />
					<label for="<?php echo $uni_custom_menu['menu_id']; ?>"><?php echo $uni_custom_menu['name']; ?></label>
				<?php } else { ?>
					<input type="checkbox" name="uni_custom_menu_module[in_module][]" value="<?php echo $uni_custom_menu['menu_id']; ?>" id="<?php echo $uni_custom_menu['menu_id']; ?>" />
					<label for="<?php echo $uni_custom_menu['menu_id']; ?>"><?php echo $uni_custom_menu['name']; ?></label>	
				<?php } ?>	
					</div>
				<?php } ?>		
			<?php } ?>	
			</div>
			<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a><div style="height:10px;"></div>
			</td>
            </tr>
          </tbody>
        </table>
        <table class="table table-bordered table-hover module-list">
			<tr>
            <td><b><?php echo $lang['entry_status']; ?></b></td>
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
	</div>
	<input type="hidden" name="uni_custom_menu_module[style]" value="0" />
    </form>
    </div>
	</div>
	</div>
	<div class="copyright"></div>
  </div>
</div>
<style>
	.tab-content .buttons {margin:-5px 0 10px; text-align:right; }
	.list .left img + input{ display:inline-block !important; float:right !important; margin-top:-16px; margin-left:22px;}
	.scrollbox {padding: 4px 0 0;}
	table tr:nth-child(2n) {background: #f4f4f4;}
	table tr + tr {border-top:solid 1px #ddd;}
	table tr td {padding:7px 10px 4px}
	1table img {display:block;float:left;border:solid 1px #aaa;border-right:none;background:#ddd;padding:6px 4px;border-radius: 2px 0 0 2px}
	1table input[type='text'], table textarea {display:block;float:left;width:150px !important; padding:2px 5px}
</style>
<?php echo $footer; ?>