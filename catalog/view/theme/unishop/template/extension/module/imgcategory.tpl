<h3 class="heading"><span><?php echo $heading_title; ?></span></h3>
<div class="row">
	<div class="imgcategory">
		<?php foreach ($categories as $category) { ?>
			<div class="col-lg-4 product-layout-1">
				<div class="product-thumb transition">
					<div class="image"><a href="<?php echo $category['href']; ?>"><img src="<?php echo $category['thumb']; ?>" title="<?php echo $category['name']; ?>" alt="<?php echo $category['name']; ?>" class="img-responsive"/></a></div>
					<h4 style="padding-left:10px"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></h4>
				</div>
			</div>
		<?php } ?>
	</div>
</div>
<script type="text/javascript">
	module_type_view('grid', '.imgcategory');
</script>