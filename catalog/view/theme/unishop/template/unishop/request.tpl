<div id="callback">
	<i class="fa fa-times close" onclick="$('#callback').popup('hide')"></i>
	<div>
	<h4 class="heading"><?php if ($reason) { ?><span><?php echo $reason; ?></span><?php } else { ?><span><?php echo $lang['text_callback']; ?></span><?php } ?></h4>
	<form class="callback">
		<input type="hidden" name="type" value="<?php echo $reason ? $reason : $lang['text_callback']; ?>" />
		<div><input type="text" name="customer_name" value="" placeholder="<?php echo $name_text; ?>" class="form-control"/></div>
		<div><input type="tel" name="customer_phone" value="" placeholder="<?php echo $phone_text; ?>" class="customer_phone form-control"/></div>
		<div class="mail" <?php if ($reason) { echo 'style="display:block"'; } ?>><input type="email" name="customer_mail" value="" placeholder="<?php echo $mail_text; ?>" class="form-control" <?php if (!$reason) { echo 'disabled="disabled"'; } ?> /></div>
		<div class="comment" <?php if ($reason) { echo 'style="display:block"'; } ?>><textarea name="customer_comment" placeholder="<?php echo $comment_text; ?>" class="form-control" <?php if (!$reason) { echo 'disabled="disabled"'; } ?> /></textarea></div>
		<?php if ($product_id) { ?><input type="hidden" name="product_id" value="<?php echo $product_id; ?>" /><?php } ?>
		<div>
			<?php if (!$reason) { ?>
				<div>
					<?php if ($show_reason1) { ?>
						<label class="input"><input type="radio" name="customer_reason" value="<?php echo $text_reason1; ?>" id="reason1" checked="checked" /><span></span><?php echo $text_reason1; ?></label><br />
					<?php } ?>
					<?php if ($show_reason2) { ?>
						<label class="input"><input type="radio" name="customer_reason" value="<?php echo $text_reason2; ?>" id="reason2" /><span></span><?php echo $text_reason2; ?></label><br />
					<?php } ?>
					<?php if ($show_reason3) { ?>
						<label class="input"><input type="radio" name="customer_reason" value="<?php echo $text_reason3; ?>" id="reason3" /><span></span><?php echo $text_reason3; ?></label>
					<?php } ?>
				</div>
			<?php } ?>
		</div>
	</form>
	<div><button class="callback_button btn btn-primary" data-loading-text="<?php echo $lang['text_loading']; ?>"><?php echo $lang['text_send']; ?></button></div>
	</div>
<script type="text/javascript" src="catalog/view/theme/unishop/js/jquery.maskedinput.min.js"></script>
<script>
$(document).ready(function() {
	$('#callback #reason1, #callback #reason2').on('click', function() {
		$('.callback .mail input, .callback .comment textarea').attr('disabled', true).parent().hide();
	});

	$('#callback #reason3').on('click', function() {
		$('.callback .mail input, .callback .comment textarea').attr('disabled', false).parent().show();
	});

	$('.callback_button').on('click', function() {
		send_callback();
	});

	var lock = false;
		
	if($(window).width() < 768) {
		var lock = true;
	}

	$('#callback').popup({
		transition: 'all 0.3s', 
		scrolllock: lock,
		onopen: function () {
			$('.tooltip').remove();
        },
		closetransitionend: function () {
			$(this).remove();
		}
	});
});
$('body').on('focus', '#callback .customer_phone', function(){
	$(this).mask('<?php echo $phone_mask; ?>');
});
</script>
</div>