<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-article" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
			<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
					<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
			<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-article" class="form-horizontal">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
						<li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
						<li><a href="#tab-design" data-toggle="tab"><?php echo $tab_design; ?></a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">
							<ul class="nav nav-tabs" id="language">
								<?php foreach ($languages as $language) { ?>
									<li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab">
									<img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" />
									<?php echo $language['name']; ?>
									</a></li>
								<?php } ?>
							</ul>
							<div class="tab-content">
								<?php foreach ($languages as $language) { ?>
									<div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
										<div class="form-group required">
											<label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name; ?></label>
											<div class="col-sm-10">
												<input type="text" name="article_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
												<?php if (isset($error_name[$language['language_id']])) { ?>
													<div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
												<?php } ?>
											</div>
										</div>	
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-meta-keyword<?php echo $language['language_id']; ?>"><?php echo $entry_short_description; ?></label>
											<div class="col-sm-10">
												<textarea name="article_description[<?php echo $language['language_id']; ?>][short_description]" rows="5" placeholder="<?php echo $entry_short_description; ?>" id="input-short-description<?php echo $language['language_id']; ?>" data-lang="ru-RU" class="form-control summernote"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['short_description'] : ''; ?></textarea>
											</div>
										</div>
										<div class="form-group required">
											<label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
											<div class="col-sm-10">
												<textarea name="article_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" data-lang="ru-RU" class="form-control summernote"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['description'] : ''; ?></textarea>
												<?php if (isset($error_description[$language['language_id']])) { ?>
													<div class="text-danger"><?php echo $error_description[$language['language_id']]; ?></div>
												<?php } ?>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-meta-title<?php echo $language['language_id']; ?>"><?php echo $entry_meta_title; ?></label>
											<div class="col-sm-10">
												<input type="text" name="article_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_title'] : ''; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title<?php echo $language['language_id']; ?>" class="form-control" />
												<?php if (isset($error_meta_title[$language['language_id']])) { ?>
													<div class="text-danger"><?php echo $error_meta_title[$language['language_id']]; ?></div>
												<?php } ?>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-meta-h1<?php echo $language['language_id']; ?>"><?php echo $entry_meta_h1; ?></label>
											<div class="col-sm-10">
												<input type="text" name="article_description[<?php echo $language['language_id']; ?>][meta_h1]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_h1'] : ''; ?>" placeholder="<?php echo $entry_meta_h1; ?>" id="input-meta-h1<?php echo $language['language_id']; ?>" class="form-control" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-meta-description<?php echo $language['language_id']; ?>"><?php echo $entry_meta_description; ?></label>
											<div class="col-sm-10">
												<textarea name="article_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-meta-keyword<?php echo $language['language_id']; ?>"><?php echo $entry_meta_keyword; ?></label>
											<div class="col-sm-10">
												<textarea name="article_description[<?php echo $language['language_id']; ?>][meta_keyword]" rows="5" placeholder="<?php echo $entry_meta_keyword; ?>" id="input-meta-keyword<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-tag<?php echo $language['language_id']; ?>"><span data-toggle="tooltip" title="<?php echo $help_tag; ?>"><?php echo $entry_tag; ?></span></label>
											<div class="col-sm-10">
												<input type="text" name="article_description[<?php echo $language['language_id']; ?>][tag]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['tag'] : ''; ?>" placeholder="<?php echo $entry_tag; ?>" id="input-tag<?php echo $language['language_id']; ?>" class="form-control" />
											</div>
										</div>
									</div>
								<?php } ?>
							</div>
						</div>
						<div class="tab-pane" id="tab-data">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-category"><?php echo $entry_category; ?></label>
								<div class="col-sm-10">
									<div class="scrollbox" style="margin-bottom:6px;">
											<?php foreach ($article_categories as $category) { ?>
												<div>
													<?php if (in_array($category['category_id'], $category_id)) { ?>
														<label><input type="checkbox" name="article_category[]" value="<?php echo $category['category_id']; ?>" checked="checked" /> <?php echo $category['name']; ?></label>
													<?php } else { ?>
														<label><input type="checkbox" name="article_category[]" value="<?php echo $category['category_id']; ?>" /> <?php echo $category['name']; ?></label>
													<?php } ?>
												</div>
											<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').attr('checked', true).prop('checked', true);"><?php echo $text_select_all; ?></a>
									/ 
									<a onclick="$(this).parent().find(':checkbox').attr('checked', false).prop('checked', false);"><?php echo $text_unselect_all; ?></a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-author"><?php echo $entry_author; ?></label>
								<div class="col-sm-10">
									<select name="article_author" id="input-author" class="form-control">
										<?php foreach($authors as $author){ ?>
											<?php if($author['user_id'] == $article_author){ ?>
												<option value="<?php echo $author['user_id']; ?>" selected="selected"><?php echo $author['username']; ?></option>
												<?php } else { ?>
												<option value="<?php echo $author['user_id']; ?>" ><?php echo $author['username']; ?></option>
											<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
								<div class="col-sm-10">
									<a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
									<input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-keyword"><span data-toggle="tooltip" title="<?php echo $help_keyword; ?>"><?php echo $entry_keyword; ?></span></label>
								<div class="col-sm-10">
									<input type="text" name="keyword" value="<?php echo $keyword; ?>" placeholder="<?php echo $entry_keyword; ?>" id="input-keyword" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-related"><span data-toggle="tooltip" title="<?php echo $help_related; ?>"><?php echo $entry_related; ?></span></label>
								<div class="col-sm-10">
									<input type="text" name="related" value="" placeholder="<?php echo $entry_related; ?>" id="input-related" class="form-control" />
									<div id="article-related" class="well well-sm" style="height: 150px; overflow: auto;">
										<?php foreach ($article_relateds as $article_related) { ?>
											<div id="article-related<?php echo $article_related['article_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $article_related['name']; ?>
												<input type="hidden" name="article_related[]" value="<?php echo $article_related['article_id']; ?>" />
											</div>
										<?php } ?>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-related"><span data-toggle="tooltip" title="<?php echo $help_product_related; ?>"><?php echo $entry_product_related; ?></span></label>
								<div class="col-sm-10">
									<input type="text" name="article_products" value="" placeholder="<?php echo $entry_product_related; ?>" id="input-related" class="form-control" />
									<div id="article-products" class="well well-sm" style="height: 150px; overflow: auto;">
										<?php foreach ($article_products as $product) { ?>
											<div id="article_products<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
												<input type="hidden" name="article_products[]" value="<?php echo $product['product_id']; ?>" />
											</div>
										<?php } ?>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $entry_store; ?></label>
								<div class="col-sm-10">
									<div class="well well-sm" style="height: 150px; overflow: auto;">
										<div class="checkbox">
											<label>
												<?php if (in_array(0, $article_store)) { ?>
													<input type="checkbox" name="article_store[]" value="0" checked="checked" />
													<?php echo $text_default; ?>
													<?php } else { ?>
													<input type="checkbox" name="article_store[]" value="0" />
													<?php echo $text_default; ?>
												<?php } ?>
											</label>
										</div>
										<?php foreach ($stores as $store) { ?>
											<div class="checkbox">
												<label>
													<?php if (in_array($store['store_id'], $article_store)) { ?>
														<input type="checkbox" name="article_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
														<?php echo $store['name']; ?>
														<?php } else { ?>
														<input type="checkbox" name="article_store[]" value="<?php echo $store['store_id']; ?>" />
														<?php echo $store['name']; ?>
													<?php } ?>
												</label>
											</div>
										<?php } ?>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-login-to-view"><?php echo $entry_login_to_view; ?></label>
								<div class="col-sm-10">
									<select name="login_to_view" id="input-login-to-view" class="form-control">
										<?php if ($login_to_view) { ?>
											<option value="1" selected="selected"><?php echo $text_yes; ?></option>
											<option value="0"><?php echo $text_no; ?></option>
											<?php } else { ?>
											<option value="1"><?php echo $text_yes; ?></option>
											<option value="0" selected="selected"><?php echo $text_no; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group" style="display:none">
								<label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
								<div class="col-sm-10">
									<input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
								<div class="col-sm-10">
									<select name="status" id="input-status" class="form-control">
										<?php if ($status) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
											<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-design">
							<div class="table-responsive">
								<table class="table table-bordered table-hover">
									<thead>
										<tr>
											<td class="text-left"><?php echo $entry_store; ?></td>
											<td class="text-left"><?php echo $entry_layout; ?></td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="text-left"><?php echo $text_default; ?></td>
											<td class="text-left"><select name="article_layout[0]" class="form-control">
												<option value=""></option>
												<?php foreach ($layouts as $layout) { ?>
													<?php if (isset($article_layout[0]) && $article_layout[0] == $layout['layout_id']) { ?>
														<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
														<?php } else { ?>
														<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
													<?php } ?>
												<?php } ?>
											</select></td>
										</tr>
										<?php foreach ($stores as $store) { ?>
											<tr>
												<td class="text-left"><?php echo $store['name']; ?></td>
												<td class="text-left"><select name="article_layout[<?php echo $store['store_id']; ?>]" class="form-control">
													<option value=""></option>
													<?php foreach ($layouts as $layout) { ?>
														<?php if (isset($article_layout[$store['store_id']]) && $article_layout[$store['store_id']] == $layout['layout_id']) { ?>
															<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
															<?php } else { ?>
															<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
														<?php } ?>
													<?php } ?>
												</select></td>
											</tr>
										<?php } ?>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">	
		<?php foreach ($languages as $language) { ?>
			<?php if ($ckeditor) { ?>
				ckeditorInit('input-description<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
				ckeditorInit('input-short-description<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
			<?php } else { ?>
				<?php if(VERSION <= 2.2) { ?>
					$('#input-description<?php echo $language['language_id']; ?>').summernote({height: 300});
					$('#input-short-description<?php echo $language['language_id']; ?>').summernote({height: 300});
				<?php } ?>
			<?php } ?>
		<?php } ?>
	</script>
	<script type="text/javascript">
		$('input[name=\'related\']').autocomplete({
			'source': function(request, response) {
				$.ajax({
					url: 'index.php?route=uni_blog/article/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
					dataType: 'json',
					success: function(json) {
						response($.map(json, function(item) {
							return {
								label: item['name'],
								value: item['article_id']
							}
						}));
					}
				});
			},
			'select': function(item) {
				$('input[name=\'related\']').val('');
				$('#article-related' + item['value']).remove();
				$('#article-related').append('<div id="article-related' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="article_related[]" value="' + item['value'] + '" /></div>');
			}
		});
		
		$('#article-related').delegate('.fa-minus-circle', 'click', function() {
			$(this).parent().remove();
		});
		
		// Related products
		$('input[name=\'article_products\']').autocomplete({
			'source': function(request, response) {
				$.ajax({
					url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
					dataType: 'json',
					success: function(json) {
						response($.map(json, function(item) {
							return {
								label: item['name'],
								value: item['product_id']
							}
						}));
					}
				});
			},
			'select': function(item) {
				$('input[name=\'article_products\']').val('');
				
				$('#article-products' + item['value']).remove();
				
				$('#article-products').append('<div id="article-products' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="article_products[]" value="' + item['value'] + '" /></div>');
			}
		});
		
		$('#article-products').delegate('.fa-minus-circle', 'click', function() {
			$(this).parent().remove();
		});
		
		
		$('#article-related div img').delegate('.fa-minus-circle', 'click', function() {
			$(this).parent().remove();
		});
	</script>
	<script type="text/javascript"><!--
		$('#language a:first').tab('show');
		$('#option a:first').tab('show');
	//--></script></div>
<style>
	.control-label span {color:#888;font-weight:400;}
	.control-label span:after {display:none}
	.scrollbox {border:1px solid #CCCCCC; height:250px; padding:4px 6px; margin-bottom:10px; background:#FFFFFF; overflow-y:scroll;}
	.scrollbox > div {padding:2px 5px}
	.scrollbox > div label {font-weight:400;}
	.scrollbox > div input[type="radio"], input[type="checkbox"] {margin: 5px 2px -2px 0;}
	.scrollbox > div:nth-child(2n) {background:#f4f4f4 !important;}
</style>
<?php echo $footer; ?>									