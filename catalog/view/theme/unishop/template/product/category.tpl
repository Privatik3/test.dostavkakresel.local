<?php echo $header; ?>
<div class="container">
	<ul class="breadcrumb <?php if (in_array('product/category', $menu_schema)) { ?>col-md-offset-4 col-lg-offset-3<?php } ?>">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i+1<count($breadcrumbs)) { ?>
				<?php if($i == 0) { ?>
					<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a href="<?php echo $breadcrumb['href']; ?>" itemprop="url"><?php echo $breadcrumb['text']; ?><span style="display:none" itemprop="title"><?php echo $shop_name; ?></span></a></li>
				<?php } else { ?>
					<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a href="<?php echo $breadcrumb['href']; ?>" itemprop="url"><span itemprop="title"><?php echo $breadcrumb['text']; ?></span></a></li>
				<?php } ?>
		<?php } else { ?>
			<li><?php echo $breadcrumb['text']; ?></li><?php } ?>
		<?php } ?>
	</ul>
	<div class="row"><?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-4 col-md-4 col-lg-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-sm-8 col-md-8 col-lg-9'; ?>
		<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<?php if (in_array('product/category', $menu_schema) && !$column_left && $column_right) { $class = 'col-sm-8 col-md-8 col-lg-6 col-md-offset-4 col-lg-offset-3'; } ?>
		<?php if (in_array('product/category', $menu_schema) && !$column_left && !$column_right) { $class = 'col-sm-8 col-md-8 col-lg-9 col-md-offset-4 col-lg-offset-3'; } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
			<h1 class="heading"><span><?php echo $heading_title; ?></span></h1>
			<?php if ($thumb || $description) { ?>
			<div class="row">
				<div class="category-info">
					<div class="col-xs-12">
						<hr />
						<?php if ($thumb) { ?><div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" /></div><?php } ?>
						<?php if ($description) { ?><div class="description"><?php echo $description; ?></div><?php } ?>
						<hr />
					</div>
					<?php if($cat_desc_pos == 'bottom') { ?><script>$(document).ready(function() {$('.cat_desc').append($('.category-info'));});</script><?php } ?>
				</div>
			</div>
			<?php } ?>
			<?php if ($categories) { ?>
				<div class="category_list row">
					<?php foreach ($categories as $category) { ?>
						<div class="category <?php echo $subcategory_column; ?>">
							<a href="<?php echo $category['href']; ?>">
								<?php if($category['thumb']) { ?><img src="<?php echo $category['thumb']; ?>" alt="" title="" class="img-responsive" /><?php } ?>
								<p><?php echo $category['name']; ?></p>
							</a>
						</div>
					<?php } ?>
				</div>
			<?php } ?>
			<?php if ($products) { ?>
				<p style="margin:0"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></p>
				<div class="row">
					<div class="col-xs-12"><hr /></div>
					<div class="col-xs-12 col-sm-4 col-md-3 col-lg-2 hidden-xs">
						<div class="btn-group">
							<?php echo $show_grid_button ? '<button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="'.$button_grid.'"><i class="fa fa-th"></i></button>' : ''; ?>
							<?php echo $show_list_button ? '<button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="'.$button_list.'"><i class="fa fa-th-list"></i></button>' : ''; ?>
							<?php echo $show_compact_button ? '<button type="button" id="compact-view" class="btn btn-default" data-toggle="tooltip" title="'.$lang['button_compact'].'"><i class="fa fa-align-justify"></i></button>' : ''; ?>
						</div>
					</div>
					<div class="col-xs-6 col-sm-5 col-md-4 col-lg-4 col-md-offset-2 col-lg-offset-3 text-right">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-sort"></i><span class="hidden-xs hidden-sm hidden-md"><?php echo $text_sort; ?></span></span>
							<select id="input-sort" class="form-control" onchange="location = this.value;">
								<?php foreach ($sorts as $sorts) { ?>
									<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
										<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
									<?php } else { ?>
										<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="col-xs-6 col-sm-3 col-md-3 col-lg-3 text-right">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-eye"></i><span class="hidden-xs hidden-sm hidden-md"><?php echo $text_limit; ?></span></span>
							<select id="input-limit" class="form-control" onchange="location = this.value;">
								<?php foreach ($limits as $limits) { ?>
									<?php if ($limits['value'] == $limit) { ?>
										<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
									<?php } else { ?>
										<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="col-xs-12"><hr /></div>
				</div>
				<div class="row">
					<?php if ($column_left && $column_right) { ?>
						<?php $class = 'col-lg-6 col-md-12 col-sm-12 col-xs-12'; ?>
					<?php } elseif ($column_left || $column_right) { ?>
						<?php $class = 'col-lg-4 col-md-6 col-sm-6 col-xs-12'; ?>
					<?php } else { ?>
						<?php $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
					<?php } ?>
					<?php foreach ($products as $product) { ?>
						<div class="product-layout product-grid <?php echo $class; ?>">
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
														<?php $tmp = 0; ?>
														<?php foreach ($option['product_option_value'] as $option_value) { ?>
														<?php if($tmp > 8) break; $tmp++; ?>
															<label class="input">
																<?php if ($option['type'] == 'checkbox') { ?>
																	<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
																<?php } ?>
																<?php if ($option['type'] == 'radio' || $option['type'] == 'image') { ?>
																	<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
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
				<div class="pagination_wrap row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
			        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
				</div>
			<?php } ?>
			<?php if (!$categories && !$products) { ?>
				<p><?php echo $text_empty; ?></p>
			<?php } ?>
			<div class="cat_desc row"></div>
			<?php echo $content_bottom; ?>
		</div>
		<?php echo $column_right; ?>
	</div>
</div>
<?php echo $footer; ?>