<?php

//  Improved options / Расширенные опции
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

$_['module_name']                   = 'Расширенные опции';
$_['heading_title']                 = 'LIVEOPENCART: '.$_['module_name'];
$_['text_edit']                     = 'Настройки модуля: '.$_['module_name'];
$_['text_module']                   = 'Модули';

$_['entry_settings']                = 'Настройки модуля';
$_['entry_about']                   = 'О модуле';

$_['entry_additional_fields']       = 'Дополнительные поля для значений опций';
$_['entry_sku_for_options']         = 'Артикул:';
$_['entry_sku_for_options_0']       = 'Не использовать';
$_['entry_sku_for_options_1']       = 'Использовать';
$_['entry_sku_for_options_2']       = 'Использовать (складывать артикул из частей: арт.товара + арт.опции 1 + арт.опции 2 + ...)';
$_['entry_model_for_options']       = 'Модель:';
$_['entry_model_for_options_0']     = 'Не использовать';
$_['entry_model_for_options_1']     = 'Использовать';
$_['entry_model_for_options_2']     = 'Использовать (складывать модель из частей: модель товара + модель опции 1 + модель опции 2 + ...)';

$_['entry_upc_for_options']         = 'UPC:';
$_['entry_upc_for_options_0']       = 'Не использовать';
$_['entry_upc_for_options_1']       = 'Использовать';

$_['entry_description_for_options'] = 'Описание:';

$_['entry_reward_for_options']         = 'Бонусные баллы:';
$_['entry_reward_for_options_0']       = 'Использовать';
$_['entry_reward_for_options_1']       = 'Не использовать';

$_['entry_additional_features']     = 'Дополнительные функции для значений опций';
$_['entry_auto_selection']          = 'Автовыбор:';
$_['entry_auto_selection_0']        = 'Не использовать';
$_['entry_auto_selection_1']        = 'Первое доступное значение';
$_['entry_auto_selection_2']        = 'Первое доступное значение (если не указано конкретное значение)';
$_['entry_auto_selection_3']        = 'Конкретное значение';
$_['entry_step_by_step']            = 'Пошаговый выбор:';
$_['text_update_alert']             = '(доступна новая версия)';


$_['entry_default_select']          = 'По умолч.';
$_['text_sku']                      = 'Артикул:';
$_['column_sku']                    = 'Артикул';
$_['text_model']                    = 'Модель:';
$_['column_model']                  = 'Модель';

$_['text_success'] = 'Настройки обновлены!';


$_['module_description']    = 'Модуль разработан для расширения стандартной функциональности опций OpenCart.
<br>Он позволяет добавить дополнительные поля для опций (Артикул, Модель, Описание) и настраивать автовыбор опции при открытии страницы товара. <br>
<br><span class="help">Для работы модуля требуется vQmod <a href="http://github.com/vqmod/vqmod" target="_blank">vQmod</a> версии 2.6.1 или выше
(<a href="http://liveopencart.ru/chto-takoe-vqmod/" target="_blank" title="что такое vqmod">что такое vqmod?</a>).</span>';

$_['text_conversation'] = 'Есть вопросы по работе модуля? Требуется интеграция с шаблоном или доработка? Пишите: <b>help@liveopencart.ru</b>.';

$_['entry_we_recommend'] = 'Также рекомендуем:';
$_['text_we_recommend'] = '
<ul>
<li>
<a href="http://liveopencart.ru/opencart-moduli-shablony/moduli/tsenyi/jivaya-tsena-dinamicheskoe-obnovlenie-tsenyi-2" title="Динамическое обновление цены - Живая цена для OpenCart/ocStore" target="_blank">
Динамическое обновление цены - Живая цена</a> - 
Модуль предназначен для динамического обновления цены на странице товара в зависимости от выбранных покупателем опций и количества.
Для определения доступной скидки учитывается количество указанное на странице товара в сумме с количеством товара уже добавленным в корзину.
</li>
<li>
<a href="http://liveopencart.ru/opencart-moduli-shablony/moduli/prochee/svyazannyie-optsii-2" title="Связанные опции для OpenCart/ocStore" target="_blank">
Связанные опции</a> - модуль позволяющий создавать для товаров комбинации связанных опций и указывать для каждой комбинации отдельный остаток, цену, модель и другие данные.
Может быть полезен для товаров, имеющих взаимозависимые опции, например, цвет и размер у одежды.
</li>
</ul>
';

$_['module_copyright'] = 'Модуль "'.$_['module_name'].'" это коммерческое дополнение. Не выкладывайте его на сайтах для скачивания и не передавайте его копии другим лицам.<br>
Приобретая модуль, Вы приобретаете право его использования на одном сайте. Если Вы хотите использовать модуль на нескольких сайтах, следует приобрести отдельную копию модуля для каждого сайта.<br>';

$_['module_info'] = '"'.$_['module_name'].'" версия %s | Разработка: <a href="http://19th19th.ru" target="_blank">19th19th.ru</a> | Поддержка: help@liveopencart.ru | '; 
$_['module_page'] = '';

// Error
$_['error_permission']    = 'У Вас нет прав для изменения модуля "'.$_['heading_title'].'"!';