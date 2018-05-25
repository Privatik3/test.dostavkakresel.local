<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button onclick="apply()" data-toggle="tooltip" title="Применить настройки и остаться" class="btn btn-success"><i class="fa fa-save"></i><span>Сохранить</span></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="Не сохранять и вернуться в раздел модулей" class="btn btn-default"><i class="fa fa-reply"></i><span>Вернуться</span></a>
			</div>
			<h1><?php echo $lang['heading_title']; ?></h1>
			<br />
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
					<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid container-fluid_new">
		<?php if ($error_warning) { ?><div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div><?php } ?>
		<ul class="nav nav-tabs">
			<?php foreach ($stores as $store) { ?>
				<li><a href="#tab-<?php echo $store['store_id']; ?>" data-toggle="tab" onclick="$('#tab-<?php echo $store['store_id']; ?> .nav-tabs a').first().trigger('click');"><?php echo html_entity_decode($store['name'], ENT_QUOTES, 'UTF-8'); ?></a></li>
			<?php } ?>
		</ul>
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="uni_set" id="unishop">
			<div class="tab-content">
				<?php foreach ($stores as $store) { ?>
					<div id="tab-<?php echo $store['store_id']; ?>" class="tab-pane">
						<?php $store_id = $store['store_id']; ?>
						<?php $set = $uni_set && isset($uni_set[$store_id]) ? $uni_set[$store_id] : array(); ?>
						<ul class="nav nav-stacked nav-tabs nav-pills">
							<li><a href="#tab-header_<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-header']; ?></a></li>
							<li><a href="#tab-footer-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-footer']; ?></a></li>
							<li><a href="#tab-home-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-home']; ?></a></li>
							<li><a href="#tab-product-block-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-catalog']; ?></a></li>
							<li><a href="#tab-product-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-product']; ?></a></li>
							<li><a href="#tab-callback-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-callback']; ?></a></li>
							<li><a href="#tab-order-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-quickorder']; ?></a></li>
							<li><a href="#tab-checkout-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-checkout']; ?></a></li>
							<li><a href="#tab-login-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-login-register']; ?></a></li>
							<li><a href="#tab-contacts-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-contacts']; ?></a></li>
							<li><a href="#tab-fly-menu-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-flymenu']; ?></a></li>
							<li><a href="#tab-search-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-livesearch']; ?></a></li>
							<li><a href="#tab-sticker-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-stickers']; ?></a></li>
							<li><a href="#tab-cart-btn-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-button']; ?></a></li>
							<li><a href="#tab-style-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-style']; ?></a></li>
							<li><a href="#tab-other-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-other']; ?></a></li>
							<li><a href="#tab-info-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-faq']; ?></a></li>
							<li><a href="#tab-license-<?php echo $store_id; ?>" data-toggle="tab"><?php echo $lang['tab-license']; ?></a></li>
						</ul>
						<div class="tab-content tab-content-new">
							<div id="tab-header_<?php echo $store_id; ?>" class="tab-pane">
								<table id="module" class="list">
									<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_topmenu']; ?></b></td></tr>
									<tr>
										<td><?php echo $lang['entry_topmenu']; ?></td>
										<td style="padding:10px;">
											<?php foreach ($languages as $key => $language) { ?>
												<?php $set[$language['language_id']]['headerlinks'] = isset($set[$language['language_id']]['headerlinks']) ? $set[$language['language_id']]['headerlinks'] : array(); ?>
												<?php $headerlinks_num = 1; ?>
												<div class="headerlinks_<?php echo $language['language_id']; ?>">
													<?php foreach ($set[$language['language_id']]['headerlinks'] as $headerlinks) { ?>
														<div class="input-group">
															<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
															<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][headerlinks][<?php echo $headerlinks_num; ?>][title]" value="<?php echo isset($headerlinks['title']) ? $headerlinks['title'] : ''; ?>" placeholder="Заголовок #<?php echo $headerlinks_num; ?>" class="form-control" />
															<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][headerlinks][<?php echo $headerlinks_num; ?>][link]" value="<?php  echo isset($headerlinks['link']) ? $headerlinks['link'] : ''; ?>" placeholder="Ссылка #<?php echo $headerlinks_num; ?>" class="form-control" />
															<span class="input-group-btn btn-default" onclick="$(this).parent().next().remove(); $(this).parent().remove();" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>
														</div>
														<div class="infolink">
															<a onclick="$(this).toggleClass('show');">Использовать ссылку на статью <i class="fa fa-caret-down" aria-hidden="true"></i></a>
															<div>
																<?php foreach($informations as $information) { ?>
																	<a onclick="$(this).parent().parent().prev().find('input:first').val('<?php echo $information['name']; ?>'); $(this).parent().parent().prev().find('input:last').val('<?php echo $information['link']; ?>');"><?php echo $information['name']; ?></a>
																<?php } ?>
															</div>
														</div>
														<?php $headerlinks_num++; ?>
													<?php } ?>
												</div>
												<a onclick="addHeaderLinks('<?php echo $store_id; ?>', '<?php echo $language['language_id']; ?>', '<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>');" class="button btn btn-success">Добавить для <img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" /></a>
												<hr />
											<?php } ?>		
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_topmenu-color']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][top_menu_bg]" class="jscolor form-control" data-type="bg" data-class="top_menu_btn" value="<?php echo isset($set['top_menu_bg']) ? $set['top_menu_bg'] : 'f5f5f5'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][top_menu_color]" class="jscolor form-control" data-type="color" data-class="top_menu_btn span:first-child" value="<?php echo isset($set['top_menu_color']) ? $set['top_menu_color'] : 'E07572'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][top_menu_color_hover]" class="jscolor form-control" data-type="color" data-class="top_menu_btn span:last-child" value="<?php echo isset($set['top_menu_color_hover']) ? $set['top_menu_color_hover'] : 'E07572'; ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn double top_menu_btn menu"><span>Текст ссылки</span><span>Текст ссылки при наведении курсора</span></div>
										</td>
									</tr>
									<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_search']; ?></b></td></tr>
									<tr>
										<td><?php echo $lang['entry_search-color']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][search_btn_bg]" class="jscolor form-control" data-type="bg" data-class="search_btn span" value="<?php echo isset($set['search_btn_bg']) ? $set['search_btn_bg'] : 'f5f5f5'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][search_btn_color]" class="jscolor form-control" data-type="color" data-class="search_btn span" value="<?php echo isset($set['search_btn_color']) ? $set['search_btn_color'] : '666666'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][search_input_color]" class="jscolor form-control" data-type="color" data-class="search_btn input" value="<?php echo isset($set['search_input_color']) ? $set['search_input_color'] : '888888'; ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn search_btn"><span>Везде</span><input type="text" value="Поиск товара" /><span><i class="fa fa-search"></i></span></div>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_search-phrase']; ?></td>
										<td>
											<?php foreach ($languages as $language) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
													<textarea type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][search_phrase]" class="form-control"><?php echo isset($set[$language['language_id']]['search_phrase']) ? $set[$language['language_id']]['search_phrase'] : ''; ?></textarea>
												</div>
											<?php } ?>
										</td>
									</tr>
									<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_phone']; ?></b></td></tr>
									<tr>
										<td><?php echo $lang['entry_mainphone-color']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][main_phone_color]" class="jscolor form-control" data-type="color" data-class="main_phone" value="<?php echo isset($set['main_phone_color']) ? $set['main_phone_color'] : '666666'; ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview main_phone"><i class="fa fa-phone" style="float:none; margin:0 3px 0 0;"></i>+7 (000) 000-00-00</div>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_additional-phone']; ?></td>
										<td>
											<?php $phones_num = 1; ?>
											<div class="phones">
												<?php 
												$set['phones'] = isset($set['phones']) ? $set['phones'] : array();
												$types = array('tel:' => 'Тип ссылки: набор номера', 'mailto:' => 'Тип ссылки: отправить e-mail', '?call' => 'Тип ссылки: Skype звонок', '?chat' => 'Тип ссылки: Skype чат', 'viber://add?number=' => 'Тип ссылки: Viber звонок');
												?>
												<?php foreach ($set['phones'] as $phones) { ?>
													<div class="input-group">
														<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_p_i_<?php echo $phones_num; ?>" onclick="popup_icons($(this).attr('id'))">Иконка: <?php echo isset($phones['icon']) ? '<i class="'.$phones['icon'].'"></i>' : '<i></i>'; ?></span>
														<input type="hidden" name="uni_set[<?php echo $store_id; ?>][phones][<?php echo $phones_num; ?>][icon]" value="<?php echo isset($phones['icon']) ? $phones['icon'] : ''; ?>" class="form-control" />
														<input type="text" name="uni_set[<?php echo $store_id; ?>][phones][<?php echo $phones_num; ?>][number]" value="<?php echo isset($phones['number']) ? $phones['number'] : ''; ?>" placeholder="Телефон #<?php echo $phones_num; ?>" class="form-control" />
														<select name="uni_set[<?php echo $store_id; ?>][phones][<?php echo $phones_num; ?>][type]" class="form-control header-call" >
															<option value="">Тип ссылки: ничего</option>
															<?php foreach($types as $key => $name) { ?>
																<option value="<?php echo $key; ?>" <?php echo ($phones['type'] == $key) ? 'selected="selected"' : ''; ?>><?php echo $name; ?></option>
															<?php } ?>
														</select>
														<span class="input-group-btn btn-default" onclick="$(this).parent().remove()" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>
													</div>
													<?php $phones_num++; ?>
												<?php } ?>
										</div>
										<a onclick="addPhones('<?php echo $store_id; ?>');" class="button btn btn-success">Добавить</a>
									</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_additional-phone-color']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][additional_phone_color]" class="jscolor form-control" data-type="color" data-class="additional_phone" value="<?php echo isset($set['additional_phone_color']) ? $set['additional_phone_color'] : '666666'; ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview additional_phone"><i class="fa fa-phone" style="float:none; margin:0 3px 0 0;"></i>+7 (000) 000-00-00</div>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_text-block']; ?></td>
										<td>
											<?php foreach ($languages as $language) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
													<textarea type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][text_in_add_contacts]" id="text_in_add_contacts_<?php echo $language['language_id']; ?>" data-lang="ru-RU" class="form-control summernote"><?php echo isset($set[$language['language_id']]['text_in_add_contacts']) ? $set[$language['language_id']]['text_in_add_contacts'] : ''; ?></textarea>
												</div>
											<?php } ?>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_text-block-before']; ?></td>
										<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][text_in_add_contacts_position]" value="1" <?php echo isset($set['text_in_add_contacts_position']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_delivery_hours']; ?></td>
										<td>
											<?php foreach ($languages as $language) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][delivery_hours]" value="<?php echo isset($set[$language['language_id']]['delivery_hours']) ? $set[$language['language_id']]['delivery_hours'] : 'Ежедневно, с 10:00 до 20:00'; ?>" class="form-control" />
												</div>
											<?php } ?>	
										</td>
									</tr>
									<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_cart']; ?></b></td></tr>
									<tr>
										<td><?php echo $lang['entry_cart-color']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_bg]" class="jscolor form-control" data-type="bg" data-class="cart" value="<?php echo isset($set['cart_bg']) ? $set['cart_bg'] : 'f5f5f5'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_color]" class="jscolor form-control" data-type="color" data-class="cart span:first-child" value="<?php echo isset($set['cart_color']) ? $set['cart_color'] : '5c5c5c'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_bg_total]" class="jscolor form-control" data-type="bg" data-class="cart span:last-child" value="<?php echo isset($set['cart_bg_total']) ? $set['cart_bg_total'] : 'E07572'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_color_total]" class="jscolor form-control" data-type="color" data-class="cart span:last-child" value="<?php echo isset($set['cart_color_total']) ? $set['cart_color_total'] : 'ffffff'; ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview cart"><span><i class="fa fa-shopping-basket"></i></span><span>0</span></div>
										</td>
									</tr>
									<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_main-menu']; ?></b></td></tr>
									<tr>
										<td><?php echo $lang['entry_main-menu']; ?></td>
										<td>
											<?php foreach ($languages as $language) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][text_menu]" value="<?php echo isset($set[$language['language_id']]['text_menu']) ? $set[$language['language_id']]['text_menu'] : 'Категории'; ?>"class="form-control" />
												</div>
											<?php } ?>	
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_main-menu-color']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][main_menu_bg]" class="jscolor form-control" data-type="bg" data-class="main_menu_btn" value="<?php echo isset($set['main_menu_bg']) ? $set['main_menu_bg'] : '666666'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][main_menu_color]" class="jscolor form-control" data-type="color" data-class="main_menu_btn span" value="<?php echo isset($set['main_menu_color']) ? $set['main_menu_color'] : 'ffffff'; ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn main_menu_btn menu"><span>Заголовок меню <i class="fa fa-bars" aria-hidden="true"></i></span></div>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_main-menu-color1']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][main_menu_parent_bg]" class="jscolor form-control" data-type="bg" data-class="main_menu_parent_btn" value="<?php echo isset($set['main_menu_parent_bg']) ? $set['main_menu_parent_bg'] : 'f5f5f5'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][main_menu_parent_color]" class="jscolor form-control" data-type="color" data-class="main_menu_parent_btn span" value="<?php echo isset($set['main_menu_parent_color']) ? $set['main_menu_parent_color'] : '777777'; ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn main_menu_parent_btn menu"><span>Имя категории <i class="fa fa-chevron-down" aria-hidden="true"></i></span></div>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_main-menu-color2']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][main_menu_parent_color_hover]" class="jscolor form-control" data-type="color" data-class="main_menu_parent_btn_hover span" value="<?php echo (isset($set['main_menu_parent_color_hover']) ? $set['main_menu_parent_color_hover'] : '555555') ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview main_menu_parent_btn_hover menu"><span>Имя категории <i class="fa fa-chevron-down" aria-hidden="true"></i></span></div>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_main-menu-color3']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][main_menu_children_bg]" class="jscolor form-control" data-type="bg" data-class="main_menu_children_btn, .main_menu_parent_btn_hover" value="<?php echo (isset($set['main_menu_children_bg']) ? $set['main_menu_children_bg'] : 'ffffff') ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][main_menu_children_color]" class="jscolor form-control" data-type="color" data-class="main_menu_children_btn span:first-child" value="<?php echo (isset($set['main_menu_children_color']) ? $set['main_menu_children_color'] : 'E07572') ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][main_menu_children_color2]" class="jscolor form-control" data-type="color" data-class="main_menu_children_btn span:last-child" value="<?php echo (isset($set['main_menu_children_color2']) ? $set['main_menu_children_color2'] : '666666') ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn double main_menu_children_btn menu"><span>Имя под-категории</span><span>Имя под-под-категории</span></div>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_main-menu-link-show']; ?></td>
										<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][menu_links_show]" value="1" <?php echo isset($set['menu_links_show']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_main-menu-link-disabled']; ?></td>
										<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][menu_links_disabled]" value="1" <?php echo isset($set['menu_links_disabled']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_main-menu-open']; ?></td>
										<td>
											<?php 
												$set['menu_schema'] = isset($set['menu_schema']) ? $set['menu_schema'] : array();
												$schemas = array(
													'common/home' => 'Главная',
													'product/category'	=> 'Категория',
													'product/special'	=> 'Акции',
													'product/search'	=> 'Поиск',
													'product/manufacturer'	=> 'Список производителей',
													'product/manufacturer/info'	=> 'Список товаров производителя',
													'information/information'	=> 'Статьи',
													'information/news'	=> 'Новости',
													'uni_blog/category'	=> 'Категория блога',
													'uni_blog/article'	=> 'Статья блога',
													'product/gallery'	=> 'Фотогалерея',
													'product/reviews'	=> 'Страница отзывов о товарах',
												);
											?>
											<?php foreach($schemas as $schema => $name) { ?>
												<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][menu_schema][]" value="<?php echo $schema; ?>" <?php echo in_array($schema, $set['menu_schema']) ? 'checked="checked"' : ''; ?> /><span></span><?php echo $name; ?></label>	
											<?php } ?>
										</td>
									</tr>
									<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_right-menu']; ?></b></td></tr>
									<tr>
										<td><?php echo $lang['entry_right-menu-links']; ?></td>
										<td>
											<?php foreach ($languages as $key => $language) { ?>
												<?php $headerlinks2_num = 1; ?>
												<div class="headerlinks2_<?php echo $language['language_id']; ?>">
													<?php if (isset($set[$language['language_id']]['headerlinks2'])) { ?>
														<?php foreach ($set[$language['language_id']]['headerlinks2'] as $headerlinks2) { ?>
															<div class="input-group">
																<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
																<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_<?php echo $language['language_id']; ?>_t_l_<?php echo $headerlinks2_num; ?>" onclick="popup_icons($(this).attr('id'))">Иконка: <?php if(isset($headerlinks2['icon'])) { ?><i class="<?php echo $headerlinks2['icon']; ?>"></i><?php } ?></span>
																<input type="hidden" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][headerlinks2][<?php echo $headerlinks2_num; ?>][icon]" value="<?php echo isset($headerlinks2['icon']) ? $headerlinks2['icon'] : ''; ?>" class="form-control" />
																<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][headerlinks2][<?php echo $headerlinks2_num; ?>][title]" value="<?php echo isset($headerlinks2['title']) ? $headerlinks2['title'] : ''; ?>" placeholder="Заголовок #<?php echo $headerlinks2_num; ?>" class="form-control" />
																<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][headerlinks2][<?php echo $headerlinks2_num; ?>][link]" value="<?php echo isset($headerlinks2['link']) ? $headerlinks2['link'] : ''; ?>" placeholder="Ссылка #<?php echo $headerlinks2_num; ?>" class="form-control" />
																<span class="input-group-btn btn-default" onclick="$(this).parent().next().remove(); $(this).parent().remove();" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>
															</div>
															<div class="infolink">
															<a onclick="$(this).toggleClass('show');">Использовать ссылку на статью <i class="fa fa-caret-down" aria-hidden="true"></i></a>
															<div>
																<?php foreach($informations as $information) { ?>
																	<a onclick="$(this).parent().parent().prev().find('input[type=\'text\']:first').val('<?php echo $information['name']; ?>'); $(this).parent().parent().prev().find('input:last').val('<?php echo $information['link']; ?>');"><?php echo $information['name']; ?></a>
																<?php } ?>
															</div>
														</div>
															<?php $headerlinks2_num++; ?>
														<?php } ?>
													<?php } ?>
												</div>
												<a onclick="addHeaderLinks2('<?php echo $store_id; ?>', '<?php echo $language['language_id']; ?>', '<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>');" class="button btn btn-success">Добавить для <img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" /></a>
												<hr />
											<?php } ?>		
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_right-menu-color']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][right_menu_bg]" class="jscolor form-control" data-type="bg" data-class="right_menu_btn" value="<?php echo (isset($set['right_menu_bg']) ? $set['right_menu_bg'] : 'f5f5f5') ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][right_menu_color]" class="jscolor form-control" data-type="color" data-class="right_menu_btn span:first-child" value="<?php echo (isset($set['right_menu_color']) ? $set['right_menu_color'] : '777777') ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][right_menu_color_hover]" class="jscolor form-control" data-type="color" data-class="right_menu_btn span:last-child" value="<?php echo (isset($set['right_menu_color_hover']) ? $set['right_menu_color_hover'] : 'E07572') ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn double right_menu_btn menu"><span>Текст ссылки</span><span>Текст ссылки при наведении курсора</span></div>
										</td>
									</tr>
								</table>
							</div>
							<div id="tab-footer-<?php echo $store_id; ?>" class="tab-pane">
								<table id="module" class="list">
									<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_footer']; ?></b></td></tr>
									<tr>
										<td><?php echo $lang['entry_footer_column_heading']; ?></td>
										<td>
											<?php foreach ($languages as $language) { ?>
												<?php $columns = array(1 => 'Информация', 2 => 'Служба поддержки', 3 => 'Дополнительно', 4 => 'Схема проезда'); ?>
												<?php foreach($columns as $key => $name) { ?>
													<div class="input-group">
														<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
														<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_f_i_<?php echo $language['language_id']; ?>_<?php echo $key; ?>" onclick="popup_icons($(this).attr('id'))">Иконка: <?php echo isset($set[$language['language_id']]['footer_column_icon'.$key]) ? '<i class="'.$set[$language['language_id']]['footer_column_icon'.$key].'"></i>' : '<i></i>'; ?></span>
														<input type="hidden" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][footer_column_icon<?php echo $key; ?>]" value="<?php echo isset($set[$language['language_id']]['footer_column_icon'.$key]) ? $set[$language['language_id']]['footer_column_icon'.$key] : ''; ?>" class="form-control" />	
														<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][footer_column_heading<?php echo $key; ?>]" value="<?php echo isset($set[$language['language_id']]['footer_column_heading'.$key]) ? $set[$language['language_id']]['footer_column_heading'.$key] : $name; ?>" class="form-control" />
													</div>
												<?php } ?>
											<?php } ?>	
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_footer-links']; ?></td>
										<td>
											<?php foreach ($languages as $key => $language) { ?>
												<?php $footerlinks_num = 1; ?>
												<div class="footerlinks_<?php echo $language['language_id']; ?>">
													<?php if (isset($set[$language['language_id']]['footerlinks'])) { ?>
														<?php foreach ($set[$language['language_id']]['footerlinks'] as $footerlinks) { ?>
															<div class="input-group">
																<?php $columns = array(1, 2, 3, 4); ?>
																<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
																<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][footerlinks][<?php echo $footerlinks_num; ?>][title]" value="<?php echo isset($footerlinks['title']) ? $footerlinks['title'] : ''; ?>" placeholder="Заголовок #<?php echo $footerlinks_num; ?>" class="form-control" />
																<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][footerlinks][<?php echo $footerlinks_num; ?>][link]" value="<?php echo isset($footerlinks['link']) ? $footerlinks['link'] : ''; ?>" placeholder="Ссылка #<?php echo $footerlinks_num; ?>" class="form-control" />
																<select name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][footerlinks][<?php echo $footerlinks_num; ?>][column]" class="form-control">
																	<?php foreach ($columns as $key) { ?>
																		<option value="<?php echo $key; ?>" <?php echo ($footerlinks['column'] == $key) ? 'selected="selected"' : ''; ?>>Показывать в колонке #<?php echo $key; ?></option>
																	<?php } ?>
																</select>
																<span class="input-group-btn btn-default" onclick="$(this).parent().remove()" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>
															</div>
															<?php $footerlinks_num++; ?>
														<?php } ?>
													<?php } ?>
												</div>
												<a onclick="addFooterLinks('<?php echo $store_id; ?>', '<?php echo $language['language_id']; ?>', '<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>');" class="button btn btn-success">Добавить для <img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" /></a>
												<hr />
											<?php } ?>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_footer-links-color']; ?></td>
										<td>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][footer_bg]" class="jscolor form-control" data-type="bg" data-class="footer_btn" value="<?php echo isset($set['footer_bg']) ? $set['footer_bg'] : '656565'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][footer_h5_color]" class="jscolor form-control" data-type="color" data-class="footer_btn span:first-child" value="<?php echo isset($set['footer_h5_color']) ? $set['footer_h5_color'] : 'dddddd'; ?>">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][footer_text_color]" class="jscolor  form-control" data-type="color" data-class="footer_btn span:last-child" value="<?php echo isset($set['footer_text_color']) ? $set['footer_text_color'] : 'c5c5c5'; ?>">
											<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn double footer_btn menu"><span>Заголовок колонки</span><span>Текст колонки</span></div>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_footer_text']; ?></td>
										<td>
											<?php foreach ($languages as $language) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
													<textarea type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][footer_text]" data-lang="ru-RU" class="form-control summernote"><?php echo isset($set[$language['language_id']]['footer_text']) ? $set[$language['language_id']]['footer_text'] : ''; ?></textarea>
												</div>
											<?php } ?>	
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_footer_map']; ?></td>
										<td><textarea type="text" name="uni_set[<?php echo $store_id; ?>][footer_map]" class="form-control"><?php echo(isset($set['footer_map']) ? $set['footer_map'] : '<script type="text/javascript" charset="utf-8" src="https://api-maps.yandex.ru/services/constructor/1.0/js/?sid=0-UEqyhQjzOUNY4v2mkEt21fwIDcbzO3&width=100%25&height=150"></script>') ?></textarea></td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_footer_socials']; ?></td>
										<td>
											<?php $socials_num = 1; ?>
											<div class="socials">
												<?php if (isset($set['socials'])) { ?>
													<?php foreach ($set['socials'] as $socials) { ?>
														<div class="input-group">
														<?php $names = array('fa-odnoklassniki' => 'Одноклассники', 'fa-vk' => 'ВКонтакте', 'fa-facebook' => 'Фейсбук', 'fa-twitter' => 'Твиттер', 'fa-google-plus' => 'Гугл+', 'fa-instagram' => 'Инстаграм', 'fa-youtube' => 'Ютуб', 'fa-pinterest' => 'Пинтерест'); ?>
															<select name="uni_set[<?php echo $store_id; ?>][socials][<?php echo $socials_num; ?>][icon]" class="form-control">
																<?php foreach ($names as $key => $name) { ?>
																	<option value="<?php echo $key; ?>" <?php echo ($socials['icon'] == $key) ? 'selected="selected"' : ''; ?>><?php echo $name; ?></option>
																<?php } ?>
															</select>
															<input type="text" name="uni_set[<?php echo $store_id; ?>][socials][<?php echo $socials_num; ?>][link]" value="<?php echo(isset($socials['link']) ? $socials['link'] : '') ?>" placeholder="Ссылка" class="form-control" />
															<span class="input-group-btn btn-default" onclick="$(this).parent().remove()" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>
														</div>
														<?php $socials_num++; ?>
													<?php } ?>
												<?php } ?>
											</div>
											<a onclick="addSocials('<?php echo $store_id; ?>');" class="button btn btn-success">Добавить</a>
										</td>
									</tr>
									<tr>
										<td><?php echo $lang['entry_footer_payment']; ?></td>
										<td>
										<?php
											$set['payment_icons'] = isset($set['payment_icons']) ? $set['payment_icons'] : array();
											$payments = array('visa' => 'Visa', 'master' => 'Mastercard', 'yandex' => 'Yandex',	'webmoney' => 'Webmoney', 'qiwi' => 'Qiwi',	'sberbank' => 'Сбербанк', 'cyberplat' => 'Сyberplat', 'alfa' => 'Альфа Банк', 'privat' => 'Приват',	'paypal' => 'Paypal',
											'eport' => 'Eport',	'mailofrussia' => 'Почта России', 'rapida' => 'Rapida',	'contact' => 'Contact',	'vtb24' => 'ВТБ24',	'sms' => 'SMS',	'skrill' => 'Skrill', 'paypal' => 'PayPal',	'rbk' => 'RBK',	'rapida' => 'Rapida', 'western-union' => 'WesternUnion');
										?>
										<?php foreach($payments as $key => $name) { ?>
											<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][payment_icons][]" value="<?php echo $key; ?>" <?php echo in_array($key, $set['payment_icons']) ? 'checked="checked"' : ''; ?> /><span></span><?php echo $name; ?></label>
										<?php } ?>
										</td>
									</tr>
								</table>
							</div>
							<div id="tab-home-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_slideshow']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_slideshow-hide']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][hide_slideshow]" value="1" <?php echo isset($set['hide_slideshow']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_slideshow_effect']; ?></td>
									<td>
										<select name="uni_set[<?php echo $store_id; ?>][slideshow_effect]" class="form-control">
											<option value="">Стандартный</option>
											<option value="fade" <?php if(isset($set['slideshow_effect']) && $set['slideshow_effect'] == 'fade'){ ?>selected="selected"<?php } ?>>Fade</option>
											<option value="fadeUp" <?php if(isset($set['slideshow_effect']) && $set['slideshow_effect'] == 'fadeUp'){ ?>selected="selected"<?php } ?>>FadeUp</option>
											<option value="backSlide" <?php if(isset($set['slideshow_effect']) && $set['slideshow_effect'] == 'backSlide'){ ?>selected="selected"<?php } ?>>BackSlide</option>
											<option value="goDown" <?php if(isset($set['slideshow_effect']) && $set['slideshow_effect'] == 'goDown'){ ?>selected="selected"<?php } ?>>GoDown</option>
										</select>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_slideshow-pause']; ?></td>
									<td>
										<div class="input-group">
											<input type="text" name="uni_set[<?php echo $store_id; ?>][slideshow_delay]" value="<?php echo isset($set['slideshow_delay']) ? $set['slideshow_delay'] : '3'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
											<span>сек.</span>
										</div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_slideshow-hide-lable']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][hide_slideshow_title]" value="1" <?php echo (isset($set['hide_slideshow_title']) ? 'checked="checked"' : '') ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_slideshow-lable-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][slideshow_title_bg]" class="jscolor form-control" data-class="slideshow_title" data-type="sticker" value="<?php echo (isset($set['slideshow_title_bg']) ? $set['slideshow_title_bg'] : 'E07572') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][slideshow_title_color]" class="jscolor form-control" data-class="slideshow_title" data-type="color" value="<?php echo (isset($set['slideshow_title_color']) ? $set['slideshow_title_color'] : 'ffffff') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview slideshow_title">Текст заголовка слайда<span></span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_slideshow-nav-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][slideshow_pagination_bg]" class="jscolor form-control" data-type="bg" data-class="slideshow_pagination span:first-child" value="<?php echo isset($set['slideshow_pagination_bg']) ? $set['slideshow_pagination_bg'] : '888888'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][slideshow_pagination_bg_active]" class="jscolor form-control" data-type="bg" data-class="slideshow_pagination span:last-child" value="<?php echo isset($set['slideshow_pagination_bg_active']) ? $set['slideshow_pagination_bg_active'] : 'E07572'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview bg slideshow_pagination"><span></span><span></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_home-text-banner']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_homebanner_position']; ?></td>
									<td>
									<div class="input-group">
										<?php $positions = array('content_top' => 'Верх страницы', 'content_bottom' => 'Низ страницы'); 
										$set['home_banners_position'] = isset($set['home_banners_position']) ? $set['home_banners_position'] : '';
										?>
										<select name="uni_set[<?php echo $store_id; ?>][home_banners_position]" class="form-control">
											<?php foreach ($positions as $key => $name) { ?>
												<option value="<?php echo $key; ?>" <?php echo $set['home_banners_position'] == $key ? 'selected="selected"' : ''; ?>><?php echo $name; ?></option>
											<?php } ?>
										</select>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][home_banners_position_n]" value="<?php echo isset($set['home_banners_position_n']) ? $set['home_banners_position_n'] : 0; ?>" class="form-control" style="width:50px !important; text-align:center;" />
									</div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_home-text-banner']; ?></td>
									<td>
										<?php foreach ($languages as $language) { ?>
											<?php $home_banners = array(1, 2, 3); ?>
											<?php foreach($home_banners as $home_banner) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
													<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_<?php echo $language['language_id']; ?>_h_b_<?php echo $home_banner; ?>" onclick="popup_icons($(this).attr('id'))">Иконка: <?php if(isset($set[$language['language_id']]['home_banners'][1]['icon'])) { ?><i class="<?php echo $set[$language['language_id']]['home_banners'][$home_banner]['icon']; ?>"></i><?php } ?></span>
													<input type="hidden" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][home_banners][<?php echo $home_banner; ?>][icon]" value="<?php echo (isset($set[$language['language_id']]['home_banners'][$home_banner]['icon']) ? $set[$language['language_id']]['home_banners'][$home_banner]['icon'] : '') ?>" class="form-control" />
													<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][home_banners][<?php echo $home_banner; ?>][text]" value="<?php echo (isset($set[$language['language_id']]['home_banners'][$home_banner]['text']) ? $set[$language['language_id']]['home_banners'][$home_banner]['text'] : '') ?>" placeholder="Первая строка текста баннера #<?php echo $home_banner; ?>" class="form-control" style="width:200px" />
													<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][home_banners][<?php echo $home_banner; ?>][text1]" value="<?php echo (isset($set[$language['language_id']]['home_banners'][$home_banner]['text1']) ? $set[$language['language_id']]['home_banners'][$home_banner]['text1'] : '') ?>" placeholder="Вторая строка текста баннера #<?php echo $home_banner; ?>" class="form-control" style="width:200px" />
													<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][home_banners][<?php echo $home_banner; ?>][link]" value="<?php echo (isset($set[$language['language_id']]['home_banners'][$home_banner]['link']) ? $set[$language['language_id']]['home_banners'][$home_banner]['link'] : '') ?>" placeholder="Ссылка с баннера #<?php echo $home_banner; ?>" class="form-control" style="width:200px" />
												</div>
												<label <?php echo $home_banner == 3 ? 'style="margin:5px 0 10px;"' : ''; ?>><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][home_banners][<?php echo $home_banner; ?>][link_popup]" value="1" <?php echo (isset($set[$language['language_id']]['home_banners'][$home_banner]['link_popup']) ? 'checked="checked"' : '') ?> /><span></span> открывать ссылку в popup окне?</label>
												<?php echo $home_banner == 3 ? '<hr />' : ''; ?>
											<?php } ?>
										<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_home-text-banner-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][home_banners_bg]" class="jscolor form-control" data-type="bg" data-class="home_banners" value="<?php echo isset($set['home_banners_bg']) ? $set['home_banners_bg'] : 'f5f5f5'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][home_banners_icon_color]" class="jscolor form-control" data-type="color" data-class="home_banners span:first-child" value="<?php echo isset($set['home_banners_icon_color']) ? $set['home_banners_icon_color'] : 'E07572'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][home_banners_text_color]" class="jscolor form-control" data-type="color" data-class="home_banners span:last-child" value="<?php echo isset($set['home_banners_text_color']) ? $set['home_banners_text_color'] : '555555'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn double home_banners"><span><i class="fa fa-info-circle" aria-hidden="true"></i></span><span><strong>Первая строка баннера</strong><br />Вторая строка баннера</span></div>
									</td>
								</tr>
							</table>
							</div>
							<div id="tab-product-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product-option']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_product-option']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][change_opt_img_p]" value="1" <?php echo isset($set['change_opt_img_p']) ? 'checked="checked"' : '' ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product-attr']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_show_attr']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_product_attr]" value="1" <?php echo isset($set['show_product_attr']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_attr_group']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][show_product_attr_group]" value="<?php echo isset($set['show_product_attr_group']) ? $set['show_product_attr_group'] : '3'; ?>" size="4" style="width:50px !important; text-align:center;" class="form-control" />
										<span><?php echo $lang['entry_item']; ?></span>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_attr_item']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][show_product_attr_item]" value="<?php if(isset($set['show_product_attr_item'])) { ?><?php echo $set['show_product_attr_item']; ?><?php } else { ?>2<?php } ?>" size="2" style="width:50px !important; text-align:center;" class="form-control" />
										<span><?php echo $lang['entry_item']; ?></span>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product-text-banner']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_product_banner']; ?></td>
									<td>
										<?php foreach ($languages as $key => $language) { ?>
											<?php $product_banner_num = 1; ?>
											<div class="product_banner_<?php echo $language['language_id']; ?>">
												<?php if (isset($set[$language['language_id']]['product_banners'])) { ?>
													<?php foreach ($set[$language['language_id']]['product_banners'] as $product_banner) { ?>
														<div class="input-group">
															<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
															<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_<?php echo $language['language_id']; ?>_p_b_<?php echo $product_banner_num; ?>" onclick="popup_icons($(this).attr('id'))">Иконка: <?php if(isset($product_banner['icon'])) { ?><i class="<?php echo $product_banner['icon']; ?>"></i><?php } ?></span>
															<input type="hidden" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][product_banners][<?php echo $product_banner_num; ?>][icon]" value="<?php echo (isset($product_banner['icon']) ? $product_banner['icon'] : '') ?>" placeholder="Иконка #<?php echo $product_banner_num; ?>" class="form-control" />
															<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][product_banners][<?php echo $product_banner_num; ?>][text]" value="<?php echo (isset($product_banner['text']) ? $product_banner['text'] : '') ?>" placeholder="Текст #<?php echo $product_banner_num; ?>" class="form-control" />
															<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][product_banners][<?php echo $product_banner_num; ?>][link]" value="<?php echo (isset($product_banner['link']) ? $product_banner['link'] : '') ?>" placeholder="Ссылка с баннера #<?php echo $product_banner_num; ?>" class="form-control" />
															<span class="input-group-btn btn-default" onclick="$(this).parent().next().remove(); $(this).parent().remove();" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>
														</div>
														<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][product_banners][<?php echo $product_banner_num; ?>][link_popup]" value="1" <?php echo (isset($product_banner['link_popup']) ? 'checked="checked"' : '') ?> /><span></span> открывать ссылку в popup окне?</label>
														<?php $product_banner_num++; ?>
													<?php } ?>
												<?php } ?>
											</div>
											<a onclick="addProductBanner('<?php echo $store_id; ?>', '<?php echo $language['language_id']; ?>', '<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>');" class="button btn btn-success">Добавить для <img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" /></a>
											<hr />
										<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product-text-banner-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][product_banners_bg]" class="jscolor form-control" data-type="bg" data-class="product_banners" value="<?php echo (isset($set['product_banners_bg']) ? $set['product_banners_bg'] : 'f5f5f5') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][product_banners_icon_color]" class="jscolor form-control" data-type="color" data-class="product_banners span:first-child" value="<?php echo (isset($set['product_banners_icon_color']) ? $set['product_banners_icon_color'] : 'E07572') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][product_banners_text_color]" class="jscolor form-control" data-type="color" data-class="product_banners span:last-child" value="<?php echo (isset($set['product_banners_text_color']) ? $set['product_banners_text_color'] : '555555') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn double product_banners"><span><i class="fa fa-info-circle" aria-hidden="true"></i></span><span>Текст баннера в две строки</div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product-plus-minus']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_product-plus-minus']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_plus_minus_review]" value="1" <?php echo isset($set['show_plus_minus_review']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product-plus-minus-req']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][plus_minus_review_required]" value="1" <?php echo isset($set['plus_minus_review_required']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_add-tab']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_add-tab']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_additional_tab]" value="1" <?php echo isset($set['show_additional_tab']) ? 'checked="checked"' : ''; ?> /><span></span><label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_add-tab-title']; ?></td>
									<td>
										<?php foreach ($languages as $language) { ?>
											<div class="input-group">
												<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
												<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_a_t" onclick="popup_icons($(this).attr('id'))">Иконка: <?php echo isset($set[$language['language_id']]['additional_tab_icon']) ? '<i class="'.$set[$language['language_id']]['additional_tab_icon'].'"></i>' : '<i></i>'; ?></span>
												<input type="hidden" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][additional_tab_icon]" value="<?php echo isset($set[$language['language_id']]['additional_tab_icon']) ? $set[$language['language_id']]['additional_tab_icon'] : ''; ?>" class="form-control" />
												<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][additional_tab_title]" value="<?php echo(isset($set[$language['language_id']]['additional_tab_title']) ? $set[$language['language_id']]['additional_tab_title'] : '') ?>" class="form-control" />
											</div>
										<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_add-tab-descr']; ?></td>
									<td>
										<?php foreach ($languages as $language) { ?>
											<div class="input-group">
												<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
												<textarea type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][additional_tab_text]" id="additional-tab-<?php echo $language['language_id']; ?>" data-lang="ru-RU" class="form-control summernote"><?php if(isset($set[$language['language_id']]['additional_tab_text'])) { ?><?php echo $set[$language['language_id']]['additional_tab_text']; ?><?php } ?></textarea>
											</div>
										<?php } ?>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_manuf-block']; ?></b></td></tr>
								<tr><td colspan="2"><b style="margin:0;color:#f00;"><?php echo $lang['header_manuf-block-att']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_manuf-block']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_manufacturer]" value="1" <?php echo isset($set['show_manufacturer']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_manuf-block-before']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][manufacturer_position]" value="1" <?php echo isset($set['manufacturer_position']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_manuf-block-title']; ?></td>
									<td>
										<?php foreach ($languages as $language) { ?>
											<div class="input-group">
												<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
												<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][manufacturer_title]" value="<?php echo isset($set[$language['language_id']]['manufacturer_title']) ? $set[$language['language_id']]['manufacturer_title'] : 'О производителе'; ?>" class="form-control" />
											</div>
										<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_manuf-block-logo']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][manufacturer_logo_w]" value="<?php echo isset($set['manufacturer_logo_w']) ? $set['manufacturer_logo_w'] : '100'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<input type="text" name="uni_set[<?php echo $store_id; ?>][manufacturer_logo_h]" value="<?php echo isset($set['manufacturer_logo_h']) ? $set['manufacturer_logo_h'] : '100'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span>пикс.</span> 
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_manuf-block-descr']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][manufacturer_text_length]" value="<?php echo isset($set['manufacturer_text_length']) ? $set['manufacturer_text_length'] : '250'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span>симв.</span>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product-related']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_title_related']; ?></td>
									<td>
										<?php foreach ($languages as $language) { ?>
											<div class="input-group">
												<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
												<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][title_related]" value="<?php echo isset($set[$language['language_id']]['title_related']) ? $set[$language['language_id']]['title_related'] : 'Рекомендуем посмотреть'; ?>" class="form-control" />
											</div>
										<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_similar']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_similar]" value="1" <?php echo isset($set['show_similar']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_title_similar']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][title_similar]" value="<?php echo(isset($set[$language['language_id']]['title_similar']) ? $set[$language['language_id']]['title_similar'] : 'Похожие товары') ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product_similar']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][product_similar]" value="<?php echo(isset($set['product_similar']) ? $set['product_similar'] : '4') ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span><?php echo $lang['entry_item']; ?></span>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product-related-hide']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][stock_similar]" value="1" <?php echo isset($set['stock_similar']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product_input']; ?></b></td></tr>
								<tr><td colspan="2"><b style="margin:0;color:#f00;"><?php echo $lang['header_product_input1']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_product_art']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][sku_text]" value="<?php echo isset($set[$language['language_id']]['sku_text']) ? $set[$language['language_id']]['sku_text'] : 'Артикул'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product_upc']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][upc_text]" value="<?php echo isset($set[$language['language_id']]['upc_text']) ? $set[$language['language_id']]['upc_text'] : 'UPC'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product_ean']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][ean_text]" value="<?php echo isset($set[$language['language_id']]['ean_text']) ? $set[$language['language_id']]['ean_text'] : 'EAN'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product_jan']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][jan_text]" value="<?php echo isset($set[$language['language_id']]['jan_text']) ? $set[$language['language_id']]['jan_text'] : 'JAN'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product_isbn']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][isbn_text]" value="<?php echo isset($set[$language['language_id']]['isbn_text']) ? $set[$language['language_id']]['isbn_text'] : 'ISBN'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product_mpn']; ?></td>
									<td>
										<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][mpn_text]" value="<?php echo isset($set[$language['language_id']]['mpn_text']) ? $set[$language['language_id']]['mpn_text'] : 'MPN'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product_location']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][location_text]" value="<?php echo isset($set[$language['language_id']]['location_text']) ? $set[$language['language_id']]['location_text'] : 'Расположение'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
							</table>
							</div>
							<div id="tab-order-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_quickorder']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_quickorder']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_quick_order]" value="1" <?php echo isset($set['show_quick_order']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quickorder-button']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_<?php echo $language['language_id']; ?>_q_o_i" onclick="popup_icons($(this).attr('id'))">Иконка: <i class="<?php echo isset($set[$language['language_id']]['quick_order_icon']) ? $set[$language['language_id']]['quick_order_icon'] : 'fa fa-send-o'; ?>"></i></span>
											<input type="hidden" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][quick_order_icon]" value="<?php echo isset($set[$language['language_id']]['quick_order_icon']) ? $set[$language['language_id']]['quick_order_icon'] : ''; ?>" class="form-control" />
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][quick_order_title]" value="<?php echo isset($set[$language['language_id']]['quick_order_title']) ? $set[$language['language_id']]['quick_order_title'] : 'Быстрый заказ'; ?>" placeholder="Текст подсказки" class="form-control" />
										</div>
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quickorder-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][quick_order_btn_bg]" class="jscolor form-control" data-type="bg" data-class="quick_order_btn" value="<?php echo (isset($set['quick_order_btn_bg']) ? $set['quick_order_btn_bg'] : 'e5e5e5') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][quick_order_btn_color]" class="jscolor form-control" data-type="color" data-class="quick_order_btn span" value="<?php echo (isset($set['quick_order_btn_color']) ? $set['quick_order_btn_color'] : '404040') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn quick_order_btn"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quickorder-color1']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][quick_order_btn_bg_hover]" class="jscolor form-control" data-type="bg" data-class="quick_order_btn_hover" value="<?php echo (isset($set['quick_order_btn_bg_hover']) ? $set['quick_order_btn_bg_hover'] : 'E07572') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][quick_order_btn_color_hover]" class="jscolor form-control" data-type="color" data-class="quick_order_btn_hover span" value="<?php echo (isset($set['quick_order_btn_color_hover']) ? $set['quick_order_btn_color_hover'] : 'ffffff') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn quick_order_btn_hover"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quickorder-button-show']; ?></td>
									<td>
										<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_quick_order_always]" value="1" <?php echo isset($set['show_quick_order_always']) ? 'checked="checked"' : ''; ?> /><span></span>Всегда, а не только при наведении на блок товара</label>
										<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_quick_order_quantity]" value="1" <?php echo isset($set['show_quick_order_quantity']) ? 'checked="checked"' : ''; ?> /><span></span>Даже если количество товара < или = 0</label>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quickorder-text-show']; ?></td>
									<td>
										<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_quick_order_text]" value="1" <?php echo isset($set['show_quick_order_text']) ? 'checked="checked"' : ''; ?> /><span></span>В категориях, модулях и т.д</label>
										<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_quick_order_text_product]" value="1" <?php echo isset($set['show_quick_order_text_product']) ? 'checked="checked"' : ''; ?> /><span></span>В карточке товара</label>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_attr']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][quick_order_attr]" value="1" <?php if (isset($set['quick_order_attr'])) { echo 'checked="checked"'; } ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_attr_group']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][quick_order_attr_group]" value="<?php echo(isset($set['quick_order_attr_group']) ? $set['quick_order_attr_group'] : '3') ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span><?php echo $lang['entry_item']; ?></span>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_attr_item']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][quick_order_attr_item]" value="<?php echo(isset($set['quick_order_attr_item']) ? $set['quick_order_attr_item'] : '2') ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span><?php echo $lang['entry_item']; ?></span>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_description']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][quick_order_description]" value="1" <?php if (isset($set['quick_order_description'])) { echo 'checked="checked"'; } ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_description_item']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][quick_order_description_item]" value="<?php echo(isset($set['show_quick_order_description_item']) ? $set['quick_order_description_item'] : '250') ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span>симв.</span>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_quickorder-option']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_quickorder-option']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][change_opt_img_q]" value="1" <?php echo isset($set['change_opt_img_q']) ? 'checked="checked"' : '' ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_quickorder-input']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_name_text']; ?></td>
									<td>
										<?php foreach ($languages as $language) { ?>
											<div class="input-group">
												<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
												<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][quick_order_name_text]" value="<?php echo(isset($set[$language['language_id']]['quick_order_name_text']) ? $set[$language['language_id']]['quick_order_name_text'] : 'Ваше имя') ?>" class="form-control" />
											</div>
										<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_phone_text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][quick_order_phone_text]" value="<?php echo isset($set[$language['language_id']]['quick_order_phone_text']) ? $set[$language['language_id']]['quick_order_phone_text'] : 'Контактный телефон'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_phone_mask']; ?></td>
									<td><input type="text" name="uni_set[<?php echo $store_id; ?>][quick_order_phone_mask]" value="<?php echo isset($set['quick_order_phone_mask']) ? $set['quick_order_phone_mask'] : '+7 (999) 999-99-99'; ?>" class="form-control" /></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_mail']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][quick_order_mail]" value="1" <?php echo isset($set['quick_order_mail']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_mail_text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][quick_order_mail_text]" value="<?php echo isset($set[$language['language_id']]['quick_order_mail_text']) ? $set[$language['language_id']]['quick_order_mail_text'] : 'Ваш e-mail'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quickorder-mail-cap']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][quick_order_mail_cap]" value="<?php echo isset($set['quick_order_mail_cap']) ? $set['quick_order_mail_cap'] : 'mail@localhost'; ?>" class="form-control" />
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_delivery']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][quick_order_delivery]" value="1" <?php echo isset($set['quick_order_delivery']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_delivery_text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][quick_order_delivery_text]" value="<?php echo isset($set[$language['language_id']]['quick_order_delivery_text']) ? $set[$language['language_id']]['quick_order_delivery_text'] : 'Адрес доставки'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_comment']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][quick_order_comment]" value="1" <?php echo isset($set['quick_order_comment']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_quick_order_comment_text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][quick_order_comment_text]" value="<?php echo isset($set[$language['language_id']]['quick_order_comment_text']) ? $set[$language['language_id']]['quick_order_comment_text'] : 'Комментарий'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>
								</tr>
							</table>
							</div>
							<div id="tab-callback-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_callback']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_show_callback']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_callback]" value="1" <?php echo isset($set['show_callback']) ? 'checked="checked"' : ''; ?> /><span></span><label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_callback-flybutton']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_fly_callback]" value="1" <?php echo isset($set['show_fly_callback']) ? 'checked="checked"' : ''; ?> /><span></span><label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_callback-flybutton1']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][hide_fly_callback]" value="1" <?php echo isset($set['hide_fly_callback']) ? 'checked="checked"' : ''; ?> /><span></span><label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_callback-title']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][fly_callback_text]" value="<?php echo(isset($set[$language['language_id']]['fly_callback_text']) ? $set[$language['language_id']]['fly_callback_text'] : 'Заказ звонка') ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>	
								</tr>
								<tr>
									<td><?php echo $lang['entry_callback-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][fly_callback_bg]" class="jscolor form-control" data-type="bg" data-class="fly_callback" value="<?php echo (isset($set['fly_callback_bg']) ? $set['fly_callback_bg'] : 'E07572') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][fly_callback_color]" class="jscolor form-control" data-type="color" data-class="fly_callback span" value="<?php echo (isset($set['fly_callback_color']) ? $set['fly_callback_color'] : 'ffffff') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview fly_callback"><span><i class="fa fa-phone" aria-hidden="true"></i></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_callback-input']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_callback-name']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][callback_name_text]" value="<?php echo(isset($set[$language['language_id']]['callback_name_text']) ? $set[$language['language_id']]['callback_name_text'] : 'Ваше имя') ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>	
								</tr>
								<tr>
									<td><?php echo $lang['entry_callback-phone']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][callback_phone_text]" value="<?php echo isset($set[$language['language_id']]['callback_phone_text']) ? $set[$language['language_id']]['callback_phone_text'] : 'Контактный телефон'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>	
								</tr>
								<tr>
									<td><?php echo $lang['entry_callback_phone_mask']; ?></td>
									<td><input type="text" name="uni_set[<?php echo $store_id; ?>][callback_phone_mask]" value="<?php echo(isset($set['callback_phone_mask']) ? $set['callback_phone_mask'] : '+7 (999) 999-99-99') ?>" class="form-control" /></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_callback-mail']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][callback_mail_text]" value="<?php echo isset($set[$language['language_id']]['callback_mail_text']) ? $set[$language['language_id']]['callback_mail_text'] : 'Ваш e-mail'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>	
								</tr>
								<tr>
									<td><?php echo $lang['entry_callback-comment']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][callback_comment_text]" value="<?php echo isset($set[$language['language_id']]['callback_comment_text']) ? $set[$language['language_id']]['callback_comment_text'] : 'Текст вопроса'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>	
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_reason1']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_reason1]" value="1" <?php echo isset($set['show_reason1']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_text_reason1']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][text_reason1]" value="<?php echo isset($set[$language['language_id']]['text_reason1']) ? $set[$language['language_id']]['text_reason1'] : 'Сделать заказ'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>	
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_reason2']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_reason2]" value="1" <?php echo isset($set['show_reason2']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_text_reason2']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][text_reason2]" value="<?php echo isset($set[$language['language_id']]['text_reason2']) ? $set[$language['language_id']]['text_reason2'] : 'Отменить заказ'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>	
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_reason3']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_reason3]" value="1" <?php echo isset($set['show_reason3']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_text_reason3']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][text_reason3]" value="<?php echo(isset($set[$language['language_id']]['text_reason3']) ? $set[$language['language_id']]['text_reason3'] : 'Задать вопрос') ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>	
								</tr>
							</table>
							</div>
							<div id="tab-product-block-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_module-view']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_module-title']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_heading_in_admin]" value="1" <?php echo (isset($set['show_heading_in_admin']) ? 'checked="checked"' : '') ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_module-view']; ?></td>
									<td>
									<?php $set['module_type_view'] = isset($set['module_type_view']) ? $set['module_type_view'] : array(); ?>
									<?php foreach ($modules as $key => $module) { ?>
										<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][module_type_view][<?php echo $key; ?>]" value="<?php echo $module['name2']; ?>" <?php echo in_array($module['name2'], $set['module_type_view']) ? 'checked="checked"' : '' ?> /><span></span><?php echo $module['name']; ?> -> <?php echo $module['name2']; ?></label>
									<?php } ?>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_category-view']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_subcategory-view']; ?></td>
									<td>
										<?php $columns = array(6 => 2, 4 => 3, 3 => 4, 2 => 6); ?>
										<?php $set['subcategory_column'] = isset($set['subcategory_column']) ? $set['subcategory_column'] : array(); ?>
										<div style="display:inline-block">
											<div class="input-group">
											<span class="input-group-addon">Десктоп:</span>
											<select name="uni_set[<?php echo $store_id; ?>][subcategory_column][]" class="form-control" style="width:55px;">
											<?php foreach($columns as $key => $column) { ?>
												<option value="col-lg-<?php echo $key; ?>" <?php echo in_array('col-lg-'.$key, $set['subcategory_column']) ? 'selected="selected"' : ''; ?>><?php echo $column; ?></option>
											<?php } ?>
											</select>
											</div>
										</div>
										<div style="display:inline-block; margin:0 0 0 5px">
											<div class="input-group">
												<span class="input-group-addon">Ноутбук:</span>
												<select name="uni_set[<?php echo $store_id; ?>][subcategory_column][]" class="form-control" style="width:55px;">
												<?php foreach($columns as $key => $column) { ?>
													<option value="col-md-<?php echo $key; ?>" <?php echo in_array('col-md-'.$key, $set['subcategory_column']) ? 'selected="selected"' : ''; ?>><?php echo $column; ?></option>
												<?php } ?>
												</select>
											</div>
										</div>
										<div style="display:inline-block; margin:0 0 0 5px">
											<div class="input-group">
												<span class="input-group-addon">Планшет:</span>
												<select name="uni_set[<?php echo $store_id; ?>][subcategory_column][]" class="form-control" style="width:55px;">
												<?php foreach($columns as $key => $column) { ?>
													<option value="col-sm-<?php echo $key; ?>" <?php echo in_array('col-sm-'.$key, $set['subcategory_column']) ? 'selected="selected"' : ''; ?>><?php echo $column; ?></option>
												<?php } ?>
												</select>
											</div>
										</div>
										<div style="display:inline-block; margin:0 0 0 5px">
											<div class="input-group">
												<span class="input-group-addon">Смартфон:</span>
												<select name="uni_set[<?php echo $store_id; ?>][subcategory_column][]" class="form-control" style="width:55px;">
												<?php foreach($columns as $key => $column) { ?>
													<option value="col-xs-<?php echo $key; ?>" <?php echo in_array('col-xs-'.$key, $set['subcategory_column']) ? 'selected="selected"' : ''; ?>><?php echo $column; ?></option>
												<?php } ?>
												</select>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_cat-desc']; ?></td>
									<td>
										<?php $set['cat_desc_pos'] = isset($set['cat_desc_pos']) ? $set['cat_desc_pos'] : 'top'; ?>
										<?php $positions = array('top' => 'Перед списком товаров', 'bottom' => 'После списка товаров'); ?>
										<select name="uni_set[<?php echo $store_id; ?>][cat_desc_pos]" class="form-control">
											<?php foreach($positions as $key => $name) { ?>
												<option value="<?php echo $key; ?>" <?php echo ($set['cat_desc_pos'] == $key) ? 'selected="selected"' : ''; ?>><?php echo $name; ?></option>
											<?php } ?>
										</select>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_button-view']; ?></td>
									<td>
										<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_grid_button]" value="1" <?php echo isset($set['show_grid_button']) ? 'checked="checked"' : ''; ?> /><span></span>Сетка</label>
										<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_list_button]" value="1" <?php echo isset($set['show_list_button']) ? 'checked="checked"' : ''; ?> /><span></span>Список</label>
										<label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_compact_button]" value="1" <?php echo isset($set['show_compact_button']) ? 'checked="checked"' : ''; ?> /><span></span>Компактный</label>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_default-view']; ?></td>
									<td>
									<?php $views = array('grid' => 'Сетка', 'list' => 'Список', 'compact' => 'Компактный'); ?>
									<select name="uni_set[<?php echo $store_id; ?>][default_view]" class="form-control">
										<?php foreach($views as $key => $view) { ?>
											<option value="<?php echo $key; ?>" <?php echo (isset($set['default_view']) && $set['default_view'] == $key) ? 'selected="selected"' : ''; ?>><?php echo $view; ?></option>
										<?php } ?>
									</select>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product-block']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_show_additional_image']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_additional_image]" value="1" <?php echo isset($set['show_additional_image']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_stock_status']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_stock_status]" value="1" <?php echo isset($set['show_stock_status']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product-block-descr']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_description]" value="1" <?php echo isset($set['show_description']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product-block-descr1']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_description_alt]" value="1" <?php echo isset($set['show_description_alt']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product-block-attr']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_product-block-attr']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_attr]" value="1" <?php echo isset($set['show_attr']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_attr_group']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][show_attr_group]" value="<?php echo isset($set['show_attr_group']) ? $set['show_attr_group'] : '3'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span><?php echo $lang['entry_item']; ?></span>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_show_attr_item']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][show_attr_item]" value="<?php echo isset($set['show_attr_item']) ? $set['show_attr_item'] : '2'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span><?php echo $lang['entry_item']; ?></span>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product-block-attr1']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_attr_name]" value="1" <?php echo isset($set['show_attr_name']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product-block-option']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_product-block-option']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_options]" value="1" <?php echo isset($set['show_options']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product-block-option2']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][show_options_item]" value="<?php echo(isset($set['show_options_item']) ? $set['show_options_item'] : '3') ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span><?php echo $lang['entry_item']; ?></span>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product-block-option3']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][change_opt_img]" value="1" <?php echo isset($set['change_opt_img']) ? 'checked="checked"' : '' ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_product-block-rating']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_product-block-rating']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_rating]" value="1" <?php echo isset($set['show_rating']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_product-block-rating1']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_rating_count]" value="1" <?php echo isset($set['show_rating_count']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
							</table>
							</div>
							<div id="tab-contacts-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr>
									<td><?php echo $lang['entry_contact-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<textarea type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][text_in_contacts]" id="text_in_contacts_<?php echo $language['language_id']; ?>" data-lang="ru-RU" class="form-control summernote"><?php echo(isset($set[$language['language_id']]['text_in_contacts']) ? $set[$language['language_id']]['text_in_contacts'] : '') ?></textarea>
										</div>
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_maps']; ?></td>
									<td><textarea type="text" name="uni_set[<?php echo $store_id; ?>][map]" class="form-control"><?php echo(isset($set['map']) ? $set['map'] : '<script type="text/javascript" charset="utf-8" src="https://api-maps.yandex.ru/services/constructor/1.0/js/?sid=0-UEqyhQjzOUNY4v2mkEt21fwIDcbzO3&width=600&height=450"></script>') ?></textarea></td>
								</tr>
							</table>
							</div>
							<div id="tab-sticker-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_sticker-spec']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_show_sticker_special']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][sticker_special]" value="1" <?php echo isset($set['sticker_special']) ? 'checked="checked"' : ''; ?> /><span></span><label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker-spec']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][sticker_special_percent]" value="1" <?php echo isset($set['sticker_special_percent']) ? 'checked="checked"' : ''; ?> /><span></span><label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker-spec-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][sticker_special_text]" value="<?php echo(isset($set[$language['language_id']]['sticker_special_text']) ? $set[$language['language_id']]['sticker_special_text'] : 'Ваша скидка:') ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker-spec-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_special_background_color]" class="jscolor form-control" data-class="st_sp" data-type="sticker" value="<?php echo (isset($set['sticker_special_background_color']) ? $set['sticker_special_background_color'] : '') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_special_text_color]" class="jscolor form-control" data-class="st_sp" data-type="color" value="<?php echo (isset($set['sticker_special_text_color']) ? $set['sticker_special_text_color'] : '') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview st_sp"><?php echo $lang['entry_sticker-text']; ?><span></span></div>	
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_sticker-new']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_show_sticker_new']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][sticker_new]" value="1" <?php echo isset($set['sticker_new']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker_new_date']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_new_date]" value="<?php if(isset($set['sticker_new_date'])) { ?><?php echo $set['sticker_new_date']; ?><?php } else { ?>30<?php } ?>" style="width:70px !important; text-align:center;" class="form-control" />
										<span>дней</span>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker_new_text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][sticker_new_text]" value="<?php echo isset($set[$language['language_id']]['sticker_new_text']) ? $set[$language['language_id']]['sticker_new_text'] : 'Новинка'; ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>		
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker-new-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_new_background_color]" class="jscolor form-control" data-class="st_new" data-type="sticker" value="<?php echo isset($set['sticker_new_background_color']) ? $set['sticker_new_background_color'] : ''; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_new_text_color]" class="jscolor form-control" data-class="st_new" data-type="color" value="<?php echo isset($set['sticker_new_text_color']) ? $set['sticker_new_text_color'] : ''; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview st_new"><?php echo $lang['entry_sticker-text']; ?><span></span></div>	
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_sticker-best']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_show_sticker_bestseller']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][sticker_bestseller]" value="1" <?php echo isset($set['sticker_bestseller']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker_bestseller_item']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_bestseller_item]" value="<?php echo isset($set['sticker_bestseller_item']) ? $set['sticker_bestseller_item'] : '5'; ?>" style="width:70px !important; text-align:center;" class="form-control" />
										<span>продаж</span>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker_bestseller_text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][sticker_bestseller_text]" value="<?php echo(isset($set[$language['language_id']]['sticker_bestseller_text']) ? $set[$language['language_id']]['sticker_bestseller_text'] : 'Лидер продаж!') ?>" class="form-control" />
										</div>
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker-best-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_bestseller_background_color]" class="jscolor form-control"data-class="st_best" data-type="sticker" value="<?php echo (isset($set['sticker_bestseller_background_color']) ? $set['sticker_bestseller_background_color'] : '') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_bestseller_text_color]" class="jscolor form-control"data-class="st_best" data-type="color" value="<?php echo (isset($set['sticker_bestseller_text_color']) ? $set['sticker_bestseller_text_color'] : '') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview st_best"><?php echo $lang['entry_sticker-text']; ?><span></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_sticker-rew']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_sticker-rew']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][sticker_reward]" value="1" <?php echo isset($set['sticker_reward']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker-rew-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][sticker_reward_text]" value="<?php echo(isset($set[$language['language_id']]['sticker_reward_text']) ? $set[$language['language_id']]['sticker_reward_text'] : 'В подарок:') ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker-rew-text1']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][sticker_reward_text_after]" value="<?php echo(isset($set[$language['language_id']]['sticker_reward_text_after']) ? $set[$language['language_id']]['sticker_reward_text_after'] : 'бонусов') ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_sticker-rew-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_reward_background_color]" class="jscolor form-control" data-class="st_rew" data-type="sticker" value="<?php echo isset($set['sticker_reward_background_color']) ? $set['sticker_reward_background_color'] : ''; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_reward_text_color]" class="jscolor form-control" data-class="st_rew" data-type="color" value="<?php echo isset($set['sticker_reward_text_color']) ? $set['sticker_reward_text_color'] : ''; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview st_rew"><?php echo $lang['entry_sticker-text']; ?><span></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['entry_additional_sticker']; ?> - UPC</b></td></tr>
								<tr>
									<td><?php echo $lang['entry_upc_as_sticker']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][upc_as_sticker]" value="1" <?php if (isset($set['upc_as_sticker'])) { echo 'checked="checked"'; } ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_additional-sticker-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_upc_background_color]" class="jscolor form-control" data-class="st_upc" data-type="sticker" value="<?php echo isset($set['sticker_upc_background_color']) ? $set['sticker_upc_background_color'] : ''; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_upc_text_color]" class="jscolor form-control" data-class="st_upc" data-type="color" value="<?php echo isset($set['sticker_upc_text_color']) ? $set['sticker_upc_text_color'] : ''; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview st_upc"><?php echo $lang['entry_sticker-text']; ?><span></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['entry_additional_sticker']; ?> - EAN</b></td></tr>
								<tr>
									<td><?php echo $lang['entry_ean_as_sticker']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][ean_as_sticker]" value="1" <?php echo isset($set['ean_as_sticker']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_additional-sticker-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_ean_background_color]" class="jscolor form-control" data-class="st_ean" data-type="sticker" value="<?php echo isset($set['sticker_ean_background_color']) ? $set['sticker_ean_background_color'] : ''; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_ean_text_color]" class="jscolor form-control" data-class="st_ean" data-type="color" value="<?php echo isset($set['sticker_ean_text_color']) ? $set['sticker_ean_text_color'] : ''; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview st_ean"><?php echo $lang['entry_sticker-text']; ?><span></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['entry_additional_sticker']; ?> - JAN</b></td></tr>
								<tr>
									<td><?php echo $lang['entry_jan_as_sticker']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][jan_as_sticker]" value="1" <?php echo isset($set['jan_as_sticker']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_additional-sticker-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_jan_background_color]" class="jscolor form-control" data-class="st_jan" data-type="sticker" value="<?php echo (isset($set['sticker_jan_background_color']) ? $set['sticker_jan_background_color'] : '') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_jan_text_color]" class="jscolor form-control" data-class="st_jan" data-type="color" value="<?php echo isset($set['sticker_jan_text_color']) ? $set['sticker_jan_text_color'] : ''; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview st_jan"><?php echo $lang['entry_sticker-text']; ?><span></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['entry_additional_sticker']; ?> - ISBN</b></td></tr>
								<tr>
									<td><?php echo $lang['entry_isbn_as_sticker']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][isbn_as_sticker]" value="1" <?php echo isset($set['isbn_as_sticker']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_additional-sticker-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_isbn_background_color]" class="jscolor form-control" data-class="st_isbn" data-type="sticker" value="<?php echo (isset($set['sticker_isbn_background_color']) ? $set['sticker_isbn_background_color'] : '') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_isbn_text_color]" class="jscolor form-control" data-class="st_isbn" data-type="color" value="<?php echo (isset($set['sticker_isbn_text_color']) ? $set['sticker_isbn_text_color'] : '') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview st_isbn"><?php echo $lang['entry_sticker-text']; ?><span></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['entry_additional_sticker']; ?> - MPN</b></td></tr>
								<tr>
									<td><?php echo $lang['entry_mpn_as_sticker']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][mpn_as_sticker]" value="1" <?php echo isset($set['mpn_as_sticker']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_additional-sticker-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_mpn_background_color]" class="jscolor form-control" data-class="st_mpn" data-type="sticker" value="<?php echo (isset($set['sticker_mpn_background_color']) ? $set['sticker_mpn_background_color'] : '') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][sticker_mpn_text_color]" class="jscolor form-control" data-class="st_mpn" data-type="color" value="<?php echo (isset($set['sticker_mpn_text_color']) ? $set['sticker_mpn_text_color'] : '') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="sticker_preview st_mpn"><?php echo $lang['entry_sticker-text']; ?><span></span></div>
									</td>
								</tr>
							</table>
							</div>
							<div id="tab-login-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_popup-login']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_popup-login']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_login]" value="1" <?php echo isset($set['show_login']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-login-mail']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][login_mail_text]" value="<?php echo isset($set[$language['language_id']]['login_mail_text']) ? $set[$language['language_id']]['login_mail_text'] : 'Ваш e-mail'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-login-pass']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][login_password_text]" value="<?php echo isset($set[$language['language_id']]['login_password_text']) ? $set[$language['language_id']]['login_password_text'] : 'Ваш пароль'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-login-forg']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_login_forgotten]" value="1" <?php echo isset($set['show_login_forgotten']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-login-reg']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_login_register]" value="1" <?php echo isset($set['show_login_register']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_popup-reg']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_register]" value="1" <?php echo isset($set['show_register']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-name']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_name]" value="1" <?php echo isset($set['show_name']) ? 'checked="checked"' : '';  ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-name-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][register_name_text]" value="<?php echo isset($set[$language['language_id']]['register_name_text']) ? $set[$language['language_id']]['register_name_text'] : 'Ваше имя'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-name1']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_lastname]" value="1" <?php echo isset($set['show_lastname']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-name1-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][register_lastname_text]" value="<?php echo isset($set[$language['language_id']]['register_lastname_text']) ? $set[$language['language_id']]['register_lastname_text'] : 'Ваша фамилия'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-mail-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][register_mail_text]" value="<?php echo isset($set[$language['language_id']]['register_mail_text']) ? $set[$language['language_id']]['register_mail_text'] : 'Ваш e-mail'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-phone']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_phone]" value="1" <?php echo isset($set['show_phone']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-phone-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][register_phone_text]" value="<?php echo isset($set[$language['language_id']]['register_phone_text']) ? $set[$language['language_id']]['register_phone_text'] : 'Контактный номер телефона'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-phone-mask']; ?></td>
									<td><input type="text" name="uni_set[<?php echo $store_id; ?>][register_phone_mask]" value="<?php echo isset($set['register_phone_mask']) ? $set['register_phone_mask'] : '+7 (999) 999-99-99'; ?>" class="form-control" /></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-pass-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][register_password_text]" value="<?php echo isset($set[$language['language_id']]['register_password_text']) ? $set[$language['language_id']]['register_password_text'] : 'Придумайте пароль'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-confirm']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_register_confirm]" value="1" <?php echo isset($set['show_register_confirm']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_popup-reg-login']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_register_login]" value="1" <?php echo isset($set['show_register_login']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
							</table>
							</div>
							<div id="tab-checkout-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_checkout']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_checkout']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_checkout]" value="1" <?php echo isset($set['show_checkout']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_checkout-related']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_checkout-related']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_related_product]" value="1" <?php echo isset($set['checkout_related_product']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr style="display:none">
									<td>Показывать блок после формы для ввода контактных данных и кнопки оформления заказа?<span>Если отключено, показывается перед ними.</span></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_related_product_after]" value="1" <?php echo isset($set['checkout_related_product_after']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-related-title']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_related_text]" value="<?php echo isset($set[$language['language_id']]['checkout_related_text']) ? $set[$language['language_id']]['checkout_related_text'] : 'Обратите внимание'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-related-product']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_related_product1]" value="1" <?php echo isset($set['checkout_related_product1']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-related-product1']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_related_product2]" value="1" <?php echo isset($set['checkout_related_product2']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_checkout-personal']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_checkout-name-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_name_text]" value="<?php echo isset($set[$language['language_id']]['checkout_name_text']) ? $set[$language['language_id']]['checkout_name_text'] : 'Ваше имя'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-name1']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_lastname]" value="1" <?php echo isset($set['checkout_lastname']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-name1-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_lastname_text]" value="<?php echo isset($set[$language['language_id']]['checkout_lastname_text']) ? $set[$language['language_id']]['checkout_lastname_text'] : 'Ваша фамилия'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-mail']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_email]" value="1" <?php echo isset($set['checkout_email']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-mail-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_email_text]" value="<?php echo isset($set[$language['language_id']]['checkout_email_text']) ? $set[$language['language_id']]['checkout_email_text'] : 'Ваш e-mail'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-mail-cap']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][checkout_mail_cap]" value="<?php echo isset($set['checkout_mail_cap']) ? $set['checkout_mail_cap'] : 'mail@localhost'; ?>" class="form-control" />
									</td>
								</tr>
								<tr style="display:none">
									<td>Маска ввода для поле "e-mail":<br /><span>Пример, как уже есть по умолчанию +7 (999) 999-99-99 - это значит, что можно ввести только цифры и только в таком виде.</span></td>
									<td><input type="text" name="uni_set[<?php echo $store_id; ?>][checkout_phone_mask]" value="<?php echo isset($set['checkout_phone_mask']) ? $set['checkout_phone_mask'] : '?*@*'; ?>" class="form-control" /></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-phone']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_phone]" value="1" <?php echo isset($set['checkout_phone']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-phone-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_phone_text]" value="<?php echo isset($set[$language['language_id']]['checkout_phone_text']) ? $set[$language['language_id']]['checkout_phone_text'] : 'Контактный телефон'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-phone-mask']; ?></td>
									<td><input type="text" name="uni_set[<?php echo $store_id; ?>][checkout_phone_mask]" value="<?php echo isset($set['checkout_phone_mask']) ? $set['checkout_phone_mask'] : '+7 (999) 999-99-99'; ?>" class="form-control" /></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-pass-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_password_text]" value="<?php echo isset($set[$language['language_id']]['checkout_password_text']) ? $set[$language['language_id']]['checkout_password_text'] : 'Придумайте пароль'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-pass-conf']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_password_confirm]" value="1" <?php echo isset($set['checkout_password_confirm']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-pass-conf-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_password_confirm_text]" value="<?php echo isset($set[$language['language_id']]['checkout_password_confirm_text']) ? $set[$language['language_id']]['checkout_password_confirm_text'] : 'Повторите пароль'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_checkout-address']; ?></b></td></tr>
								<tr><td colspan="2" style="margin:0;color:#f00;"><b><?php echo $lang['header_checkout-address2']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_checkout-country']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_country_zone]" value="1" <?php echo isset($set['checkout_country_zone']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-city']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_city]" value="1" <?php echo isset($set['checkout_city']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-city-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_city_text]" value="<?php echo isset($set[$language['language_id']]['checkout_city_text']) ? $set[$language['language_id']]['checkout_city_text'] : 'Город'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-postcode']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_postcode]" value="1" <?php echo isset($set['checkout_postcode']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-postcode-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_postcode_text]" value="<?php echo isset($set[$language['language_id']]['checkout_postcode_text']) ? $set[$language['language_id']]['checkout_postcode_text'] : 'Индекс'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-address']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_address]" value="1" <?php echo isset($set['checkout_address']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-address-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_address_text]" value="<?php echo isset($set[$language['language_id']]['checkout_address_text']) ? $set[$language['language_id']]['checkout_address_text'] : 'Ваш адрес'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-address1']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][checkout_address2]" value="1" <?php echo isset($set['checkout_address2']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_checkout-address1-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][checkout_address2_text]" value="<?php echo isset($set[$language['language_id']]['checkout_address2_text']) ? $set[$language['language_id']]['checkout_address2_text'] : 'Ваш адрес, продолжнение'; ?>" class="form-control" />
										</div>
									<?php } ?>	
									</td>
								</tr>
							</table>
							</div>
							<div id="tab-cart-btn-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_buybutton']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_buybutton-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_<?php echo $language['language_id']; ?>_с_b" onclick="popup_icons($(this).attr('id'))">Иконка: <i class="<?php echo(isset($set[$language['language_id']]['cart_btn_icon']) ? $set[$language['language_id']]['cart_btn_icon'] : 'fa fa-shopping-basket') ?>"></i></span>
											<input type="hidden" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][cart_btn_icon]" value="<?php echo(isset($set[$language['language_id']]['cart_btn_icon']) ? $set[$language['language_id']]['cart_btn_icon'] : 'fa fa-shopping-basket') ?>" class="form-control" />
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][cart_btn_text]" value="<?php echo isset($set[$language['language_id']]['cart_btn_text']) ? $set[$language['language_id']]['cart_btn_text'] : 'В корзину'; ?>" placeholder="" class="form-control" />
										</div>
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_buybutton-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_btn_bg]" class="jscolor form-control" data-type="bg" data-class="cart_btn" value="<?php echo (isset($set['cart_btn_bg']) ? $set['cart_btn_bg'] : 'E07572') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_btn_color]" class="jscolor form-control" data-type="color" data-class="cart_btn span" value="<?php echo isset($set['cart_btn_color']) ? $set['cart_btn_color'] : 'ffffff'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn cart_btn"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_buybutton-color1']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_btn_bg_hover]" class="jscolor form-control" data-type="bg" data-class="cart_btn_hover" value="<?php echo (isset($set['cart_btn_bg_hover']) ? $set['cart_btn_bg_hover'] : 'E07572') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_btn_color_hover]" class="jscolor form-control" data-type="color" data-class="cart_btn_hover span" value="<?php echo isset($set['cart_btn_color_hover']) ? $set['cart_btn_color_hover'] : 'ffffff'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn cart_btn_hover"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_buybutton-dis']; ?></td>
									<td>
										<?php $set['cart_btn_disabled'] = isset($set['cart_btn_disabled']) ? $set['cart_btn_disabled'] : array(); ?>
										<?php $buttons = array('disabled' => 'Отключить', 'disabled2' => 'Скрыть'); ?>
										<select name="uni_set[<?php echo $store_id; ?>][cart_btn_disabled]" class="form-control">
											<option value="">Ничего не делать</option>
											<?php foreach($buttons as $key => $name) { ?>
												<option value="<?php echo $key; ?>" <?php echo $set['cart_btn_disabled'] == $key ? 'selected="selected"' : ''; ?>><?php echo $name; ?></option>
											<?php } ?>
										</select>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_buybutton-dis-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_<?php echo $language['language_id']; ?>_с_b_d" onclick="popup_icons($(this).attr('id'))">Иконка: <i class="<?php echo(isset($set[$language['language_id']]['cart_btn_icon_disabled']) ? $set[$language['language_id']]['cart_btn_icon_disabled'] : 'fa fa-minus-circle') ?>"></i></span>
											<input type="hidden" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][cart_btn_icon_disabled]" value="<?php echo(isset($set[$language['language_id']]['cart_btn_icon_disabled']) ? $set[$language['language_id']]['cart_btn_icon_disabled'] : '') ?>" class="form-control" />
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][cart_btn_text_disabled]" value="<?php echo isset($set[$language['language_id']]['cart_btn_text_disabled']) ? $set[$language['language_id']]['cart_btn_text_disabled'] : 'Закончился'; ?>" placeholder="" class="form-control" />
										</div>
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_buybutton-dis-icon']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][cart_btn_icon_disabled_mobile]" value="1" <?php echo isset($set['cart_btn_icon_disabled_mobile']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_buybutton-dis-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_btn_bg_disabled]" class="jscolor form-control" data-type="bg" data-class="cart_btn_disabled" value="<?php echo (isset($set['cart_btn_bg_disabled']) ? $set['cart_btn_bg_disabled'] : 'e5e5e5') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_btn_color_disabled]" class="jscolor form-control" data-type="color" data-class="cart_btn_disabled span" value="<?php echo (isset($set['cart_btn_color_disabled']) ? $set['cart_btn_color_disabled'] : '444444') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn cart_btn_disabled"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_buybutton-in-text']; ?></td>
									<td>
									<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="<?php echo (VERSION >= 2.2) ? 'language/'.$language['code'].'/'.$language['code'].'.png' : 'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<span class="input-group-addon open_icon" id="<?php echo $store_id; ?>_<?php echo $language['language_id']; ?>_с_b_i" onclick="popup_icons($(this).attr('id'))">Иконка: <i class="<?php echo(isset($set[$language['language_id']]['cart_btn_icon_incart']) ? $set[$language['language_id']]['cart_btn_icon_incart'] : 'fa fa-check') ?>"></i></span>
											<input type="hidden" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][cart_btn_icon_incart]" value="<?php echo(isset($set[$language['language_id']]['cart_btn_icon_incart']) ? $set[$language['language_id']]['cart_btn_icon_incart'] : '') ?>" class="form-control" />
											<input type="text" name="uni_set[<?php echo $store_id; ?>][<?php echo $language['language_id']; ?>][cart_btn_text_incart]" value="<?php echo(isset($set[$language['language_id']]['cart_btn_text_incart']) ? $set[$language['language_id']]['cart_btn_text_incart'] : 'В корзине') ?>" placeholder="" class="form-control" />
										</div>
									<?php } ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_buybutton-in-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_btn_bg_incart]" class="jscolor form-control" data-type="bg" data-class="cart_btn_incart" value="<?php echo (isset($set['cart_btn_bg_incart']) ? $set['cart_btn_bg_incart'] : 'E07572') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][cart_btn_color_incart]" class="jscolor form-control" data-type="color" data-class="cart_btn_incart span" value="<?php echo (isset($set['cart_btn_color_incart']) ? $set['cart_btn_color_incart'] : 'ffffff') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn cart_btn_incart"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_wishbutton']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_wishbutton']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][wishlist_btn_disabled]" value="1" <?php echo(isset($set['wishlist_btn_disabled']) ? 'checked="checked"' : '') ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_wishbutton-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][wishlist_btn_bg]" class="jscolor form-control" data-type="bg" data-class="wishlist_btn" value="<?php echo (isset($set['wishlist_btn_bg']) ? $set['wishlist_btn_bg'] : 'e5e5e5') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][wishlist_btn_color]" class="jscolor form-control" data-type="color" data-class="wishlist_btn span" value="<?php echo (isset($set['wishlist_btn_color']) ? $set['wishlist_btn_color'] : '333333') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn wishlist_btn"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_wishbutton-color1']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][wishlist_btn_bg_hover]" class="jscolor form-control" data-type="bg" data-class="wishlist_btn_hover" value="<?php echo (isset($set['wishlist_btn_bg_hover']) ? $set['wishlist_btn_bg_hover'] : 'e5e5e5') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][wishlist_btn_color_hover]" class="jscolor form-control" data-type="color" data-class="wishlist_btn_hover span" value="<?php echo (isset($set['wishlist_btn_color_hover']) ? $set['wishlist_btn_color_hover'] : 'E07572') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn wishlist_btn_hover"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_compbutton']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_compbutton']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][compare_btn_disabled]" value="1" <?php echo(isset($set['compare_btn_disabled']) ? 'checked="checked"' : '') ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_compbutton-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][compare_btn_bg]" class="jscolor form-control" data-type="bg" data-class="compare_btn" value="<?php echo (isset($set['compare_btn_bg']) ? $set['compare_btn_bg'] : 'e5e5e5') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][compare_btn_color]" class="jscolor form-control" data-type="color" data-class="compare_btn span" value="<?php echo (isset($set['compare_btn_color']) ? $set['compare_btn_color'] : '333333') ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn compare_btn"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_compbutton-color1']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][compare_btn_bg_hover]" class="jscolor form-control" data-type="bg" data-class="compare_btn_hover" value="<?php echo isset($set['compare_btn_bg_hover']) ? $set['compare_btn_bg_hover'] : 'e5e5e5'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][compare_btn_color_hover]" class="jscolor form-control" data-type="color" data-class="compare_btn_hover span" value="<?php echo isset($set['compare_btn_color_hover']) ? $set['compare_btn_color_hover'] : 'E07572'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn compare_btn_hover"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
							</table>
							</div>
							<div id="tab-fly-menu-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_flymenu']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_flymenu']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_fly_menu]" value="1" <?php echo isset($set['show_fly_menu']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_flymenu-product']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][fly_menu_product]" value="1" <?php echo isset($set['fly_menu_product']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_flymenu-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][fly_menu_bg]" class="jscolor form-control" data-type="bg" data-class="fly_menu" value="<?php echo (isset($set['fly_menu_bg']) ? $set['fly_menu_bg'] : 'f5f5f5') ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][fly_menu_color]" class="jscolor form-control" data-type="color" data-class="fly_menu span" value="<?php echo isset($set['fly_menu_color']) ? $set['fly_menu_color'] : 'E07572'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn fly_menu menu"><span>Текст блока плавающего меню</span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_flycart']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_flycart']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_fly_cart]" value="1" <?php echo isset($set['show_fly_cart']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
							</table>
							</div>
							<div id="tab-search-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_livesearch']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_livesearch']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_search]" value="1" <?php echo isset($set['show_search']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-sort']; ?></td>
									<td class="input-group">
										<?php $s_sorts = array('pd.name' => 'Наименованию', 'p.model' => 'Модели', 'p.quantity' => 'Количеству', 'p.price' => 'Цене', 'rating' => 'Рейтингу', 'p.date_added' => 'Дате добавления'); ?>
										<select name="uni_set[<?php echo $store_id; ?>][search_sort]" class="form-control" style="width:150px">
										<?php foreach($s_sorts as $key => $name) { ?>
											<option value="<?php echo $key; ?>" <?php echo isset($set['search_sort']) && $set['search_sort'] == $key ? 'selected="selected"' : ''; ?>><?php echo $name; ?></option>
										<?php } ?>
										</select>
										<?php $s_orders = array('ASC' => 'Возрастанию', 'DESC' => 'Убыванию'); ?>
										<select name="uni_set[<?php echo $store_id; ?>][search_order]" class="form-control" style="width:150px">
										<?php foreach($s_orders as $key => $name) { ?>
											<option value="<?php echo $key; ?>" <?php echo isset($set['search_order']) && $set['search_order'] == $key ? 'selected="selected"' : ''; ?>><?php echo $name; ?></option>
										<?php } ?>
										</select>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-img']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_search_image]" value="1" <?php echo isset($set['show_search_image']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-img-size']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][search_image_w]" value="<?php echo isset($set['search_image_w']) ? $set['search_image_w'] : '50'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<input type="text" name="uni_set[<?php echo $store_id; ?>][search_image_h]" value="<?php echo isset($set['search_image_h']) ? $set['search_image_h'] : '50'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span>пикс.</span> 
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-name-len']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][search_name_length]" value="<?php echo isset($set['search_name_length']) ? $set['search_name_length'] : '50'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span>симв.</span> 
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-desc']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][search_description]" value="1" <?php echo isset($set['search_description']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-desc2']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_search_description]" value="1" <?php echo isset($set['show_search_description']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-desc-len']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][search_description_length]" value="<?php echo isset($set['search_description_length']) ? $set['search_description_length'] : '50'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span>симв.</span> 
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-rating']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_search_rating]" value="1" <?php echo isset($set['show_search_rating']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-price']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_search_price]" value="1" <?php echo isset($set['show_search_price']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_livesearch-item']; ?></td>
									<td class="input-group">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][search_limit]" value="<?php echo isset($set['search_limit']) ? $set['search_limit'] : '5'; ?>" style="width:50px !important; text-align:center;" class="form-control" />
										<span><?php echo $lang['entry_item']; ?>.</span> 
									</td>
								</tr>
							</table>
							</div>
							<div id="tab-style-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_h']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_h1']; ?></span></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][h1_color]" class="jscolor form-control" data-type="color" data-class="h1 span" value="<?php echo isset($set['h1_color']) ? $set['h1_color'] : '333333'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview h1"><span>Текст тега H1</span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_h2']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][h2_color]" class="jscolor form-control" data-type="color" data-class="h2 span" value="<?php echo isset($set['h2_color']) ? $set['h2_color'] : '333333'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview h2"><span>Текст тега H2</span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_h3']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][h3_color]" class="jscolor form-control" data-type="color" data-class="h3 span" value="<?php echo isset($set['h3_color']) ? $set['h3_color'] : '333333'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview h3"><span>Текст тега H3</span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_h4']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][h4_color]" class="jscolor form-control" data-type="color" data-class="h4 span" value="<?php echo isset($set['h4_color']) ? $set['h4_color'] : '333333'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview h4"><span>Текст тега H4</span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_h5']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][h5_color]" class="jscolor form-control" data-type="color" data-class="h5 span" value="<?php echo isset($set['h5_color']) ? $set['h5_color'] : '333333'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview h5"><span>Текст тега H5</span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_link']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_link-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][a_color]" class="jscolor form-control" data-type="color" data-class="a span:first-child" value="<?php echo isset($set['a_color']) ? $set['a_color'] : 'E07572'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][a_color_hover]" class="jscolor form-control" data-type="color" data-class="a span:last-child" value="<?php echo isset($set['a_color_hover']) ? $set['a_color_hover'] : '333333'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview double a"><span>Текст ссылки</span><span>Текст ссылки при наведении курсора</span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_text']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_text-color']; ?></span></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][text_color]" class="jscolor form-control" data-type="color" data-class="text span" value="<?php echo isset($set['text_color']) ? $set['text_color'] : '333333'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview text"><span>Текст описания</span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_tooltip']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_tooltip-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][tooltip_bg]" class="jscolor form-control" data-type="bg" data-class="tooltips span" value="<?php echo isset($set['tooltip_bg']) ? $set['tooltip_bg'] : '666666'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][tooltip_color]" class="jscolor form-control" data-type="color" data-class="tooltips span" value="<?php echo isset($set['tooltip_color']) ? $set['tooltip_color'] : 'ffffff'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div style="display:inline-block; margin:0 0 10px 0" class="tooltips tooltip fade top in"><span class="tooltip-arrow" style="left:50%; background:transparent !important;"></span><span class="tooltip-inner">Текст подсказки</span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_input']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_input-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][checkbox_radiobutton_bg]" class="jscolor form-control" data-type="bg" data-class="checkbox_radiobutton span" value="<?php echo isset($set['checkbox_radiobutton_bg']) ? $set['checkbox_radiobutton_bg'] : 'E07572'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn checkbox_radiobutton"><span></span><span></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_button']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_button-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][btn_primary_bg]" class="jscolor form-control" data-type="bg" data-class="button_primary" value="<?php echo isset($set['btn_primary_bg']) ? $set['btn_primary_bg'] : 'E07572'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][btn_primary_color]" class="jscolor form-control" data-type="color" data-class="button_primary span" value="<?php echo isset($set['btn_primary_color']) ? $set['btn_primary_color'] : 'ffffff'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn button_primary"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_button-color2']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][btn_primary_bg_hover]" class="jscolor form-control" data-type="bg" data-class="button_primary_hover" value="<?php echo isset($set['btn_primary_bg_hover']) ? $set['btn_primary_bg_hover'] : 'E07572'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][btn_primary_color_hover]" class="jscolor form-control" data-type="color" data-class="button_primary_hover span" value="<?php echo isset($set['btn_primary_color_hover']) ? $set['btn_primary_color_hover'] : 'ffffff'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn button_primary_hover"><span><?php echo $lang['entry_button-text']; ?></span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_mod']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_mod-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][h3_heading_color]" class="jscolor form-control" data-type="color" data-class="h3_heading_color span" value="<?php echo isset($set['h3_heading_color']) ? $set['h3_heading_color'] : '333333'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview h3_heading_color"><span>Заголовок модуля</span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_prod-name']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_prod-name-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][product_thumb_h4_color]" class="jscolor form-control" data-type="color" data-class="product_thumb_h4 span:first-child" value="<?php echo isset($set['product_thumb_h4_color']) ? $set['product_thumb_h4_color'] : 'E07572'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][product_thumb_h4_color_hover]" class="jscolor form-control" data-type="color" data-class="product_thumb_h4 span:last-child" value="<?php echo isset($set['product_thumb_h4_color_hover']) ? $set['product_thumb_h4_color_hover'] : 'E07572'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview double product_thumb_h4"><span>Наименование товара</span><span>Наименование товара при наведении курсора</span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_option']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_option-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][options_bg]" class="jscolor form-control" data-type="bg" data-class="options_color" value="<?php echo isset($set['options_bg']) ? $set['options_bg'] : 'eeeeee'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][options_color]" class="jscolor form-control" data-type="color" data-class="options_color span" value="<?php echo isset($set['options_color']) ? $set['options_color'] : '555'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn options_color"><span>Значение опции</span></div>
									</td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_option-color2']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][options_bg_active]" class="jscolor form-control" data-type="bg" data-class="options_color_active" value="<?php echo isset($set['options_bg_active']) ? $set['options_bg_active'] : 'E07572'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][options_color_active]" class="jscolor form-control" data-type="color" data-class="options_color_active span" value="<?php echo isset($set['options_color_active']) ? $set['options_color_active'] : 'ffffff'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn options_color_active"><span>Значение отмеченной опции</span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_rating']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_rating-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][rating_star_color]" class="jscolor form-control" data-type="color" data-class="rating_star_color i" value="<?php echo isset($set['rating_star_color']) ? $set['rating_star_color'] : 'E07572'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview rating_star_color"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_pag']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_pag-color']; ?></td>
									<td>
										<input type="text" name="uni_set[<?php echo $store_id; ?>][pagination_bg_active]" class="jscolor form-control" data-type="bg" data-class="pagination span:first-child" value="<?php echo isset($set['pagination_bg_active']) ? $set['pagination_bg_active'] : 'E07572'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][pagination_color_active]" class="jscolor form-control" data-type="color" data-class="pagination span:first-child" value="<?php echo isset($set['pagination_color_active']) ? $set['pagination_color_active'] : 'ffffff'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][pagination_bg]" class="jscolor form-control" data-type="bg" data-class="pagination span:not(:first-child)" value="<?php echo isset($set['pagination_bg']) ? $set['pagination_bg'] : 'ffffff'; ?>">
										<input type="text" name="uni_set[<?php echo $store_id; ?>][pagination_color]" class="jscolor form-control" data-type="color" data-class="pagination span:not(:first-child)" value="<?php echo isset($set['pagination_color']) ? $set['pagination_color'] : 'E07572'; ?>">
										<div><?php echo $lang['entry_preview']; ?></div><div class="preview_btn pagination"><span>1</span><span>2</span><span>3</span><span>4</span></div>
									</td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_bgimg']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_background_image']; ?></td>
									<td>
										<a href="" id="thumb-image_<?php echo $store_id; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo (isset($set['background_image']) && $set['background_image'] != '') ? HTTPS_CATALOG.'image/'.$set['background_image'] : $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
										<input type="hidden" name="uni_set[<?php echo $store_id; ?>][background_image]" value="<?php echo isset($set['background_image']) && $set['background_image'] != '' ? $set['background_image'] : ''; ?>" id="image_<?php echo $store_id; ?>" />
									</td>
								</tr>
							</table>
							</div>
							<div id="tab-other-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_other']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_other-robots']; ?></td>
									<td><label><input type="checkbox" name="uni_set[<?php echo $store_id; ?>][show_meta_robots]" value="1" <?php echo isset($set['show_meta_robots']) ? 'checked="checked"' : ''; ?> /><span></span></label></td>
								</tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b><?php echo $lang['header_other-style']; ?></b></td></tr>
								<tr>
									<td><?php echo $lang['entry_custom_style']; ?></td>
									<td><input type="text" name="uni_set[<?php echo $store_id; ?>][custom_style]" value="<?php echo(isset($set['custom_style']) ? $set['custom_style'] : '') ?>" placeholder="Пример: my_mega_style.css" class="form-control"/></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_other-css']; ?></td>
									<td><textarea name="uni_set[<?php echo $store_id; ?>][user_css]" placeholder="Пример: body{background:#fff; color:#555}" class="form-control"><?php echo(isset($set['user_css']) ? $set['user_css'] : '') ?></textarea></td>
								</tr>
								<tr>
									<td><?php echo $lang['entry_other-js']; ?></td>
									<td><textarea name="uni_set[<?php echo $store_id; ?>][user_js]" placeholder="Пример: $(document).ready(function() { autoheight(); });" class="form-control"><?php echo(isset($set['user_js']) ? $set['user_js'] : '') ?></textarea></td>
								</tr>
							</table>
							</div>
							<div id="tab-info-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b>Системные требования</b></td></tr>
								<tr><td>Для корректной работы шаблона необходимы:<br /> - ocStore(OpenCart) версий 2.1.* - 2.3.*,<br />  - PHP версий 5.4 - 5.6,<br />  - ionCube версий 5.*.* - 6.*.*</td></tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b>Что надо сделать после обновления шаблона?</b></td></tr>
								<tr><td>После обновления шаблона обязательно настройте вновь появившиеся опции настроек и нажмите кнопку сохранить.<br /></td></tr>
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b>Где можно найти бекап файлов шаблона?</b></td></tr>
								<tr><td>Если вы обновляли шаблон через модуль управления обновлениями, бекап файлов шаблона можно найти по адресу <strong>/system/storage/download/<strong>.</td></tr>
							</table>
							</div>
							<div id="tab-license-<?php echo $store_id; ?>" class="tab-pane">
							<table id="module" class="list">
								<tr><td colspan="2" class="header"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i><b>Условия использования</b></td></tr>
								<tr>
									<td>
										<?php echo $lang['license']; ?>
									</td>
								</tr>
							</table>
							</div>
						</div>
					</div>
				<?php } ?>
				<input type="hidden" name="apply" value="0" />
			</div>
		</form>
		<div id="copyright"><?php echo $lang['text_copyright']; ?></div>
	</div>
</div>
<link href="../catalog/view/theme/unishop/stylesheet/font-awesome.min.css" property="stylesheet" rel="stylesheet" type="text/css" media="screen" />
<script src="view/javascript/popup.js" type="text/javascript"></script>
<script type="text/javascript">
	function popup_icons(id) {
		$('.popup_icons').popup('show');
		$('.target').val(id);
		
		$('.popup_icons .fa').on('click', function() {
			var this_class = $(this).attr('class');
			$('.class').val(this_class);
			save_icons();
			$('.popup_icons').popup('hide');
		});
	}
	
	function save_icons() {
		var target = $('.target').val();
		var this_class = $('.class').val();
		$('#'+target).html('Иконка: <i class="'+this_class+'"></i>');
		$('#'+target).next().val(this_class);
	}
	
	$('document').ready(function() {
		$('.fontawesome-icon-list').load('view/template/extension/module/uni_icon_block.html');
	});
</script>

<input type="hidden" class="target" name="target" value="" />
<input type="hidden" class="class" name="class" value="" />

<div class="popup_icons"><div class="fontawesome-icon-list"></div>

<script type="text/javascript">
	<?php foreach ($languages as $language) { ?>
		<?php if ($ckeditor) { ?>
			ckeditorInit('additional-tab-<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
			ckeditorInit('text_in_add_contacts_<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
			ckeditorInit('text_in_contacts_<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
		<?php } else { ?>
			<?php if(VERSION <= 2.2) { ?>
				$('#additional-tab-<?php echo $language['language_id']; ?>, #text_in_add_contacts_<?php echo $language['language_id']; ?>, #text_in_contacts_<?php echo $language['language_id']; ?>').summernote({
					height:100,
					lang:'ru-RU'
				});
			<?php } ?>
		<?php } ?>
	<?php } ?>
</script>

<script type="text/javascript">
	$('.nav-tabs a:first').tab('show');
	$('#tab-0 .nav-tabs a:first').tab('show');

	function addHeaderLinks(store_id, lang_id, lang_img) {
		var headerlinks_num = $('#tab-header_'+store_id+' .headerlinks_'+lang_id+' .input-group').size()+1;
		if (headerlinks_num > 4) {
			if (!confirm('Внимание! Большое количество ссылок может некорректно отображаться в данном меню.')) {
				return false;
			}
		}
		html  = '';
		html += '<div class="input-group">';
		html += '<span class="input-group-addon"><img src="'+lang_img+'" title="<?php echo $language['name']; ?>" /></span>';
		html += '<input type="text" name="uni_set['+store_id+']['+lang_id+'][headerlinks]['+headerlinks_num+'][title]" value="" placeholder="Заголовок #'+headerlinks_num+'" class="form-control" />';
		html += '<input type="text" name="uni_set['+store_id+']['+lang_id+'][headerlinks]['+headerlinks_num+'][link]" value="" placeholder="Ссылка #'+headerlinks_num+'" class="form-control" />';
		html += '<span class="btn-default" onclick="$(this).parent().next().remove(); $(this).parent().remove();" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>';
		html += '</div>';
		html += '<div class="infolink">';
		html += '<a onclick="$(this).toggleClass(\'show\');">Использовать ссылку на статью <i class="fa fa-caret-down" aria-hidden="true"></i></a>';
		html += '<div>';
		<?php foreach($informations as $information) { ?>
		html += '<a onclick="$(this).parent().parent().prev().find(\'input:first\').val(\'<?php echo $information['name']; ?>\'); $(this).parent().parent().prev().find(\'input:last\').val(\'<?php echo $information['link']; ?>\');"><?php echo $information['name']; ?></a>';
		<?php } ?>
		html += '</div>';
		html += '</div>';
			
		$('#tab-header_'+store_id+' .headerlinks_'+lang_id).append(html);
	}
	
	function addHeaderLinks2(store_id, lang_id, lang_img) {
		var headerlinks2_num = $('#tab-header_'+store_id+' .headerlinks2_'+lang_id+' .input-group').size()+1;
		if (headerlinks2_num > 4) {
			if (!confirm('Внимание! Большое количество ссылок может некорректно отображаться в данном меню.')) {
				return false;
			}
		}
		html  = '';
		html += '<div class="input-group">';
		html += '<span class="input-group-addon"><img src="'+lang_img+'" title="<?php echo $language['name']; ?>" /></span>';
		html += '<span class="input-group-addon open_icon" id="'+store_id+'_'+lang_id+'_t_l_'+headerlinks2_num+'" onclick="popup_icons($(this).attr(\'id\'))">Иконка: </span>';
		html += '<input type="hidden" name="uni_set['+store_id+']['+lang_id+'][headerlinks2]['+headerlinks2_num+'][icon]" value="" class="form-control" />';
		html += '<input type="text" name="uni_set['+store_id+']['+lang_id+'][headerlinks2]['+headerlinks2_num+'][title]" value="" placeholder="Заголовок #'+headerlinks2_num+'" class="form-control" />';
		html += '<input type="text" name="uni_set['+store_id+']['+lang_id+'][headerlinks2]['+headerlinks2_num+'][link]" value="" placeholder="Ссылка #'+headerlinks2_num+'" class="form-control" />';
		html += '<span class="btn-default" onclick="$(this).parent().next().remove(); $(this).parent().remove();" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>';
		html += '</div>';
		html += '<div class="infolink">';
		html += '<a onclick="$(this).toggleClass(\'show\');">Использовать ссылку на статью <i class="fa fa-caret-down" aria-hidden="true"></i></a>';
		html += '<div>';
		<?php foreach($informations as $information) { ?>
		html += '<a onclick="$(this).parent().parent().prev().find(\'input:first\').val(\'<?php echo $information['name']; ?>\'); $(this).parent().parent().prev().find(\'input:last\').val(\'<?php echo $information['link']; ?>\');"><?php echo $information['name']; ?></a>';
		<?php } ?>
		html += '</div>';
		html += '</div>';
			
		$('#tab-header_'+store_id+' .headerlinks2_'+lang_id).append(html);
	}

	function addPhones(store_id) {
		var phones_num = $('#tab-header_'+store_id+' .phones .input-group').size()+1;
		if (phones_num > 8) {
			if (!confirm('Внимание! Большое количество номеров телефонов может некорректно отображаться в данном меню.')) {
				return false;
			}
		}
		html  = '';
		html += '<div class="input-group">';
		html += '<span class="input-group-addon open_icon" id="'+store_id+'_p_i_'+phones_num+'" onclick="popup_icons($(this).attr(\'id\'))">Иконка: </span>';
		html += '<input type="hidden" name="uni_set['+store_id+'][phones]['+phones_num+'][icon]" value="" class="form-control" />';
		html += '<input type="text" name="uni_set['+store_id+'][phones]['+phones_num+'][number]" value="" placeholder="Телефон #'+phones_num+'" class="form-control" />';
		html += '<select name="uni_set['+store_id+'][phones]['+phones_num+'][type]" class="form-control header-call">';
		html += '<option value="">Тип ссылки: ничего</option>';
		<?php foreach($types as $key => $name) { ?>
		html += '<option value="<?php echo $key; ?>"><?php echo $name; ?></option>';
		<?php } ?>
		html += '</select>';
		html += '<span class="btn-default" onclick="$(this).parent().remove()" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>';
		html += '</div>';
			
		$('#tab-header_'+store_id+' .phones').append(html);
	}

	function addFooterLinks(store_id, lang_id, lang_img) {
		var footerlinks_num = $('#tab-footer-'+store_id+' .footerlinks_'+lang_id+' .input-group').size()+1;
		
		html  = '';
		html += '<div class="input-group">';
		html += '<span class="input-group-addon"><img src="'+lang_img+'" title="" /></span>';
		html += '<input type="text" name="uni_set['+store_id+']['+lang_id+'][footerlinks]['+footerlinks_num+'][title]" value="" placeholder="Заголовок #'+footerlinks_num+'" class="form-control" />';
		html += '<input type="text" name="uni_set['+store_id+']['+lang_id+'][footerlinks]['+footerlinks_num+'][link]" value="" placeholder="Ссылка #'+footerlinks_num+'" class="form-control" />';
		html += '<select name="uni_set['+store_id+']['+lang_id+'][footerlinks]['+footerlinks_num+'][column]" class="form-control">';
		html += '<option value="1" selected="selected">Показывать в колонке #1</option>';
		html += '<option value="2">Показывать в колонке #2</option>';
		html += '<option value="3">Показывать в колонке #3</option>';
		html += '<option value="4">Показывать в колонке #4</option>';
		html += '</select>';
		html += '<span class="btn-default" onclick="$(this).parent().remove()" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>';
		html += '</div>';
			
		$('#tab-footer-'+store_id+' .footerlinks_'+lang_id).append(html);
	}

	function addSocials(store_id) {
		var socials_num = $('#tab-footer-'+store_id+' .socials .input-group').size()+1;
		if (socials_num > 8) {
			if (!confirm('Внимание! Большое количество иконок соцсетей может некорректно отображаться в данном меню.')) {
				return false;
			}
		}
		html  = '';
		html += '<div class="input-group">';
		html += '<select name="uni_set['+store_id+'][socials]['+socials_num+'][icon]" class="form-control">';
		html += '<option value="fa-odnoklassniki" selected="selected">Одноклассники</option>';
		html += '<option value="fa-vk">ВКонтакте</option>';
		html += '<option value="fa-facebook">Фейсбук</option>';
		html += '<option value="fa-twitter">Твиттер</option>';
		html += '<option value="fa-google-plus">Гугл+</option>';
		html += '<option value="fa-instagram">Инстаграм</option>';
		html += '<option value="fa-youtube">Ютуб</option>';
		html += '<option value="fa-pinterest">Пинтерест</option>';
		html += '</select>';
		html += '<input type="text" name="uni_set['+store_id+'][socials]['+socials_num+'][link]" value="" placeholder="Ссылка" class="form-control" />';
		html += '<span class="btn-default" onclick="$(this).parent().remove()" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>';
		html += '</div>';
			
		$('#tab-footer-'+store_id+' .socials').append(html);
	}
	
	function addProductBanner(store_id, lang_id, lang_img) {
		var product_banner_num = $('#tab-product-'+store_id+' .product_banner_'+lang_id+' .input-group').size()+1;
		if (product_banner_num > 6) {
			if (!confirm('Внимание! Большое количество блоков может некорректно отображаться в данном меню.')) {
				return false;
			}
		}
		html  = '';
		html += '<div class="input-group">';
		html += '<span class="input-group-addon"><img src="'+lang_img+'" title="" /></span>';
		html += '<span class="input-group-addon open_icon" id="'+store_id+'_'+lang_id+'_p_b_'+product_banner_num+'" onclick="popup_icons($(this).attr(\'id\'))">Иконка:</span>';
		html += '<input type="hidden" name="uni_set['+store_id+']['+lang_id+'][product_banners]['+product_banner_num+'][icon]" value="" placeholder="Иконка #'+product_banner_num+'" class="form-control" />';
		html += '<input type="text" name="uni_set['+store_id+']['+lang_id+'][product_banners]['+product_banner_num+'][text]" value="" placeholder="Текст #'+product_banner_num+'" class="form-control" />';
		html += '<input type="text" name="uni_set['+store_id+']['+lang_id+'][product_banners]['+product_banner_num+'][link]" value="" placeholder="Ссылка #'+product_banner_num+'" class="form-control" />';
		html += '<span class="btn-default" onclick="$(this).parent().next().remove(); $(this).parent().remove();" title="<?php echo $lang['entry_delete']; ?>"><i class="fa fa-close"></i></span>';
		html += '</div>';
		html += '<label><input type="checkbox" name="uni_set['+store_id+']['+lang_id+'][product_banners]['+product_banner_num+'][link_popup]" value="1" /><span></span>открывать ссылку в popup окне?</label>';
			
		$('#tab-product-'+store_id+' .product_banner_'+lang_id).append(html);
	}
	
	function update_stiker_bg(bg, cl) {
		$('.'+cl).css('background', '#'+bg);
		$('.'+cl+' span').attr('style', 'border-color:#'+bg+' transparent #'+bg+' #'+bg);
	}
	
	function apply() {
		$('.note-editable').each(function() {
			$(this).parent().prev().val($(this).html());
		});
		
		$('.cke_wysiwyg_frame').each(function() {
			$(this).parent().parent().parent().prev().val($(this).contents().find('.cke_editable').html())
		});
		
		data = $('#unishop input, #unishop textarea, #unishop select').serialize();
		$.ajax({
			url: 'index.php?route=extension/module/uni_settings/save&token=<?php echo $token; ?>',
			type: 'post',
			data: data,
			dataType: 'html',
			beforeSend: function() {
				$('.pull-right .btn-success, .scroll_button .btn-success').html('<i class="fa fa-spinner" aria-hidden="true"></i><span>Сохраняем</span>')
			}, 
			success: function(data) {
				if(data == 'success') {
					$('.pull-right .btn-success, .scroll_button .btn-success').html('<i class="fa fa-check" aria-hidden="true"></i><span>Готово!</span>');
					setTimeout(function() {
						$('.pull-right .btn-success, .scroll_button .btn-success').html('<i class="fa fa-save"></i><span>Сохранить</span>');
					}, 1000);
				} else {
					$('.pull-right .btn-success, .scroll_button .btn-success').html('<i class="fa fa-remove"></i>').attr('data-original-title', 'У вас недостаточно прав для управления настройками шаблона').attr('class', 'btn btn-danger');
				}
				refresh();
			}
		});
	}
	
	function refresh() {
		$.ajax({
			url: 'index.php?route=unishop/elements&token=<?php echo $token; ?>',
		});
		$.ajax({
			url: 'index.php?route=extension/modification/refresh&token=<?php echo $token; ?>',
		});
		$.ajax({
			url: 'index.php?route=catalog/review&token=<?php echo $token; ?>',
		});
		$.ajax({
			url: 'index.php?route=uni_blog/category&token=<?php echo $token; ?>',
		});
	}
	
	function set_color(parent, cl, type, color) {
		if(type == 'bg') {
			$('#'+parent+' .'+cl).css('background', '#'+color);
		} else if (type == 'color') {
			$('#'+parent+ ' .'+cl).css('color', '#'+color);
		} else {
			$('#'+parent+' .'+cl).css('background', '#'+color);
			$('#'+parent+' .'+cl+' span').attr('style', 'border-color:#'+color+' transparent #'+color+' #'+color);
		}
		
		if(cl == 'main_menu_children_btn') {$('#'+parent+' .main_menu_parent_btn_hover').css('background', '#'+color);}
		if(cl == 'tooltips span') {$('#'+parent+' .tooltips .tooltip-arrow').css('border-top-color', '#'+color);}
		if(cl == 'options_color') {$('#'+parent+' .options_color').attr('style', 'border: solid 2px #'+color+' !important');}
		if(cl == 'options_color_active') {$('#'+parent+' .options_color_active').attr('style', 'border: solid 2px #'+color+' !important');}
	}

	$('document').ready(function() {
	<?php foreach ($stores as $store) { ?>
		$('#tab-<?php echo $store['store_id']; ?> .jscolor').on('change', function(data) {
			parent = 'tab-<?php echo $store['store_id']; ?>';
			type = $(this).attr('data-type');
			cl = $(this).attr('data-class');
			color = $(this).val();
			
			set_color(parent, cl, type, color)
		});
	
		$('#tab-<?php echo $store['store_id']; ?> .jscolor').each(function() {
			parent = 'tab-<?php echo $store['store_id']; ?>';
			var type = $(this).attr('data-type');
			var cl = $(this).attr('data-class');
			var color = $(this).val();
			
			set_color(parent, cl, type, color)
		});
	<?php } ?>
		
		$('.nav-pills li').on('click', function() {
			var destination = $('.nav-pills').offset().top-60;
			$('html, body').animate({scrollTop: destination}, 400);
		});
		
		$(window).scroll(function(){		
			if($(this).scrollTop()>100) {
				if(!$('.scroll_button').length) {
					$('body').append('<div class="scroll_button"></div>');
					$('.container-fluid .pull-right > *').clone().appendTo('.scroll_button');
					$('[data-toggle=\'tooltip\']').tooltip({container:'body', placement:'bottom'});
				}
			} else {
				$('.scroll_button').remove();
			}
		});
		
		refresh();
		
		
	});
</script>
<?php echo $footer; ?>