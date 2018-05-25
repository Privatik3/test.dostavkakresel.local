<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h4 class="modal-title"><?php echo $dae_form_attribute_correct_title;?></h4>

    </div>

    <div class="modal-body">
      <div class="alert alert-danger hidden" ><i class="fa fa-exclamation-circle"></i> <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      
      <div class="alert alert-success hidden"><i class="fa fa-check-circle"></i> <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>

      <div class="alert alert-info hidden"><i class="fa fa-check-circle"></i> <span></span>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
						<form class="form-horizontal">
							<input type="hidden" name="attribute_id"  id="input_attribute_id"  value="<?php echo $attribute_id; ?>" />

							<div class="form-group">
								<label for="select_value_attr"  class="col-sm-4 control-label" ><?php echo $dae_lang_text_select_value;?></label>
								<div class="col-sm-8">
									<select class="form-control" id="select_value_attr" name="select_value_attr">
									<?php foreach ($attribute_distinct_values as $attribute_distinct_value) { ?>
										<?php //if(empty($attribute_distinct_value['text'])) continue; ?>
										<option value="<?php echo $attribute_distinct_value['text']; ?>"><?php echo $attribute_distinct_value['text']; ?></option>
									<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="replace_value_attr"  class="col-sm-4 control-label" ><?php echo $dae_lang_text_replace_value_attr;?></label>
								<div class="col-sm-8">
									<input class="form-control" id="replace_value_attr" name="replace_value_attr" autocomplete="on">						
								</div>
							</div>
						</form>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
      <button type="button" class="btn btn-primary" onclick="daeSendFormCorretionAttributeValue();" ><?php echo $button_replase; ?></button>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var attribute_id = <?php echo $attribute_id; ?>;

function daeSendFormCorretionAttributeValue(){
	$.ajax({
		url: 'index.php?route=catalog/devos_attribute_ext/correctionAttributeValue&token=<?php echo $token; ?>',
		dataType: 'json',
		type: "POST",
		data: {
			attribute_id: attribute_id,
			search_value: $('#select_value_attr').val(),
			replace_value: $('#replace_value_attr').val()
		},
		success: function(json) {
			$('.alert-success span').html(json.message);
			$('#text_success').html(json.count);
			$('#select_value_attr').empty();
			for (var i in json.list_value) {
				$("#select_value_attr").append( $('<option value="'+json.list_value[i]['text']+'">'+json.list_value[i]['text']+'</option>'));
			}
			$('.alert-success').removeClass('hidden');
		}
	});
}
function attributeautocomplete() {

	$('#replace_value_attr').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/devos_attribute_ext/autocompleteValueAttribute&token=<?php echo $token; ?>&text=' +  encodeURIComponent(request),
				dataType: 'json',
				data: {
					attribute_id: attribute_id
				},
				success: function(json) {
					
					response($.map(json, function(item) {
						return {
							label: item.text,
							value: item.text
						}
					}));
				}
			});
		},
		'select': function(item) {
			$('#replace_value_attr').val(item['value']);
			//$('input[name=\'product_attribute[' + attribute_row + '][attribute_id]\']').val(item['value']);
			
		}
	});
}



$(window).ready(function(){
	attributeautocomplete();
});

//--></script>
