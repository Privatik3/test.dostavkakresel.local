<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <a onclick="$('#form').submit();" data-toggle="tooltip" title="<?php echo $lang['button_save']; ?>" class="btn btn-primary"><i class="fa fa-save"></i></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $lang['button_cancel']; ?>" class="btn btn-danger"><i class="fa fa-reply"></i></a>
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
	<div class="panel panel-default">
    <div class="panel-heading"><h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $lang['heading_title']; ?></h3></div>
    <div class="panel-body">	
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" name="uni_newsform" style="background:#fcfcfc">
        <div class="table-responsive">
		<h4 <?php if($module_id) {echo 'style="display:none;"';} ?>><b>Общие настройки новостей</b></h4>
        <table id="module" class="list" <?php echo ($module_id) ? 'style="display:none;"' : 'style="border:solid 1px #ddd"'; ?>>
			<tr>
				<td><?php echo $lang['entry_newspage_image']; ?></td>
				<td>
					<label><input type="checkbox" name="uni_news[image]" value="1" <?php echo isset($uni_news['image']) ? 'checked="checked"' : ''; ?> /><span></span></label>
				</td>
			</tr>
          <tr>
            <td>* <?php echo $lang['entry_newspage_thumb']; ?></td>
            <td class="input-group">
				<input type="text" name="uni_news[thumb_width]" value="<?php echo isset($uni_news['thumb_width']) ? $uni_news['thumb_width'] : 320; ?>" class="form-control" style="width:50px !important; text-align:center;" />
				<input type="text" name="uni_news[thumb_height]" value="<?php echo isset($uni_news['thumb_height']) ? $uni_news['thumb_height'] : 240; ?>" class="form-control" style="width:50px !important; text-align:center;" /> 
				<span>пикс.</span>
              <?php if ($error_newspage_thumb) { ?>
                <span class="error"><?php echo $lang['error_newspage_thumb']; ?></span>
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td>* <?php echo $lang['entry_newspage_popup']; ?></td>
            <td class="input-group">
              <input type="text" name="uni_news[popup_width]" value="<?php echo isset($uni_news['popup_width']) ? $uni_news['popup_width'] : 800; ?>" class="form-control" style="width:50px !important; text-align:center;" />
              <input type="text" name="uni_news[popup_height]" value="<?php echo isset($uni_news['popup_height']) ? $uni_news['popup_height'] : 600; ?>" class="form-control" style="width:50px !important; text-align:center;" />
			  <span>пикс.</span>
              <?php if ($error_newspage_popup) { ?>
                <span class="error"><?php echo $lang['error_newspage_popup']; ?></span>
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td><?php echo $lang['entry_newspage_addthis']; ?></td>
            <td>
				<label><input type="checkbox" name="uni_news[addthis]" value="1" <?php echo isset($uni_news['addthis']) ? 'checked="checked"'  : ''; ?> /><span></span></td>
          </tr>
          <tr>
            <td>* <?php echo $lang['entry_headline_chars']; ?></td>
            <td class="input-group">
				<input type="text" name="uni_news[chars]" value="<?php echo isset($uni_news['chars']) ? $uni_news['chars'] : 300; ?>" class="form-control" style="width:50px !important; text-align:center;" />
				<span>симв.</span>
				<?php if ($error_numchars) { ?><span class="error"><?php echo $lang['error_numchars']; ?></span><?php } ?>
            </td>
          </tr>
		</table>
		<br />
		<h4><b>Настройки модуля</b></h4>
		<table id="module" class="list" style="border:solid 1px #ddd">
		<tr <?php if($module_id) {echo 'style="display:none;"';} ?>>
			<td><?php echo $lang['entry_add_module']; ?></td>
			<td>
				<label><input type="checkbox" name="add_module" value="1" /><span></span></label>
			</td>
        </tr>
		<tr>
        <td>* <?php echo $lang['entry_module_name']; ?></td>
        <td><input type="text" name="name" value="<?php echo isset($name) ? $name : ''; ?>" class="form-control" /></td>
        </tr>
		<tr>
            <td>* <?php echo $lang['entry_module_customtitle']; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
			<div class="input-group">
				<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
				<input type="text" name="uni_news_module[<?php echo $language['language_id']; ?>][title]" value="<?php if(isset($uni_news_module[$language['language_id']]['title'])) {echo $uni_news_module[$language['language_id']]['title'];} ?>" placeholder="Пример: Наши новости" class="form-control" />
            </div>
			<?php } ?>
			</td>
          </tr>
          <tr>
            <td>* <?php echo $lang['entry_module_heading']; ?></td>
            <td>
				<label><input type="checkbox" name="uni_news_module[heading]" value="1" <?php echo isset($uni_news_module['heading']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
          </tr>
		<tr>
			<td>* <?php echo $lang['entry_module_limit']; ?></td>
			<td class="input-group">
				<input type="text" name="uni_news_module[limit]" value="<?php echo isset($uni_news_module['limit']) ? $uni_news_module['limit'] : 10; ?>" class="form-control" style="width:50px !important; text-align:center;" />
				<span>шт.</span>
			</td>
		</tr>
		<tr>
			<td>* <?php echo $lang['entry_module_numchars']; ?></td>
			<td class="input-group">
				<input type="text" name="uni_news_module[numchars]" value="<?php echo isset($uni_news_module['numchars']) ? $uni_news_module['numchars'] : 100; ?>" class="form-control" style="width:50px !important; text-align:center;" />
				<span>симв.</span>
			</td>
		</tr>
		<tr>
            <td>* <?php echo $lang['entry_module_thumb']; ?></td>
            <td class="input-group">
				<input type="text" name="uni_news_module[thumb_width]" value="<?php echo isset($uni_news_module['thumb_width']) ? $uni_news_module['thumb_width'] : 320; ?>" class="form-control" style="width:50px !important; text-align:center;" />
				<input type="text" name="uni_news_module[thumb_height]" value="<?php echo isset($uni_news_module['thumb_height']) ? $uni_news_module['thumb_height'] : 240; ?>" class="form-control" style="width:50px !important; text-align:center;" />
				<span>пикс.</span>
				<?php if ($error_newspage_thumb) { ?>
					<span class="error"><?php echo $error_newspage_thumb; ?></span>
				<?php } ?>
            </td>
          </tr>
		<tr>
            <td><b><?php echo $lang['entry_module_status']; ?></b></td>
            <td>
				<select name="status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $lang['text_enabled']; ?></option>
                <option value="0"><?php echo $lang['text_disabled']; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $lang['text_enabled']; ?></option>
                <option value="0" selected="selected"><?php echo $lang['text_disabled']; ?></option>
                <?php } ?>
              </select>
            </td>
          </tr>
        </table>
		</div>
      </form>
    </div>
	
	
	
	
	
</div>
</div>
</div>
</div>
<?php echo $footer; ?>