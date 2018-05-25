<?php echo $header; ?>
<div class="container">
	<div class="row"><?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-4 col-md-4 col-lg-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-sm-12 col-md-8 col-lg-9'; ?>
		<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<?php if (in_array('common/home', $menu_schema) && !$column_left && !$column_right) { $class = 'col-sm-12 col-md-8 col-lg-9 col-md-offset-4 col-lg-offset-3'; } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?></div>
		<?php echo $column_right; ?>
	</div>
	<div class="row">
		<div class="col-xs-12">
			<?php echo $content_bottom; ?>
		</div>
	</div>
</div>
<?php echo $footer; ?>