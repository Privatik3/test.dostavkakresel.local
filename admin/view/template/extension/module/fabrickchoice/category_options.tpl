<div class="tab-pane" id="tab-option">
    
	<div class="row">
		<div class="col-sm-2">
			<ul class="nav nav-pills nav-stacked" id="option">
				<?php $option_row = 0; ?>
				<?php foreach ($product_options as $product_option) { ?>
					<li><a href="#tab-option<?php echo $option_row; ?>" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$('a[href=\'#tab-option<?php echo $option_row; ?>\']').parent().remove(); $('#tab-option<?php echo $option_row; ?>').remove(); $('#option a:first').tab('show');"></i> <?php echo $product_option['name']; ?></a></li>
					<?php $option_row++; ?>
				<?php } ?>
				<li>
					<input type="text" name="option" value="" placeholder="<?php echo $entry_option; ?>" id="input-option" class="form-control" />
				</li>
			</ul>
		</div>
		<div class="col-sm-10">
			<div class="tab-content">
				<?php $option_value_row = 0; ?>
				<?php $option_row = 0; ?>
				<?php foreach ($product_options as $product_option) { ?>
					<div class="tab-pane" id="tab-option<?php echo $option_row; ?>">
						<input type="hidden" name="product_option[<?php echo $option_row; ?>][product_option_id]" value="<?php echo $product_option['product_option_id']; ?>" />
						<input type="hidden" name="product_option[<?php echo $option_row; ?>][name]" value="<?php echo $product_option['name']; ?>" />
						<input type="hidden" name="product_option[<?php echo $option_row; ?>][option_id]" value="<?php echo $product_option['option_id']; ?>" />
						<input type="hidden" name="product_option[<?php echo $option_row; ?>][type]" value="<?php echo $product_option['type']; ?>" />
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-required<?php echo $option_row; ?>"><?php echo $entry_required; ?></label>
							<div class="col-sm-10">
								<select name="product_option[<?php echo $option_row; ?>][required]" id="input-required<?php echo $option_row; ?>" class="form-control">
									<?php if ($product_option['required']) { ?>
										<option value="1" selected="selected"><?php echo $text_yes; ?></option>
										<option value="0"><?php echo $text_no; ?></option>
									<?php } else { ?>
										<option value="1"><?php echo $text_yes; ?></option>
										<option value="0" selected="selected"><?php echo $text_no; ?></option>
									<?php } ?>
								</select>
							</div>
						</div>
						<?php if ($product_option['type'] == 'text') { ?>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
								<div class="col-sm-10">
									<input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" id="input-value<?php echo $option_row; ?>" class="form-control" />
								</div>
							</div>
						<?php } ?>
						<?php if ($product_option['type'] == 'textarea') { ?>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
								<div class="col-sm-10">
									<textarea name="product_option[<?php echo $option_row; ?>][value]" rows="5" placeholder="<?php echo $entry_option_value; ?>" id="input-value<?php echo $option_row; ?>" class="form-control"><?php echo $product_option['value']; ?></textarea>
								</div>
							</div>
						<?php } ?>
						<?php if ($product_option['type'] == 'file') { ?>
							<div class="form-group" style="display: none;">
								<label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
								<div class="col-sm-10">
									<input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" id="input-value<?php echo $option_row; ?>" class="form-control" />
								</div>
							</div>
						<?php } ?>
						<?php if ($product_option['type'] == 'date') { ?>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
								<div class="col-sm-3">
									<div class="input-group date">
										<input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" data-date-format="YYYY-MM-DD" id="input-value<?php echo $option_row; ?>" class="form-control" />
                            <span class="input-group-btn">
                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                            </span></div>
								</div>
							</div>
						<?php } ?>
						<?php if ($product_option['type'] == 'time') { ?>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
								<div class="col-sm-10">
									<div class="input-group time">
										<input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" data-date-format="HH:mm" id="input-value<?php echo $option_row; ?>" class="form-control" />
                            <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                            </span></div>
								</div>
							</div>
						<?php } ?>
						<?php if ($product_option['type'] == 'datetime') { ?>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>
								<div class="col-sm-10">
									<div class="input-group datetime">
										<input type="text" name="product_option[<?php echo $option_row; ?>][value]" value="<?php echo $product_option['value']; ?>" placeholder="<?php echo $entry_option_value; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-value<?php echo $option_row; ?>" class="form-control" />
                            <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                            </span></div>
								</div>
							</div>
						<?php } ?>
						<?php if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') { ?>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-fcr<?php echo $option_row; ?>"><?php echo $entry_fcr; ?></label>
								<div class="col-sm-10">
									<select name="product_option[<?php echo $option_row; ?>][fcr]" id="input-fcr<?php echo $option_row; ?>" class="form-control">
										<?php if (isset($product_option['fcr']) && $product_option['fcr']) { ?>
											<option value="1" selected="selected"><?php echo $text_yes; ?></option>
											<option value="0"><?php echo $text_no; ?></option>
										<?php } else { ?>
											<option value="1"><?php echo $text_yes; ?></option>
											<option value="0" selected="selected"><?php echo $text_no; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="table-responsive">
								<table id="option-value<?php echo $option_row; ?>" class="level table table-bordered table-hover">
									<thead>
									<tr>
										<td></td>
										<td class="text-left"><?php echo $entry_option_value; ?></td>
										<td class="text-right"><?php echo $entry_quantity; ?></td>
										<td class="text-left"><?php echo $entry_subtract; ?></td>
										<td class="text-right"><?php echo $entry_price; ?></td>
										<td class="text-right"><?php echo $entry_option_points; ?></td>
										<td class="text-right"><?php echo $entry_weight; ?></td>
									</tr>
									</thead>
									<tbody>
									<?php $defaultRow =
									'<tr class="row-default">
										  <td class="text-left"><input type="checkbox" data-toggle="eneble"/></td>
										  <td colspan="2" class="text-right"><input type="text" value="" data-toggle="quantity" placeholder="' . $entry_quantity . ' " class="form-control" /></td>
										  <td class="text-left"><select class="form-control" data-toggle="subtract">
												    <option value="1">' . $text_yes . ' </option>
												    <option value="0">' . $text_no . ' </option>
												  </select></td>
										  <td class="text-right"><select class="form-control" data-toggle="price_prefix">
												    <option value="=">=</option>
                                                    <option value="+">+</option>
												    <option value="-">-</option>
												  </select>
											  <input type="text" value="" placeholder="' . $entry_price . ' " class="form-control" data-toggle="price"/></td>
										  <td class="text-right"><select class="form-control" data-toggle="points_prefix">
												    <option value="+">+</option>
												    <option value="-">-</option>
												  </select>
											  <input type="text" value="" placeholder="' . $entry_points . ' " class="form-control" data-toggle="points"/></td>
										  <td class="text-right"><select class="form-control" data-toggle="weight_prefix">
												    <option value="+">+</option>
												    <option value="-">-</option>
												  </select>
											  <input type="text" value="" placeholder="' . $entry_weight . ' " class="form-control" data-toggle="weight"/></td>';?>
										<?php $defaultRow .= '</tr>';?>
									<?php echo $defaultRow;?>
									<?php echo $product_option['view'];?>
									</tbody>
								</table>
							</div>
						<?php } ?>
					</div>
					<?php $option_row++; ?>
				<?php } ?>
			</div>
		</div>
	</div>


<script type="text/javascript"><!--
	var option_row = <?php echo $option_row; ?>;

	$('input[name=\'option\']').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=extension/module/fabrickchoice/category/optionautocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							category: item['category'],
							label: item['name'],
							value: item['option_id'],
							type: item['type'],
							option_value: item['option_value']
						}
					}));
				}
			});
		},
		'select': function(item) {

			html  = '<div class="tab-pane" id="tab-option' + option_row + '">';
			html += '	<input type="hidden" name="product_option[' + option_row + '][product_option_id]" value="" />';
			html += '	<input type="hidden" name="product_option[' + option_row + '][name]" value="' + item['label'] + '" />';
			html += '	<input type="hidden" name="product_option[' + option_row + '][option_id]" value="' + item['value'] + '" />';
			html += '	<input type="hidden" name="product_option[' + option_row + '][type]" value="' + item['type'] + '" />';

			html += '	<div class="form-group">';
			html += '	  <label class="col-sm-2 control-label" for="input-required' + option_row + '"><?php echo $entry_required; ?></label>';
			html += '	  <div class="col-sm-10"><select name="product_option[' + option_row + '][required]" id="input-required' + option_row + '" class="form-control">';
			html += '	      <option value="1"><?php echo $text_yes; ?></option>';
			html += '	      <option value="0"><?php echo $text_no; ?></option>';
			html += '	  </select></div>';
			html += '	</div>';

			if (item['type'] == 'text') {
				html += '	<div class="form-group">';
				html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
				html += '	  <div class="col-sm-10"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" id="input-value' + option_row + '" class="form-control" /></div>';
				html += '	</div>';
			}

			if (item['type'] == 'textarea') {
				html += '	<div class="form-group">';
				html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
				html += '	  <div class="col-sm-10"><textarea name="product_option[' + option_row + '][value]" rows="5" placeholder="<?php echo $entry_option_value; ?>" id="input-value' + option_row + '" class="form-control"></textarea></div>';
				html += '	</div>';
			}

			if (item['type'] == 'file') {
				html += '	<div class="form-group" style="display: none;">';
				html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
				html += '	  <div class="col-sm-10"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" id="input-value' + option_row + '" class="form-control" /></div>';
				html += '	</div>';
			}

			if (item['type'] == 'date') {
				html += '	<div class="form-group">';
				html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
				html += '	  <div class="col-sm-3"><div class="input-group date"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" data-date-format="YYYY-MM-DD" id="input-value' + option_row + '" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></div>';
				html += '	</div>';
			}

			if (item['type'] == 'time') {
				html += '	<div class="form-group">';
				html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
				html += '	  <div class="col-sm-10"><div class="input-group time"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" data-date-format="HH:mm" id="input-value' + option_row + '" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></div>';
				html += '	</div>';
			}

			if (item['type'] == 'datetime') {
				html += '	<div class="form-group">';
				html += '	  <label class="col-sm-2 control-label" for="input-value' + option_row + '"><?php echo $entry_option_value; ?></label>';
				html += '	  <div class="col-sm-10"><div class="input-group datetime"><input type="text" name="product_option[' + option_row + '][value]" value="" placeholder="<?php echo $entry_option_value; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-value' + option_row + '" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></div>';
				html += '	</div>';
			}

			if (item['type'] == 'select' || item['type'] == 'radio' || item['type'] == 'checkbox' || item['type'] == 'image') {

				html += '<div class="form-group">';
				html += '<label class="col-sm-2 control-label" for="input-fcr' + option_row + '"><?php echo $entry_fcr; ?></label>';
				html += '<div class="col-sm-10">';
				html += '<select name="product_option[' + option_row + '][fcr]" id="input-fcr' + option_row + '" class="form-control">';
				html += '<option value="0"><?php echo $text_no; ?></option>';
				html += '<option value="1"><?php echo $text_yes; ?></option>';
				html += '</select>';
				html += '</div>';
				html += '</div>';
				html += '<div class="table-responsive">';
				html += '  <table id="option-value' + option_row + '" class="level table table-bordered table-hover">';
				html += '  	 <thead>';
				html += '      <tr>';
				html += '        <td></td>';
				html += '        <td class="text-left"><?php echo $entry_option_value; ?></td>';
				html += '        <td class="text-right"><?php echo $entry_quantity; ?></td>';
				html += '        <td class="text-left"><?php echo $entry_subtract; ?></td>';
				html += '        <td class="text-right"><?php echo $entry_price; ?></td>';
				html += '        <td class="text-right"><?php echo $entry_option_points; ?></td>';
				html += '        <td class="text-right"><?php echo $entry_weight; ?></td>';
				html += '      </tr>';
				html += '  	 </thead>';
				html += '  	 <tbody>';
				html += addRowDefault();
				$.each(item['option_value'], function (index, element) {
					html += addOptionValue(option_row, element);
				});
				html += '    </tbody>';
				html += '    <tfoot>';
				html += '    </tfoot>';
				html += '  </table>';
				html += '</div>';

				html += '  <select id="option-values' + option_row + '" style="display: none;">';

				for (i = 0; i < item['option_value'].length; i++) {
					html += '  <option value="' + item['option_value'][i]['option_value_id'] + '">' + item['option_value'][i]['name'] + '</option>';
				}

				html += '  </select>';
				html += '</div>';

			}

			$('#tab-option .tab-content').append(html);
			var tabs = '<li><a href="#tab-option' + option_row + '" data-toggle="tab"><i class="fa fa-minus-circle" onclick=" $(\'#option a:first\').tab(\'show\');$(\'a[href=\'#tab-option' + option_row + '\']\').parent().remove(); $(\'#tab-option' + option_row + '\').remove();"></i>' + item['label'] + '</li>';
			$('#option > li:last-child').before(tabs);

			$('#option a[href=\'#tab-option' + option_row + '\']').tab('show');

			$('[data-toggle=\'tooltip\']').tooltip({
				container: 'body',
				html: true
			});

			$('.date').datetimepicker({
				pickTime: false
			});

			$('.time').datetimepicker({
				pickDate: false
			});

			$('.datetime').datetimepicker({
				pickDate: true,
				pickTime: true
			});

			option_row++;
		}
	});
	//--></script>
<script type="text/javascript"><!--

	function addRowDefault() {
		var html = '';

		html += '<tr class="row-default">';
		html += '  <td class="text-left"><input type="checkbox" data-toggle="eneble"/></td>';
		html += '  <td colspan="2" class="text-right"><input type="text" value="" data-toggle="quantity" placeholder="<?php echo $entry_quantity; ?>" class="form-control" /></td>';
		html += '  <td class="text-left"><select class="form-control" data-toggle="subtract">';
		html += '    <option value="1"><?php echo $text_yes; ?></option>';
		html += '    <option value="0"><?php echo $text_no; ?></option>';
		html += '  </select></td>';
		html += '  <td class="text-right"><select class="form-control" data-toggle="price_prefix">';
        html += '    <option value="=">=</option>';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '  </select>';
		html += '  <input type="text" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" data-toggle="price"/></td>';
		html += '  <td class="text-right"><select class="form-control" data-toggle="points_prefix">';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '  </select>';
		html += '  <input type="text" value="" placeholder="<?php echo $entry_points; ?>" class="form-control" data-toggle="points"/></td>';
		html += '  <td class="text-right"><select class="form-control" data-toggle="weight_prefix">';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '  </select>';
		html += '  <input type="text" value="" placeholder="<?php echo $entry_weight; ?>" class="form-control" data-toggle="weight"/></td>';
		html += '</tr>';

		return html;
	}
	var option_value_row = <?php echo $option_value_row; ?>;

	function addRow(option_row, option) {
		html ='';
		html += '<tr id="option-value-row' + option_value_row + '" class="level">';
		html += '  <td class="text-left"><input type="checkbox" class="enable-value" data-toggle="eneble"/></td>';
		html += '  <td class="text-left"><input disabled hidden name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][option_value_id]" value="' + option['option_value_id'] + '"/>';
		html += option['name'];
		html += '  <input disabled type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][product_option_value_id]" value="" /></td>';
		html += '  <td class="text-right"><input disabled type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][quantity]" value="" placeholder="<?php echo $entry_quantity; ?>" class="form-control" data-toggle="quantity"/></td>';
		html += '  <td class="text-left"><select disabled name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][subtract]" class="form-control" data-toggle="subtract">';
		html += '    <option value="1"><?php echo $text_yes; ?></option>';
		html += '    <option value="0"><?php echo $text_no; ?></option>';
		html += '  </select></td>';
		html += '  <td class="text-right"><select disabled name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price_prefix]" class="form-control" data-toggle="price_prefix">';
        html += '    <option value="=">=</option>';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '  </select>';
		html += '  <input type="text" disabled name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price]" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" data-toggle="price"/></td>';
		html += '  <td class="text-right"><select disabled name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points_prefix]" class="form-control" data-toggle="points_prefix">';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '  </select>';
		html += '  <input type="text" disabled name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][points]" value="" placeholder="<?php echo $entry_points; ?>" class="form-control" data-toggle="points"/></td>';
		html += '  <td class="text-right"><select disabled name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][weight_prefix]" class="form-control" data-toggle="weight_prefix">';
		html += '    <option value="+">+</option>';
		html += '    <option value="-">-</option>';
		html += '  </select>';
		html += '  <input type="text" disabled name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][weight]" value="" placeholder="<?php echo $entry_weight; ?>" class="form-control" data-toggle="weight"/></td>';
		html += '</tr>';

		option_value_row++;

		return html;
	};
	function addOptionValue(option_row, option) {

		var child = null;
		var value = null;
		var values = null;
		var category = null;
		(typeof option['child'] == 'undefined') ? child = false : child = true;
		(typeof option['option_value_id'] == 'undefined') ? value = false : value = true;
		(typeof option['option_value'] == 'undefined') ? values = false : values = true;
		(typeof option['category_id'] == 'undefined') ? category = false : category = true;
		html = '';

		if (category) {

			html += '<thead><tr class="collapsed head" aria-expanded="false" data-toggle="collapse" data-target="#category' + option_row + option['category_id'] + '"><th colspan="9"><span></span>' + option['name'] + '</th></tr></thead>';
			html += '<tbody id="category' + option_row + option['category_id'] + '" class="level collapse out">';
			html += addRowDefault();
			html += '<tr>';
			html += '<td colspan="9">';
			html += '<table class="table table-bordered table-hover">';

			if (child) {
				$.each(option['child'], function (index, element) {
					html += addOptionValue(option_row, element);
				});
			}

			if (values) {
				$.each(option['option_value'], function (index, element) {
					html += addOptionValue(option_row, element);
				});
			}

			html += '</table>';
			html += '</td>';
			html += '</tr>';
			html += '</tbody>';


		}
		else if (values) {
			$.each(option['option_value'], function (index, element) {
				html += addOptionValue(option_row, element);
			});
		}

		if (value) {
			addRow(option_row, option);
		}

		return html;
	}

	$(document).on('change', '.enable-value', function () {
		if ($(this).prop('checked') == true) {
			$(this).closest('.level').find('input, select').removeAttr('disabled');
		} else {
			$(this).closest('.level').find('input, select').not($(this)).attr('disabled', true);
		};
	});

	$(document).on('change', '.row-default input, .row-default select', function () {
		var toggle = $(this).attr('data-toggle');

		if (toggle == 'sku') return changeSku($(this));

		if ($(this).attr('type') == 'checkbox') {
			$(this).closest('.level').find('[data-toggle='+ toggle +']').not($(this)).prop('checked', $(this).prop('checked'));
			$(this).closest('.level').find('[data-toggle='+ toggle +']').not($(this)).change();
		} else {
			$(this).closest('.level').find('[data-toggle='+ toggle +']').not($(this)).val($(this).val());
		}
	});

	function changeSku(input) {
		var base_value = input.val();
		var enable_row = input.closest('.level').find('.enable-value:checked');

		if (enable_row.length) {
			enable_row.closest('tr').find('[data-toggle="sku"]').each(function (index, input) {
				$(input).val(base_value + '-' + parseInt(index+1));
			});
		}
	};

	$(document).on('keyup','.row-default input', function () {
		$(this).change();
	});
	//--></script>

	<style>
		tr.head[aria-expanded=false] span:before{
			content: "\f067";
			font-family: FontAwesome;
			padding-right: 10px;
		}
		tr.head[aria-expanded=true] span:before{
			content: "\f068";
			font-family: FontAwesome;
			padding-right: 10px;
		}

		.table-responsive .text-right .form-control:not([data-toggle=quantity]) {
			width: 49%;
			display: inline-block;
		}

	</style >