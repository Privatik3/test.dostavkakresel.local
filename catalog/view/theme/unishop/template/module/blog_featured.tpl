<?php if($articles) { ?>
	<div class="row product_carousel">
		<h3 class="heading"><span><?php echo $heading_title; ?></span></h3>
		<div class="article_wrapper">
			<div class="article_to_category_<?php echo $article_to_category = rand(); ?>">
				<?php foreach ($articles as $article) { ?>
					<div class="article_module">
						<?php if ($article['thumb']) { ?>
							<div class="image">
								<a onclick="location='<?php echo $article['href']; ?>'" title="<?php echo $article['name']; ?>"><img src="<?php echo $article['thumb']; ?>" class="img-responsive" alt="<?php echo $article['name']; ?>" /></a>
							</div>
						<?php } ?>
						<div class="name"><a href="<?php echo $article['href']; ?>" title=""><?php echo $article['name']; ?></a></div>
						<?php if ($article['description'] && $article['description'] != '<p><br></p>') { ?>
							<div class="description"><?php echo $article['description']; ?><br /><a onclick="location.href='<?php echo $article['href']; ?>';" style="text-decoration:underline"><?php echo $button_more; ?></a></div>
						<?php } ?>
						<hr />
						<div class="posted">
							<span><i class="fa fa-calendar" aria-hidden="true"></i><?php echo $article['date_added']; ?></span>
							<span><i class="fa fa-eye" aria-hidden="true"></i><?php echo $article['viewed']; ?></span>	
						</div>
					</div>
				<?php } ?>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		module_type_view('carousel', '.article_to_category_<?php echo $article_to_category; ?>');
	</script>
<?php } ?>