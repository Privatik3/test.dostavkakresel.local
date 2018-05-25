<div class="tab-pane" id="tab-apt">
<div class="tab-content">
  <ul class="nav nav-tabs" id="languages_apt">
    <?php foreach ($languages as $language) { ?>
    <li><a href="#language_apt<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
    <?php } ?>
  </ul>
  <?php foreach ($languages as $language) { ?>
  <div class="tab-pane" id="language_apt<?php echo $language['language_id']; ?>">
  	<div>
	  	<div class="row" style="font-size: 14px;font-weight: bold;margin-bottom: 17px;border-bottom: 2px solid #ccc;padding-bottom: 10px;">
	  		<div class="col-sm-2"><?php echo $entry_title; ?></div>
	  		<div class="col-sm-8"><?php echo $entry_text; ?></div>
	  		<div class="col-sm-1"><?php echo $sort_order; ?></div>
	  		<div class="col-sm-1"><?php echo $entry_remove; ?></div>
	  	</div>
  	</div>
    <div id="apts<?php echo $language['code']?>" class="apt-list">
      <?php $apt_row = 0; ?>
      <?php if(isset($product_apt_names[$language['code']])){ 
      	for ( $p=0; $p < count($product_apt_names[$language['code']]); $p++ ) { ?>
	      	<div id="apt_row<?php echo $language['code']?><?php echo $apt_row; ?>" class="row" style="margin-bottom: 20px">
	          <div class="col-sm-2">
	          	<input type="text" name="product_apt_name[<?php echo $language['code']?>][]" value="<?php echo $product_apt_names[$language['code']][$p]; ?>" id="apt_name<?php echo $apt_row; ?>" class="form-control" />
	          </div>
	          <div class="col-sm-8">
	          	<textarea name="product_apt_desc[<?php echo $language['code']?>][]" id="apt_desc_<?php echo $language['language_id']; ?>_<?php echo $apt_row; ?>" cols="45" rows="5" class="form-control summernote"><?php echo $product_apt_descs[$language['code']][$p];?></textarea>
	          </div>
	          <div class="col-sm-1">
	            <input name="tab_sort_order[<?php echo $language['code']?>][]" type="text" id="sort_order<?php echo $apt_row; ?>" value="<?php echo $tab_sort_order[$language['code']][$p]; ?>" size="5" class="form-control" />
	          </div>
	          <div class="col-sm-1">
	          	<a onclick="$('#apt_row<?php echo $language['code']?><?php echo $apt_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-minus-circle fa-fw"></i></a>
	          </div>
	      	</div>
	      	
	      
      		<?php $apt_row++; ?>
      	<?php }
      } ?>
      <div id="put-here"></div>
      <a onclick="addApt<?php echo str_replace(array('-','_'),'',$language['code'])?>();" class="btn btn-success"><i class="fa fa-plus fa-fw"></i> <span><?php echo $button_add_apt; ?></span></a>
	</div>
  </div>
  <?php } ?>
</div>
</div>
<script type="text/javascript"><!--
var apt_row = <?php echo $apt_row; ?>;
<?php foreach ($languages as $language) { ?>
function addApt<?php echo str_replace(array("-","_"),"",$language['code'])?>() {
    html  = '<div id="apt_row<?php echo $language['code']?>' + apt_row + '" class="row" style="margin-bottom: 20px">';
	html += '<div class="col-sm-2"><input type="text" name="product_apt_name[<?php echo $language['code']?>][]" value="" id="apt_name' + apt_row + '" class="form-control" /></div>';
	html += '<div class="col-sm-8"><textarea name="product_apt_desc[<?php echo $language['code']?>][]"  id="apt_desc_<?php echo $language['language_id']; ?>' + apt_row + '" cols="45" rows="5" class="form-control summernote" ></textarea></div>';
	html += '<div class="col-sm-1"><input type="text" name="tab_sort_order[<?php echo $language['code']?>][]" value="" id="sort_order' + apt_row + '" size="5" class="form-control"/></div>';
	html += '<div class="col-sm-1"><a onclick="$(\'#apt_row<?php echo $language['code']?>' + apt_row  + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle fa-fw"></i></a></div>';
	html += '</div>';
	
	$('#apts<?php echo $language['code']?> #put-here').before(html);
	$('.summernote').each(function() {
		var element = this;
		
		$(element).summernote({
			disableDragAndDrop: true,
			height: 300,
			emptyPara: '',
			lang: 'ru-RU',
			toolbar: [
				['style', ['style']],
				['font', ['bold', 'underline', 'clear']],
				['fontname', ['fontname']],
				['color', ['color']],
				['para', ['ul', 'ol', 'paragraph']],
				['table', ['table']],
				['insert', ['link', 'image', 'video']],
				['view', ['fullscreen', 'codeview', 'help']]
			],
			buttons: {
    			image: function() {
					var ui = $.summernote.ui;

					// create button
					var button = ui.button({
						contents: '<i class="note-icon-picture" />',
						tooltip: $.summernote.lang[$.summernote.options.lang].image.image,
						click: function () {
							$('#modal-image').remove();
						
							$.ajax({
								url: 'index.php?route=common/filemanager&token=' + getURLVar('token'),
								dataType: 'html',
								beforeSend: function() {
									$('#button-image i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
									$('#button-image').prop('disabled', true);
								},
								complete: function() {
									$('#button-image i').replaceWith('<i class="fa fa-upload"></i>');
									$('#button-image').prop('disabled', false);
								},
								success: function(html) {
									$('body').append('<div id="modal-image" class="modal">' + html + '</div>');
									
									$('#modal-image').modal('show');
									
									$('#modal-image').delegate('a.thumbnail', 'click', function(e) {
										e.preventDefault();
										
										$(element).summernote('insertImage', $(this).attr('href'));
																	
										$('#modal-image').modal('hide');
									});
								}
							});						
						}
					});
				
					return button.render();
				}
  			}
		});
	});
	
	apt_row++;
}
<?php }?>
$('#languages_apt a:first').tab('show');
//--></script>
