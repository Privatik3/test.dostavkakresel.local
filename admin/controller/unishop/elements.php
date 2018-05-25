<?php 
class ControllerUniShopElements extends Controller {
	public function index() {
		$this->load->model('unishop/settings');
		$this->load->model('setting/store');
			
		$host = $this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG;

		$stores = array(0);
		
		$results = $this->model_setting_store->getStores();
    	foreach ($results as $result) {		
			$stores[] = $result['store_id'];
		}
		
		$settings = $this->model_unishop_settings->getSetting();
			
		foreach($stores as $store) {
		
			$set = $settings[$store];
			
			$style = '';
			
			//basic  elements
			$style .= 'body {color:#'.$set['text_color'].'}';
			$style .= isset($set['background_image']) && $set['background_image'] != '' ? 'body {background-image:url("'.$host.'image/'.$set['background_image'].'")}' : '';
			$style .= 'h1 {color:#'.$set['h1_color'].'}';
			$style .= 'h2 {color:#'.$set['h2_color'].'}';
			$style .= 'h3 {color:#'.$set['h3_color'].'}';
			$style .= 'h4 {color:#'.$set['h4_color'].'}';
			$style .= 'h5 {color:#'.$set['h5_color'].'}';
			$style .= 'h3.heading {color:#'.$set['h3_heading_color'].'}';
			$style .= 'a, #list-view, #grid-view, #compact-view, #phone .open_callback, #phone .open_callback span, #phone .fa-chevron-down {color:#'.$set['a_color'].'}';
			$style .= 'a:hover, a:focus, a:active {color:#'.$set['a_color_hover'].'}';
			$style .= '.rating i, .rating sup a {color:#'.$set['rating_star_color'].'}';
			$style .= 'label input[type="radio"]:checked + span, label input[type="checkbox"]:checked + span{background:#'.$set['checkbox_radiobutton_bg'].'}';
			//$style .= '.option input[type="radio"]:checked + span.img:before {border-color:#'.$set['checkbox_radiobutton_bg'].'}';
			$style .= '.noUi-horizontal .noUi-handle {background:#'.$set['checkbox_radiobutton_bg'].'}';
			$style .= '.tooltip-inner {color:#'.$set['tooltip_color'].'; background:#'.$set['tooltip_bg'].'}';
			$style .= '.tooltip-arrow {border-top-color:#'.$set['tooltip_bg'].' !important}';
			
			$style .= '.option label input[type="radio"] + span, .option label input[type="checkbox"] + span, .option select{color:#'.$set['options_color'].';border:solid 1px #'.$set['options_bg'].' !important}';
			$style .= '.option label input[type="radio"]:checked + span, .option label input[type="checkbox"]:checked + span{color:#'.$set['options_color_active'].'}';
			
			$style .= '.option label input[type="radio"] + span:before, .option label input[type="checkbox"] + span:before{border:solid 2px transparent;}';
			$style .= '.option label input[type="radio"]:checked + span:before, .option label input[type="checkbox"]:checked + span:before, #product .image-additional a.selected:before{border:solid 2px #'.$set['options_bg_active'].'}';
			$style .= '.product-thumb .option input:checked + span:before{border:solid 1px #'.$set['options_bg_active'].' !important}';

			$style .= '.btn.btn-primary {color:#'.$set['btn_primary_color'].' !important; background:#'.$set['btn_primary_bg'].' !important}';
			$style .= '.btn.btn-primary:hover, .btn.btn-primary:focus {color:#'.$set['btn_primary_color_hover'].' !important; background:#'.$set['btn_primary_bg_hover'].' !important}';
			
			//top menu
			$style .= '#top, #top > .container {background:#'.$set['top_menu_bg'].'}';
			$style .= '#top li > a, #top i, #top .btn-group > .btn span {color:#'.$set['top_menu_color'].'}';
			$style .= '#top li > a:hover, #top i:hover, #top .btn-group > .btn:hover span, #top .btn-group.open > .btn span {color:#'.$set['top_menu_color_hover'].'}';
			$style .= ($set['top_menu_color'] > 'EEEEEE') ? '#top .btn-group ul li a {color:#777}' : '';
			
			//search block
			$style .= 'header #search .btn {color:#'.$set['search_btn_color'].'; background:#'.$set['search_btn_bg'].'}';
			$style .= 'header #search input[type="text"]{color:#'.$set['search_input_color'].'}';
			$style .= '#search input::-webkit-input-placeholder{color:#'.$set['search_input_color'].'}';
			$style .= '#search input::-moz-placeholder{color:#'.$set['search_input_color'].' }';
			$style .= '#search input:-ms-input-placeholder{color:#'.$set['search_input_color'].'}';
			$style .= '#search input:-input-placeholder{color:#'.$set['search_input_color'].'}';
			
			//phone block
			$style .= 'header .phone > div:first-child{color:#'.$set['main_phone_color'].'}';
			$style .= 'header .phone + .dropdown-menu li a > i, header .phone + .dropdown-menu li a > span{color:#'.$set['additional_phone_color'].'}';
			
			//cart block
			$style .= 'header #cart .btn {background:#'.$set['cart_bg'].'}';
			$style .= 'header #cart .btn i{color:#'.$set['cart_color'].'}';
			$style .= '#cart > .btn span {color:#'.$set['cart_color_total'].'; background:#'.$set['cart_bg_total'].'}';
			
			//main menu
			$style .= '#menu {color:#'.$set['main_menu_color'].' !important; background:#'.$set['main_menu_bg'].' !important}';
			$style .= '#menu .btn-navbar {color:#'.$set['main_menu_color'].'}';
			
			$style .= '#menu .nav {background:#'.$set['main_menu_parent_bg'].'}';
			$style .= '#menu .nav > li > a, #menu .nav li > .visible-xs i {color:#'.$set['main_menu_parent_color'].'}';
			$style .= '#menu .nav > li:hover > a, #menu .nav > li:hover > .visible-xs i {color:#'.$set['main_menu_parent_color_hover'].'}';
			
			$style .= '#menu .nav > li > .dropdown-menu {background:#'.$set['main_menu_children_bg'].'}';
			$style .= '#menu .nav > li:hover {background:#'.$set['main_menu_children_bg'].'}';
			$style .= '#menu .nav > li.has_chidren:hover:before {background:#'.$set['main_menu_children_bg'].'}';
			
			$style .= '#menu .nav > li ul > li > a {color:#'.$set['main_menu_children_color'].'}';
			$style .= '#menu .nav > li ul li ul > li > a {color:#'.$set['main_menu_children_color2'].'}';
			
			//right menu
			$style .= '.menu_links  {background:#'.$set['right_menu_bg'].'}';
			$style .= '.menu_links a {color:#'.$set['right_menu_color'].'}';
			$style .= '.menu_links a:hover {color:#'.$set['right_menu_color_hover'].'}';
			$style .= ($set['right_menu_color'] > $set['right_menu_bg']) ? '@media (max-width:992px){.menu_links a, .menu_links a:hover {color:#'.$set['right_menu_bg'].'}}' : '';
			
			//fly menu
			$style .= '#menu_wrap #menu, #menu_wrap #menu .navbar-header, #menu_wrap #search .btn, #menu_wrap #account, #menu_wrap #cart > button {background:#'.$set['fly_menu_bg'].'}';
			$style .= '#menu_wrap #menu #category, #menu_wrap #menu .btn-navbar, #menu_wrap #search .btn, #menu_wrap #phone .phone > div, #menu_wrap #account button i, #menu_wrap #cart > button i {color:#'.$set['fly_menu_color'].'}';
			$style .= '#menu_wrap #cart > .btn span {background:#'.$set['fly_menu_color'].'}';
			
			//slideshow
			$style .= '.slideshow .title{color:#'.$set['slideshow_title_color'].'; background:#'.$set['slideshow_title_bg'].'}';
			$style .= '.slideshow .title:after{border-color: #'.$set['slideshow_title_bg'].' transparent #'.$set['slideshow_title_bg'].' #'.$set['slideshow_title_bg'].'}';
			$style .= isset($set['hide_slideshow_title']) ? '.slideshow .title{display:none}' : '';
			$style .= '.slideshow .owl-page span{background:#'.$set['slideshow_pagination_bg'].'}';
			$style .= '.slideshow .owl-page.active span{background:#'.$set['slideshow_pagination_bg_active'].'}';
			
			//home text banners
			$style .= '.home_banners > div > div {background:#'.$set['home_banners_bg'].'; color:#'.$set['home_banners_text_color'].'}';
			$style .= '.home_banners > div i {color:#'.$set['home_banners_icon_color'].'}';
			
			//cat description
			$style .= ($set['cat_desc_pos'] == 'bottom') ? '.category-info{display:none}' : '';
			
			//product-thumb
			$style .= '.product-thumb .caption > a{color:#'.$set['product_thumb_h4_color'].'}';
			$style .= '.product-thumb .caption > a:hover{color:#'.$set['product_thumb_h4_color_hover'].'}';
			
			//cart btn
			$style .= '.add_to_cart {color:#'.$set['cart_btn_color'].' !important; background:#'.$set['cart_btn_bg'].' !important}'; 
			$style .= '.product-thumb:hover .add_to_cart, .add_to_cart:hover, .add_to_cart:focus, .add_to_cart:active {color:#'.$set['cart_btn_color_hover'].' !important; background:#'.$set['cart_btn_bg_hover'].' !important}';
			$style .= '.add_to_cart.in_cart, .add_to_cart.in_cart:hover, .product-thumb:hover .add_to_cart.in_cart {color:#'.$set['cart_btn_color_incart'].' !important; background:#'.$set['cart_btn_bg_incart'].' !important}';
			$style .= '.add_to_cart.disabled, .add_to_cart.disabled:hover, .product-thumb:hover .add_to_cart.disabled {color:#'.$set['cart_btn_color_disabled'].' !important; background:#'.$set['cart_btn_bg_disabled'].' !important}';  				
			
			//quick order btn
			$style .= '.btn.quick_order {color:#'.$set['quick_order_btn_color'].' !important; background:#'.$set['quick_order_btn_bg'].' !important}'; 
			$style .= '.btn.quick_order:hover, .btn.quick_order:focus, .btn.quick_order:active {color:#'.$set['quick_order_btn_color_hover'].' !important; background:#'.$set['quick_order_btn_bg_hover'].' !important}';
			$style .= isset($set['show_quick_order_always']) ? '.btn.quick_order {transform: scale(1)}' : '';
			
			//wishlist&compare btn
			$style .= '.btn.wishlist {color:#'.$set['wishlist_btn_color'].' !important; background:#'.$set['wishlist_btn_bg'].' !important}'; 
			$style .= '.btn.wishlist:hover {color:#'.$set['wishlist_btn_color_hover'].' !important; background:#'.$set['wishlist_btn_bg_hover'].' !important}';
			$style .= '.btn.compare {color:#'.$set['compare_btn_color'].' !important; background:#'.$set['compare_btn_bg'].' !important}'; 
			$style .= '.btn.compare:hover {color:#'.$set['compare_btn_color_hover'].' !important; background:#'.$set['compare_btn_bg_hover'].' !important}';
			
			//stickers
			$style .= '.product_sticker.reward {color:#'.$set['sticker_reward_text_color'].'; background:#'.$set['sticker_reward_background_color'].'}';
			$style .= '.product_sticker.reward:after {border-color:#'.$set['sticker_reward_background_color'].' transparent #'.$set['sticker_reward_background_color'].' #'.$set['sticker_reward_background_color'].'}';
			$style .= '.product_sticker.special {color:#'.$set['sticker_special_text_color'].'; background:#'.$set['sticker_special_background_color'].'}';
			$style .= '.product_sticker.special:after {border-color:#'.$set['sticker_special_background_color'].' transparent #'.$set['sticker_special_background_color'].' #'.$set['sticker_special_background_color'].'}';
			$style .= '.product_sticker.bestseller {color:#'.$set['sticker_bestseller_text_color'].'; background:#'.$set['sticker_bestseller_background_color'].'}';
			$style .= '.product_sticker.bestseller:after {border-color:#'.$set['sticker_bestseller_background_color'].' transparent #'.$set['sticker_bestseller_background_color'].' #'.$set['sticker_bestseller_background_color'].'}';
			$style .= '.product_sticker.new {color:#'.$set['sticker_new_text_color'].'; background:#'.$set['sticker_new_background_color'].'}';
			$style .= '.product_sticker.new:after {border-color:#'.$set['sticker_new_background_color'].' transparent #'.$set['sticker_new_background_color'].' #'.$set['sticker_new_background_color'].'}';
			$style .= '.product_sticker.upc {color:#'.$set['sticker_upc_text_color'].'; background:#'.$set['sticker_upc_background_color'].'}';
			$style .= '.product_sticker.upc:after {border-color:#'.$set['sticker_upc_background_color'].' transparent #'.$set['sticker_upc_background_color'].' #'.$set['sticker_upc_background_color'].'}';
			$style .= '.product_sticker.ean {color:#'.$set['sticker_ean_text_color'].'; background:#'.$set['sticker_ean_background_color'].'}';
			$style .= '.product_sticker.ean:after {border-color:#'.$set['sticker_ean_background_color'].' transparent #'.$set['sticker_ean_background_color'].' #'.$set['sticker_ean_background_color'].'}';
			$style .= '.product_sticker.jan {color:#'.$set['sticker_jan_text_color'].'; background:#'.$set['sticker_jan_background_color'].'}';
			$style .= '.product_sticker.jan:after {border-color:#'.$set['sticker_jan_background_color'].' transparent #'.$set['sticker_jan_background_color'].' #'.$set['sticker_jan_background_color'].'}';
			$style .= '.product_sticker.isbn {color:#'.$set['sticker_isbn_text_color'].'; background:#'.$set['sticker_isbn_background_color'].'}';
			$style .= '.product_sticker.isbn:after {border-color:#'.$set['sticker_isbn_background_color'].' transparent #'.$set['sticker_isbn_background_color'].' #'.$set['sticker_isbn_background_color'].'}';
			$style .= '.product_sticker.mpn {color:#'.$set['sticker_mpn_text_color'].'; background:#'.$set['sticker_mpn_background_color'].'}';
			$style .= '.product_sticker.mpn:after {border-color:#'.$set['sticker_mpn_background_color'].' transparent #'.$set['sticker_mpn_background_color'].' #'.$set['sticker_mpn_background_color'].'}';
			
			//product text banners
			$style .= '.product_banners > div > div {color:#'.$set['product_banners_text_color'].'; background:#'.$set['product_banners_bg'].'}';
			$style .= '.product_banners > div i {color:#'.$set['product_banners_icon_color'].'}';
			
			//pagination
			$style .= '.pagination li a, .pagination li a:hover, .pagination li a:visited{color:#'.$set['pagination_color'].' !important; background:#'.$set['pagination_bg'].' !important}';
			$style .= '.pagination li.active span{color:#'.$set['pagination_color_active'].' !important; background:#'.$set['pagination_bg_active'].'!important}';
			
			//footer
			$style .= 'footer{background:url(\'../image/footer.png\') #'.$set['footer_bg'].'}';
			$style .= isset($set['background_image']) && $set['background_image'] != '' ? 'footer > .container {background:url(\'../image/footer.png\') #'.$set['footer_bg'].'}' : '';
			$style .= 'footer h5{color:#'.$set['footer_h5_color'].'}';
			$style .= 'footer, footer a, footer a:hover, footer a:visited{color:#'.$set['footer_text_color'].'}';
			
			//fly callback button
			$style .= '.fly_callback, .fly_callback2 {color:#'.$set['fly_callback_color'].'; background:#'.$set['fly_callback_bg'].'}';
			$style .= '.fly_callback:before, .fly_callback:after {border:solid 1px;border-color:#'.$set['fly_callback_bg'].' transparent}';
			$style .= isset($set['hide_fly_callback']) ? '@media (max-width:767px){.fly_callback, .fly_callback2 {display:none !important}}' : '';
			
			$style_file = fopen(DIR_CATALOG.'view/theme/unishop/stylesheet/elements_'.$store.'.css', 'w');
			fwrite($style_file, $style);
			fclose($style_file);
		}
	}
}
?>