<?php if (isset($category_id)) { ?>
	<thead><tr class="collapsed head" aria-expanded="false" data-toggle="collapse" data-target="#category-<?php echo $option_product['product_option_id']; ?>-<?php echo $category_id; ?>"><th colspan="9"><span></span><?php echo $name; ?></th></tr></thead>
	<tbody id="category-<?php echo $option_product['product_option_id']; ?>-<?php echo $category_id; ?>" class="level collapse out">
	<tr class="row-default">
		<td class="text-left"><input type="checkbox" data-toggle="eneble"/></td>
		<td colspan="2" class="text-right"><input type="text" value="" data-toggle="quantity" placeholder="<?php echo $entry_quantity; ?>" class="form-control" /></td>
		<td class="text-left"><select class="form-control" data-toggle="subtract">
				<option value="1"><?php echo $text_yes; ?></option>
				<option value="0"><?php echo $text_no; ?></option>
			</select></td>
		<td class="text-right"><select class="form-control" data-toggle="price_prefix">
				<option value="+">+</option>
				<option value="-">-</option>
                <option value="=">=</option>
			</select>
			<input type="text" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" data-toggle="price"/></td>
		<td class="text-right"><select class="form-control" data-toggle="points_prefix">
				<option value="+">+</option>
				<option value="-">-</option>
			</select>
			<input type="text" value="" placeholder="<?php echo $entry_points; ?>" class="form-control" data-toggle="points"/></td>
		<td class="text-right"><select class="form-control" data-toggle="weight_prefix">
				<option value="+">+</option>
				<option value="-">-</option>
			</select>
			<input type="text" value="" placeholder="<?php echo $entry_weight; ?>" class="form-control" data-toggle="weight"/></td>
	</tr>
	<tr>
	<td colspan="9">
	<table class="table table-bordered table-hover">
<?php } ?>
<?php if (isset($option_value)) { ?>
	<?php foreach ($option_value as $value) { ?>
		<?php $option_value_row = $value['option_value_id']; ?>
		<?php (isset($option_product['product_option_value'][$value['option_value_id']])) ? $isset = true : $isset = false; ?>
		<tr id="option-value-row-<?php echo $option_value_row?>" class="level">
			  <td class="text-left"><input<?php if ($isset) { ?> checked<?php }?> type="checkbox" class="enable-value" data-toggle="eneble"/></td>
			  <td class="text-left"><input<?php if (!$isset) { ?><?php if (!$isset) { ?> disabled<?php } ?><?php } ?> hidden name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][option_value_id]" value="<?php echo $value['option_value_id']?>"/>
				  <?php echo $value['name']?>
				  <input<?php if (!$isset) { ?> disabled<?php } ?> type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][product_option_value_id]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$value['option_value_id']]['product_option_value_id'];} ?>" /></td>
			  <td class="text-right"><input<?php if (!$isset) { ?> disabled<?php } ?> type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][quantity]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$value['option_value_id']]['quantity'];} ?>" placeholder="<?php echo $entry_quantity; ?>" class="form-control" data-toggle="quantity"/></td>
			  <td class="text-left"><select<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][subtract]" class="form-control" data-toggle="subtract" value="">
					  <?php if ($isset && $option_product['product_option_value'][$value['option_value_id']]['subtract'] == 0) { ?>
					    <option value="1"><?php echo $text_yes; ?></option>
					    <option value="0" selected="selected"><?php echo $text_no; ?></option>
					  <?php } else { ?>
					    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
					    <option value="0"><?php echo $text_no; ?></option>
					  <?php } ?>
					  </select></td>
			  <td class="text-right"><select<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][price_prefix]" class="form-control" data-toggle="price_prefix">
					<?php if ($isset && $option_product['product_option_value'][$value['option_value_id']]['price_prefix'] == '-') { ?>
					    <option value="=">=</option>
                        <option value="+">+</option>
					    <option value="-" selected="selected">-</option>
					<?php } elseif ($isset && $option_product['product_option_value'][$value['option_value_id']]['price_prefix'] == '+') { ?>
                        <option value="=">=</option>
						<option value="+" selected="selected">+</option>
						<option value="-">-</option>
					<?php } else { ?>
                        <option value="=" selected="selected">=</option>
						<option value="+">+</option>
						<option value="-">-</option>
                    <?php } ?>
					  </select>
				  <input type="text"<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][price]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$value['option_value_id']]['price'];} ?>" placeholder="<?php echo $entry_price; ?>" class="form-control" data-toggle="price"/></td>
			  <td class="text-right"><select<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][points_prefix]" class="form-control" data-toggle="points_prefix">
		<?php if ($isset && $option_product['product_option_value'][$value['option_value_id']]['points_prefix'] == '-') { ?>
					    <option value="+">+</option>
					    <option value="-" selected="selected">-</option>
					<?php } else { ?>
						<option value="+" selected="selected">+</option>
						<option value="-">-</option>
					<?php } ?>
					  </select>
				  <input type="text"<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][points]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$value['option_value_id']]['points'];} ?>" placeholder="<?php echo $entry_points; ?>" class="form-control" data-toggle="points"/></td>
			  <td class="text-right"><select<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][weight_prefix]" class="form-control" data-toggle="weight_prefix">
					  <?php if ($isset && $option_product['product_option_value'][$value['option_value_id']]['weight_prefix'] == '-') { ?>
						  <option value="+">+</option>
						  <option value="-" selected="selected">-</option>
					  <?php } else { ?>
						  <option value="+" selected="selected">+</option>
						  <option value="-">-</option>
					  <?php } ?>
					  </select>
				  <input type="text"<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][weight]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$value['option_value_id']]['weight'];} ?>" placeholder="<?php echo $entry_weight; ?>" class="form-control" data-toggle="weight"/></td>
			</tr>
	<?php } ?>
<?php } ?>
<?php if (isset($option_value_id)) { ?>
	<?php $option_value_row = $option_value_id; ?>
	<?php (isset($option_product['product_option_value'][$option_value_id])) ? $isset = true : $isset = false; ?>
	<tr id="option-value-row-<?php echo $option_value_row?>" class="level">
		<td class="text-left"><input<?php if ($isset) { ?> checked<?php }?> type="checkbox" class="enable-value" data-toggle="eneble"/></td>
		<td class="text-left"><input<?php if (!$isset) { ?><?php if (!$isset) { ?> disabled<?php } ?><?php } ?> hidden name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][option_value_id]" value="<?php echo $option_value_id?>"/>
			<?php echo $name; ?>
			<input<?php if (!$isset) { ?> disabled<?php } ?> type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][product_option_value_id]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$option_value_id]['product_option_value_id'];} ?>" /></td>
		<td class="text-right"><input<?php if (!$isset) { ?> disabled<?php } ?> type="text" name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][quantity]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$option_value_id]['quantity'];} ?>" placeholder="<?php echo $entry_quantity; ?>" class="form-control" data-toggle="quantity"/></td>
		<td class="text-left"><select<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][subtract]" class="form-control" data-toggle="subtract" value="">
				<?php if ($isset && $option_product['product_option_value'][$option_value_id]['subtract'] == 0) { ?>
					<option value="1"><?php echo $text_yes; ?></option>
					<option value="0" selected="selected"><?php echo $text_no; ?></option>
				<?php } else { ?>
					<option value="1" selected="selected"><?php echo $text_yes; ?></option>
					<option value="0"><?php echo $text_no; ?></option>
				<?php } ?>
			</select></td>
		<td class="text-right"><select<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][price_prefix]" class="form-control" data-toggle="price_prefix">
				<?php if ($isset && $option_product['product_option_value'][$option_value_id]['price_prefix'] == '-') { ?>
					<option value="=">=</option>
                    <option value="+">+</option>
					<option value="-" selected="selected">-</option>
				<?php } elseif ($isset && $option_product['product_option_value'][$option_value_id]['price_prefix'] == '+') { ?>
					<option value="=">=</option>
                    <option value="+" selected="selected">+</option>
					<option value="-">-</option>
				<?php } else { ?>
                    <option value="=" selected="selected">=</option>
                    <option value="+">+</option>
					<option value="-">-</option>
                <?php } ?>
			</select>
			<input type="text"<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][price]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$option_value_id]['price'];} ?>" placeholder="<?php echo $entry_price; ?>" class="form-control" data-toggle="price"/></td>
		<td class="text-right"><select<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][points_prefix]" class="form-control" data-toggle="points_prefix">
				<?php if ($isset && $option_product['product_option_value'][$option_value_id]['points_prefix'] == '-') { ?>
					<option value="+">+</option>
					<option value="-" selected="selected">-</option>
				<?php } else { ?>
					<option value="+" selected="selected">+</option>
					<option value="-">-</option>
				<?php } ?>
			</select>
			<input type="text"<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][points]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$option_value_id]['points'];} ?>" placeholder="<?php echo $entry_points; ?>" class="form-control" data-toggle="points"/></td>
		<td class="text-right"><select<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][weight_prefix]" class="form-control" data-toggle="weight_prefix">
				<?php if ($isset && $option_product['product_option_value'][$option_value_id]['weight_prefix'] == '-') { ?>
					<option value="+">+</option>
					<option value="-" selected="selected">-</option>
				<?php } else { ?>
					<option value="+" selected="selected">+</option>
					<option value="-">-</option>
				<?php } ?>
			</select>
			<input type="text"<?php if (!$isset) { ?> disabled<?php } ?> name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row?>][weight]" value="<?php if ($isset) {  echo $option_product['product_option_value'][$option_value_id]['weight'];} ?>" placeholder="<?php echo $entry_weight; ?>" class="form-control" data-toggle="weight"/></td>
	</tr>
<?php } ?>
<?php if (isset($footer)) { ?>
		</table>
		</td>
		</tr>
		</tbody>
<?php } ?>