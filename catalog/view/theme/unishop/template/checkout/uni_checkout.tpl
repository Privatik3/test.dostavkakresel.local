<?php echo $header;?>
<style>
	#menu_wrap {display:none !important}
	#cart.fly{position:relative;top:auto;right:auto;margin-top:0;}
	#cart > .btn {border-radius:100% !important;}
	#cart .dropdown-menu {display:none !important}
</style>
<div id="unicheckout" class="checkout_form container">        
	<div class="row">
		<div class="col-md-12">
			<div class="breadcrumbs">
				<ul class="breadcrumb">
					<?php foreach ($breadcrumbs as $breadcrumb) { ?>
						<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
					<?php } ?>
				</ul>
			</div>
		</div>
	</div>
	<div class="error"></div>
	<h1 class="heading"><span><?php echo $lang['text_checkout']; ?></span></h1>
	<div class="row">
		<div class="col-xs-12">
			<div id="unicart">
				<?php echo $cart; ?>
			</div>
		</div>
	</div>
	<?php if (!$is_logged) { ?>
		<div class="row">
			<div class="col-md-12">
			    <div class="well"><?php echo $lang['text_register3']; ?> &nbsp;<a href="#" onclick="login(); return false;"><?php echo $lang['text_login4']; ?></a></div>
		    </div>
		</div>
	<?php } ?>
	<div id="checkout_data">		
		<form id="user" class="row">
		    <div class="col-md-6">
				<div class="user_data row">
					<div class="col-md-12">
						<h3 class="heading"><span><?php echo $text_your_details; ?></span></h3>
					</div>			  
					<div class="form-group required <?php echo !$show_lastname && !$show_email && !$show_phone ? 'col-xs-12' : 'col-xs-6'; ?>">
						<input type="text" name="firstname" value="<?php echo isset($firstname) ? $firstname : ''; ?>" placeholder="<?php echo $name_text; ?>" class="form-control" />
					</div>
					<div class="form-group required <?php echo !$show_lastname ? 'hide' : ''; ?> col-xs-6">
						<input type="text" name="lastname" value="<?php echo isset($lastname) ? $lastname : '';?>" placeholder="<?php echo $lastname_text; ?>" class="form-control" />
					</div>
					<div class="form-group required <?php echo !$show_email ? 'hide' : ''; ?> <?php echo $show_lastname && !$show_phone ? 'col-xs-12' : 'col-xs-6'; ?>">
						<input type="email" name="email" value="<?php echo isset($email) ? $email : '';?>" placeholder="<?php echo $email_text; ?>" class="form-control" />
					</div>
					<div class="form-group required <?php echo !$show_phone ? 'hide' : ''; ?> <?php echo ($show_lastname && !$show_email) || (!$show_lastname && $show_email) ? 'col-xs-12' : 'col-xs-6'; ?>">
						<input type="tel" name="telephone" value="<?php echo isset($telephone) ? $telephone : '';?>" placeholder="<?php echo $phone_text; ?>" class="form-control" />
					</div>					
					
					<input type="hidden" name="fax" value="" />
				</div>
				<div class="row <?php echo !$show_email ? 'hide' : ''; ?>">	
					<?php if (!isset($customer_id)) { ?>	
						<div class="form-group col-md-12" <?php echo !$checkout_guest ? 'style="display:none"' : ''; ?>>
							<label class="input show-register-form">
								<input type="checkbox" name="register" value="register" id="register_user" <?php echo !$checkout_guest ? 'checked="checked"' : ''; ?> /><span></span><span><?php echo $lang['text_register2']; ?></span>
							</label>
						</div>    
						<div class="register-form col-xs-12" <?php echo $checkout_guest ? 'style="display:none"' : ''; ?>>
							<div>
								<?php if($customer_groups) { ?>
									<label class="control-label"><?php echo $entry_customer_group; ?>:</label> &nbsp;&nbsp;&nbsp;
									<?php foreach ($customer_groups as $customer_group) { ?>
										<div class="radio">
											<?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
												<label class="input"><input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" /><span></span><span><?php echo $customer_group['name']; ?></span></label>
											<?php } else { ?>
												<label class="input"><input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="<?php echo $customer_group['customer_group_id']; ?>" /><span></span><span><?php echo $customer_group['name']; ?></span></label>
											<?php } ?>
										</div>
									<?php } ?>
									<div style="height:12px"></div>
								<?php } ?>
							</div>
							<div class="form-group required">
								<input type="password" name="password" value="" placeholder="<?php echo $password_text; ?>" id="input-payment-password" class="form-control" />
							</div>
							<?php if ($show_password_confirm) {?>	
								<div class="form-group required">
									<input type="password" name="confirm" value="" placeholder="<?php echo $password_confirm_text; ?>" id="input-payment-confirm" class="form-control" />
								</div>
							<?php } ?>
						</div>
					<?php } ?>
				</div>
				<div class="row">
					<div class="payment_address col-xs-12">
						<?php echo $address; ?>			
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<?php if (isset($custom_fields)) foreach ($custom_fields as $custom_field) { ?>
					<?php if ($custom_field['type'] == 'select') { ?>
						<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
							<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
							<div class="">
								<select name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
									<?php } ?>
								</select>
							</div>
						</div>
					<?php } ?>
					<?php if ($custom_field['type'] == 'radio') { ?>
						<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
							<label class="control-label"><?php echo $custom_field['name']; ?></label>
							<div class="">
								<div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
									<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<div class="radio">
											<label class="input"><input type="radio" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" /><span></span><span><?php echo $custom_field_value['name']; ?></span></label>
										</div>
									<?php } ?>
								</div>
							</div>
						</div>
					<?php } ?>
					<?php if ($custom_field['type'] == 'checkbox') { ?>
						<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
							<label class="control-label"><?php echo $custom_field['name']; ?></label>
							<div class="">
								<div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
									<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<div class="checkbox">
											<label class="input"><input type="checkbox" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" /><span></span><span><?php echo $custom_field_value['name']; ?></span></label>
										</div>
									<?php } ?>
								</div>
							</div>
						</div>
					<?php } ?>
					<?php if ($custom_field['type'] == 'text') { ?>
						<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
							<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
							<div class="">
								<input type="text" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
							</div>
						</div>
					<?php } ?>
					<?php if ($custom_field['type'] == 'textarea') { ?>
						<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
							<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
							<div class="">
								<textarea name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo $custom_field['value']; ?></textarea>
							</div>
						</div>
					<?php } ?>
					<?php if ($custom_field['type'] == 'file') { ?>
						<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
							<label class="control-label"><?php echo $custom_field['name']; ?></label>
							<div class="">
								<button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
								<input type="hidden" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
							</div>
						</div>
					<?php } ?>
					<?php if ($custom_field['type'] == 'date') { ?>
						<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
							<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
							<div class="">
								<input type="date" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
							</div>
						</div>
					<?php } ?>
					<?php if ($custom_field['type'] == 'datetime') { ?>
						<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
							<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
							<div class="">
								<input type="datetime-local" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
							</div>
						</div>
					<?php } ?>
					<?php if ($custom_field['type'] == 'time') { ?>
						<div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field">
							<label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
							<div class="">
								<input type="time" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo str_replace(':','',$custom_field['name']); ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
							</div>
						</div>
					<?php } ?>
				<?php } ?>
				<div class="shipping_wrap">
					<?php echo $shipping_method; ?>
				</div>							
				<div class="payment_wrap">						    
					<?php echo $payment_method; ?>
				</div>
			</div>
			<div class="col-xs-12 visible-md visible-lg" style="height:20px"></div>
			<div class="col-xs-12">
				<h3 class="heading"><span><?php echo $lang['text_comment2']; ?></span></h3>
				<p><textarea name="comment" rows="3" class="form-control"><?php echo $comment; ?></textarea></p>
			</div>
		</form>
		<div id="confirm" class="row">
			<div class="total_checkout col-sm-12 col-md-12 text-right">
				<h3 style="margin:10px 0 20px;"><span style="padding:0;color:#777;"><?php echo $lang['text_total_checkout']; ?><span style="padding:0;color:#D9534F;"><span/><span/></h3>
			</div>
			<div class="col-sm-12 col-md-12">
				<?php if ($text_agree) { ?>
					<div class="buttons clearfix">
						<div class="radio pull-left hidden-xs">
							<label class="input">
								<input type="checkbox" name="agree" value="1" <?php echo $agree ? 'checked="checked"' : ''; ?> id="agree" />
								<span></span>
								<span><?php echo $text_agree; ?></span>
							</label>
						</div>
						<div class="radio pull-right text-right visible-xs">
							<label class="input">
								<input type="checkbox" name="agree" value="1" <?php echo $agree ? 'checked="checked"' : ''; ?> id="agree" />
								<span></span>
								<span><?php echo $text_agree; ?></span>
							</label>
							<hr />
						</div>
						<div class="pull-right">
							<button data-loading-text="<?php echo $lang['text_loading']; ?>" id="confirm_checkout" class="btn btn-primary"><?php echo $lang['button_confirm_checkout'];?></button>
						</div>
					</div>
				<?php } else { ?>
					<div class="buttons">
						<div class="pull-right">
							<button data-loading-text="<?php echo $lang['text_loading']; ?>" id="confirm_checkout" class="btn btn-primary"><?php echo $lang['button_confirm_checkout'];?></button>
						</div>
					</div>
				<?php } ?>
				<div class="payment"></div>
			</div>
		</div>
		<div class="related_after"></div>
	</div>			
    <?php echo $content_bottom; ?>
    <?php echo $column_right; ?>
</div>
<script type="text/javascript" src="catalog/view/theme/unishop/js/jquery.maskedinput.min.js"></script>
<script type="text/javascript">
$('.show-register-form input').on('change', function() {
	$('.register-form').toggle();
});

update_checkout();
	
var error = true;

$('body').on('change', 'input[name=\'shipping_method\'], input[name=\'payment_method\'], .payment_address input[name=\'city\'], .payment_address input[name=\'postcode\'], input[name=\'address\'], select[name=\'address_id\']', function() {
	update_checkout();
});

$('body').on('click', '.add_to_cart', function() {
	option = $(this).parent().parent().find('.option').children().size();
	option_checked = $(this).parent().parent().find('.option input:checked, .option select').size();
	if(!option || option_checked) {
		update_checkout();
	}
});

$('body').on('click', '#confirm_checkout', function() {
	var data = $('.checkout_form input[type=\'text\'], .checkout_form input[type=\'tel\'], .checkout_form input[type=\'email\'], .checkout_form input[type=\'date\'], .checkout_form input[type=\'datetime-local\'], .checkout_form input[type=\'time\'], .checkout_form input[type=\'password\'], .checkout_form input[type=\'hidden\'], .checkout_form input[type=\'checkbox\']:checked, .checkout_form input[type=\'radio\']:checked, .checkout_form textarea, .checkout_form select').serialize();
	data += '&_shipping_method='+ $('.checkout_form input[name=\'shipping_method\']:checked').prop('title') + '&_payment_method=' + $('.checkout_form input[name=\'payment_method\']:checked').prop('title');
	
    $.ajax({
        url: 'index.php?route=checkout/uni_checkout/validate',
        type: 'post',
        data: data,
        dataType: 'json',
        beforeSend: function() {
			$('#confirm_checkout').button('loading');
		},  
        complete: function() {
            $('#confirm_checkout').button('reset');
        },          
        success: function(json) {
            $('#unicheckout > .alert').remove();
                        
            if (json['error']) {
				error = true;
                if (json['error']['warning']) {
                    $('.error').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
                $('#unicheckout').append('<div class="alert"></div>');
				for (i in json['error']) {
					$('#unicheckout > .alert').append('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' +json['error'][i]+ ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}
            }
			
			if (json['success']) {
				$('.payment').html(json['success']);
					if (!$('.payment h2, .payment p, .payment input[type=\'radio\'], .payment input[type=\'checkbox\'], .payment select').length) {
						$('.payment').css('display', 'none');
						$('.payment #button-confirm, .payment input[type=\'button\'], .payment input[type=\'submit\'], .payment button, .payment a, .payment .btn-primary').click();
						if($('.payment a').length) {
							$('.payment a')[0].click();
						}
					}
			}
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});  

$('body').on('focus', '#unicheckout input[name=\'telephone\']', function(){
	$(this).mask('<?php echo $checkout_phone_mask; ?>');
});

$('body').on('click', '#button-coupon', function() {
	$.ajax({
		url: 'index.php?route=<?php echo (VERSION >= 2.3) ? 'extension/total' : 'total' ?>/coupon/coupon',
		type: 'post',
		data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-coupon').button('loading');
		},
		complete: function() {
			$('#button-coupon').button('reset');
		},
		success: function(json) {
			$('.alert').remove();

			if (json['error']) {
				$('#unicheckout').append('<div class="alert"></div>');
				$('#unicheckout .alert').append('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}

			if (json['redirect']) {
				update_checkout();
			}
		}
	});
});
$('body').on('click', '#button-reward', function() {
	$.ajax({
		url: 'index.php?route=<?php echo (VERSION >= 2.3) ? 'extension/total' : 'total' ?>/reward/reward',
		type: 'post',
		data: 'reward=' + encodeURIComponent($('input[name=\'reward\']').val()),
		dataType: 'json',
		beforeSend: function() {
			$('#button-reward').button('loading');
		},
		complete: function() {
			$('#button-reward').button('reset');
		},
		success: function(json) {
			$('.alert').remove();

			if (json['error']) {
				$('#unicheckout').append('<div class="alert"></div>');
				$('#unicheckout .alert').append('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}

			if (json['redirect']) {
				update_checkout();
			}
		}
	});
});
$('body').on('click', '#button-voucher', function() {
  $.ajax({
    url: 'index.php?route=<?php echo (VERSION >= 2.3) ? 'extension/total' : 'total' ?>/voucher/voucher',
    type: 'post',
    data: 'voucher=' + encodeURIComponent($('input[name=\'voucher\']').val()),
    dataType: 'json',
    beforeSend: function() {
      $('#button-voucher').button('loading');
    },
    complete: function() {
      $('#button-voucher').button('reset');
    },
    success: function(json) {
		$('.alert').remove();

		if (json['error']) {
			$('#unicheckout').append('<div class="alert"></div>');
			$('#unicheckout .alert').append('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
		}

		if (json['redirect']) {
			update_checkout();
		}
    }
  });
});

function cart_update(key, quantity) {
	$.ajax({
		url: 'index.php?route=checkout/uni_checkout/cart_edit',
		type: 'post',
		data: 'quantity['+key+']='+quantity,
		dataType: 'json',
		success: function(json) {
			$('#cart').load('index.php?route=common/cart/info #cart > *');
			p_array();
			update_checkout();
		}
	});
}

function update_checkout() {
	var data = $('#user input[type=\'radio\']:checked, #user input[type=\'checkbox\']:checked, #user select, #user input[type=\'text\'], #user input[type=\'email\'], #user input[type=\'tel\']').serialize();
	$.ajax({
		url: 'index.php?route=checkout/uni_checkout/address&render=1',
		type: 'post',
		data: data,
		dataType: 'html',
		beforeSend: function() {
			$('#unicart').append('<div class="loading"><i class="fa fa-spinner" aria-hidden="true"></i></div>');
		},
		success: function(html) {
			$('.payment_address').html(html);
			update_shipping();
		}
	});
}

function update_shipping() {
	$.ajax({
		url: 'index.php?route=checkout/uni_checkout/shipping_method&render=1',
		dataType: 'html',
		success: function(html) {
			$('.shipping_wrap').html(html);
			if(!$('.shipping-method input:checked').length) {
				$('.shipping-method input:first').attr('checked', true).prop('checked', true);
			}
			if($('.shipping-method input:checked').val() == 'pickup.pickup') {
				$('#payment-address-new input').each(function() {
					if($(this).val() == '') {
						$(this).val('---');
					}
				});
				if(!$('#payment-address-new .cover').length) {
					$('#payment-address-new').append('<div class="cover"></div>');
				}
			} else {
				$('#payment-address-new input').each(function() {
					if($(this).val() == '---') {
						$(this).val('');
					}
				});
				$('#payment-address-new .cover').remove();
			}
			update_payment();
		}
	});
}

function update_payment() {
	$.ajax({
		url: 'index.php?route=checkout/uni_checkout/payment_method&render=1',
		dataType: 'html',
		success: function(html) {
			$('.payment_wrap').html(html);
			if(!$('.payment-method input:checked').length) {
				$('.payment-method input:first').attr('checked', true).prop('checked', true);
			}
			update_cart();
		}
	});
}

function update_cart() {
	$.ajax({
		url: 'index.php?route=checkout/uni_checkout/cart&render=1',
		dataType: 'html',
		success: function(html) {
			$('#unicart').html(html);
			$('.total_checkout h3 span span').html($('.total_table td:last').html());
		}
	});
}
</script>

<?php echo $footer;?>