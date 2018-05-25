<?php echo $header; ?>
<div class="container">
	<?php $menu_schema = isset($menu_schema) ? $menu_schema : array(); ?>
	<ul class="breadcrumb <?php if (in_array('information/information', $menu_schema)) { ?>col-md-offset-4 col-lg-offset-3<?php } ?>">
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
		<?php if (in_array('information/information', $menu_schema) && !$column_left && $column_right) { $class = 'col-sm-8 col-md-8 col-lg-6 col-md-offset-4 col-lg-offset-3'; } ?>
		<?php if (in_array('information/information', $menu_schema) && !$column_left && !$column_right) { $class = 'col-sm-8 col-md-8 col-lg-9 col-md-offset-4 col-lg-offset-3'; } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
			<h1 class="heading"><span><?php echo $heading_title; ?></span></h1>
			<div class="article_description">
				<?php echo $description; ?>
			</div>
			<?php echo $content_bottom; ?>
		</div>
		<?php echo $column_right; ?>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('.article_description img').each(function() {
			var href = $(this).attr('src');
			$(this).addClass('img-responsive');
			$(this).wrap('<a href="'+href+'" class="img_popup" style="max-width:350px; overflow:auto;"></a>');
		});
		$('.article_description').magnificPopup({
			type:'image',
			delegate: 'a.img_popup',
			gallery: {
				enabled:true
			}
		});
	});
</script>
<?php echo $footer; ?>