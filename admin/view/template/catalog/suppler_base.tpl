<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
     <div class="breadcrumb">
       <?php foreach ($breadcrumbs as $breadcrumb) { ?>
       <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
       <?php } ?>
     </div>
     <?php if ($error_warning) { ?>
     <div class="warning"><?php echo $error_warning; ?></div>
     <?php } ?>
     <?php if ($success) { ?>
     <div class="success"><?php echo $success; ?></div>
     <?php } ?>
     <div class="box">
      <div class="heading">
        <h1><img src="view/image/backup.png" alt="" /> <?php echo $heading_base_title; ?></h1>	    
      </div>
	  <div class="text-right">
		<a onclick="$('#form').submit();" data-toggle="tooltip" class="btn btn-primary" type="button"><i>Start / Continue</i></a>
	  </div>
      <div class="content">
        <form action="<?php echo $start; ?>" method="post" enctype="multipart/form-data" id="form">
          <table class="form">
           <tr>
            <td colspan="2"><?php echo $entry_description; ?></td>
           </tr>
           <tr>
            <td width="25%"><?php echo $entry_restore; ?></td>
            <td><input type="file" name="xmlfile" /></td>
		   </tr>
          </table>
       </form>
      </div>
     </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>