<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<h1><?php echo $heading_title; ?></h1><br />
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
					<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
			<div class="alert alert-danger">
				<i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
		<?php if ($success) { ?>
			<div class="alert alert-success">
				<i class="fa fa-check-circle"></i> <?php echo $success; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
			</div>
			<div class="panel-body">
				<div class="well well-sm">
					<div class="row">
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="input-type"><?php echo $entry_type; ?></label>
								<select name="filter_type" id="input-status" class="form-control">
									<option value=""></option>
									<?php foreach($types as $type) { ?>
										<option value="<?php echo $type['type']; ?>" <?php if ($filter_type == $type['type']) { ?>selected="selected"<?php } ?>><?php echo $type['type']; ?></option>
									<?php } ?>
								</select>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
								<input type="text" name="filter_name" value="<?php echo $filter_name; ?>" id="input-name" class="form-control" />
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
								<div class="input-group date">
									<input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" placeholder="<?php echo $entry_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
									<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="input-status"><?php echo $entry_status; ?></label>
								<select name="filter_status" id="input-status" class="form-control">
									<option value=""></option>
									<option value="1" <?php if ($filter_status == 1) { ?>selected="selected"<?php } ?>><?php echo $text_status_1; ?></option>
									<option value="2" <?php if ($filter_status == 2) { ?>selected="selected"<?php } ?>><?php echo $text_status_2; ?></option>
									<option value="3" <?php if ($filter_status == 3) { ?>selected="selected"<?php } ?>><?php echo $text_status_3; ?></option>
								</select>
							</div>
						</div>
						<div class="col-sm-12">
							<button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
						</div>
					</div>
				</div>
				<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-review">
					<div class="table-responsive">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<td class="text-left">
										<?php if ($sort == 'type') { ?>
											<a href="<?php echo $sort_type; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_type; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_type; ?>"><?php echo $column_type; ?></a>
										<?php } ?>
									</td>
									<td class="text-left">
										<?php if ($sort == 'name') { ?>
											<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
										<?php } ?>
									</td>
									<td class="text-left">
										<?php if ($sort == 'phone') { ?>
											<a href="<?php echo $sort_phone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_phone; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_phone; ?>"><?php echo $column_phone; ?></a>
										<?php } ?>
									</td>
									<td class="text-left">
										<?php if ($sort == 'mail') { ?>
											<a href="<?php echo $sort_mail; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_mail; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_mail; ?>"><?php echo $column_mail; ?></a>
										<?php } ?>
									</td>
									<td class="text-left"><?php echo $column_comment; ?></td>
									<td class="text-left"><?php echo $column_admin_comment; ?></td>
									<td class="text-left">
										<?php if ($sort == 'date_added') { ?>
											<a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
										<?php } ?>
									</td>
									<td class="text-left">
										<?php if ($sort == 'date_modified') { ?>
											<a href="<?php echo $sort_date_modified; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_modified; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_date_modified; ?>"><?php echo $column_date_modified; ?></a>
										<?php } ?>
									</td>
									<td class="text-left">
										<?php if ($sort == 'status') { ?>
											<a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
										<?php } ?>
									</td>
									<td class="text-right"><?php echo $column_action; ?></td>
								</tr>
							</thead>
							<tbody>
								<?php if ($requests) { ?>
									<?php foreach ($requests as $request) { ?>
										<tr>
											<td class="text-left"><?php echo $request['type']; ?></td>
											<td class="text-left"><?php echo $request['name']; ?></td>
											<td class="text-left"><?php echo $request['phone']; ?></td>
											<td class="text-left"><?php echo $request['mail']; ?></td>
											<td class="text-left">
												<?php if($request['product_name'] && $request['product_href']) { ?>
													<a href="<?php echo $request['product_href']; ?>" style="text-decoration:underline;"target="_blank"><?php echo $request['product_name']; ?> <i class="fa fa-clone" aria-hidden="true"></i></a><br />
												<?php } ?>
												<?php echo $request['comment']; ?></td>
											<td class="text-left"><?php echo $request['admin_comment']; ?></td>
											<td class="text-left"><?php echo $request['date_added']; ?></td>
											<td class="text-left"><?php echo $request['date_modified']; ?></td>
											<td class="text-left"><?php echo $request['status']; ?></td>
											<td class="text-right" style="min-width:100px;">
												<a href="<?php echo $request['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
												<button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? location='<?php echo $request['delete']; ?>' : false;"><i class="fa fa-trash-o"></i></button>
											</td>
										</tr>
									<?php } ?>
								<?php } else { ?>
									<tr>
										<td class="text-center" colspan="10"><?php echo $text_no_results; ?></td>
									</tr>
								<?php } ?>
							</tbody>
						</table>
					</div>
				</form>
				<div class="row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
					<div class="col-sm-6 text-right"><?php echo $results; ?></div>
				</div>
			</div>
		</div>
	</div>
</div>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
  url = 'index.php?route=tool/unishop_request&token=<?php echo $token; ?>';

  var filter_type = $('select[name=\'filter_type\']').val();

  if (filter_type) {
    url += '&filter_type=' + encodeURIComponent(filter_type);
  }

  var filter_name = $('input[name=\'filter_name\']').val();

  if (filter_name) {
    url += '&filter_name=' + encodeURIComponent(filter_name);
  }

  var filter_status = $('select[name=\'filter_status\']').val();

  if (filter_status != '*') {
    url += '&filter_status=' + encodeURIComponent(filter_status);
  }

  var filter_date_added = $('input[name=\'filter_date_added\']').val();

  if (filter_date_added) {
    url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
  }

  location = url;
});
//--></script>
  <script type="text/javascript"><!--
$('.date').datetimepicker({
  pickTime: false
});
//--></script>
<?php echo $footer; ?>