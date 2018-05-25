<div <?php echo !$is_shipping ? 'class="hide"' : ''; ?>>
<h3 class="heading"><span><?php echo $lang['shipping_address']; ?></span></h3>
<?php if ($addresses) { ?>
	<?php if ($customer_id) { ?>	
		<?php if(isset($address_1) && isset($city) && isset($zone) && isset($country)) { ?>
			<div class="radio">
				<label class="input"><input type="radio" name="address" value="existing" <?php echo !$new_address ? 'checked="checked"' : ''; ?> onclick="$('#payment-address-new').hide();" id="payment_address" /><span></span><span><?php echo $text_address_existing; ?></span></label>
			</div>
			<div id="payment-existing">
				<select name="address_id" class="form-control">
					<?php foreach ($addresses as $address) { ?>
						<?php if (isset($address_id) && $address['address_id'] == $address_id) { ?>
							<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
						<?php } else { ?>
							<option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
						<?php } ?>
					<?php } ?>
				</select>
			</div>
		<?php } else { ?>
			<script>
				$(document).ready(function() {
					$('#new_payment_address').trigger('click');
				});
			</script>
		<?php } ?>
	<?php } ?>
	<?php if ($customer_id) { ?>
		<div class="radio">
			<label class="input"><input type="radio" name="address" value="new" <?php echo $new_address ? 'checked="checked"' : ''; ?> onclick="$('#payment-address-new').show();" id="new_payment_address"/><span></span><span><?php echo $text_address_new; ?></span></label>
		</div>
	<?php } ?>
<?php } ?>
<div class="row">
	<div id="payment-address-new" <?php if ($customer_id && $addresses && !$new_address) {?> style="display:none"<?php }?>>
		<input type="hidden" name="company" value="" />
		<input type="hidden" name="company_id" value="" />
		<input type="hidden" name="tax_id" value="" />
		<div class="form-group required <?php echo !$show_country_zone ? 'hide' : ''; ?> col-md-6">
			<select name="country_id" id="input-payment-country" class="form-control" onchange="zone();">
				<option value=""><?php echo $lang['select_country']; ?></option>
				<?php foreach ($countries as $country) { ?>
					<?php if ($country['country_id'] == $country_id) { ?>
						<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
					<?php } else { ?>
						<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
					<?php } ?>
				<?php } ?>
			</select>
		</div>
		<div class="form-group required <?php echo !$show_country_zone ? 'hide' : ''; ?> col-md-6">
			<select name="zone_id" id="input-payment-zone" class="form-control" onchange="update_checkout();"></select>
		</div>
		<div class="form-group required <?php echo !$show_city ? 'hide' : ''; ?> <?php echo !$show_postcode ? 'col-xs-12' : 'col-xs-6'; ?>">
			<input type="text" name="city" value="<?php echo $city ;?>" placeholder="<?php echo $city_text; ?>" id="input-payment-city" class="form-control" />
		</div>
		<div class="form-group required <?php echo !$show_postcode ? 'hide' : ''; ?> col-xs-6">
			<input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $postcode_text; ?>" id="input-payment-postcode" class="form-control" />
		</div>
		<div class="address form-group <?php echo !$show_address ? 'hide' : ''; ?> col-xs-12">
			<input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $address_text; ?>" id="input-payment-address-1" class="form-control" />
		</div>
		<div class="form-group <?php echo !$show_address2 ? 'hide' : ''; ?> col-xs-12">
			<input type="text" name="address_2" value="<?php echo $address_2 ;?>" placeholder="<?php echo $address2_text; ?>" id="input-payment-address-2" class="form-control" />
		</div>
	</div>
	<div class="col-xs-12 visible-xs visible-sm" style="height:20px"></div>
</div>
<script>
$(document).ready(function() {
	zone();
});

function zone() {
	var data = $('.payment_address select[name=\'country_id\']').val();
	
	$.ajax({
        url: 'index.php?route=checkout/uni_checkout/country&country_id='+data,
        dataType: 'json',          
        success: function(json) {
			if (json['postcode_required'] == '1') {
				$('input[name=\'postcode\']').parent().parent().addClass('required');
			} else {
				$('input[name=\'postcode\']').parent().parent().removeClass('required');
			}
			            
            html = '<option value=""><?php echo $text_select; ?></option>';
			selected = false;
            
            if (json['zone'] && json['zone'] != '') {
                for (i = 0; i < json['zone'].length; i++) {
                    html += '<option value="' + json['zone'][i]['zone_id'] + '"';
                    
                    if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                        html += ' selected="selected"';
						selected = true;
                    }
    
                    html += '>' + json['zone'][i]['name'] + '</option>';
                }
            } else {
                html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
            }
            
            $('select[name=\'zone_id\']').html(html);
			
			if (!selected) {
				$('select[name=\'zone_id\']').val("");
			}
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
}
</script>
</div>