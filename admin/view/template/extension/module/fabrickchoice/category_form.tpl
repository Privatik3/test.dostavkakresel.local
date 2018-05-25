<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-category" data-toggle="tooltip" title="<?php echo $button_save; ?>"
				        class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
				   class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-category"
				      class="form-horizontal">
					<div class="form-group">
						<ul class="nav nav-tabs" id="language">
							<?php foreach ($languages as $language) { ?>
								<li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
									</a></li>
							<?php } ?>
						</ul>
						<div class="tab-content">
							<?php foreach ($languages as $language) { ?>
								<div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
									<div class="form-group required">
										<label class="col-sm-2 control-label"
										       for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name; ?></label>
										<div class="col-sm-10">
											<input type="text"
											       name="category_description[<?php echo $language['language_id']; ?>][name]"
											       value="<?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['name'] : ''; ?>"
											       placeholder="<?php echo $entry_name; ?>"
											       id="input-name<?php echo $language['language_id']; ?>"
											       class="form-control"/>
											<?php if (isset($error_name[$language['language_id']])) { ?>
												<div
													class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
											<?php } ?>
										</div>
									</div>
									<!-- natom -->
									<div class="form-group">
										<label class="col-sm-2 control-label"
										       for="input-desc<?php echo $language['language_id']; ?>">Краткое описание</label>
										<div class="col-sm-10">
											<textarea rows="5" name="category_description[<?php echo $language['language_id']; ?>][description]" placeholder="Краткое описание.." id="input-desc<?php echo $language['language_id']; ?>" class="form-control"/><?php echo isset($category_description[$language['language_id']]) ? $category_description[$language['language_id']]['description'] : ''; ?></textarea>
											<?php if (isset($error_name[$language['language_id']])) { ?>
												<div
													class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
											<?php } ?>
										</div>
									</div>
									<!-- natom -->
								</div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-parent"><?php echo $entry_parent; ?></label>
						<div class="col-sm-10">
							<select name="parent_id" class="form-control">
								<option value="0" selected="selected"><?php echo $text_none; ?></option>
								<?php foreach ($categories as $category) { ?>
									<?php if ($category['category_id'] == $parent_id) { ?>
										<option value="<?php echo $category['category_id']; ?>"
										        selected="selected"><?php echo $category['name']; ?></option>
									<?php } else { ?>
										<option
											value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="select-options"><?php echo $entry_option; ?></label>
						<div class="col-sm-10">
							<select name="select-options" id="select-options" class="form-control">
								<?php if ($options) { ?>
									<?php foreach ($options as $option) { ?>
										<option value="<?php echo $option['option_id']; ?>"><?php echo $option['name']; ?></option>
									<?php } ?>
								<?php } ?>
							</select>
							<div id="option-values" class="well well-sm" style="height: 150px; overflow: auto;"></div>
							<div id="category-option-values" class="well well-sm" style="height: 150px; overflow: auto;">
								<?php if ($options_values) { ?>
									<?php foreach ($options_values as $value) { ?>
										<div id="category-option-value<?php echo $value['option_value_id']?>"><i class="fa fa-minus-circle"></i> <?php echo $value['option_name'] . ' > ' . $value['option_value_name']?><input type="hidden" name="category_option_values[]" value="<?php echo $value['option_value_id']?>"></div>
									<?php } ?>
								<?php } ?>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"
						       for="input-sort-order"><?php echo $entry_sort_order; ?></label>
						<div class="col-sm-10">
							<input type="text" name="sort_order" value="<?php echo $sort_order; ?>"
							       placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order"
							       class="form-control"/>
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
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript"><!--
		$(document).ready(function () {
			$('[name=\'select-options\']').trigger('change');
		});

		$('#language a:first').tab('show');

		$('[name=\'select-options\']').change(function() {
				$.ajax({
					url: 'index.php?route=extension/module/fabrickchoice/category/getoptionvalues&token=<?php echo $token; ?>&option_id=' + $(this).val(),
					dataType: 'json',
					success: function(json) {
							insertValueInForm(json);
						}
				});
			});

		function insertValueInForm(json){
			var html = '';
			if (json['option_value']) {

				$.each(json['option_value'], function (index, element) {
					html += '<div id="option-value' + element['option_value_id'] + '"><i class="fa fa-plus-circle"></i> ' + element['name'] + '<input type="hidden" value="' + element['option_value_id'] + '"></div>';
				});
			}

			$('#option-values').html(html);
		}

		$('#option-values').on('click', '.fa-plus-circle', function () {

			var value_id = $(this).siblings('input').val();
			var value_name = $('#select-options option:selected').text() + ' >' + $(this).closest('div').text();

			var html = '<div id="category-option-value' + value_id + '"><i class="fa fa-minus-circle"></i> ' + value_name + '<input type="hidden" name="category_option_values[]" value="' + value_id + '"></div>';

			$('#category-option-values').append(html);
			$(this).closest('div').remove();
		});

		$('#category-option-values').on('click', '.fa-minus-circle', function () {

			var value_id = $(this).siblings('input').val();
			var option_name = $(this).closest('div').text().split(' >')[0];
			var value_name = $(this).closest('div').text().split(' >')[1];

			if ($('#select-options option:selected').text() == option_name.trim()) {
				var html = '<div id="category-option-value' + value_id + '"><i class="fa fa-plus-circle"></i> ' + value_name + '<input type="hidden" value="' + value_id + '"></div>';
				$('#option-values').append(html);
			}
			$(this).closest('div').remove();
		});

		//--></script>
</div>
<?php echo $footer; ?>
