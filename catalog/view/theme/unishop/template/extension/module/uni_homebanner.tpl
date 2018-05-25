<?php if($home_banners) { ?>
	<?php
		switch (count($home_banners)) {
			case 3:
				$banner = 'col-sm-4 col-md-4';
				break;
			case 2:
				$banner = 'col-sm-6 col-md-6'; 
				break;
			case 1:
				$banner = 'col-sm-12 col-md-12';			
				break;
		}
	?>
	<div class="home_banners row">
		<?php foreach($home_banners as $key => $home_banner) { ?>
			<div class="<?php echo $banner; ?>">
				<div class="home_banner <?php if($home_banner['link']) { ?>has_link<?php } ?>" <?php if($home_banner['link'] && !isset($home_banner['link_popup'])) { ?>onclick="location='<?php echo $home_banner['link']; ?>'"<?php } ?><?php if($home_banner['link'] && isset($home_banner['link_popup'])) { ?>onclick="banner_link('<?php echo $home_banner['link']; ?>');"<?php } ?>>
					<?php if($home_banner['icon']) { ?>
						<div class="icon"><i class="<?php echo $home_banner['icon']; ?>"></i></div>
					<?php } ?>
					<div class="text">
						<strong><?php echo $home_banner['text']; ?></strong>
						<span><?php echo $home_banner['text1']; ?></span>
					</div>
				</div>
			</div>
		<?php } ?>
	</div>
<?php } ?>