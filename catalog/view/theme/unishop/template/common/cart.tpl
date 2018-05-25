<div id="cart" class="btn-group pull-right <?php if ($products) { ?>show<?php } ?>">
	<button type="button" data-toggle="dropdown" data-loading-text="<?php echo $text_loading; ?>" class="btn dropdown-toggle"><i class="fa fa-shopping-basket"></i> <span id="cart-total"><?php echo $items; ?></span></button>
	<ul class="dropdown-menu pull-right">
		<?php if ($products || $vouchers) { ?>
			<li>
				<table class="cart table table-striped">
					<?php foreach ($products as $product) { ?>
						<tr>
							<td class="image">
								<?php if ($product['thumb']) { ?>
									<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
								<?php } ?>
							</td>
							<td class="name text-left">
								<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
								<?php if ($product['option']) { ?>
									<?php foreach ($product['option'] as $option) { ?>
										<br />- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
									<?php } ?>
								<?php } ?>
								<?php if ($product['recurring']) { ?>
									<br />- <small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
								<?php } ?>
							</td>
							<td class="quantity text-right">
								<div class="input-group" style="max-width:100px;"> 
									<input type="text" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" onchange="cart.update('<?php echo $product['cart_id']; ?>', $(this).val());" size="1" class="form-control" /> 
									<span>
										<i class="fa fa-plus btn btn-default" onclick="cart.update('<?php echo $product['cart_id']; ?>', parseFloat($(this).parent().prev().val())+1);"></i>
										<i class="fa fa-minus btn btn-default" onclick="cart.update('<?php echo $product['cart_id']; ?>', parseFloat($(this).parent().prev().val())-1);"></i> 
									</span>
								</div>
							</td>
							<td class="total text-right"><?php echo $product['total']; ?></td>
							<td class="remove text-center"><button type="button" onclick="cart.remove('<?php echo $product['cart_id']; ?>', <?php echo $product['id']; ?>);" title="<?php echo $button_remove; ?>" class=""><i class="fa fa-times"></i></button></td>
						</tr>
					<?php } ?>
					<?php foreach ($vouchers as $voucher) { ?>
						<tr>
							<td class="text-center"></td>
							<td class="text-left"><?php echo $voucher['description']; ?></td>
							<td class="text-right">x&nbsp;1</td>
							<td class="text-right"><?php echo $voucher['amount']; ?></td>
							<td class="text-center text-danger"><button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class=""><i class="fa fa-times"></i></button></td>
						</tr>
					<?php } ?>
				</table>
			</li>
			<li>
				<div>
					<table class="table table-bordered">
						<?php foreach ($totals as $total) { ?>
							<tr>
								<td class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
								<td class="text-right"><?php echo $total['text']; ?></td>
							</tr>
						<?php } ?>
					</table>
					<p class="text-right">
						<?php if($show_checkout) { ?>
							<a href="index.php?route=checkout/uni_checkout" class="btn btn-primary"><?php echo $text_checkout; ?></strong></a>
						<?php } else { ?>
							<a href="<?php echo $cart; ?>"><strong><i class="fa fa-shopping-cart"></i> <?php echo $text_cart; ?></strong></a>&nbsp;&nbsp;&nbsp;
							<a href="<?php echo $checkout; ?>"><strong><i class="fa fa-share"></i> <?php echo $text_checkout; ?></strong></a>
						<?php } ?>
					</p>
				</div>
			</li>
		<?php } else { ?>
			<li style="padding-top:0;border-top:none">
				<p class="text-center"><?php echo $text_empty; ?></p>
			</li>
		<?php } ?>
	</ul>
<script>
function p_array() {
<?php foreach ($products as $product) { ?>
<?php if($product['option']) { ?>
	replace_button('<?php echo $product['id']; ?>', 1);
<?php } else { ?>
	replace_button('<?php echo $product['id']; ?>', 0);
<?php } ?>
<?php } ?>
}

function replace_button(product_id, options){
	$('.'+product_id).html('<i class="<?php echo $cart_btn_icon_incart; ?>" aria-hidden="true"></i> <span class="hidden-sm"><?php echo $cart_btn_text_incart; ?></span>').addClass('in_cart');
}
function return_button(product_id) {
	$('.'+product_id).html('<i class="<?php echo $cart_btn_icon; ?>" aria-hidden="true"></i> <span class="hidden-sm"><?php echo $cart_btn_text; ?></span>').removeClass('in_cart');
}

$(document).ready(function() {
	p_array();
});
</script>
</div>