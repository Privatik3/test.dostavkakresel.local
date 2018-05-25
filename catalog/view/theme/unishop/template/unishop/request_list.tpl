<?php if ($requests) { ?>
	<?php foreach($requests as $request) { ?>
		<div class="request_list">
			<div class="name_date">
				<div class="name"><i class="fa fa-user" aria-hidden="true"></i><span><?php echo $request['name']; ?></span></div>
				<div class="date"><?php echo $request['date_added']; ?></div>
			</div>
			<div class="comment">
				<?php echo $request['comment']; ?>
			</div>
			<?php if (isset($request['admin_comment']) && $request['admin_comment'] != '') { ?> 
				<div class="admin_reply">
					<div><i class="fa fa-reply" aria-hidden="true"></i><span><?php echo $lang['text_admin_reply']; ?></span></div>
					<?php echo $request['admin_comment']; ?>
				</div>
			<?php } ?>
		</div>
	<?php } ?>
<?php } else { ?>
	<p><?php echo $lang['text_no_requests']; ?></p>
<?php } ?>
	<div class="request_pagination">
		<div class="text-right"><?php echo $pagination; ?></div>
		<div class="text-right"><button class="btn btn-primary" onclick="$('#form-request').slideToggle();"><?php echo $lang['button_new_request']; ?></button></div>
	</div>
	<form class="form-horizontal" id="form-request">
		<?php if ($request_guest) { ?>
			<div class="rev_form well well-sm">
				<div class="form-group required">
					<div class="col-sm-12">
						<label class="control-label" for="input-name"><?php echo $lang['entry_request_name']; ?></label>
						<input type="text" name="customer_name" value="" id="input-name" class="form-control" />
					</div>
				</div>
				<?php if ($show_phone) { ?>
					<div class="form-group required">
						<div class="col-sm-12">
							<label class="control-label" for="input-name"><?php echo $lang['entry_request_phone']; ?></label>
							<input type="text" name="customer_phone" value="" id="input-name" class="form-control" />
						</div>
					</div>
				<?php } ?>
				<?php if ($show_email) { ?>
					<div class="form-group <?php echo $show_email_required ? 'required' : '';?> ">
						<div class="col-sm-12">
							<label class="control-label" for="input-name"><?php echo $lang['entry_request_mail']; ?><?php echo $show_email_required ? '' : $lang['entry_request_mail_required'];?></label>
							<input type="text" name="customer_mail" value="" id="input-name" class="form-control" />
						</div>
					</div>
				<?php } ?>
				<div class="form-group required">
					<div class="col-sm-12">
						<label class="control-label" for="input-request"><?php echo $lang['entry_request_text']; ?></label>
						<textarea name="customer_comment" rows="5" id="input-request" class="form-control"></textarea>
						<div class="help-block"><?php echo $text_note; ?></div>
					</div>
				</div>
				<?php if ($show_captcha) { ?>
					<?php echo $captcha; ?>
				<?php } ?>
				<div class="text-right clearfix">
					<button type="button" id="button-request" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $lang['button_add_new_request']; ?></button>
				</div>
			</div>
			<input type="hidden" name="type" value="<?php echo $type; ?>" />
			<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
			<input type="hidden" name="question_form" value="1" />
		<?php } else { ?>
			<?php echo $text_login; ?>
		<?php } ?>
	</form>
	<style type="text/css">
		#request .request_list {margin:0 0 20px;border-bottom:solid 0px rgba(0, 0, 0, .12);}
		#request .request_list .name_date{overflow:auto;margin:0 0 10px;padding:5px 16px;background:linear-gradient(to right, #f5f5f5 0%,transparent 100%);border:solid 1px rgba(0, 0, 0, .1);border-radius:3px}
		#request .request_list .name_date .name {float:left;font-weight:700;}
		#request .request_list .name_date .name i {margin:0 10px 0 0;color:#D9534F;}
		#request .request_list .name_date .date {float:right;color:#888}
		#request .request_list .comment {margin:0 0 12px;padding:0 16px;}
		#request .request_list .admin_reply {margin:0 0 0 15px; padding:5px 10px;border-left:solid 2px #D9534F;font-weight:500;background:rgba(0, 0, 0, .025);}
		#request .request_list .admin_reply > div {margin:0 0 3px;padding:0 0 3px;color:#666;font-size:.85em;border-bottom: solid 1px rgba(0, 0, 0, .1);}
		#request .request_list .admin_reply > div i {margin:0 6px 0 0;transform:rotate(180deg);font-size:.85em}
		#request #input-captcha {width:100px;float:left;margin:0 10px 0 0;}
		#request #input-captcha + img{max-height:33px;}
		#request  .request_pagination {margin:0 0 20px; padding:20px 0 0;border-top: solid 1px rgba(0, 0, 0, .12);}
		#form-request {display:none;}
		#request .pagination {float:left;margin: 0 0 10px;}
	</style>
	<script type="text/javascript">
		if(!$('body').find('.tab-request span').length) {
			$('body').find('.tab-request').append(' <span>(<?php echo $requests_total; ?>)</span>');
		}
		
		$('#button-request').on('click', function() {
			$.ajax({
				url: 'index.php?route=unishop/request/mail',
				type: 'post',
				data: $('#form-request input, #form-request textarea').serialize(),
				dataType: 'json',
				beforeSend: function() {
					$('#button-request').button('loading');
				},
				complete: function() {
					$('#button-request').button('reset');
				},
				success: function(json) {
					$('.container > .alert').remove();
					$('#main_content .breadcrumb').after('<div class="alert"></div>');
					
					if (json['success']) {
						$('.container > .alert').append('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
						$('#form-request').slideToggle();
						$('#form-request input, #form-request textarea').val('');
					}

					if (json['error']) {
						for (i in json['error']) {
							$('.container > .alert').append('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'][i] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
						}
					}
				}
			});
		});
	</script>