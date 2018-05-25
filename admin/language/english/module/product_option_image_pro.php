<?php
//  Product Option Image PRO / Изображения опций PRO
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

// Heading
$_['module_name']           = 'Product option image PRO';
$_['heading_title']         = 'LIVEOPENCART: '.$_['module_name'];
$_['text_edit']             = 'Edit '.$_['module_name'].' Module';
$_['poip_module_name']      = $_['module_name'];

// Text
$_['text_module']         = 'Modules';
$_['text_success']        = 'Success: "'.$_['module_name'] .'" settings changed!';
$_['text_content_top']    = 'Content Top';
$_['text_content_bottom'] = 'Content Bottom';
$_['text_column_left']    = 'Column Left';
$_['text_column_right']   = 'Column Right';

// Entry
$_['entry_settings']                  = 'Module settings';
$_['entry_custom_theme_id']           = 'Custom theme ID';
$_['entry_custom_theme_id_help']      = 'Should be filled only if theme directory is renamed or if theme directory name is not unique';
$_['entry_import']                    = 'Import';
$_['entry_import_description']        = 'Import file format: XLS. Import uses only first sheet for getting data.
<br>First table row must contain fields names (head): product_id, option_value_id, image (not product_option_id)
<br>Next table rows must contain data in accordance with fields names in first table row.';
$_['entry_import_nothing_before']     = 'Don\'t delete options images before import';
$_['entry_import_delete_before']      = 'Delete all options images before import';
$_['PHPExcelNotFound']                = '<a href="https://liveopencart.com/PHPExcel" target="_blank">PHPExcel</a> not found. Not found file: ';
$_['button_upload']		                = 'Import file';
$_['button_upload_help']              = 'import starts immediately after selecting the file';
$_['entry_server_response']           = 'Server answer';
$_['entry_import_result']             = 'Processed rows/images/skipped';
$_['entry_export']                    = 'Export';
$_['button_export']		                = 'Export data';
$_['entry_export_description']        = 'Export products options images data. File format: XLS. Export uses only first sheet for data.
<br>First table row contain fields names (head): product_id, option_value_id, image (not product_option_id)
<br>Next table rows contain data in accordance with fields names in first table row.';

$_['entry_layout']        = 'Layout:';
$_['entry_position']      = 'Position:';
$_['entry_status']        = 'Status:';
$_['entry_sort_order']    = 'Sort Order:';
$_['entry_sort_order_short']    = 'sort:';
$_['entry_settings_default']          = 'global settings';
$_['entry_settings_yes']          = 'On';
$_['entry_settings_no']          = 'Off';

$_['entry_options_images_edit']       = 'Option images edit';
$_['entry_options_images_edit_help']  = 'to set a method to edit options images';
$_['entry_options_images_edit_v0']    = 'Images for options (edit on \'Options\' tab)';
$_['entry_options_images_edit_v1']    = 'Options for images (edit on \'Images\' tab)';

$_['entry_img_use_v0']          = 'Off';
$_['entry_img_use_v1']          = 'On for all';
$_['entry_img_use_v2']          = 'On for selected';

$_['entry_img_first_v0']          = 'As usual';
$_['entry_img_first_v1']          = 'Replace with first option image';
$_['entry_img_first_v2']          = 'Add to option images list';

// Entry Module Settings
$_['entry_img_change']          = 'Change main product image on option select';
$_['entry_img_change_help']     = 'change main product image on product page when option value is selected (use first option image)';
$_['entry_img_hover']           = 'Change main product image on mouse over';
$_['entry_img_hover_help']      = 'change main product image on product page when mouse hover additional image';
$_['entry_img_main_to_additional']           = 'Main image to additional';
$_['entry_img_main_to_additional_help']      = 'add main product image to additional images list';

$_['entry_img_use']             = 'Options images like additional images';
$_['entry_img_use_help']        = 'show options images in additional product images list on product page';

$_['entry_img_limit']           = 'Filter additional images';
$_['entry_img_limit_help']      = 'show in additional product images list on product page only images situable for selected options values<br>
works only with feature "'.$_['entry_img_use'].'"';
$_['entry_img_gal']             = 'Filter product image gallery';
$_['entry_img_gal_help']        = 'show in product image gallery only visible images from additional product images list on product page recommended touse with features "'.$_['entry_img_use'].'" and "'.$_['entry_img_limit'].'"';

$_['entry_img_option']          = 'Images below option';
$_['entry_img_option_help']     = 'show option value images below option value select/radio/checkbox when option value is selected';
//$_['entry_img_select']          = 'Выбор опций по изображениям';
//$_['entry_img_select_help']     = 'добавляет надпись "Выбрать" под каждым изображением опции в списке товаров, при клике на надпись соответствующая опция выбирается автоматически';
$_['entry_img_category']        = 'Options in products lists';
$_['entry_img_category_help']   = 'show option values images with small preview in product lists on categories pages, manufaturers pages, in standard modules "Latest", "Bestsellers", "Special", "Featured".';
//$_['entry_img_sort']            = 'Сквозная сортировка изображений';
//$_['entry_img_sort_help']       = 'сортировать изображения в соответствии с указанным порядком вне зависимости от опций к которым они привязаны';
$_['entry_img_first']           = 'Standard option image';
$_['entry_img_first_help']      = 'usage of standard option images added at options page (menu Catalog - Options - etc)';
$_['entry_img_cart']            = 'Option value image in cart';
$_['entry_img_cart_help']       = 'show selected option value image in cart';

$_['entry_show_settings']       = 'Show individual settings for current product option';
$_['entry_hide_settings']       = 'Hide individual settings for current product option';
$_['entry_show_hide']           = 'show/hide';
$_['entry_img_radio_checkbox']  = 'Show thumbnails for radios and checkboxes';
$_['entry_img_radio_checkbox_help']  = 'show thumbnails for options \'Radio\' and \'Checkbox\' like for \'Image\' (custom theme compatibility not guaranteed)';
$_['entry_dependent_thumbnails']= 'Dependent thumbnails';
$_['entry_dependent_thumbnails_help']= 'change options thumbnails depending on others options selection';

$_['text_update_alert']     = '(new version available)';

$_['entry_about']               = 'About';
$_['module_description']    = '
Module allows to set images for product options values and use these images to better product view in front-end.
<br>To change product images depending on selected options,
change main product image on mouse over additional image,
show individual option thumb instead of standard,
etc.
<br>Compatible with options types: "select", "radio", "image", "checkbox".
<br><span class="help-block">Required <a href="http://github.com/vqmod/vqmod" target="_blank">vQmod 2.6.1 or later</a></span>
';

$_['text_conversation'] = 'We are open for conversation. If you need to modify or integrate our modules, to add new functionality or develop new modules, email as to <b>support@liveopencart.com</b>.';

$_['entry_we_recommend'] = 'We also recommend:';
$_['text_we_recommend'] = '
<ul>
<li>
<a href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=20835" title="Live Price for OpenCart" target="_blank">
Live Price</a> - to dynamic price update on a product page, depending on the quantity and options currenly chosen by the customer (completely compatible with related options).
</li>
<li>
<a href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=20902" title="Related Options for OpenCart" target="_blank">
Related Options</a> - to create combinations of related product options and set stock, price, model etc. for each combination. This functionality can be useful for sales of products, having interlinked options, such as size and color for clothes.
</li>
</ul>
';
$_['module_copyright'] = '"'.$_['module_name'].'". is a commercial extension. Resell or transfer it to other users is NOT ALLOWED.
<br>By purchasing this module, you get it for use on one site. 
If you want to use the module on multiple sites, you should purchase a separate copy for each site.
<br>Thank you for purchasing the module.
';

// Error
$_['error_permission']    = 'Warning: You do not have permission to modify module "'.$_['module_name'] .'"!';


$_['module_info'] = '"'.$_['module_name'] .'" v %s | Developer: <a href="http://liveopencart.com" target="_blank">liveopencart.com</a> | Support: support@liveopencart.com | ';
$_['module_page'] = '<a href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=21188" target="_blank"
title="Product Option Image PRO on opencart.com">Product Option Image PRO on opencart.com</a>
';


