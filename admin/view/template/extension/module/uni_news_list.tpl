<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <a href="<?php echo $insert; ?>" data-toggle="tooltip" title="<?php echo $button_insert; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
		<button onclick="$('#form').submit();" type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></button>
		<a href="<?php echo $module; ?>" data-toggle="tooltip" title="<?php echo $button_module; ?>" class="btn btn-primary"><i class="fa fa-cog"></i></a>
	  </div>
      <h1><?php echo $heading_title; ?></h1>
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
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
	  
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form" name="newslist">
        <div class="table-responsive">
        <table class="table table-bordered table-hover">
          <thead>
            <tr>
              <td width="1" align="center"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="center"><?php echo $column_image; ?></td>
              <td class="left"><?php if ($sort == 'nd.title') { ?>
                <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?> (<?php echo $totalnews; ?>)</a>
              <?php } else { ?>
                <a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?> (<?php echo $totalnews; ?>)</a>
              <?php } ?></td>
              <td class="left"><?php if ($sort == 'n.date_added') { ?>
                <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
              <?php } else { ?>
                <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
              <?php } ?></td>
              <td class="left"><?php if ($sort == 'n.viewed') { ?>
                <a href="<?php echo $sort_viewed; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_viewed; ?>
              <?php } else { ?>
                <a href="<?php echo $sort_viewed; ?>"><?php echo $column_viewed; ?></a>
              <?php } ?></td>
              <td class="left"><?php if ($sort == 'n.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?>
              <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
              <?php } ?></td>
              <td class="center"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
          <?php if ($news) { ?>
            <?php $class = 'odd'; ?>
            <?php foreach ($news as $news_story) { ?>
              <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
              <tr class="<?php echo $class; ?>">
                <td align="center">
                  <?php if ($news_story['selected']) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $news_story['news_id']; ?>" checked="checked" />
                  <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $news_story['news_id']; ?>" />
                  <?php } ?>
                </td>
                <td class="center"><img src="<?php echo $news_story['image']; ?>" alt="<?php echo $news_story['title']; ?>" style="padding:1px; border:1px solid #DCDCDC;" /></td>
                <td class="left"><?php echo $news_story['title']; ?></td>
                <td class="left"><?php echo $news_story['date_added']; ?></td>
                <td class="left"><?php echo $news_story['viewed']; ?></td>
                <td class="left"><?php echo $news_story['status']; ?></td>
                <td class="center">
                  <?php foreach ($news_story['action'] as $action) { ?>
                    <a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
                  <?php } ?>
                </td>
              </tr>
            <?php } ?>
          <?php } else { ?>
            <tr class="even">
              <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
            </tr>
          <?php } ?>
          </tbody>
        </table>
		</div>
      </form>
	  <div class="pagination"><?php echo $pagination; ?></div>
	  </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>