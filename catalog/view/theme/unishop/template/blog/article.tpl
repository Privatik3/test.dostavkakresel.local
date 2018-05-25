<?php echo $header; ?>
<div class="container" itemscope itemtype="http://schema.org/Article" >
	<ul class="breadcrumb <?php if (in_array('uni_blog/article', $menu_schema)) { ?>col-md-offset-4 col-lg-offset-3<?php } ?>">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<div class="row"><?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-4 col-md-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-sm-8 col-md-8 col-lg-9'; ?>
		<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<?php if (in_array('uni_blog/article', $menu_schema) && !$column_left && $column_right) { $class = 'col-sm-8 col-md-8 col-lg-6 col-md-offset-4 col-lg-offset-3'; } ?>
		<?php if (in_array('uni_blog/article', $menu_schema) && !$column_left && !$column_right) { $class = 'col-sm-8 col-md-8 col-lg-9 col-md-offset-4 col-lg-offset-3'; } ?>
		<div id="content" class="blog_article <?php echo $class; ?>"><?php echo $content_top; ?>
			<div class="row">
				<div class="col-xs-12">
					<h1 class="heading"><span itemprop="headline"><?php echo $heading_title; ?></span></h1>
					<div class="article row">
						<div class="col-xs-12" style="margin-bottom:20px;">
							<div class="row" style="margin:0;">
							<?php if (isset($thumb)) { ?>
								<div class="image">
									<a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="img-popup"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" itemprop="image" /></a>
								</div>
							<?php } ?>
							<div class="description">
								<?php if (isset($short_description)) { ?><div itemprop="description"><?php echo $short_description; ?></div><?php } ?>
								<div itemprop="articleBody"><?php echo $description; ?></div>
							</div>
							</div>
							<hr />
							<div class="row">
								<div class="col-xs-12 col-sm-6 text-left">
									<script type="text/javascript" src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js" charset="utf-8"></script>
									<script type="text/javascript" src="//yastatic.net/share2/share.js" charset="utf-8"></script>
									<div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki,gplus,twitter,viber,whatsapp" data-counter=""></div>
								</div>
								<div class="posted col-xs-12 col-sm-6 text-right"></div>
							</div>
							<hr />
							<?php if ($download_status) { ?>
								<div class="row">
									<div class="col-xs-12">
										<?php if($downloads){ ?>
											<?php foreach($downloads as $download){ ?>
												<a href="<?php echo $download['href']; ?>" title=""><i class="fa fa-floppy-o"></i> <?php echo $download['name']; ?> <?php echo " (". $download['size'] .")";?></a><br>
											<?php } ?>
											<hr />
										<?php } ?> 
									</div>
								</div>
							<?php } ?>
						</div>
					</div>
					<?php if ($review_status) { ?>
						<div class="row">
							<div class="col-xs-12" style="margin-bottom:20px;">
							<h3 class="heading"><span><?php echo $text_write; ?></span></h3>
								<div id="review"></div>
								<div class="text-right"><button class="btn btn-primary" onclick="$('#form-review').slideToggle();"><?php echo $text_write; ?></button></div>
								<form class="form-horizontal" id="form-review">
									<?php if ($review_guest) { ?>
										<div class="rev_form well well-sm">
											<div class="form-group required">
												<div class="col-sm-12">
													<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
													<input type="text" name="name" value="" id="input-name" class="form-control" />
												</div>
											</div>
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
												<button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $text_write; ?></button>
											</div>
										</div>
									<?php } else { ?>
										<?php echo $text_login; ?>
									<?php } ?>
								</form>
							</div>
						</div>
					<?php } ?>
				</div>
			</div>
			<?php if ($articles) { ?>
				<h3 class="heading"><span><?php echo $text_related; ?></span></h3>
				<div class="row">
					<?php $i = 0; ?>
					<?php foreach ($articles as $article) { ?>
						<?php if ($column_left && $column_right) { ?>
							<?php $class = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
							<?php } elseif ($column_left || $column_right) { ?>
							<?php $class = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
							<?php } else { ?>
							<?php $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
						<?php } ?>
						<div class="<?php echo $class; ?>">
							<div class="product-thumb transition">
								<div class="image"><a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class="img-responsive" /></a></div>
								<div class="caption">
									<h4><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>
									<p><?php echo $article['description']; ?></p>
									<?php if ($article['rating'] >= 0) { ?>
										<div class="rating">
											<?php for ($i = 1; $i <= 5; $i++) { ?>
												<?php if ($article['rating'] < $i) { ?>
													<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } else { ?>
													<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i></span>
												<?php } ?>
											<?php } ?>
										</div>
									<?php } ?>
								</div>
							</div>
						</div>
						<?php if (($column_left && $column_right) && ($i % 2 == 0)) { ?>
							<div class="clearfix visible-md visible-sm"></div>
							<?php } elseif (($column_left || $column_right) && ($i % 3 == 0)) { ?>
							<div class="clearfix visible-md"></div>
							<?php } elseif ($i % 4 == 0) { ?>
							<div class="clearfix visible-md"></div>
						<?php } ?>
						<?php $i++; ?>
					<?php } ?>
				</div>
			<?php } ?>
			<?php if ($products) { ?>
				<div class="row product_carousel">
					<h3 class="heading"><span><?php echo $text_related_product; ?></span></h3>
					<div class="products product_related">
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
												<?php if ($product['tax']) { ?><span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span><?php } ?>
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
					module_type_view('carousel', '.product_related');
				</script>
			<?php } ?>
			<?php if (isset($tags)) { ?>
				<p><?php echo $text_tags; ?>
					<?php for ($i = 0; $i < count($tags); $i++) { ?>
						<?php if ($i < (count($tags) - 1)) { ?>
							<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
							<?php } else { ?>
							<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
						<?php } ?>
					<?php } ?>
				</p>
			<?php } ?>
		<?php echo $content_bottom; ?></div>
	<?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
	$('#review').delegate('.pagination a', 'click', function(e) {
		e.preventDefault();
		
		$('#review').fadeOut('slow');
		
		$('#review').load(this.href);
		
		$('#review').fadeIn('slow');
	});
	
	$('#review').load('index.php?route=blog/article/review&article_id=<?php echo $article_id; ?>');
	
	$('#button-review').on('click', function() {
		$.ajax({
			url: 'index.php?route=blog/article/write&article_id=<?php echo $article_id; ?>',
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
					$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
				}
				
				if (json['success']) {
					$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
					
					$('input[name=\'name\']').val('');
					$('textarea[name=\'text\']').val('');
					$('input[name=\'rating\']:checked').prop('checked', false);
				}
			}
		});
	});
	
	$(document).ready(function() {
		$('.article .description img').each(function() {
			var href = $(this).attr('src');
			$(this).addClass('img-responsive').attr('itemprop', 'image');
			$(this).wrap('<a href="'+href+'" style="max-width:350px; overflow:auto;" class="img-popup"></a>');
		});
	
		$('.article .image, .article .description').magnificPopup({
			type:'image',
			delegate:'a.img-popup',
			gallery: {
				enabled:true
			}
		});
		
		var hash = window.location.hash;	
		if (hash) {
			scroll_to(hash);
		}
		
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
//--></script>
<?php echo $footer; ?>