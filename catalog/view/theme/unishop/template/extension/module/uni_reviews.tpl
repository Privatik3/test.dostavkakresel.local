<?php if ($reviews) { ?>
<div class="row product_carousel">
	<?php if ($module_header) { ?>
		<h3 class="heading"><span><?php echo $module_header; ?></span></h3>
	<?php } ?>	
	<div class="products review<?php echo $module; ?>">
		<?php foreach ($reviews as $review) { ?>
			<div class="product-layout-1">
				<div class="product-thumb transition">
					<div class="image"><a href="<?php echo $review['prod_href']; ?>"><img src="<?php echo $review['prod_thumb']; ?>" alt="<?php echo $review['prod_name']; ?>" title="<?php echo $review['prod_name']; ?>" class="img-responsive" /></a></div>
					<div class="caption reviews-caption">
						<a href="<?php echo $review['prod_href']; ?>"><?php echo $review['prod_name']; ?></a>
						<p class="reviews-description"><?php echo $review['description']; ?></p>
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
						<div class="reviews-sign row">
							<div class="reviews-author col-xs-6 text-left"><?php echo $review['author']; ?></div>
							<div class="reviews-date col-xs-6 text-right"><?php echo $review['date_added']; ?></div>
						</div>
				   <?php if ($show_all_button) { ?>
					<div class="all">
						<a onclick="window.location.href='<?php echo $review['link_all_reviews']; ?>'"><?php echo $text_all_reviews ?></a>
					</div>
				<?php } ?>
					</div>
				</div>
			</div>
		<?php } ?>
	</div>
</div>
<script type="text/javascript">
	module_type_view('carousel', '.review<?php echo $module; ?>');
</script>
<?php } ?>