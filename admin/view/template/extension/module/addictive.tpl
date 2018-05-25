<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-featured" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-featured" class="form-horizontal">
		<div class="col-lg-3 col-md-3 col-sm-12 pull-left">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
            </div>
          </div>          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-product"><?php echo $entry_category; ?></label>
            <div class="col-sm-10">
              <input type="text" name="category" value="" placeholder="<?php echo $entry_category; ?>" id="input-category" class="form-control" />
              <div id="addictive-category" class="well well-sm" style="height: 150px; overflow: auto;">
                 <div id="addictive-category0"> <span class='category-span'><?php echo $default_category; ?></span>
                  <input type="hidden" name="category[]" value="0" />
                </div>
				<?php foreach ($categories as $category) { ?>
                <div id="addictive-category<?php echo $category['category_id']; ?>"><i class="fa fa-minus-circle"></i> <span class='category-span'><?php echo $category['name']; ?></span>
                  <input type="hidden" name="category[]" value="<?php echo $category['category_id']; ?>" />
                </div>
                <?php } ?>
				
              </div>
            </div>
          </div>
          <? 
		    $counter = 0;		  
		  ?>
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
        </div>
       
	   <div class='col-lg-9 col-md-9 col-sm-9 pull-right' id='content-data'>
	    <table class='table table-striped content-table' id='service-table0'>
		 <tr><td><span class="text-center">#</span></td><td class="text-center"><? print $entry_service; ?></td><td class="text-center"><s><? print $entry_price; ?></s></td><td class="text-center"><? print $entry_new_price; ?></td>
		 <td class="text-center"><? print $entry_description; ?></td>
		 <td class='text-center'>Порядок</td></tr>
		 <? $c = 0;
		  if (!$services){
			  ?>
			  <tr id='no-data0'><td colspan=6 class="text-center" ><? print $no_data; ?></td></tr>
			  <?  }else{  
			   foreach($services as $service){
			     foreach($service as $item){
				if ($item['category_id'] != 0) continue; else 
			    $c++;
			  ?>
			   <tr>
			       <td class="text-center"><input type="checkbox" class="check-item"></td>
			       <td><input type="text" name='service-name-0[]' class="form-control" value="<? print $item['name']; ?>"></td>
				   <td><input type="text" name='service-price-0[]' class="form-control" value="<? print $item['price']; ?>"></td>
				   <td><input type="text" name='service-newprice-0[]' class="form-control" value="<? print $item['new_price']; ?>"></td>
				   <td><textarea style='min-width: 300px;min-height: 120px' class="form-control" name='service-description-0[]'><? print $item['desc']; ?></textarea></td>
				   <td><input type="text" name='service-order-0[]' class="form-control" value="<? print $item['order']; ?>"></td>
			   </tr>
			  <? } } 
			  if ($c == 0){  ?>
				  <tr id='no-data0'><td colspan='6' class="text-center" ><? print $no_data; ?></td></tr>
			  <?  }	  }?>
         <tr id="service-button-place0"><td colspan='6' class='text-right'>
		  <button onclick="addRow(0); return false;" class='btn btn-primary' data-original-title="Добавить услугу"><i class='fa fa-plus'></i></button>
		  <button onclick="deleteRow(0); return false;" class='btn btn-danger' data-original-title="Удалить услугу"><i class='fa fa-minus'></i></button>
		 </td></tr>
		</table>
		<? foreach($categories as $category){ $counter++;?>
		<table class='table table-striped hidden content-table' id='service-table<? print $category['category_id']; ?>'>
		 <tr><td><span class="text-center">#</span></td><td><? print $entry_service; ?></td><td><? print $entry_price; ?></td><td><? print $entry_new_price; ?></td><td><? print $entry_description; ?></td><td>Порядок</td></tr>
		 <? 
		  if (!$services){
			  ?>
			  <tr id='no-data<? print $category['category_id']; ?>'><td colspan=5 class="text-center" ><? print $no_data; ?></td></tr>
			  <?  }else{  
			   foreach($services as $service){
			     foreach($service as $item){
				if ($item['category_id'] != $category['category_id']) continue; else 
			  ?>
			   <tr><td class="text-center"><input type="checkbox" class="check-item"></td>
			       <td><input type="text" name='service-name-<? print $category['category_id']?>[]' class="form-control" value="<? print $item['name']; ?>"></td>
				   <td><input type="text" name='service-price-<? print $category['category_id']?>[]' class="form-control" value="<? print $item['price']; ?>"></td>
				   <td><input type="text" name='service-newprice-<? print $category['category_id']?>[]' class="form-control" value="<? print $item['new_price']; ?>"></td>
				   <td><textarea class="form-control" name='service-description-<? print $category['category_id']?>[]'><? print $item['desc']; ?></textarea></td>
				   <td><input type="text" name='service-order-<? print $category['category_id']?>[]' class="form-control" value="<? print $item['order']; ?>"></td>
			   </tr>
			  <? } } }?>
         <tr id="service-button-place<? print $category['category_id']; ?>"><td colspan='6' class='text-right'>
		  <button onclick="addRow(<? print $category['category_id']; ?>); return false;" class='btn btn-primary' data-original-title="Добавить услугу"><i class='fa fa-plus'></i></button>
		  <button onclick="deleteRow(<? print $category['category_id']; ?>); return false;" class='btn btn-danger' data-original-title="Удалить услугу"><i class='fa fa-minus'></i></button>
		 </td></tr>
		</table>
		<? } ?>		
	   </div>
	   </form>
    </div>
  </div>
  <script type="text/javascript"><!--
  function addRow(vt){
	  $('#no-data'+vt).remove();
	  $('#service-button-place'+vt).before('<tr><td class="text-center"><input type="checkbox" class="check-item"></td><td><input type="text" class="form-control" name="service-name-'+vt+'[]"></td><td><input type="text" class="form-control" name="service-price-'+vt+'[]"></td><td><input type="text" class="form-control" name="service-newprice-'+vt+'[]"></td><td><textarea style="min-width: 300px;min-height: 120px" class="form-control" name="service-description-'+vt+'[]"></textarea></td>'+
	  '<td><input type="text" name="service-order-'+vt+'[]" class="form-control"></td></tr>');
   
  }
  function deleteRow(vt){
	 //var vt = $(this).attr('vt');
	 $('#service-table'+vt+' .check-item:checked').parent().parent().remove(); 	  
  }
  
  $('#addictive-category div span').bind('click', function(){
	  var item = $(this).parent().attr('id').replace('addictive-category', '');
	  $('.content-table').addClass('hidden');
	  $('#service-table'+item).removeClass('hidden');
  });
  
  $('input[name=\'category\']').autocomplete({
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=extension/module/addictive/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['category_id']
					}
				}));
			}
		});
	},
	select: function(item) {
		$('input[name=\'category\']').val('');
		$('#addictive-category' + item['value']).remove();
		$('#addictive-category').append('<div id="addictive-category' + item['value'] + '"><i class="fa fa-minus-circle"></i><span class="category-span"> ' + item['label'] + '</span><input type="hidden" name="category[]" value="' + item['value'] + '" /></div>');	
		$('#addictive-category' + item['value']).bind('click', function(){
	       $('.content-table').addClass('hidden');
	       $('#service-table'+item['value']).removeClass('hidden');  });
		var content = "<table class='table table-striped hidden content-table' id='service-table"+item['value']+"'>"+
		 "<tr><td><span class='text-center'>#</span></td><td><? print $entry_service; ?></td><td><? print $entry_price; ?></td><td><? print $entry_new_price; ?></td><td><? print $entry_description; ?></td><td>Порядок</td></tr>"+
		 "<tr id='no-data"+item['value']+"'><td colspan=6 class='text-center' ><? print $no_data; ?></td></tr>"+
         "<tr id='service-button-place"+item['value']+"'><td colspan='6' class='text-right'>"+
		  "<button onclick='addRow("+item['value']+"); return false;' class='btn btn-primary' data-original-title='Добавить услугу'><i class='fa fa-plus'></i></button>"+
		  "<button onclick='deleteRow("+item['value']+"); return false;' class='btn btn-danger' data-original-title='Удалить услугу'><i class='fa fa-minus'></i></button>"+
		 "</td></tr>"+
		"</table>";
		$('#content-data').append(content);
	}
});
	
$('#addictive-category').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});

//--></script></div>
<?php echo $footer; ?>