<div class='addictive-main'>
<div class='addictive-header'>
<span><?php echo $heading_title; ?></span> 
</div>
<div class='list-group addictive-listgr' style='padding-top:12px;'>
  <?php 
   if ($services){
   foreach ($services as $service) { ?>
   <a class="list-group-item">
   <input type="checkbox" class='cbx-input' name='service' <? if ($service['selected'] == 1) print "checked='checked'"; ?> data-price='<? print $service['content_price']; ?>' onclick="change_service()" id="service<? print $service['id']; ?>" style='vertical-align: inherit;'>
   <label class='cbx' for="cbx-input" ></label>
   <?php echo $service['name']; ?>&nbsp;- <s><?php echo $service['price']; ?></s>&nbsp;&nbsp;<span class="red"><? print $service['new_price']; ?></span>
   <small><? print html_entity_decode($service['desc']); ?></small> 
   </a>
   <? }
   }else{if (isset($error)){?><div class="alert alert-danger"><? print $error;?></div><?  }  }   ?>
   <div class="progress hidden" id='loader'><div class="progress-bar text-center" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">0%</div></div> 
  </div> 
  <link rel='stylesheet' href='catalog/view/theme/default/stylesheet/addictive.css'>
     <style>
   .red{
	font-weight: bold;
    color: red;	
}
   </style>

<script language='javascript'>
 function change_service(id){
	 $('#loader').removeClass('hidden');
	 $(".progress-bar").css("width", "10%").html('10%');
	 var services = new Array();
	 $('input[name="service"]:checked').each(function(){
		services.push($(this).attr('id')); 
	 });
	
	$.ajax({
		url: 'index.php?route=extension/module/addictive/change',
		type: 'post',
		data: {'services': services},
		dataType: 'json',
		beforeSend: function() {
		 $(".progress-bar").css("width", "20%").html('20%');
		},
		complete: function() {
		$(".progress-bar").css("width", "100%").html('100%');
		 $('#cart').load('index.php?route=common/cart/info');
		},
		success: function(json) {
			$('.alert').remove();
			if (json['error']) {
				$('.breadcrumb').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		  $(".progress-bar").css("width", "75%").html('75%');
		}, 
		error: function(data){
		 console.log(data);
		}
	});
 }
</script>