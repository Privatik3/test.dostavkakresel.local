<h3 class="heading"><span><?php echo $lang['delivery_methods']; ?></span></h3>
<div class="shipping-method">
	<?php if ($error_warning) { ?>
		<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
	<?php } ?>
	<?php if ($shipping_methods) { ?>
		<?php foreach ($shipping_methods as $shipping_method) { ?>
			<?php if (!$shipping_method['error']) { ?>
				<?php foreach ($shipping_method['quote'] as $quote) { ?>
					<div class="radio">
						<?php if ($quote['code'] == $code || !$code) { ?>
							<?php $code = $quote['code']; ?>
							<label class="input">
								<input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
								<span></span>
								<span><span class="method"><?php echo $quote['title']; ?>:</span><span class="method"><?php echo $quote['text']; ?></span></span>
							</label>
						<?php } else { ?>
							<label class="input">
								<input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
								<span></span>
								<span><span class="method"><?php echo $quote['title']; ?>:</span><span class="method"><?php echo $quote['text']; ?></span></span>
							</label>
						<?php } ?>
					</div>
				<?php } ?>
			<?php } else { ?>
				<div class="alert alert-danger"><?php echo $shipping_method['error']; ?></div>
			<?php } ?>
		<?php } ?>
	<?php } ?>
</div>