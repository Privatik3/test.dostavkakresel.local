<?php echo $header; ?>
<div class="container">
	<ul class="breadcrumb <?php if (in_array('product/gallery', $menu_schema)) { ?>col-md-offset-4 col-lg-offset-3<?php } ?>">
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
		<?php if (in_array('product/gallery', $menu_schema) && !$column_left && $column_right) { $class = 'col-sm-8 col-md-8 col-lg-6 col-md-offset-4 col-lg-offset-3'; } ?>
		<?php if (in_array('product/gallery', $menu_schema) && !$column_left && !$column_right) { $class = 'col-sm-8 col-md-8 col-lg-9 col-md-offset-4 col-lg-offset-3'; } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
			<!-- <h1 class="heading"><span><?php echo $heading_title; ?></span></h1> -->
			<div id="gallery">
				<?php if (isset($gallerys)) { ?>
					<?php foreach ($gallerys as $key => $gallery) { ?>
						<h3 class="heading"><span><?php echo $gallery['name']; ?></span></h3>
						<div class="gallery_wrapper">
							<div class="gallery gallery_<?php echo $key; ?>">
								<?php foreach ($gallery['images'] as $key => $images) { ?>
									<div>
										<div class="image">
											<a href="<?php echo $images['popup']; ?>" title="<?php echo $images['title']; ?>" data-caption="<?php echo $images['title']; ?>" class="img_popup" >
												<img src="<?php echo $images['image']; ?>" alt="<?php echo $images['title']; ?>" title="<?php echo $images['title']; ?>" class="img-responsive" />
											</a>
											<?php if ($images['title']) { ?>
												<?php if ($images['link']) { ?>
													<div class="name"><a href="<?php echo $images['link']; ?>"><?php echo $images['title']; ?></a></div>
												<?php } else { ?>
													<div class="name"><?php echo $images['title']; ?></div>
												<?php } ?>
											<?php } ?>
										</div>
									</div>
								<?php } ?>
							</div>
						</div>
					<?php } ?>
				<?php } ?>
			</div>
			<?php echo $content_bottom; ?>
		</div>
		<?php echo $column_right; ?>
	</div>
</div>
<script type="text/javascript">
	$('.gallery').owlCarousel({
		responsiveBaseWidth: '.gallery',
		navigation: true,
		slideSpeed: 200,
		paginationSpeed: 300,
		autoPlay: false,
		stopOnHover: true,
		touchDrag: true,
		mouseDrag: false,
		navigationText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>'],
		pagination: false,
	});
<?php foreach ($gallerys as $key => $gallery) { ?>
	$('.gallery_<?php echo $key; ?>').magnificPopup({
		type:'image',
		delegate: 'a.img_popup',
		gallery: {
			enabled:true
		}
	});
<?php } ?>
</script>
<?php echo $footer; ?>