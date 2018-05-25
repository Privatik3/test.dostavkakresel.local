<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><a href="<?php echo $link_to_product_search; ?>"><?php echo $text_product_search; ?></a> | <?php echo $heading_title; ?></h1>
      <label class="control-label" for="input-search"><?php echo $entry_search; ?></label>
      <div class="row">
        <div class="col-sm-4">
          <input type="text" name="blog_search" value="<?php echo $blog_search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control" />
        </div>
        <div class="col-sm-3">
          <select name="category_id" class="form-control">
            <option value="0"><?php echo $text_category; ?></option>
            <?php foreach ($categories as $category_1) { ?>
            <?php if ($category_1['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
            <?php } ?>
            <?php foreach ($category_1['children'] as $category_2) { ?>
            <?php if ($category_2['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } ?>
            <?php foreach ($category_2['children'] as $category_3) { ?>
            <?php if ($category_3['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="col-sm-3">
          <label class="checkbox-inline">
            <?php if ($sub_category) { ?>
            <input type="checkbox" name="sub_category" value="1" checked="checked" />
            <?php } else { ?>
            <input type="checkbox" name="sub_category" value="1" />
            <?php } ?>
            <?php echo $text_sub_category; ?></label>
        </div>
      </div>
      <p>
        <label class="checkbox-inline">
          <?php if ($description) { ?>
          <input type="checkbox" name="description" value="1" id="description" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="description" value="1" id="description" />
          <?php } ?>
          <?php echo $entry_description; ?></label>
      </p>
	  <hr />
      <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn btn-primary" />
	  <hr />
      <h3 class="heading"><span><?php echo $text_search; ?></span></h3>
	  <hr />
      <?php if ($articles) { ?>
		<div class="article_list">
			<?php foreach ($articles as $article) { ?>
				<div class="image_description row">
				<div class="image col-xs-12 col-sm-12 col-md-3"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" class="img-responsive" onclick="location='<?php echo $article['href']; ?>'" /></div>
					<div style="margin:0 0 10px" class="col-xs-12 visible-xs"></div>
					<div class="col-xs-12 col-sm-12 col-md-9">
						<h4><?php echo $article['name']; ?></h4>
						<div class="description"><?php echo $article['description']; ?></div>
						<div class="row">
							<div class="col-xs-12"><hr /></div>
							<div class="col-xs-3"><a href="<?php echo $article['href']; ?>"><?php echo $text_more; ?></a></div>
							<div class="posted col-xs-9">
								<?php if($show_author) { ?><span data-toggle="tooltip" title="<?php echo $text_author; ?>"><i class="fa fa-user" aria-hidden="true"></i><?php echo $article['author']; ?></span><?php } ?>
								<?php if($show_date_added) { ?><span data-toggle="tooltip" title="<?php echo $text_date_added; ?>"><i class="fa fa-calendar" aria-hidden="true"></i><?php echo $article['date_added']; ?></span><?php } ?>
								<?php if($show_viewed) { ?><span data-toggle="tooltip" title="<?php echo $text_viewed; ?>"><i class="fa fa-eye" aria-hidden="true"></i><?php echo $article['viewed']; ?></span><?php } ?>
								<?php if ($review_status) { ?><span data-toggle="tooltip" title="<?php echo $text_review; ?>"><a href="<?php echo $article['href']; ?>#review"><i class="fa fa-comment" aria-hidden="true"></i><?php echo $article['reviews']; ?></a></span><?php } ?>
							</div>
						</div>
					</div>
				</div>
				<hr />
			<?php } ?>
		</div>
		<div class="row">
			<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
			<div class="col-sm-6 text-right"><?php echo $results; ?></div>
		</div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
$('#button-search').bind('click', function() {
  url = 'index.php?route=blog/search';

  var blog_search = $('#content input[name=\'blog_search\']').prop('value');

  if (blog_search) {
    url += '&blog_search=' + encodeURIComponent(blog_search);
  }

  var category_id = $('#content select[name=\'category_id\']').prop('value');

  if (category_id > 0) {
    url += '&category_id=' + encodeURIComponent(category_id);
  }

  var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');

  if (sub_category) {
    url += '&sub_category=true';
  }

  var filter_description = $('#content input[name=\'description\']:checked').prop('value');

  if (filter_description) {
    url += '&description=true';
  }

  location = url;
});

$('#content input[name=\'blog_search\']').bind('keydown', function(e) {
  if (e.keyCode == 13) {
    $('#button-search').trigger('click');
  }
});

$('select[name=\'category_id\']').on('change', function() {
  if (this.value == '0') {
    $('input[name=\'sub_category\']').prop('disabled', true);
  } else {
    $('input[name=\'sub_category\']').prop('disabled', false);
  }
});

$('select[name=\'category_id\']').trigger('change');
--></script>
<?php echo $footer; ?>