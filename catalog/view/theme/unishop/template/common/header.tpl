<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<title><?php echo $title; ?></title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<base href="<?php echo $base; ?>" />
<?php if ($show_meta_robots) { ?>
<meta name="robots" content="<?php echo isset($_GET['page']) || isset($_GET['limit']) || isset($_GET['sort']) ? 'noindex, follow' : 'index, follow'; ?>" />
<?php } ?>
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<meta property="og:title" content="<?php echo $title; ?>" />
<meta property="og:type" content="website" />
<?php if (isset($og_url)) { ?>
<meta property="og:url" content="<?php echo $og_url; ?>" />
<?php } ?>
<?php if (isset($og_image)) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>
<meta property="og:site_name" content="<?php echo $name; ?>" />
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<link href="catalog/view/theme/unishop/stylesheet/stylesheet.css?v=2.2.0.4" rel="stylesheet" type="text/css" media="screen" />
<link href="catalog/view/theme/unishop/stylesheet/font-awesome.min.css" rel="stylesheet" type="text/css" media="screen" />
<link href="catalog/view/theme/unishop/stylesheet/elements_<?php echo $store_id; ?>.css" rel="stylesheet" type="text/css" media="screen" />
<?php if ($background_image) { ?>
<link href="catalog/view/theme/unishop/stylesheet/background.css" rel="stylesheet" type="text/css" media="screen" />
<?php } ?>
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php if ($custom_style) { ?>
<link href="catalog/view/theme/unishop/stylesheet/<?php echo $custom_style; ?>" rel="stylesheet" type="text/css" media="screen" />
<?php } ?>
<?php if ($user_css) { ?>
<style type="text/css"><?php echo $user_css; ?></style>
<?php } ?>
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript">if(!localStorage.getItem('display')) {localStorage.setItem('display', '<?php echo $default_view; ?>');}</script>
<script src="catalog/view/theme/unishop/js/common.js" type="text/javascript"></script>
<?php if ($user_js) { ?>
<script><?php echo $user_js; ?></script>
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php if (in_array($route, $menu_schema) || (!$route && in_array('common/home', $menu_schema))) { ?>
<?php
	$one_line = 0;
	$two_line = 0;
	foreach($categories as $category) { 
		if(utf8_strlen($category['name']) <= 30) {
			++$one_line;
		} else {
			++$two_line;
		}
	}
?>
<style type="text/css">
	@media (min-width:992px){
	<?php if ($route == 'common/home' || (!$route && in_array('common/home', $menu_schema))) { ?>
		#column-left {margin-top:<?php echo ($one_line*41)+($two_line*60)+1 ?>px} 
	<?php } else { ?>
		#column-left {margin-top:<?php echo ($one_line*41)+($two_line*60)-42 ?>px} 
	<?php } ?>
		#menu {border-radius:4px 4px 0 0} #menu.menu2 .navbar-collapse {display:block !important}
	}
</style>
<?php } ?>
</head>
<body class="<?php echo $class; ?>">
<nav id="top">
  <div class="container">
	<div class="pull-right">
	<div id="account" class="btn-group">
		<button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
			<i class="fa fa-user" aria-hidden="true"></i> 
			<span class="hidden-xs"><?php echo $logged ? $customer_name : $text_account; ?></span> 
			<i class="fa fa-caret-down"></i>
		</button>
        <ul class="dropdown-menu dropdown-menu-right">
            <?php if ($logged) { ?>
            <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
            <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
            <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
            <?php } else { ?>
            <li><a <?php if($show_register) { ?>onclick="register();"<?php } else { ?>href="<?php echo $register; ?>"<?php } ?> ><?php echo $text_register; ?></a></li>
            <li><a <?php if($show_login) { ?>onclick="login();"<?php } else { ?>href="<?php echo $login; ?>"<?php } ?>><?php echo $text_login; ?></a></li>
            <?php } ?>
        </ul>
    </div>
	</div>
	<?php echo $language; ?>
	<?php echo $currency; ?>
	<?php if($headerlinks) { ?>
		<div id="top-links" class="hidden-xs hidden-sm">
			<ul>
			<?php foreach ($headerlinks as $headerlink) { ?>
				<li><a href="<?php echo $headerlink['link']; ?>" title="<?php echo $headerlink['title']; ?>"><?php echo $headerlink['title']; ?></a></li>
			<?php } ?>
			</ul>
		</div>
		<div id="top-links2" class="btn-group pull-left visible-xs visible-sm">
			<button class="btn btn-link dropdown-toggle" data-toggle="dropdown"><i class="fa fa-info" aria-hidden="true"></i> <i class="fa fa-caret-down"></i></button>
		</div>
	<?php } ?>
  </div>
</nav>
<header>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-3">
				<div id="logo">
					<?php if ($logo) { ?>
						<?php if (isset($og_url) && $home == $og_url) { ?>
							<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
						<?php } else { ?>
							<a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
						<?php } ?>
					<?php } ?>
				</div>
			</div>
			<div class="col-xs-9 col-sm-4 col-md-3 col-md-push-5">
				<div id="phone">
					<div class="phone dropdown-toggle pull-right" data-toggle="dropdown">
						<div><i class="fa fa-phone" aria-hidden="true"></i> <span><?php echo $telephone; ?></span> <i class="fa fa-chevron-down hidden-xs" aria-hidden="true"></i></div>
						<div><?php echo $delivery_hours; ?></div>
					</div>
					<?php if ($phones || $text_in_add_contacts) { ?>
						<ul class="dropdown-menu dropdown-menu-right">
							<?php if($callback) { ?><li><a onclick="callback();" class="open_callback"><span class="hidden-xs"><?php echo $lang_1['text_header_callback']; ?></span><?php echo $lang_1['text_header_callback1']; ?></a></li><?php } ?>
							<?php if($text_in_add_contacts_position && $text_in_add_contacts) { ?><li class="text"><hr style="margin-top:0px;" /><?php echo $text_in_add_contacts; ?><hr style="margin-bottom:5px;" /></li><?php } ?>
							<?php foreach ($phones as $phone) { ?>
								<li>
									<a <?php if($phone['type']) { echo 'href="'.$phone['type'].'"';} ?>>
										<i class="<?php echo $phone['icon']; ?>" aria-hidden="true"></i>
										<span><?php echo $phone['number']; ?></span>
									</a>
								</li>
							<?php } ?>
							<?php if(!$text_in_add_contacts_position && $text_in_add_contacts) { ?><li class="text"><hr style="margin-top:5px;" /><?php echo $text_in_add_contacts; ?></li><?php } ?>
						</ul>
					<?php } ?>
				</div>
			</div>
			<div class="col-xs-3 col-sm-2 col-md-1 col-md-push-5"><?php echo $cart; ?></div>
			<div id="div_search" class="col-xs-12 col-sm-6 col-md-4 col-lg-5 hidden-sm col-md-pull-4"><?php echo $search; ?></div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-12 col-md-8 col-lg-9 col-md-push-4 col-lg-push-3">
				<div class="menu_links">
					<?php foreach ($headerlinks2 as $headerlink) { ?>
						<a href="<?php echo $headerlink['link']; ?>" title="<?php echo $headerlink['title']; ?>"><?php if($headerlink['icon']) { echo '<i class="'.$headerlink['icon'].' hidden-md"></i>'; } ?><?php echo $headerlink['title']; ?></a>
					<?php } ?>
				</div>
			</div>
			<?php if ($categories) { ?>
				<div class="col-sm-6 col-md-4 col-lg-3 col-md-pull-8 col-lg-pull-9">
					<nav id="menu" class="menu2 navbar">
						<div class="navbar-header">
							<span id="category" class=""><?php echo $text_menu; ?></span>
							<button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars" aria-hidden="true"></i></button>
						</div>
						<div class="collapse navbar-collapse navbar-ex1-collapse">
						<ul class="nav navbar-nav">
							<?php foreach ($categories as $category) { ?>
								<?php if ($category['children']) { ?>
									<li class="has_chidren">
										<?php if($menu_links_disabled && $category['category_id'] == $category_id) { ?>
											<a><?php echo $category['name']; ?> <i class="fa fa-chevron-down" aria-hidden="true"></i></a>
										<?php } else { ?>
											<a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?> <i class="fa fa-chevron-down" aria-hidden="true"></i></a>
										<?php } ?>
										<span class="dropdown-toggle visible-xs visible-sm"><i class="fa fa-plus" aria-hidden="true"></i><i class="fa fa-minus" aria-hidden="true"></i></span>
										<div class="dropdown-menu">
											<div class="dropdown-inner">
												<?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
													<ul class="list-unstyled <?php if ($category['column']) { echo 'column'; } ?>">
														<?php foreach ($children as $child) { ?>
															<li>
																<?php if($menu_links_disabled && $child['category_id'] == $category_id) { ?>
																	<a style="text-decoration:none;cursor:default"><i class="fa fa-level-up visible-xs visible-sm" aria-hidden="true"></i><?php echo $child['name']; ?></a>
																<?php } else { ?>
																	<a href="<?php echo $child['href']; ?>"><i class="fa fa-level-up visible-xs visible-sm" aria-hidden="true"></i><?php echo $child['name']; ?></a>
																<?php } ?>
																<?php if (isset($child['children']) && count($child['children']) > 0) { ?>
																	<span class="visible-xs visible-sm"><i class="fa fa-plus" aria-hidden="true"></i><i class="fa fa-minus" aria-hidden="true"></i></span>
																	<div class="dropdown-menu">
																		<div class="dropdown-inner">
																			<ul class="list-unstyled">
																				<?php foreach ($child['children'] as $child) { ?>
																					<li>
																						<?php if($menu_links_disabled && $child['category_id'] == $category_id) { ?>
																							<a style="text-decoration:none;cursor:default"><i class="fa fa-level-up visible-xs visible-sm" aria-hidden="true"></i><?php echo $child['name']; ?></a>
																						<?php } else { ?>
																							<a href="<?php echo $child['href']; ?>"><i class="fa fa-level-up visible-xs visible-sm" aria-hidden="true"></i><?php echo $child['name']; ?></a>
																						<?php } ?>
																					</li>
																				<?php } ?>
																			</ul>
																		</div>
																	</div>
																<?php } ?>
															</li>
														<?php } ?>
													</ul>
												<?php } ?>
											</div>
										</div>
									</li>
								<?php } else { ?>
									<?php if($menu_links_disabled && $category['category_id'] == $category_id) { ?>
										<li><a><?php echo $category['name']; ?></a></li>
									<?php } else { ?>
										<li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
									<?php } ?>
								<?php } ?>
							<?php } ?>
						</ul>
						</div>
					</nav>
				</div>
			<?php } ?>
			<div id="div_search2" class="col-xs-12 col-sm-6 col-md-5 visible-sm"></div>
			<script type="text/javascript">$('#div_search > *').clone().appendTo('#div_search2');</script>
		</div>
	</div>
</header>
<div id="main_content">