<?php if($articles) { ?>
<div class="row product_carousel">
<h3 class="heading"><span><?php echo $heading_title; ?></span></h3>
<?php $article_to_category = rand();?>
	<div class="article_wrapper">
      <div class="article_to_category_<?php echo $article_to_category; ?>">
        <?php foreach ($articles as $article) { ?>
          <div class="article_module">
			<?php if ($article['thumb']) { ?>
              <div class="image">
                <a onclick="location='<?php echo $article['href']; ?>'" title="<?php echo $article['name']; ?>"><img src="<?php echo $article['thumb']; ?>" class="img-responsive" alt="<?php echo $article['name']; ?>" /></a>
              </div>
            <?php } ?>
			<div class="name"><a href="<?php echo $article['href']; ?>" title=""><?php echo $article['name']; ?></a></div>
			<?php if ($article['description'] && $article['description'] != '<p><br></p>') { ?>
				<div class="description"><?php echo $article['description']; ?></div>
			<?php } ?>
			<hr />
			<div class="posted">
				<?php if($show_author) { ?><span data-toggle="tooltip" title="<?php echo $text_author; ?>"><i class="fa fa-user" aria-hidden="true"></i><?php echo $article['author']; ?></span><?php } ?>
				<?php if($show_date_added) { ?><span data-toggle="tooltip" title="<?php echo $text_date_added; ?>"><i class="fa fa-calendar" aria-hidden="true"></i><?php echo $article['date_added']; ?></span><?php } ?>
				<?php if($show_viewed) { ?><span data-toggle="tooltip" title="<?php echo $text_viewed; ?>"><i class="fa fa-eye" aria-hidden="true"></i><?php echo $article['viewed']; ?></span><?php } ?>
				<?php if ($review_status) { ?><span data-toggle="tooltip" title="<?php echo $text_review; ?>"><a href="<?php echo $article['href']; ?>#review"><i class="fa fa-comment" aria-hidden="true"></i><?php echo $article['reviews']; ?></a></span><?php } ?>			
			</div>
          </div>
        <?php } ?>
      </div>
    </div>
	<?php if($category_href) { ?>
		<div class="text-right">
			<a href="<?php echo $category_href; ?>">Все статьи этой категории</a>
		</div>
	<?php } ?>
</div>
<script type="text/javascript">
	$('.article_to_category_<?php echo $article_to_category; ?>').owlCarousel({
		responsiveBaseWidth: '.article_to_category_<?php echo $article_to_category; ?>',
		itemsCustom: [[0, 1], [580, 2], [720, 3], [1000, 4]],
		autoPlay: false,
		mouseDrag:false,
		navigation: true,
		navigationText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>'],
		pagination: false,
	});
</script>
<?php } ?>