<?php echo $header; ?>
<div class="container" itemscope itemtype="http://schema.org/Product">
	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i+1<count($breadcrumbs)) { ?>
				<?php if($i == 0) { ?>
					<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a href="<?php echo $breadcrumb['href']; ?>" itemprop="url"><?php echo $breadcrumb['text']; ?><span style="display:none" itemprop="title"><?php echo $shop_name; ?></span></a></li>
				<?php } else { ?>
					<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a href="<?php echo $breadcrumb['href']; ?>" itemprop="url"><span itemprop="title"><?php echo $breadcrumb['text']; ?></span></a></li>
				<?php } ?>
			<?php } else { ?>
				<li><?php echo $breadcrumb['text']; ?></li>
			<?php } ?>
		<?php } ?>
	</ul>
	<div class="row"><?php //echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-sm-6'; ?>
		<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<div id="content" class="col-xs-12"><?php echo $content_top; ?>
			<div id="product" class="row">
				<div class="col-sm-12"><h1 class="heading"><span itemprop="name"><?php echo $heading_title; ?></span></h1></div>
					<div class="col-sm-6 col-md-5">
						<?php if ($thumb || $images) { ?>
							<?php foreach($stickers as $sticker) { ?>
								<div class="product_sticker <?php echo $sticker['name']; ?>"><?php echo $sticker['text']; ?> <?php echo $sticker['value']; ?> <?php echo $sticker['text_after']; ?></div>
							<?php } ?>
							<ul class="thumbnails">
								<?php if ($thumb) { ?>
									<li>
										<a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" itemprop="image" data-key="0">
											<img src="<?php echo $thumb; ?>" <?php if ($quantity < 1 && $show_stock_status) { ?>data-status="<?php echo $stock_status; ?>" data-status-id="<?php echo $stock_status_id; ?>"<?php } ?> title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
										</a>
									</li>
								<?php } ?>
								<?php if ($images) { ?>
									<li class="row">
										<div class="image-additional col-xs-3 col-sm-2">
											<a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" data-thumb="<?php echo $thumb; ?>" data-key="0">
												<img src="<?php echo $small; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" />
											</a>
										</div>
										<?php foreach ($images as $key => $image) { ?>
											<div class="image-additional col-xs-3 col-sm-2">
												<a class="thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" data-thumb="<?php echo $image['small']; ?>" data-key="<?php echo $key+1; ?>">
													<img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" />
												</a>
											</div>
										<?php } ?>
									</li>
								<?php } ?>
							</ul>
						<?php } ?>
					</div>
					<div class="col-sm-6 col-md-5">
						<div class="row">
							<div class="col-md-12">
								<div class="row">

<!----------------------------------------Табы для комплекта товаров------------------------------------>

									<div class="col-xs-12">
										<ul class="nav nav-tabs">
											<li><a href="#tab-description" data-toggle="tab"><i class="" aria-hidden="true"></i>Мебель на фото</a></li>
											<?php if ($attribute_groups) { ?>
											<li><a href="#tab-specification" data-toggle="tab"><i class="fa fa-list-alt" aria-hidden="true"></i><?php echo $tab_attribute; ?></a></li>
											<?php } ?>
											<?php if ($review_status) { ?>
											<li class="active" ><a  href="#tab-review" data-toggle="tab"><i class="" aria-hidden="true"></i>Инфо о товаре</a></li>
											<?php } ?>
											<?php if ($show_additional_tab) { ?>
											<li><a href="#tab-additional_tab" data-toggle="tab"><i class="<?php echo $additional_tab_icon; ?>"></i><?php echo $additional_tab_title; ?></a></li>
											<?php } ?>
											<?php if(isset($product_tabs)) { ?>
											<?php foreach($product_tabs as $key => $tab){ ?>
											<li><a href="#tab-<?php echo $product_id ?>-<?php echo $tab['product_tab_id']; ?>" data-toggle="tab"><?php echo $tab['title']; ?></a></li>
											<?php } ?>
											<?php } ?>
										</ul>
										<div class="tab-content">
											<div class="tab-pane tab-description-style" id="tab-description" itemprop="description" >

												<?php /* --------------------------- Вывод списка товаров --------------------------- */ ?>
												<?php foreach ($products_group as $group) {
                								foreach ($group as $product) { ?>
												<div class="pointID_514005">
													<div class="checkbox"><input class="checkbox-complect" name="" type="checkbox" checked></div>
													<hr style="margin: 8px 0;border-color: #b8b8b8;">
													<div class="name"><a class="name-tab" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
													<div class="price price-tab"><?php echo $product['price']; ?></div>
													<hr style="margin: 8px 0;border-color: #b8b8b8;">
												</div>
												<?php }} ?>
												<?php /*------------------------ Вывод списка товаров ( END ) ------------------------ */ ?>

												<?php /* --------------------------- Вывод общей суммы товара --------------------------- */ ?>
												<div id="total-price " style="margin-top: 25px;margin-bottom: 15px;">Общая стоимость покупки: <?php echo $total_price; ?></div>
												<?php /*------------------------ Вывод общей суммы товара ( END ) ------------------------ */ ?>

											</div>
											<?php if ($attribute_groups) { ?>
											<div class="tab-pane" id="tab-specification">
												<div class="row">
													<?php $i = 1; ?>
													<?php foreach ($attribute_groups as $key => $attribute_group) { ?>
													<div class="attributes <?php if(count($attribute_groups) > 1) { ?>col-sm-6 col-md-6<?php } else { ?>col-sm-12 col-md-12<?php } ?>" >
														<hr class="visible-xs" />
														<h4 class="heading"><span><?php echo $attribute_group['name']; ?></span></h4>
														<div class="attribute">
															<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
															<div>
																<span><span><?php echo $attribute['name']; ?></span></span>
																<span><span><?php echo $attribute['text']; ?></span></span>
															</div>
															<?php } ?>
														</div>
													</div>
													<?php } ?>
												</div>
											</div>
											<?php } ?>
											<?php if ($review_status) { ?>
											<div class="tab-pane active" id="tab-review">

												<?php if ($manufacturer) { ?><div class="col-sm-6 col-md-6"><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><span itemprop="brand"><?php echo $manufacturer; ?></span></a></div><?php } ?>
												<div class="col-sm-6 col-md-6"><?php echo $text_model; ?> <span itemprop="model"><?php echo $model; ?></span></div>
												<?php if ($reward) { ?><div class="col-sm-6 col-md-6"><?php echo $text_reward; ?> <?php echo $reward; ?></div><?php } ?>
												<div class="col-sm-6 col-md-6"><?php echo $text_stock; ?> <?php echo $stock; ?></div>
												<?php if ($points) { ?><div class="col-sm-6 col-md-6"><?php echo $text_points; ?> <?php echo $points; ?></div><?php } ?>
												<?php if ($sku_text && $sku) { ?><div class="col-sm-6 col-md-6"><?php echo $sku_text; ?>: <?php echo $sku; ?></div><?php } ?>
												<?php if ($upc_text && $upc) { ?><div class="col-sm-6 col-md-6"><?php echo $upc_text; ?>: <?php echo $upc; ?></div><?php } ?>
												<?php if ($ean_text && $ean) { ?><div class="col-sm-6 col-md-6"><?php echo $ean_text; ?>: <?php echo $ean; ?></div><?php } ?>
												<?php if ($jan_text && $jan) { ?><div class="col-sm-6 col-md-6"><?php echo $jan_text; ?>: <?php echo $jan; ?></div><?php } ?>
												<?php if ($isbn_text && $isbn) { ?><div class="col-sm-6 col-md-6"><?php echo $isbn_text; ?>: <?php echo $isbn; ?></div><?php } ?>
												<?php if ($mpn_text && $mpn) { ?><div class="col-sm-6 col-md-6"><?php echo $mpn_text; ?>: <?php echo $mpn; ?></div><?php } ?>
												<?php if ($location_text && $location) { ?><div class="col-sm-6 col-md-6"><?php echo $location_text; ?>: <?php echo $location; ?></div><?php } ?>
												<?php if ($price) { ?>
												<hr />
												<div style="display:none;" itemprop="offers" itemscope itemtype="http://schema.org/Offer"><meta itemprop="priceCurrency" content="<?php echo $currency_code; ?>" /> <span itemprop="price"><?php echo $p_value; ?></span></div>
												<ul class="list-unstyled price">
													<?php if (!$special) { ?>
													<li><span><?php echo $price; ?></span></li>
													<?php } else { ?>
													<li><span class="old_price"><?php echo $price; ?></span><span><?php echo $special; ?></span></li>
													<?php } ?>
													<?php if ($tax) { ?><li><?php echo $text_tax; ?> <?php echo $tax; ?></li><?php } ?>
													<li>
														<hr />
														<div class="form-group quantity">
															<label class="control-label hidden-xs" for="input-quantity"><?php echo $entry_qty; ?></label>
															<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
															<input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
															<span>
											<i class="fa fa-plus btn btn-default" onclick="quantity('<?php echo $product_id; ?>', '<?php echo $minimum; ?>', '+');"></i>
											<i class="fa fa-minus btn btn-default" onclick="quantity('<?php echo $product_id; ?>', '<?php echo $minimum; ?>', '-');"></i>
										</span>
															<button type="button" class="add_to_cart button btn btn-lg <?php echo $cart_btn_class; ?> <?php echo $product_id; ?>" data-toggle="tooltip" title="<?php echo $cart_btn_text; ?>" id="button-cart"><i class="<?php echo $cart_btn_icon; ?>"></i><span><?php echo $cart_btn_text; ?></span></button>
															<?php if ($show_quick_order && $quantity > 0) { ?>
															<button type="button" class="quick_order button btn btn-default btn-lg" data-toggle="tooltip" title="<?php echo $quick_order_title; ?>" onclick="quick_order('<?php echo $product_id; ?>');"><i class="<?php echo $quick_order_icon; ?>"></i><?php echo ($show_quick_order_text_product ? '<span class="hidden-xs hidden-sm hidden-md">'.$quick_order_title.'</span>' : '') ?></button>
															<?php } ?>
														</div>
														<?php if ($minimum > 1) { ?><div class="alert alert-info minimum"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div><?php } ?>
													</li>
													<?php if ($discounts) { ?>
													<li class="discount">
														<hr>
														<?php foreach ($discounts as $discount) { ?>
														<span><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></span>
														<?php } ?>
													</li>
													<?php } ?>
												</ul>
												<?php } ?>
												<div class="option row">
													<?php if ($options) { ?>
													<div class="col-xs-12"><hr /></div>
													<div class="col-xs-12"><h5 class="heading"><span><?php echo $text_option; ?></span></h5></div>
													<?php foreach ($options as $option) { ?>
													<?php if ($option['type'] == 'select') { ?>
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> options_select col-xs-12 col-sm-6">
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
													<?php if ($option['type'] == 'radio') { ?>
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> col-xs-12 ">
														<label class="control-label"><?php echo $option['name']; ?></label>
														<div id="input-option<?php echo $option['product_option_id']; ?>">
															<?php foreach ($option['product_option_value'] as $option_value) { ?>
															<div class="radio">
																<label class="input">
																	<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="<?php echo $option['product_option_id']; ?>_<?php echo $option_value['product_option_value_id']; ?>" />
																	<?php if ($option_value['image']) { ?>
																	<span class="img" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" data-toggle="tooltip" data-thumb="<?php echo $option_value['small']; ?>" data-full="<?php echo $option_value['full']; ?>">
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
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> col-xs-12 ">
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
													<?php if ($option['type'] == 'image') { ?>
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> col-xs-12 ">
														<label class="control-label"><?php echo $option['name']; ?></label>
														<div id="input-option<?php echo $option['product_option_id']; ?>">
															<?php foreach ($option['product_option_value'] as $option_value) { ?>
															<div class="radio">
																<label>
																	<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="<?php echo $option['product_option_id']; ?>_<?php echo $option_value['product_option_value_id']; ?>" />
																	<span class="img" data-toggle="tooltip" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" data-thumb="<?php echo $option_value['small']; ?>" data-full="<?php echo $option_value['full']; ?>">
																<img src="<?php echo $option_value['image']; ?>" data-toggle="tooltip" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
															</span>
																</label>
															</div>
															<?php } ?>
														</div>
													</div>
													<?php } ?>
													<?php if ($option['type'] == 'text') { ?>
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> col-xs-12 ">
														<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
														<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
													</div>
													<?php } ?>
													<?php if ($option['type'] == 'textarea') { ?>
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> col-xs-12 ">
														<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
														<textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
													</div>
													<?php } ?>
													<?php if ($option['type'] == 'file') { ?>
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> col-xs-12 ">
														<label class="control-label"><?php echo $option['name']; ?></label>
														<button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
														<input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
													</div>
													<?php } ?>
													<?php if ($option['type'] == 'date') { ?>
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> col-xs-12 ">
														<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
														<div class="input-group date">
															<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
															<span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span>
														</div>
													</div>
													<?php } ?>
													<?php if ($option['type'] == 'datetime') { ?>
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> col-xs-12 ">
														<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
														<div class="input-group datetime">
															<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
															<span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
														</div>
													</div>
													<?php } ?>
													<?php if ($option['type'] == 'time') { ?>
													<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> col-xs-12 ">
														<label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
														<div class="input-group time">
															<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
															<span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
														</div>
													</div>
													<?php } ?>
													<?php } ?>
													<?php } ?>
													<?php if ($recurrings) { ?>
													<hr>
													<h3><?php echo $text_payment_recurring ?></h3>
													<div class="form-group required">
														<select name="recurring_id" class="form-control">
															<option value=""><?php echo $text_select; ?></option>
															<?php foreach ($recurrings as $recurring) { ?>
															<option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
															<?php } ?>
														</select>
														<div class="help-block" id="recurring-description"></div>
													</div>
													<?php } ?>
												</div>

											</div>
											<?php } ?>
											<?php if ($show_additional_tab) { ?>
											<div class="tab-pane" id="tab-additional_tab" itemprop="description"><?php echo $additional_tab_text; ?></div>
											<?php } ?>
											<?php if(isset($product_tabs)) { ?>
											<?php foreach($product_tabs as $key => $tab){ ?>
											<div class="tab-pane" id="tab-<?php echo $product_id ?>-<?php echo $tab['product_tab_id']; ?>"><?php echo $tab['description']; ?></div>
											<?php } ?>
											<?php } ?>
										</div>
									</div>
								</div>
							</div>
						</div>

<!----------------------------------------Табы для комплекта товаров END------------------------------------>




						<hr <?php if ($options) { ?>style="margin-top:0"<?php } ?> />
						<?php if ($show_product_attr && $attribute_groups) { ?>
							<h5 class="heading"><span><?php echo $lang['text_short_attributes']; ?></span></h5>
							<div class="attributes">
								<?php foreach ($attribute_groups as $key => $attribute_group) { ?>
									<?php if ($key < $show_product_attr_group) { ?>
										<?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
											<?php if ($key < $show_product_attr_item) { ?>
												<div class="attribute">
													<span><span><?php echo $attribute['name']; ?></span></span>
													<span><span><?php echo $attribute['text']; ?></span></span>
												</div>
											<?php } ?>
										<?php } ?>
									<?php } ?>
								<?php } ?>
							</div>
							<a href="" class="show_attr" onclick="$('a[href=\'#tab-specification\']').trigger('click'); scroll_to('#tab-specification'); return false;"><?php echo $lang['text_all_attributes']; ?></a>
							<hr />
						<?php } ?>
						<div class="row">
							<div class="share col-sm-12 col-md-12 col-lg-6">
								<script type="text/javascript" src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js" charset="utf-8"></script>
								<script type="text/javascript" src="//yastatic.net/share2/share.js" charset="utf-8"></script>
								<div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki,gplus,twitter,viber,whatsapp" data-counter=""></div>
							</div>
							<div class="col-sm-12 col-md-12 visible-xs visible-sm visible-md"><hr /></div>
							<?php if ($review_status) { ?>
								<div class="rating col-xs-7 col-sm-8 col-md-12 col-lg-6">
									<?php for ($i = 1; $i <= 5; $i++) { ?>
										<?php if ($rating < $i) { ?>
											<i class="fa fa-star-o"></i>
										<?php } else { ?>
											<i class="fa fa-star"></i>
										<?php } ?>
									<?php } ?>

									<?php if ($rating ) { ?>
										<div itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating" style="display:none">
											<span itemprop="ratingValue"><?php echo $rating; ?></span>
											<span itemprop="reviewCount"><?php echo preg_replace('/[^\d.]/','',$reviews); ?></span>
										</div>
									<?php } ?>
									<i class="fa fa-comments-o" aria-hidden="true"></i><a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); scroll_to('#tab-review'); return false;"><span class="hidden-xs"><?php echo $reviews; ?></span><span class="visible-xs"><?php echo preg_replace("/[^0-9]/", '', $reviews); ?></span></a>
								</div>
								<div class="btn-group col-xs-5 col-sm-4 visible-xs visible-sm">
									<button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $lang["text_question"]; ?>" onclick="callback('<?php echo $lang["text_question"]; ?>', '<?php echo $product_id; ?>');"><i class="fa fa-question"></i></button>
									<?php if(!$wishlist_btn_disabled) { ?><button type="button" data-toggle="tooltip" class="wishlist btn btn-default" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></button><?php } ?>
									<?php if(!$compare_btn_disabled) { ?><button type="button" data-toggle="tooltip" class="compare btn btn-default" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-exchange"></i></button><?php } ?>
								</div>
							<?php } ?>
							<div class="col-sm-12 col-md-12 visible-xs visible-sm visible-md"><hr /></div>
						</div>
						<hr />
					</div>
					<div class="col-sm-12 col-md-2">
						<div class="product_button btn-group hidden-xs hidden-sm">
							<button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $lang["text_question"]; ?>" onclick="callback('<?php echo $lang["text_question"]; ?>', '<?php echo $product_id; ?>');"><i class="fa fa-question"></i></button>
							<?php if(!$wishlist_btn_disabled) { ?><button type="button" data-toggle="tooltip" class="wishlist btn btn-default" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></button><?php } ?>
							<?php if(!$compare_btn_disabled) { ?><button type="button" data-toggle="tooltip" class="compare btn btn-default" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-exchange"></i></button><?php } ?>
						</div>
			<!-- <hr /> -->
						<div class="row">
							<div class="product_banners">
								<?php foreach($product_banners as $product_banner) { ?>
									<div class="col-xs-6 col-sm-4 col-md-12">
										<div <?php if($product_banner['link']) { ?>class="has_link"<?php } ?> <?php if($product_banner['link'] && !isset($product_banner['link_popup'])) { ?>onclick="location='<?php echo $product_banner['link']; ?>'"<?php } ?><?php if($product_banner['link'] && isset($product_banner['link_popup'])) { ?>onclick="banner_link('<?php echo $product_banner['link']; ?>');"<?php } ?>>
											<i class="<?php echo $product_banner['icon']; ?>"></i>
											<span><span><?php echo html_entity_decode($product_banner['text'], ENT_QUOTES, 'UTF-8'); ?></span></span>
										</div>
									</div>
								<?php } ?>
							</div>
						</div>
						<hr class="visible-xs visible-sm" />
					</div>
				</div>
				<?php if ($show_manufacturer && $manufacturer_position) { ?>
					<h3 class="heading"><span><?php if($manufacturer_title) { echo $manufacturer_title; } else { echo $manufacturer_name; } ?></span></h3>
					<div class="manufacturer_block row">
						<?php if($manufacturer_image)  { ?>
							<div class="col-xs-4 col-sm-2">
								<img src="<?php echo $manufacturer_image; ?>" alt="<?php echo $manufacturer_name; ?>" class="img-responsive"/>
							</div>
						<?php } ?>
						<div class="<?php if($manufacturer_image)  { ?>col-xs-8 col-sm-10<?php } else { ?>col-xs-12<?php } ?>">
							<h4><?php echo $manufacturer_name; ?></h4>
							<div class="description"><?php echo $manufacturer_description; ?>... <a href="<?php echo $manufacturer_href; ?>" title="" ><?php echo $lang['text_manufacturer_more']; ?></a></div>
						</div>
					</div>
					<hr />
					<div style="height:10px; clear:both;"></div>
				<?php } ?>
				<div class="row">
					<div class="col-xs-12">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#tab-description" data-toggle="tab"><i class="fa fa-file-text-o" aria-hidden="true"></i><?php echo $tab_description; ?></a></li>
				            <?php if ($attribute_groups) { ?>
								<li><a href="#tab-specification" data-toggle="tab"><i class="fa fa-list-alt" aria-hidden="true"></i><?php echo $tab_attribute; ?></a></li>
							<?php } ?>
							<?php if ($review_status) { ?>
								<li><a href="#tab-review" data-toggle="tab"><i class="fa fa-comments-o" aria-hidden="true"></i><?php echo $tab_review; ?></a></li>
							<?php } ?>
							<?php if ($show_additional_tab) { ?>
								<li><a href="#tab-additional_tab" data-toggle="tab"><i class="<?php echo $additional_tab_icon; ?>"></i><?php echo $additional_tab_title; ?></a></li>
							<?php } ?>
							<?php if(isset($product_tabs)) { ?>
								<?php foreach($product_tabs as $key => $tab){ ?>
									<li><a href="#tab-<?php echo $product_id ?>-<?php echo $tab['product_tab_id']; ?>" data-toggle="tab"><?php echo $tab['title']; ?></a></li>
								<?php } ?>
							<?php } ?>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tab-description" itemprop="description"><?php echo $description; ?></div>
							<?php if ($attribute_groups) { ?>
								<div class="tab-pane" id="tab-specification">
									<div class="row">
										<?php $i = 1; ?>
										<?php foreach ($attribute_groups as $key => $attribute_group) { ?>
											<div class="attributes <?php if(count($attribute_groups) > 1) { ?>col-sm-6 col-md-6<?php } else { ?>col-sm-12 col-md-12<?php } ?>" >
												<hr class="visible-xs" />
												<h4 class="heading"><span><?php echo $attribute_group['name']; ?></span></h4>
												<div class="attribute">
													<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
														<div>
															<span><span><?php echo $attribute['name']; ?></span></span>
															<span><span><?php echo $attribute['text']; ?></span></span>
														</div>
													<?php } ?>
												</div>
											</div>
										<?php } ?>
									</div>
								</div>
							<?php } ?>
							<?php if ($review_status) { ?>
								<div class="tab-pane" id="tab-review">
									<div id="review"></div>
									<form class="form-horizontal" id="form-review">
										<?php if ($review_guest) { ?>
											<div class="rev_form well well-sm">
												<div class="form-group required">
													<div class="col-sm-12">
														<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
														<input type="text" name="name" value="" id="input-name" class="form-control" />
													</div>
												</div>
												<?php if($show_plus_minus_review) { ?>
													<div class="form-group <?php if($plus_minus_review_required) { ?>required<?php } ?>">
														<div class="col-sm-12">
															<label class="control-label" for="input-review-minus"><?php echo $lang['entry_plus']; ?></label>
															<textarea name="plus" rows="5" id="input-review-minus" class="form-control"></textarea>
														</div>
													</div>
													<div class="form-group <?php if($plus_minus_review_required) { ?>required<?php } ?>">
														<div class="col-sm-12">
															<label class="control-label" for="input-review-plus"><?php echo $lang['entry_minus']; ?></label>
															<textarea name="minus" rows="5" id="input-review-plus" class="form-control"></textarea>
														</div>
													</div>
												<?php } else { ?>
													<input type="hidden" name="plus" value="" />
													<input type="hidden" name="minus" value="" />
												<?php } ?>
												<div class="form-group required">
													<div class="col-sm-12">
														<label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
														<textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
														<div class="help-block"><?php echo $text_note; ?></div>
													</div>
												</div>
												<div class="form-group required">
													<div class="col-sm-12">
														<label class="control-label"><?php echo $entry_rating; ?></label>
														<div class="review_star">
															<input type="radio" name="rating" value="1" />
															<input type="radio" name="rating" value="2" />
															<input type="radio" name="rating" value="3" />
															<input type="radio" name="rating" value="4" />
															<input type="radio" name="rating" value="5" />
															<div class="stars">
																<i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
															</div>
														</div>
													</div>
												</div>
												<?php echo $captcha; ?>
												<div class="text-right clearfix">
													<button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $lang['add_new_review']; ?></button>
												</div>
											</div>
										<?php } else { ?>
											<?php echo $text_login; ?>
										<?php } ?>
									</form>
								</div>
							<?php } ?>
							<?php if ($show_additional_tab) { ?>
								<div class="tab-pane" id="tab-additional_tab" itemprop="description"><?php echo $additional_tab_text; ?></div>
							<?php } ?>
							<?php if(isset($product_tabs)) { ?>
								<?php foreach($product_tabs as $key => $tab){ ?>
									<div class="tab-pane" id="tab-<?php echo $product_id ?>-<?php echo $tab['product_tab_id']; ?>"><?php echo $tab['description']; ?></div>
								<?php } ?>
							<?php } ?>
						</div>
					</div>
				</div>
				<hr />
			<?php if ($products_group) { ?>
				<div class="row">
					<div class="col-xs-12">
						<h3 class="heading select-group"><span>Выбрать по элементам</span></h3>
						<?php if (isset($product_group_categories) && $product_group_categories) {?>
							<ul class="nav nav-tabs">
								<?php foreach ($product_group_categories as $key => $category) { ?>
									<li<?php if (!$key) { ?> class="active"<?php } ?>>
										<a href="#tab-category-<?php echo $key;?>" data-toggle="tab"><i class="fa fa-file-text-o" aria-hidden="true"></i><?php echo $category['name']; ?></a>
									</li>
								<?php } ?>
							</ul>
							<div class="tab-content">
								<?php foreach ($product_group_categories as $key => $category) { ?>
									<div class="tab-pane<?php if (!$key) { ?> active<?php } ?>" id="tab-category-<?php echo $key;?>">
										<div class="products product_related1">
											<?php foreach ($products_group[$category['category_id']] as $product) { ?>
												<div class="product-layout col-sm-3">
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

																			<!-- devos Attribute ext - start -->
																			<?php if(isset($attribute['dae_view'])){ echo $attribute['dae_view']; continue; } ?>
																			<!-- devos Attribute end - start -->


																			<!-- devos Attribute ext - start -->
																			<?php if(isset($attribute['dae_view'])){ echo $attribute['dae_view']; continue; } ?>
																			<!-- devos Attribute end - start -->


																			<!-- devos Attribute ext - start -->
																			<?php if(isset($attribute['dae_view'])){ echo $attribute['dae_view']; continue; } ?>
																			<!-- devos Attribute end - start -->

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
																							<option value="<?php echo $option_value['product_option_value_id']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>"><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?>
																									(<?php echo ($option_value['price_prefix'] == '+' || $option_value['price_prefix'] == '-' ? $option_value['price_prefix'] : '') . $option_value['price']; ?>)
																								<?php } ?></option>
																						<?php } ?>
																					</select>
																				<?php } ?>
																				<?php if ($option['type'] == 'checkbox' || $option['type'] == 'radio' || $option['type'] == 'image') { ?>
																					<?php foreach ($option['product_option_value'] as $option_value) { ?>
																						<label class="input">
																							<?php if ($option['type'] == 'checkbox') { ?>
																								<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
																							<?php } ?>
																							<?php if ($option['type'] == 'radio' || $option['type'] == 'image') { ?>
																								<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
																								<?php if($option_value['image']) { ?>
																									<span class="img" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" data-toggle="tooltip" data-thumb="<?php echo $option_value['small']; ?>">
																						<img src="<?php echo $option_value['image']; ?>" data-toggle="tooltip" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
																					</span>
																								<?php } ?>
																							<?php } ?>
																							<span><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?><span>
																									(<?php echo ($option_value['price_prefix'] == '+' || $option_value['price_prefix'] == '-' ? $option_value['price_prefix'] : '') . $option_value['price']; ?>)
																									</span><?php } ?></span>
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
																	<?php if ($product['tax']) { ?><span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span><?php } ?>
																</p>
															<?php } ?>
														</div>
														<div class="cart">
															<button type="button" class="add_to_cart button btn btn-default <?php echo $product['cart_btn_class']; ?> <?php echo $product['product_id']; ?>" data-toggle="tooltip" title="<?php echo $product['cart_btn_text']; ?>" onclick="cart.add('<?php echo $product['product_id'] ?>');"><i class="<?php echo $product['cart_btn_icon']; ?>"></i><span class="hidden-sm"><?php echo $product['cart_btn_text']; ?></span></button>
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
								<?php } ?>
							</div>
						<?php } else { ?>
							<div class="products product_related1">
								<?php foreach ($products_group[0] as $product) { ?>
									<div class="product-layout col-sm-3">
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

																<!-- devos Attribute ext - start -->
																<?php if(isset($attribute['dae_view'])){ echo $attribute['dae_view']; continue; } ?>
																<!-- devos Attribute end - start -->


																<!-- devos Attribute ext - start -->
																<?php if(isset($attribute['dae_view'])){ echo $attribute['dae_view']; continue; } ?>
																<!-- devos Attribute end - start -->


																<!-- devos Attribute ext - start -->
																<?php if(isset($attribute['dae_view'])){ echo $attribute['dae_view']; continue; } ?>
																<!-- devos Attribute end - start -->

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
																				<option value="<?php echo $option_value['product_option_value_id']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>"><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?>
																						(<?php echo ($option_value['price_prefix'] == '+' || $option_value['price_prefix'] == '-' ? $option_value['price_prefix'] : '') . $option_value['price']; ?>)
																					<?php } ?></option>
																			<?php } ?>
																		</select>
																	<?php } ?>
																	<?php if ($option['type'] == 'checkbox' || $option['type'] == 'radio' || $option['type'] == 'image') { ?>
																		<?php foreach ($option['product_option_value'] as $option_value) { ?>
																			<label class="input">
																				<?php if ($option['type'] == 'checkbox') { ?>
																					<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
																				<?php } ?>
																				<?php if ($option['type'] == 'radio' || $option['type'] == 'image') { ?>
																					<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" data-points="<?php echo (isset($option_value['points_value']) ? $option_value['points_value'] : 0); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo $option_value['price_value']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
																					<?php if($option_value['image']) { ?>
																						<span class="img" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" data-toggle="tooltip" data-thumb="<?php echo $option_value['small']; ?>">
																						<img src="<?php echo $option_value['image']; ?>" data-toggle="tooltip" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
																					</span>
																					<?php } ?>
																				<?php } ?>
																				<span><?php echo $option_value['name']; ?><?php if ($option_value['price']) { ?><span>
																						(<?php echo ($option_value['price_prefix'] == '+' || $option_value['price_prefix'] == '-' ? $option_value['price_prefix'] : '') . $option_value['price']; ?>)
																						</span><?php } ?></span>
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
														<?php if ($product['tax']) { ?><span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span><?php } ?>
													</p>
												<?php } ?>
											</div>
											<div class="cart">
												<button type="button" class="add_to_cart button btn btn-default <?php echo $product['cart_btn_class']; ?> <?php echo $product['product_id']; ?>" data-toggle="tooltip" title="<?php echo $product['cart_btn_text']; ?>" onclick="cart.add('<?php echo $product['product_id'] ?>');"><i class="<?php echo $product['cart_btn_icon']; ?>"></i><span class="hidden-sm"><?php echo $product['cart_btn_text']; ?></span></button>
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
						<?php } ?>
					</div>
				</div>
			<?php } ?>
				<?php if ($show_manufacturer && !$manufacturer_position) { ?>
					<h3 class="heading"><span><?php if($manufacturer_title) { echo $manufacturer_title; } else { echo $manufacturer_name; } ?></span></h3>
					<div class="manufacturer_block row">
						<?php if($manufacturer_image)  { ?>
							<div class="col-xs-4 col-sm-2">
								<img src="<?php echo $manufacturer_image; ?>" alt="<?php echo $manufacturer_name; ?>" class="img-responsive"/>
							</div>
						<?php } ?>
						<div class="<?php if($manufacturer_image)  { ?>col-xs-8 col-sm-10<?php } else { ?>col-xs-12<?php } ?>">
							<h4><?php echo $manufacturer_name; ?></h4>
							<div class="description"><?php echo $manufacturer_description; ?>... <a href="<?php echo $manufacturer_href; ?>" title="" ><?php echo $lang['text_manufacturer_more']; ?></a></div>
						</div>
					</div>
					<hr />
					<div style="height:10px; clear:both;"></div>
				<?php } ?>
				<?php if ($products) { ?>
					<div class="row product_carousel">
						<h3 class="heading"><span><?php echo $text_related; ?></span></h3>
						<div class="products product_related">
							<?php foreach ($products as $product) { ?>
								<div class="product-layout">
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
													<?php if ($product['tax']) { ?><span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span><?php } ?>
												</p>
											<?php } ?>
										</div>
										<div class="cart">
											<button type="button" class="add_to_cart button btn btn-default <?php echo $product['cart_btn_class']; ?> <?php echo $product['product_id']; ?>" data-toggle="tooltip" title="<?php echo $product['cart_btn_text']; ?>" onclick="cart.add('<?php echo $product['product_id'] ?>');"><i class="<?php echo $product['cart_btn_icon']; ?>"></i><span class="hidden-sm"><?php echo $product['cart_btn_text']; ?></span></button>
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
					<hr />
				<?php } ?>
			<script type="text/javascript">
				$('.product_related').each(function (index, element) {
					var id = 'product_related' + '-'  + index;
					$(element).attr('id', id);
					module_type_view('carousel', '#' + id);

				});
				//						module_type_view('carousel', '.product_related');
			</script>
				<?php if(isset($auto_related)) {echo $auto_related;} ?>
				<?php if ($tags) { ?>
				    <p>
						<i class="fa fa-tag" data-toggle="tooltip" title="<?php echo $text_tags; ?>"></i>
						<?php for ($i = 0; $i < count($tags); $i++) { ?>
							<?php if ($i < (count($tags) - 1)) { ?>
								<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
							<?php } else { ?>
								<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
							<?php } ?>
						<?php } ?>
				    </p>
					<hr style="margin-bottom:20px" />
				<?php } ?>
				<?php echo $content_bottom; ?>
			</div>
			<?php //echo $column_right; ?>
		</div>
</div>
<script type="text/javascript">
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});

$('#button-cart').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
						
						$('#content').parent().before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['option'][i] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				//$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				$('.tooltip').remove();
				$('#content').parent().before('<div id="add_to_cart_success">'+json['success_new']+'</div>');
				$('#add_to_cart_success').popup({
					transition: 'all 0.3s',
					closetransitionend: function () {
						$(this).remove();
					}
				});
				$('#add_to_cart_success').popup('show');
				
				product_id = $('input[name=\'product_id\']').val();
				$('#cart > button').html('<i class="fa fa-shopping-basket"></i><span id="cart-total">' + json['total_items'] + '</span>');
				replace_button(product_id);

				$('#cart > ul').load('index.php?route=common/cart/info ul li');
				$('#cart').addClass('show');
			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});

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

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});





$('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();
    $('#review').fadeOut('slow').load(this.href).fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				//$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
				$('#content').parent().before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}

			if (json['success']) {
				$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
				$('#form-review input, #form-review textarea').val('');
				$('.review_star input').attr('checked', false).prop('checked', false);
				$('#form-review').slideToggle();
			}
		}
	});
});

$(document).ready(function() {
	var img_array = [];
	
	$p_block = $('#product .thumbnails');

	$p_block.find('.image-additional a').each(function() {
		$(this).on('click', function(e) {
			e.preventDefault();
			$(this).addClass('selected')
			$p_block.find('.image-additional a').not($(this)).removeClass('selected');
			$p_block.find('li:first a').attr('href', $(this).attr('href')).attr('data-key', $(this).attr('data-key'));
			$p_block.find('li:first img').attr('src', $(this).attr('data-thumb'));
		});
		img_array.push({src:$(this).attr('href'), type:'image', title:$(this).attr('title')});
	});
	
	if(img_array.length == 0) {
		img_array.push({src:$p_block.find('li:first a').attr('href'), type:'image', title:$p_block.find('li:first a').attr('title')});
	}

	$p_block.find('li:first a').click(function(e) {
		e.preventDefault();
		$.magnificPopup.open({
			items:img_array,
			gallery:{
				enabled:true,
			},
		});
		$.magnificPopup.instance.goTo(parseFloat($(this).attr('data-key')));
	});

	$('.nav-tabs a').each(function() {
		var href = $(this).attr('href');	
		if (window.location.hash == href) {
			$($(this)).trigger('click');
			scroll_to(window.location.hash);
		}
	});
	
	$('.review_star input').hover(function(){
		var stars = $(this).val();
		$('.stars i').addClass('fa-star-o');
		$('.stars i:lt('+stars+')').addClass('fa-star').removeClass('fa-star-o');
	},
	function(){
		var start = $('input:radio[name=rating]:checked').val()
		if(start == 'undefined' ){start = 0; } 
		$('.stars i').addClass('fa-star-o');
		$('.stars i:lt('+start+')').addClass('fa-star').removeClass('fa-star-o');
	});
	
	$('.review_star input').click(function(){	
		$('.review_star input').each(function(){
			$('.review_star input').not($(this)).attr('checked', false);
		});
		$(this).attr('checked', true).prop('checked', true);

	});

});
</script>
<?php echo $footer; ?>