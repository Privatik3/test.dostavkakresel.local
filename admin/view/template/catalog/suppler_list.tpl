<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="<?php echo $insert; ?>" data-toggle="tooltip" title="<?php echo $button_insert; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
        
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">      
      <div class="panel-body">        
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"> </td>                 
                  <td class="text-left" style="color: #1E91CF;"><?php echo $column_name; ?></a></td>
                  <td class="text-right" style="color: #1E91CF;"><?php echo $column_scode; ?></a></td>
                  <td class="text-right" style="color: #1E91CF;"><?php echo $column_load; ?></td>                    
                  <td class="text-right" style="color: #1E91CF;"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($supplers) { ?>
            <?php foreach ($supplers as $suppler) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($suppler['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $suppler['form_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $suppler['form_id']; ?>" />
                <?php } ?></td>
              <td class="text-left"><?php echo $suppler['name']; ?></td>
              <td class="text-right"><?php $c=$suppler['suppler_id']; if ($c<10) {$c=' 0'.$c;} echo $c; ?></td>	
			  
			  <td class="text-right"><?php foreach ($suppler['action'] as $action) { ?>
				<a href="<?php echo $action['load']; ?>" data-toggle="tooltip" title="Load"><?php echo $suppler['form_id'] . '.xml/csv'; ?></a></td>				
                <?php } ?></td>                
              
				<td class="text-right"><?php foreach ($suppler['action'] as $action) { ?>
				<a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>				
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>          
        </div>
      </div>
    </div>
  </div>
</div>  
<?php echo $footer; ?>