<script>
	$(document).ready(function() {
	<?php if($show_fly_menu) { ?>fly_menu('<?php echo $fly_menu_product; ?>');<?php } ?>
	<?php if($show_fly_cart) { ?>fly_cart();<?php } ?>
	<?php if($show_fly_callback) { ?>fly_callback('<?php echo $fly_callback_text; ?>');<?php } ?>
	change_opt_img('<?php echo $change_opt_img; ?>', '<?php echo $change_opt_img_p; ?>');
	<?php if($show_search) { ?>uni_live_search('<?php echo $show_search_image; ?>', '<?php echo $show_search_description; ?>', '<?php echo $show_search_rating; ?>', '<?php echo $show_search_price; ?>', '<?php echo $search_limit; ?>', '<?php echo $lang['text_live_search_all'];?>', '<?php echo $lang['text_live_search_empty'];?>');<?php } ?>
	});
</script>
<div class="clear container"></div>
<i class="fa fa-chevron-up scroll_up" onclick="scroll_to('body')"></i>
<div class="show_quick_order"></div>
<div class="show_callback"></div>
<div class="show_login_register"></div>
</div>
<footer>
  <div class="container">
    <div class="row">
      <div class="col-sm-6 col-md-3">
        <h5 class="heading"><i class="<?php echo $col_icon1; ?>"></i><span><?php echo $col_heading1; ?></span></h5>
        <ul class="list-unstyled">
		<?php if ($informations) { ?>
			<?php foreach ($informations as $information) { ?>
				<li><a href="<?php echo $information['href']; ?>"><i class="fa fa-chevron-right"></i><?php echo $information['title']; ?></a></li>
			<?php } ?>
		<?php } ?>
		<?php if ($footerlinks) { ?>
			<?php foreach($footerlinks as $footerlink) { ?>
				<?php if($footerlink['column'] == 1) { ?>
					<li>
						<?php if($footerlink['link']) { ?><a href="<?php echo $footerlink['link']; ?>"><?php } ?>
							<i class="fa fa-chevron-right"></i><?php echo $footerlink['title']; ?>
						<?php if($footerlink['link']) { ?></a><?php } ?>
					</li>
				<?php } ?>
			<?php } ?>
		<?php } ?>
        </ul>
      </div>
      <div class="col-sm-6 col-md-3">
	  <hr class="visible-xs" />
        <h5 class="heading"><i class="<?php echo $col_icon2; ?>"></i><span><?php echo $col_heading2; ?></span></h5>
        <ul class="list-unstyled">
          <?php if ($footerlinks) { ?>
			<?php foreach($footerlinks as $footerlink) { ?>
				<?php if($footerlink['column'] == 2) { ?>
					<li>
						<?php if($footerlink['link']) { ?><a href="<?php echo $footerlink['link']; ?>"><?php } ?>
							<i class="fa fa-chevron-right"></i><?php echo $footerlink['title']; ?>
						<?php if($footerlink['link']) { ?></a><?php } ?>
					</li>
				<?php } ?>
			<?php } ?>
		<?php } ?>
        </ul>
      </div>
	  <div class="clearfix visible-sm"></div>
      <div class="col-sm-6 col-md-3">
	  <hr class="visible-xs visible-sm" />
        <h5 class="heading"><i class="<?php echo $col_icon3; ?>"></i><span><?php echo $col_heading3; ?></span></h5>
        <ul class="list-unstyled">
          <?php if ($footerlinks) { ?>
			<?php foreach($footerlinks as $footerlink) { ?>
				<?php if($footerlink['column'] == 3) { ?>
					<li>
						<?php if($footerlink['link']) { ?><a href="<?php echo $footerlink['link']; ?>"><?php } ?>
							<i class="fa fa-chevron-right"></i><?php echo $footerlink['title']; ?>
						<?php if($footerlink['link']) { ?></a><?php } ?>
					</li>
				<?php } ?>
			<?php } ?>
		<?php } ?>
        </ul>
		<?php if($footer_text) { ?><div class="text"><?php echo $footer_text; ?></div><?php } ?>
      </div>
      <div class="col-sm-6 col-md-3">
	  <hr class="visible-xs visible-sm" />
        <h5 class="heading"><i class="<?php echo $col_icon4; ?>"></i><span><?php echo $col_heading4; ?></span></h5>
        <ul class="list-unstyled">
          <?php if ($footerlinks) { ?>
			<?php foreach($footerlinks as $footerlink) { ?>
				<?php if($footerlink['column'] == 4) { ?>
					<li>
						<?php if($footerlink['link']) { ?><a href="<?php echo $footerlink['link']; ?>"><?php } ?>
							<i class="fa fa-chevron-right"></i><?php echo $footerlink['title']; ?>
						<?php if($footerlink['link']) { ?></a><?php } ?>
					</li>
				<?php } ?>
			<?php } ?>
		<?php } ?>
        </ul>
		<?php if($footer_map) { ?><div class="ya_maps"><?php echo $footer_map; ?></div><?php } ?>
      </div>
    </div>
	<hr />
	<div class="row">
		<div class="col-sm-12 col-md-6">
		<div class="socials">
			<?php if ($socials) { ?>
			<?php foreach ($socials as $social) { ?>
				<a href="<?php echo $social['link']; ?>" target="_blank" title="" ><i class="fa <?php echo $social['icon']; ?>"></i></a>
			<?php } ?>
			<?php } ?>
		</div>
		</div>
		<div class="col-sm-12  col-md-6">
		<hr class="visible-xs visible-sm" />
		<div class="payments">
			<?php if ($payment_icons) { ?>
			<?php foreach ($payment_icons as $payment_icon) { ?>
				<img src="<?php echo HTTPS_SERVER; ?>image/payment/<?php echo $payment_icon; ?>.png" alt="<?php echo $payment_icon; ?>" />
			<?php } ?>
			<?php } ?>
		</div>
		</div>
	</div>
  </div>
</footer>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>
</body></html>