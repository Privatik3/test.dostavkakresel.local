<link href="catalog/view/theme/unishop/stylesheet/quick_order.css" property="stylesheet" rel="stylesheet" type="text/css" media="screen" /> 
<div id="quick_order">
	<i class="fa fa-times close" onclick="$('#quick_order').popup('hide');"></i>
	<div id="product">
		<div class="row">
			<div class="image col-xs-12 col-sm-4 col-md-5">
				<?php foreach($stickers as $sticker) { ?><div class="product_sticker <?php echo $sticker['name']; ?>"><?php echo $sticker['text']; ?> <?php echo $sticker['value']; ?> <?php echo $sticker['text_after']; ?></div><?php } ?>
				<?php if ($thumb) { ?><img src="<?php echo $thumb; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /><?php } ?>
				<?php if($images) { ?>
					<div class="image-additional">
						<div class="col-xs-3 col-sm-4"><img src="<?php echo $small; ?>" data-image="<?php echo $thumb; ?>" alt="" class="img-responsive" /></div>
						<?php foreach($images as $image) { ?>
							<div class="col-xs-3 col-sm-4"><img src="<?php echo $image['small']; ?>" data-image="<?php echo $image['thumb']; ?>" alt="" class="img-responsive" /></div>
						<?php } ?>
					</div>
				<?php } ?>
			</div>
			<div class="name col-xs-12 col-sm-8 col-md-7">
				<hr class="visible-xs" />
				<div class="row"><div class="col-xs-12"><h3 class="heading"><span><?php echo $name; ?></span></h3></div></div>
				<div class="row">
					<?php if ($manufacturer) { ?><div class="col-sm-6 col-md-6"><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></div><?php } ?>
					<div class="col-sm-6 col-md-6"><?php echo $text_model; ?> <?php echo $model; ?></div>
					<?php if ($reward) { ?><div class="col-sm-6 col-md-6"><?php echo $text_reward; ?> <?php echo $reward; ?></div><?php } ?>
					<div class="col-sm-6 col-md-6"><?php echo $text_stock; ?> <?php echo $stock; ?></div>
					<?php if ($points) { ?><div class="col-sm-6 col-md-6"><?php echo $text_points; ?> <?php echo $points; ?></div><?php } ?>
				</div>
				<div class="price">
					<?php if (!$special) { ?>
						<h2><?php echo $price; ?></h2>
					<?php } else { ?>
						<span class="old_price"><?php echo $price; ?></span> <h2><?php echo $special; ?></h2>
					<?php } ?>
				</div>
				<?php if ($minimum > 1) { ?>
					<div class="alert alert-info minimum"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
				<?php } ?>
			</div>
		</div>
		<?php if ($show_attr && $attribute_groups) { ?>
			<h5 class="heading"><span><?php echo $lang['text_attributes']; ?></span></h5>
			<div class="row">
			<?php foreach ($attribute_groups as $key => $attribute_group) { ?>
				<?php if ($key < $show_attr_group) { ?>
					<div class="attributes col-xs-12 col-sm-6">
					<hr class="visible-xs" />
						<div class="attribute">
							<?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
								<?php if ($key < $show_attr_item) { ?>
									<div>
										<span><span><?php echo $attribute['name']; ?></span></span>
										<span><span><?php echo $attribute['text']; ?></span></span>
									</div>
								<?php } ?>
							<?php } ?>
						</div>
					</div>
				<?php } ?>
			<?php } ?>
			</div>
		<?php } ?>
		<?php if ($description_on) { ?>
			<h5 class="heading"><span><?php echo $lang['text_description']; ?></span></h5>
			<div class="row" style="margin-bottom:15px;">
				<div class="col-xs-12"><?php echo $description; ?> <a href="<?php echo $href; ?>" title=""><?php echo $lang['text_more']; ?></a></div>
			</div>
		<?php } ?>
		<div class="row">
			<div class="options option col-xs-12">
				<?php if ($options) { ?>
					<h5 class="heading"><span><?php echo $text_option; ?></span></h5>
					<?php foreach ($options as $option) { ?>
						<?php if ($option['type'] == 'select') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								<select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
										<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?> 
											<?php if ($option_value['price']) { ?>(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<?php } ?>
										</option>
									<?php } ?>
								</select>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'radio' || $option['type'] == 'image') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<label class="control-label"><?php echo $option['name']; ?></label>
								<div id="input-option<?php echo $option['product_option_id']; ?>">
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
										<div class="radio">
											<label class="input">
												<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="<?php echo $option['product_option_id']; ?>_<?php echo $option_value['product_option_value_id']; ?>" />
												<?php if ($option_value['image']) { ?>
													<span class="img" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" data-toggle="tooltip" data-thumb="<?php echo $option_value['small']; ?>">
														<img src="<?php echo $option_value['image']; ?>" data-toggle="tooltip" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
													</span>
												<?php } else { ?>
													<span><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?><span>(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)</span><?php } ?></span>
												<?php } ?>
											</label>
										</div>
									<?php } ?>
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'checkbox') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<label class="control-label"><?php echo $option['name']; ?></label>
								<div id="input-option<?php echo $option['product_option_id']; ?>">
									<?php foreach ($option['product_option_value'] as $option_value) { ?>
										<div class="checkbox radio">
											<label class="input">
												<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="<?php echo $option['product_option_id']; ?>_<?php echo $option_value['product_option_value_id']; ?>" />
												<span><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?><span>(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)</span><?php } ?></span>
											</label>
										</div>
									<?php } ?>
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'text') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'textarea') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								<textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'file') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<label class="control-label"><?php echo $option['name']; ?></label>
								<button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
								<input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'date') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								<div class="input-group date">
									<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
									<span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span>
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'datetime') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								<div class="input-group datetime">
									<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
									<span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
								</div>
							</div>
						<?php } ?>
						<?php if ($option['type'] == 'time') { ?>
							<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
								<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
								<div class="input-group time">
									<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
									<span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
								</div>
							</div>
						<?php } ?>
					<?php } ?>
				<?php } ?>
			</div>
		</div>
		<h5 class="heading"><span><?php echo $lang['text_contact_data']; ?></span></h5>
		<div class="row_input row">
			<form>
			<div class="col-sm-6 col-md-6"><input type="text" name="customer_name" class="customer_name form-control" placeholder="<?php echo $name_text; ?>*" value="<?php echo $firstname; ?>" /></div>
			<div class="col-sm-6 col-md-6"><input type="text" name="customer_phone" class="customer_phone form-control " placeholder="<?php echo $phone_text; ?>*" value="<?php echo $telephone; ?>" /></div>
			<?php if($mail) { ?><div class="col-sm-6 col-md-6"><input type="text" name="customer_mail" class="form-control" placeholder="<?php echo $mail_text; ?>" value="<?php echo $email; ?>" /></div><?php } ?>
			<?php if($delivery) { ?><div class="col-sm-6 col-md-6"><input type="text" name="customer_delivery" class="form-control" placeholder="<?php echo $delivery_text; ?>" value="<?php echo $address; ?>" /></div><?php } ?>
			<?php if($comment) { ?><div class="<?php if($delivery) { ?>col-xs-12<?php } else { ?>col-sm-6 col-md-6<?php } ?>"><input type="text" name="customer_comment" class="form-control" placeholder="<?php echo $comment_text; ?>" /></div><?php } ?>
			</form>
		</div>
		<hr style="margin-top:0" />
		<div class="row">
			<div class="col-xs-12" style="text-align:center">
				<div class="add_quick_order quantity form-group">
					<label class="control-label hidden-xs" for="input-quantity"><?php echo $entry_qty; ?></label>
					<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
					<input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
					<span>
						<i class="fa fa-plus btn btn-default" onclick="quantity('<?php echo $product_id; ?>', '<?php echo $minimum; ?>', '+');"></i>
						<i class="fa fa-minus btn btn-default" onclick="quantity('<?php echo $product_id; ?>', '<?php echo $minimum; ?>', '-');"></i>
					</span>
					<button type="button" onclick="cart.add('<?php echo $product_id; ?>', $(this).prev().prev().val(), '1')" data-loading-text="<?php echo $text_loading; ?>" class="add_to_cart btn btn-default btn-lg"><i class="<?php echo $cart_btn_icon; ?>"></i> <span><?php echo $lang['text_quickorder_button']; ?></span></button>
				</div>
			</div>
		</div>
	</div>
	<?php if ($options) { ?>
		<?php foreach ($options as $option) { ?>
			<?php if ($option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') { ?>
				<link type="text/css" href="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen" />
				<script type="text/javascript" src="catalog/view/javascript/jquery/datetimepicker/moment.js"></script> 
				<script type="text/javascript" src="catalog/view/javascript/jquery/datetimepicker/locale/ru.js"></script> 
				<script type="text/javascript" src="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js"></script>
				<style>.bootstrap-datetimepicker-widget {z-index: 9999999999!important;position:absolute !important}</style>
				<script>
					$('.date').datetimepicker({
						pickTime: false
					});
					$('.datetime').datetimepicker({
						pickDate: true,
						pickTime: true
					});
					$('.time').datetimepicker({
						pickDate: false
					});
				</script>
			<?php } ?>
		<?php } ?>
	<?php } ?>
	<script type="text/javascript" src="catalog/view/theme/unishop/js/jquery.maskedinput.min.js"></script>
	<script>
	$(document).ready(function() {
		if($(window).width() < 768) {
			var lock = true;
		} else {
			var lock = false;
		}

		$('#quick_order').popup({
			transition: 'all 0.3s', 
			scrolllock: lock,
			onopen: function () {
				$('.tooltip').remove();
			},
			closetransitionend: function () {
				$(this).remove();
				return_button(<?php echo $product_id; ?>);
			}
		});
	
		$('#quick_order .image-additional img').each(function() {
			$(this).hover(function() {
				$('#quick_order .image > .img-responsive').attr('src', $(this).attr('data-image'))
			});
		});
<?php if($change_opt_img_q) { ?>		
		$('#quick_order .option input[type=\'radio\'] + .img').on('click', function() {
			$('#quick_order .image > .img-responsive').attr('src', $(this).attr('data-thumb'));
		});
<?php } ?>
	});
	$('body').on('focus', '.customer_phone', function(){
		$(this).mask('<?php echo $phone_mask; ?>');
	});
	</script>
</div>