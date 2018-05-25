<?php if (count($categories)) { ?>
	<?php if ($cover_status) { ?>
		<div class="row categorywall <?php if ($cover_status) echo 'covers'; ?>">
			<?php foreach ($categories as $category) { ?>
				<div class="product-layout-1">
					<div class="categorywall_thumbnail product-thumb">
						<?php if ($category['children']) { ?>
							<div class="caption">
								<ul>
									<?php foreach ($category['children'] as $child) { ?>
										<li>
											<a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
										</li>
									<?php } ?>
								</ul>
							</div>	
						<?php } ?>
						<!--noindex--><div class="image"><a rel="nofollow" href="<?php echo $category['href']; ?>"><img class="img-responsive" src="<?php echo $category['image']; ?>"></a></div><!--/noindex-->
						<h4 style="padding-left:10px"><a class="category_name<?php if ($category['children']) echo ' parent'; ?>" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></h4>
					</div>
				</div>  
			<?php } ?>
		</div>
		<script>
		$( document ).ready(function() {
			$('.categorywall_thumbnail').hover(
				function(){
					$(this).find('.caption').slideDown(200); //.fadeIn(250)
				},
				function(){
					$(this).find('.caption').slideUp(200); //.fadeOut(205)
				}
			); 
		});
		</script>
	<?php } else { ?>	
		<div class="row categorywall wide">
			 <?php foreach ($categories as $category) { ?>
				<div class="product-layout-1">
					<div class="product-thumb transition">
						<div class="categorywall_thumbnail <?php if ($category['children']) echo ' half'; ?>">
							<h4><a class="category_name" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></h4>
							<div class="clearfix"></div>
							<!--noindex--><a rel="nofollow" href="<?php echo $category['href']; ?>"><img class="img-responsive" src="<?php echo $category['image']; ?>"></a><!--/noindex-->
							<?php if ($category['children']) { ?>
								<div class="children">
									<ul>
										<?php foreach ($category['children'] as $child) { ?>
											<li>
												<a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?><span class="sub"><i class="fa fa-angle-right"></i></span></a>
											</li>
										<?php } ?>
									</ul>
								</div>	
							<?php } ?>
						</div>
					</div>  
				 </div>  
			<?php } ?>
		</div>
	<?php } ?> 
<script type="text/javascript">
	module_type_view('grid', '.categorywall');
</script>
<?php } ?>