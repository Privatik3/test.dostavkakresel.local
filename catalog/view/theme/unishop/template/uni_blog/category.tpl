<?php echo $header; ?>
<div class="container">
	<ul class="breadcrumb <?php if (in_array('uni_blog/category', $menu_schema)) { ?>col-md-offset-4 col-lg-offset-3<?php } ?>">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<div class="row"><?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-4 col-md-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-sm-8 col-md-8 col-lg-9'; ?>
		<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<?php if (in_array('uni_blog/category', $menu_schema) && !$column_left && $column_right) { $class = 'col-sm-8 col-md-8 col-lg-6 col-md-offset-4 col-lg-offset-3'; } ?>
		<?php if (in_array('uni_blog/category', $menu_schema) && !$column_left && !$column_right) { $class = 'col-sm-8 col-md-8 col-lg-9 col-md-offset-4 col-lg-offset-3'; } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
			<h1 class="heading"><span><?php echo $heading_title; ?></span></h1>
			<?php if ($thumb || ($short_description && $short_description != '<p><br></p>')) { ?>
				<div class="category_description">
					<?php if ($thumb) { ?>
						<div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" /></div>
					<?php } ?>
					<div class="short_description"><?php echo $short_description; ?></div>
				</div>
				<hr />
			<?php } ?>
			<?php if ($categories) { ?>
				<div class="category_list row">
					<?php foreach ($categories as $category) { ?>
						<div class="col-xs-6 col-sm-6 col-md-3 col-lg-4">
							<a href="<?php echo $category['href']; ?>">
								<img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>"  class="img-responsive"/>
								<span><?php echo $category['name']; ?></span>
							</a>
						</div>
					<?php } ?>
				</div>
			<?php } ?>
			<?php if ($description && $description != '<p><br></p>') { ?>
				<div class="short_description"><?php echo $description; ?></div>
				<hr />
			<?php } ?>
			<?php if ($articles) { ?>
			<div class="article_list">
				<?php foreach ($articles as $article) { ?>
					<div class="image_description row">
					<div class="image col-xs-12 col-sm-12 col-md-3"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" class="img-responsive" onclick="location='<?php echo $article['href']; ?>'" style="cursor:pointer" /></div>
						<div style="margin:0 0 10px" class="col-xs-12 visible-xs"></div>
						<div class="col-xs-12 col-sm-12 col-md-9">
							<h4 onclick="location='<?php echo $article['href']; ?>'" style="cursor:pointer"><?php echo $article['name']; ?></h4>
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
		<?php } ?>
		<?php if (!$categories && !$articles) { ?>
			<p><?php echo $text_empty; ?></p>
			<div class="buttons">
				<div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
			</div>
		<?php } ?>
	<?php echo $content_bottom; ?></div>
<?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>