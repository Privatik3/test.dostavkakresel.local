<?php if ($news) { ?>
	<div class="row product_carousel">
		<h3 class="heading"><span><?php echo $heading_title; ?></span></h3>
		<div class="news_wrapper">
			<div class="news_module">
				<?php foreach ($news as $news_story) { ?>
					<div class="news">
						<?php if ($news_story['image']) { ?>
							<div class="image">
								<a onclick="location='<?php echo $news_story['href']; ?>'" title="<?php echo $news_story['title']; ?>"><img src="<?php echo $news_story['image']; ?>" class="img-responsive" alt="<?php echo $news_story['title']; ?>" /></a>
							</div>
						<?php } ?>
						<?php if ($show_headline) { ?>
							<div class="name"><a href="<?php echo $news_story['href']; ?>" title=""><?php echo $news_story['title']; ?></a></div>
						<?php } ?>
						<div class="description"><?php echo $news_story['description']; ?></div>
						<div class="posted"><a onclick="location='<?php echo $news_story['href']; ?>'"> <?php echo $text_more; ?></a><?php echo $news_story['posted']; ?></div>
					</div>
				<?php } ?>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		module_type_view('carousel', '.news_module');
	</script>
<?php } ?>