<link href="catalog/view/theme/unishop/stylesheet/login_register.css" property="stylesheet" rel="stylesheet" type="text/css" media="screen" /> 
<?php if($show_login) { ?>
<div id="popup_login">
	<i class="fa fa-times close" onclick="$('#popup_login').popup('hide');"></i>
	<h4 class="heading"><span><?php echo $lang['text_login']; ?></span></h4>
	<form name="popuplogin" class="popup_login">
		<div><input type="text" name="email" value="" placeholder="<?php echo $login_mail_text; ?>" class="form-control" /></div>
		<div><input type="password" name="password" value="" placeholder="<?php echo $login_password_text; ?>" class="form-control"  /></div>
	</form>
	<div><button class="login_button btn btn-primary" onclick="send_login();" data-loading-text="<?php echo $lang['text_loading']; ?>"><?php echo $lang['text_login2']; ?></button></div>
	<?php if($show_login_forgotten && $show_login_register) { ?>
		<?php $class = 'col-sm-6'; ?>
	<?php } else { ?>
		<?php $class = 'col-sm-12'; ?>
	<?php } ?>
	<?php if($show_login_forgotten || $show_login_register)  { ?><div class="row"><?php } ?>
	<?php if($show_login_forgotten) { ?><div class="<?php echo $class; ?>"><a href="index.php?route=account/forgotten"><?php echo $lang['text_forgotten']; ?></a></div><?php } ?>
	<?php if($show_login_register) { ?>
		<?php if ($show_register) { ?>
			<div class="<?php echo $class; ?>"><a onclick="$('#popup_login').popup('hide'); register();"><?php echo $lang['text_register2']; ?></a></div>
		<?php } else { ?>
			<div class="<?php echo $class; ?>"><a href="<?php echo $register_link; ?>"><?php echo $lang['text_register2']; ?></a></div>
		<?php } ?>
	<?php } ?>
	<?php if($show_login_forgotten || $show_login_register)  { ?></div><?php } ?>
</div>
<?php } ?>
<?php if($show_register){ ?>
<div id="popup_register">
	<i class="fa fa-times close" onclick="$('#popup_register').popup('hide');"></i>
	<h4 class="heading"><span><?php echo $lang['text_register']; ?></span></h4>
	<form class="popup_register">
		<?php if($show_name) { ?><div><input type="text" name="firstname" value="" placeholder="<?php echo $register_name_text; ?>" class="form-control" /></div><?php } ?>
		<?php if($show_lastname) { ?><div><input type="text" name="lastname" value="" placeholder="<?php echo $register_lastname_text; ?>" class="form-control" /></div><?php } ?>
		<?php if($show_phone) { ?><div><input type="text" name="telephone" value="" placeholder="<?php echo $register_phone_text; ?>" class="customer_phone form-control" /></div><?php } ?>
		<div><input type="text" name="email" value="" placeholder="<?php echo $register_mail_text; ?>" class="form-control" /></div>
		<div><input type="password" name="password" value="" placeholder="<?php echo $register_password_text; ?>" class="form-control" /></div>
		<div class="customer_group" style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
			<?php foreach ($customer_groups as $customer_group) { ?>
			<?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
				<input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
				<label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"></label>
				<label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
				<br />
			<?php } else { ?>
				<input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
				<label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"></label>
				<label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
				<br />
			<?php } ?>
			<?php } ?>
		</div>
		<?php if ($show_register_confirm) { ?><div><input id="confirm" type="checkbox" name="confirm" value="1" /><label for="confirm"></label><?php echo $lang['text_confirm']; ?> "<a href="<?php echo $link_confirm; ?>"><?php echo $text_confirm; ?></a>"</div><?php } ?>
	</form>
	<div><button class="register_button btn btn-primary" onclick="send_register();" data-loading-text="<?php echo $lang['text_loading']; ?>"><?php echo $lang['text_register2']; ?></button></div>
	<?php if ($show_register_login) { ?>
		<?php if ($show_login) { ?>
			<div><?php echo $lang['text_register3']; ?> <a onclick="$('#popup_register').popup('hide'); login();"><?php echo $lang['text_login3']; ?></a></div>
		<?php } else { ?>
			<div><?php echo $lang['text_register3']; ?> <a href="<?php echo $login_link; ?>"><?php echo $lang['text_login3']; ?></a></div>
		<?php } ?>
	<?php } ?>
</div>
<?php } ?>
<script type="text/javascript" src="catalog/view/theme/unishop/js/jquery.maskedinput.min.js"></script>
<script>
$(document).ready(function() {
	$('#popup_login, #popup_register').popup({
		transition: 'all 0.3s', 
		closetransitionend: function () {
			$(this).remove();
		}
	});
	$('body').on('focus', '#popup_register .customer_phone', function(){
		$(this).mask('<?php echo $register_phone_mask; ?>');
	});
});
</script>