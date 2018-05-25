<?php if(isset($manufacturers)) { ?>
<?php if($manufacturer_view_res == 768) {
	$class = 'hidden-xs';
} else if ($manufacturer_view_res == 992)  {
	$class = 'hidden-xs hidden-sm';
} else if ($manufacturer_view_res == 1200) {
	$class = 'hidden-sm hidden-sm hidden-md';
} else {
	$class = '';
}
?>
<div id="manufacturer_module" class="row <?php echo $class; ?>">
	<div class="col-xs-12">
		<div class="heading"><?php echo $heading_title; ?></div>
		<ul>
			<?php foreach ($manufacturers as $manufacturer) { ?>
				<li>
					<a onclick="location.href='<?php echo $href; ?>#<?php echo $manufacturer['name']; ?>'"><?php echo $manufacturer['name']; ?></a>
					<?php if ($manufacturer['manufacturer']) { ?>
						<div class="hidden-xs">
							<ul>
								<?php foreach($manufacturer['manufacturer'] as $manufacturer) { ?>
									<li><a onclick="location.href='<?php echo $manufacturer['href']; ?>'"><?php echo $manufacturer['name']; ?></a></li>
								<?php } ?>
							</ul>
						</div>
					<?php } ?>
				</li>
			<?php } ?>
		</ul> 
	</div>
</div>
<?php } ?>