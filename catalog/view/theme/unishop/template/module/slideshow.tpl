<div id="slideshow<?php echo $module; ?>" class="slideshow owl-carousel <?php if($hide_slideshow) {echo 'hidden-xs';} ?>" style="opacity: 1;">
  <?php foreach ($banners as $banner) { ?>
  <div class="item">
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
    <?php } ?>
	<div class="title"><?php echo $banner['title']; ?></div>
  </div>
  <?php } ?>
</div>
<script type="text/javascript">
$('#slideshow<?php echo $module; ?>').owlCarousel({
	autoPlay:'<?php if ($slideshow_delay) { ?><?php echo $slideshow_delay*1000; ?><?php } else { ?>3000<?php } ?>',
	singleItem: true,
	navigation: true,
	stopOnHover:true,
	mouseDrag:false,
	<?php if($slideshow_effect) { ?>transitionStyle:'<?php echo $slideshow_effect; ?>',<?php } ?>
	navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
	pagination: true
});
</script>