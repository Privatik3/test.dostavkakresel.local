<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-setting" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-setting" class="form-horizontal">
        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
          <li><a href="#tab-image" data-toggle="tab"><?php echo $tab_image; ?></a></li>
        </ul>
         <div class="tab-content">
            <div class="tab-pane active" id="tab-general">
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_catalog_limit; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="blog_catalog_limit" value="<?php echo $blog_catalog_limit; ?>" placeholder="<?php echo $blog_catalog_limit; ?>" id="input-name" class="form-control" />
                </div>
              </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $entry_show_author; ?></span></label>
              <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($blog_show_author) { ?>
                    <input type="radio" name="blog_show_author" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_show_author" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$blog_show_author) { ?>
                    <input type="radio" name="blog_show_author" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_show_author" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $entry_show_viewed; ?></span></label>
              <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($blog_show_viewed) { ?>
                    <input type="radio" name="blog_show_viewed" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_show_viewed" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$blog_show_viewed) { ?>
                    <input type="radio" name="blog_show_viewed" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_show_viewed" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $entry_show_date_added; ?></span></label>
              <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($blog_show_date_added) { ?>
                    <input type="radio" name="blog_show_date_added" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_show_date_added" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$blog_show_date_added) { ?>
                    <input type="radio" name="blog_show_date_added" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_show_date_added" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $entry_show_date_modified; ?></span></label>
              <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($blog_show_date_modified) { ?>
                    <input type="radio" name="blog_show_date_modified" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_show_date_modified" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$blog_show_date_modified) { ?>
                    <input type="radio" name="blog_show_date_modified" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_show_date_modified" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $entry_review; ?></span></label>
              <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($blog_review_status) { ?>
                    <input type="radio" name="blog_review_status" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_review_status" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$blog_review_status) { ?>
                    <input type="radio" name="blog_review_status" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="blog_review_status" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>            
        </div>
        <div class="tab-pane" id="tab-image">
          <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $entry_image_category; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="blog_image_category_width" value="<?php echo $blog_image_category_width; ?>" placeholder="<?php echo $entry_width; ?>" id="blog-image-category-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="blog_image_category_height" value="<?php echo $blog_image_category_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                </div>
              </div> 
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $entry_image_thumb; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="blog_image_thumb_width" value="<?php echo $blog_image_thumb_width; ?>" placeholder="<?php echo $entry_width; ?>" id="blog-image-thumb-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="blog_image_thumb_height" value="<?php echo $blog_image_thumb_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                </div>
              </div> 
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $entry_image_article; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="blog_image_article_width" value="<?php echo $blog_image_article_width; ?>" placeholder="<?php echo $entry_width; ?>" id="blog-image-article-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="blog_image_article_height" value="<?php echo $blog_image_article_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $entry_image_related; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="blog_image_related_width" value="<?php echo $blog_image_related_width; ?>" placeholder="<?php echo $entry_width; ?>" id="blog-image-related-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="blog_image_related_height" value="<?php echo $blog_image_related_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                </div>
              </div>   
              </div>         
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<?php echo $footer; ?>