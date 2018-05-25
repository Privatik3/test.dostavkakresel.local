<?php if ($fc_options) { ?>

	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/magnific/magnific-popup.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/pagination/simplePagination.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/fabrickchoice.css" />
	<script src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js"></script>
	<script src="catalog/view/javascript/jquery/izotope/isotope.pkgd.min.js"></script>
	<script src="catalog/view/javascript/jquery/pagination/jquery.simplePagination.js"></script>
	<div class="row fc">
       
	<?php foreach ($fc_options as $option) { ?>
		<div class="col-xs-6 col-md-4">
		<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>" id="input-option<?php echo $option['product_option_id']; ?>">
			<button id="fc_btn" data-option_id="<?php echo $option['option_id'];?>"
			        class="fc-popup button btn-lg<?php if(array_key_exists($option['product_option_id'], $selected_options) && $selected_options[$option['product_option_id']]) {?> selected<?php } ?>" 		        <?php if(array_key_exists($option['product_option_id'], $selected_options) && $selected_options[$option['product_option_id']] && $selected_options[$option['product_option_id']]['image']) { ?>style="background-image: url('<?php echo $selected_options[$option['product_option_id']]['image'];?>');background-size: 110%, 110%;"<?php } elseif(!empty($option['default_image'])) { ?> style="background-image: url('<?php echo $option['default_image']; ?>');background-size: 110%, 110%;" <?php } ?>>
			<span><?php echo $option['name']; ?></span></button>
			<input checked="checked" data-price="<?php if(array_key_exists($option['product_option_id'], $selected_options) && $selected_options[$option['product_option_id']]) { echo $selected_options[$option['product_option_id']]['price_value']; } ?>" data-prefix="<?php if(array_key_exists($option['product_option_id'], $selected_options) && $selected_options[$option['product_option_id']]) { echo $selected_options[$option['product_option_id']]['price_prefix']; } ?>" type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php if(array_key_exists($option['product_option_id'], $selected_options) && $selected_options[$option['product_option_id']]) { echo $selected_options[$option['product_option_id']]['product_option_value_id']; } ?>"/>
		</div>
		</div>
	<?php } ?>
	<input type="hidden" name="fc_product_id" value="<?php echo $product_id;?>">
	</div>
	<script>
        
		$('.fc-popup').on('click', function () {
			var data = $('.fc input[type=\'hidden\']').serialize();
			data += '&option_id=' + $(this).attr('data-option_id');
			var self = this;
			$.ajax({
				type: 'POST',
				url: 'index.php?route=extension/module/fabrickchoice/getoption',
				data: data,
				dataType: 'json',
				success: function(json) {
					if (json.success) {
						$.magnificPopup.open({
							items: {
								src: json.content,
								type: 'inline'
							},
							callbacks: {

								beforeClose: function() {
									var value = $('#selected-option input').val();
                                    var price_prefix = $('#selected-option input').attr('data-prefix');
                                    var price_value = $('#selected-option input').attr('data-price');
									var img_src = $('#selected-option img').attr('src');
									ipt = $(self).closest('div').find('input');
                                    //if(ipt.val()) {
                                        ipt.val(value)
                                            .attr('data-prefix', price_prefix)
                                            .attr('data-price', price_value)
                                            .change();
                                    //}
									if (value) {
										$(self).css('background-image', "url('" + img_src + "')");
										$(self).addClass('selected');
									} else {
										$(self).removeAttr('style');
										$(self).removeClass('selected');
									}

									var savedCoki = getCookie('fc');
									if (savedCoki) {
										savedCoki = JSON.parse(savedCoki);
									} else {
										savedCoki = {};
									}

									var options = $('.fc input[type=\'hidden\'][value!=\'\']');//.serialize();
                                    console.log(options)
                                    var opt = $('.fc input[type=\'hidden\'][data-price][value!=\'\']');
                                    var tmp = '';
                                    for(var i in opt.data()){
                                        tmp += '&' + i + '=' + opt.attr('data-' + i);
                                    }
                                    options = options.serialize() + tmp;
                                    console.log(options);
									savedCoki[<?php echo $product_id;?>] = options;
									if (!$('.fc .selected').length) {
										delete savedCoki[<?php echo $product_id;?>];
									}

									var date = new Date(new Date().getTime() + 60 * 1000 * 3600 * 24 * 7);
									document.cookie = "fc=" + encodeURIComponent(JSON.stringify(savedCoki)) + "; expires=" + date.toUTCString();
                                    
								},
								afterClose: function () {
									recalculateprice();
								}
							}
						});
					}
				}
			});
		});

		function getCookie(name) {
			var matches = document.cookie.match(new RegExp("(?:^|; )" + name + "=([^;]*)"));
			return matches ? decodeURIComponent(matches[1]) : undefined;
		}

	</script>
<? } ?>

