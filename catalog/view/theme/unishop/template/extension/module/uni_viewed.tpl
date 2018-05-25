<?php if ($products) { ?>
<div class="row product_carousel">
	<h3 class="heading"><span><?php echo $heading_title; ?></span></h3>
	<div class="products product_<?php echo $module_id = rand(); ?>">
		<?php foreach ($products as $product) { ?>
			<div class="product-layout-1">
				<div class="product-thumb transition">
					<div class="image">
						<?php foreach($product['stickers'] as $sticker) { ?>
							<div class="product_sticker <?php echo $sticker['name']; ?>"><?php echo $sticker['text']; ?> <?php echo $sticker['value']; ?> <?php echo $sticker['text_after']; ?></div>
						<?php } ?>
						<a href="<?php echo $product['href']; ?>">
							<img src="<?php echo $product['thumb']; ?>" <?php if ($product['quantity'] < 1 && $show_stock_status) { ?>data-status="<?php echo $product['stock_status']; ?>" data-status-id="<?php echo $product['stock_status_id']; ?>"<?php } ?> <?php if($product['additional_image']) { ?>data-additional="<?php echo $product['additional_image'];?>"<?php } ?> alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
						</a>
					</div>
					<div class="caption">
						<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
						<?php if ($show_description || ($show_description_alt && !$product['attribute_groups'])) { ?>
							<p class="description"><?php echo $product['description']; ?></p>
						<?php } ?>
						<?php if ($show_attr) { ?>
							<div class="attribute <?php if ($show_description_alt && !$product['attribute_groups']) { ?>attribute_alt<?php } ?>">
								<?php foreach ($product['attribute_groups'] as $attribute_group) { ?>
									<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
										<?php if ($show_attr_name) { ?><span class="attr_name"><?php echo $attribute['name']; ?>:</span><?php } ?>
										<span class="attr_value"><?php echo $attribute['text']; ?></span>
									<?php } ?>
								<?php } ?>
							</div>
						<?php } ?>
						<div id="option_<?php echo $product['product_id']; ?>" class="option">
							<?php if ($product['options']) { ?>
								<?php foreach ($product['options'] as $option) { ?>
									<?php if ($option['type'] == 'checkbox' || $option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'image') { ?>
										<div id="input-option<?php echo $option['product_option_id']; ?>">
											<?php if ($option['required']) { ?>*<?php } ?> <label><?php echo $option['name']; ?>:</label><br />
											<?php if ($option['type'] == 'select') { ?>
												<select name="option[<?php echo $option['product_option_id']; ?>]" class="form-control">
													<option value=""><?php echo $text_select; ?></option>
													<?php foreach ($option['product_option_value'] as $option_value) { ?>
														<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?>(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<?php } ?></option>
													<?php } ?>
												</select>
											<?php } ?>
											<?php if ($option['type'] == 'checkbox' || $option['type'] == 'radio' || $option['type'] == 'image') { ?>
												<?php foreach ($option['product_option_value'] as $option_value) { ?>
													<label class="input">
														<?php if ($option['type'] == 'checkbox') { ?>
															<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>_<?php echo $module_id; ?>" />
														<?php } ?>
														<?php if ($option['type'] == 'radio' || $option['type'] == 'image') { ?>
															<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>_<?php echo $module_id; ?>" />
															<?php if($option_value['image']) { ?>
																<span class="img" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" data-toggle="tooltip" data-thumb="<?php echo $option_value['small']; ?>">
																	<img src="<?php echo $option_value['image']; ?>" data-toggle="tooltip" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
																</span>
															<?php } ?>
														<?php } ?>
														<span><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?><span>(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)</span><?php } ?></span>
													</label>
												<?php } ?>
											<?php } ?>
										</div>
									<?php } ?>
								<?php } ?>
							<?php } ?>
						</div>
						<?php if ($product['rating'] >= 0 && $show_rating) { ?>
							<div class="rating">
								<?php for ($i = 1; $i <= 5; $i++) { ?>
									<?php if ($product['rating'] < $i) { ?>
										<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
									<?php } else { ?>
										<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
									<?php } ?>
								<?php } ?>
								<?php if ($show_rating_count) { ?><sup><a onclick="location='<?php echo $product['href']; ?>#tab-review'"><?php echo $product['num_reviews']; ?></a></sup><?php } ?>
							</div>
						<?php } ?>
						<?php if ($product['price']) { ?>
							<p class="price">
								<?php if (!$product['special']) { ?>
									<?php echo $product['price']; ?>
								<?php } else { ?>
									<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span> 
								<?php } ?>
								<?php if ($product['tax']) { ?>
									<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
								<?php } ?>
							</p>
						<?php } ?>
					</div>
					<div class="cart">
						<button type="button" class="add_to_cart button btn btn-default <?php echo $product['cart_btn_class']; ?> <?php echo $product['product_id']; ?>" data-toggle="tooltip" title="<?php echo $product['cart_btn_text']; ?>" onclick="cart.add(<?php echo $product['product_id']; ?>)"><i class="<?php echo $product['cart_btn_icon']; ?>"></i><span class="hidden-sm"><?php echo $product['cart_btn_text']; ?></span></button>
						<?php if ($show_quick_order && $show_quick_order_quantity || $show_quick_order && $product['quantity'] > 0) { ?>
							<button type="button" class="quick_order button btn btn-default" data-toggle="tooltip" title="<?php echo $quick_order_title; ?>" onclick="quick_order('<?php echo $product['product_id']; ?>');"><i class="<?php echo $quick_order_icon; ?>"></i><?php echo ($show_quick_order_text ? '<span class="hidden-sm">'.$quick_order_title.'</span>' : '') ?></button>
						<?php } ?>
						<?php if(!$wishlist_btn_disabled) { ?><button type="button" class="wishlist btn btn-default" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button><?php } ?>
						<?php if(!$compare_btn_disabled) { ?><button type="button" class="compare btn btn-default" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button><?php } ?>
					</div>
				</div>
			</div>
		<?php } ?>
	</div>
</div>
<script type="text/javascript">
	module_type_view('carousel', '.product_<?php echo $module_id; ?>');
</script>
<?php } ?>