<?php echo $header; ?>
<div class="container">
	<ul class="breadcrumb <?php if (in_array('product/reviews', $menu_schema)) { ?>col-md-offset-4 col-lg-offset-3<?php } ?>">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i+1<count($breadcrumbs)) { ?><li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li><?php } else { ?><li><?php echo $breadcrumb['text']; ?></li><?php } ?>
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
		<?php if (in_array('product/reviews', $menu_schema) && !$column_left && $column_right) { $class = 'col-sm-8 col-md-8 col-lg-6 col-md-offset-4 col-lg-offset-3'; } ?>
		<?php if (in_array('product/reviews', $menu_schema) && !$column_left && !$column_right) { $class = 'col-sm-8 col-md-8 col-lg-9 col-md-offset-4 col-lg-offset-3'; } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
			<h1 class="heading"><span><?php echo $heading_title; ?></span></h1>
			<?php if ($reviews) { ?>
				<div class="row">
					<?php foreach ($reviews as $review) { ?>
						<div class="product-layout product-list col-xs-12">
							<div class="product-thumb transition">
								<div class="image"><a href="<?php echo $review['prod_href']; ?>"><img src="<?php echo $review['prod_thumb']; ?>" alt="<?php echo $review['prod_name']; ?>" title="<?php echo $review['prod_name']; ?>" class="img-responsive" /></a></div>
								<div class="caption">
									<h4><a href="<?php echo $review['prod_href']; ?>"><?php echo $review['prod_name']; ?></a></h4>
									<?php if ($review['rating']) { ?>
										<div class="rating">
											<?php for ($i = 1; $i <= 5; $i++) { ?>
												<?php if ($review['rating'] < $i) { ?>
													<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
												<?php } else { ?>
													<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
												<?php } ?>
											<?php } ?>
										</div>
									<?php } ?>
									<p class="reviews-description"><?php echo $review['description']; ?></p>
									<div class="reviews-sign">
										<div class="reviews-author"><?php echo $review['author']; ?></div>
										<div class="reviews-date"><?php echo $review['date_added']; ?></div>
									</div>
								</div>
							</div>
						</div>
					<?php } ?>
				</div>
				<div class="pagination_wrap row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
					<div class="col-sm-6 text-right"><?php echo $results; ?></div>
				</div>
			<?php } else { ?>
				<p><?php echo $text_empty; ?></p>
			<?php } ?>
			<?php echo $content_bottom; ?>
		</div>
		<?php echo $column_right; ?>
	</div>
</div>
<?php echo $footer; ?>