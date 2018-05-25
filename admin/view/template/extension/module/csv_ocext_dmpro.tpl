<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
              <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
              <?php foreach ($breadcrumbs as $breadcrumb) { ?>
              <li><a  href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
              <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
    <style>
        
        small {
            color: darkcyan !important;
            font-size: 10px !important;
            font-weight: bolder !important;
        }
        .small_text{
            font-size: 9px;
            color: darkgray;
        }
        .small_text:hover{
            font-size: 9px;
            color: black;
        }
        .table_zebra tbody tr td:nth-child(2n+1){
           background: lemonchiffon;
        }
        .table_zebra tbody tr td:nth-child(2){
           background: none;
        }
        
        .alert-box{
            margin-bottom: 5px;
            margin-top: 5px;
            display: none;
        }
        
        .table-abc-analysis tr td:first-child{
            width: 25%;
        }
        
        .field-file{
            font-size: 15px;
            font-weight: bold;
            color: white;
            padding: 5px;
            text-align: center;
            background: #444;
        }
        
        optgroup{
            border-bottom: 1px solid #ccc;
            color:#bbb;
        }
        optgroup option{
            color:#444;
        }
        
        .error-border{
            border:3px solid red;
            background: bisque;
        }
        
        
        .setTemplateDataBtn{
            border:1px solid #dddddd;
            background: #bbbbbb;
        }
        
        .setTemplateDataBtnNeedSave{
            border:1px solid brown;
            background: red;
        }
        
        .field-view-file-data{
            font-size: 9px; color:#bbb;
        }
        
        .field-view-file-data:hover{
            background: white;
            color: black;
        }
        
        .info-box-modal{
        
            background: #888;
            color: white;
            padding: 10px;
            max-width: 600px;
            width: auto;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
        }       
        
        .arrow{
            width: 0px;
            height: 0px;
            border: 5px solid transparent;
            /*border-top-color:orangered;*/
            margin: 0;
            padding: 0;
            float: left;
        }
        
        .arrow:before{
          content:'';
          width: 0px;
          height: 0px;
          border: 10px solid transparent;
          border-top-color: #888;
          display: inline-block;
          -webkit-transform: translate(20px, -33px);
        }
        .arrow.down{
            transform: rotate(0deg) translate(0px, 25px);
            -webkit-transform: rotate(0deg) translate(0px, 25px);
            -moz-transform: rotate(0deg) translate(0px, 25px);
            -o-transform: rotate(0deg) translate(0px, 25px);
            -ms-transform: rotate(0deg) translate(0px, 25px);
          }
          
          .vert_text {
            -webkit-transform: rotate(-90deg); /* не забываем префиксные свойства */
            -moz-transform: rotate(-90deg);
            -ms-transform: rotate(-90deg);
            -o-transform: rotate(-90deg);
            transform: rotate(-90deg);
          }
          
          #check_row_info{
          
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 0px;
          
          }
          .sh-tab a, .sh-tab a h2{
            background: #ddd !important;
            color: black;
            font-size: 18px;
            margin-bottom: 0px;
          }
          
          .sh-tab-n {
              border-bottom: 3px solid #ddd;
          }
          span[data-toggle="tooltip"]:after{
            font-family: FontAwesome;
            color: #1E91CF;
            content: "\f059";
            margin-left: 4px;
          }
          
          .help-box{
          
              padding: 10px;
              font-size: 12px;
              background: ivory;
          
          }
          
          .box-help-csv{
              border: 1px solid #888;
              background: white;
              padding: 3px;
              margin-top: 5px;
              margin-bottom: 5px;
          }
          
          .additional_forms h5{
          
             
          
          }
        
    </style>
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
          <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if ($success) { ?>
        <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
          <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        
    <div class="panel panel-default">
    
    <div class="panel-body">
        
        <ul  class="nav nav-tabs" >
            <li><a onclick="$('#stepOneSettings_export').empty(); $('#stepTwoSettings_export').empty();" data-toggle="tab"  href="#tab_csv_import" ><?php echo $tab_csv_import; ?></a></li>
            <li><a onclick="$('#stepOneSettings_import').empty(); $('#stepTwoSettings_import').empty();$('select[name=\'odmpro_format_data\']').val('0'); getStepOneSettings('csv',0,'export');" data-toggle="tab"  href="#tab_csv_export" ><?php echo $tab_csv_export; ?></a></li>
            <li><a  data-toggle="tab" href="#tab-setting"  ><?php echo $tab_setting; ?></a></li>
            <li onclick="getWelcomeWindow();"><a  data-toggle="tab" href="#tab-welcome-extecom"  ><?php echo $tab_welcome_extecom; ?></a></li>
        </ul>
        
        <div class="tab-content">
            <div id="tab_csv_import" class="tab-pane" >
                <div class="row">
                    <div class="col-sm-12">				
                        <div class="tab-content">
                            <div class="table-responsive">
                                <ul  class="nav nav-tabs sh-tab-n" >
                                    <li class="active sh-tab"><a onclick="showHide('.stepOneTempl');" style="cursor: pointer"><h2><?php echo $text_step_1_setting ?></h2></a></li>
                                </ul>
                                <form id="tamplate_data_form_import" nctype="multipart/form-data">
                                    <table class="table table-bordered table-hover stepOneTempl">
                                          <tbody>
                                                <tr>
                                                    <td class="text-left" width="25%">
                                                        <?php echo $entry_odmpro_format_data ?>
                                                    </td>
                                                    <td class="text-left">
                                                        <div class="panel-body">
                                                            <div class="form-group">
                                                                <select onchange="getStepOneSettings(this.value,0,'import');" name="odmpro_format_data"  class="form-control">
                                                    <option value="0" ><?php echo $entry_select; ?></option>
                                                                    <?php foreach($odmpro_format_data as $odmpro_format_data_name => $odmpro_format_data_row){ ?>
                                                    <option value="<?php echo $odmpro_format_data_row ?>" ><?php echo $odmpro_format_data_name; ?></option>
                                                                    <?php } ?>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-left" colspan="2" id="stepOneSettings_import">

                                                    </td>
                                                </tr>
                                            </tbody>
                                    </table>
                                    <div  id="stepTwoSettings_import">

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="tab_csv_export" class="tab-pane" >
                    <div class="row">
                        <div class="col-sm-12">				
                            <div class="tab-content">
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                    <?php if($entry_odmpro_format_data_empty){ ?>
                                    <div class="alert alert-success">
                                        <?php echo $entry_odmpro_format_data_empty ?>
                                    </div>
                                    <?php }elseif($text_lic_error){ ?>
                                    
                                    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $text_lic_error; ?>
                                      <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    </div>
                                    
                                    <?php }else{ ?>
                                    
                                    
                                    
                                    <ul  class="nav nav-tabs sh-tab-n" >
                                        <li class="active sh-tab"><a onclick="showHide('#stepOneSettings_export');" style="cursor: pointer"><h2><?php echo $text_step_4_setting ?></h2></a></li></ul>
                                    
                                    <form id="tamplate_data_form_export">
                                    
                                        <div  id="stepOneSettings_export">

                                        </div>
                                        <div  id="stepTwoSettings_export">

                                        </div>
                                        
                                    </form>
                                    
                                    
                                    
                                    
                                    
                                    <?php } ?>
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                
                            </div>
                        </div>
                    </div>
            </div>
            
            <div id="tab-setting" class="tab-pane" >
            
                <div align="right">
                    <a onclick="$('#form-setting').submit();" title="<?php echo $entry_odmpro_tamplate_data_save_tamplate_data; ?>" class="btn btn-info"><i class="fa fa-tasks"></i>  <?php echo $entry_odmpro_tamplate_data_save_tamplate_data; ?></a>
                </div>   
            
                <br>
            
                <h2><?php echo $entry_update_csv_link_new_title ?></h2>
                
                <form action="<?php echo $action_setting; ?>" method="post" enctype="multipart/form-data" id="form-setting">
                    
                    <?php $id = time(); ?>
                    
                    <input name="odmpro_update_csv_link[<?php echo $id ?>][id]" type="hidden" value="<?php echo $id ?>" />
                    
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th><?php echo $column_update_csv_link_template_data ?></th>
                                <th><?php echo $column_update_csv_link_token ?></th>
                                <th><?php echo $column_update_csv_link_status ?></th>
                            </tr>
                        </thead>
                        <tbody>
                              <tr>
                                  <td class="text-left">
                                      <div class="input-group">
                                      <?php if(!$odmpro_update_csv_link_tamplate_data){ ?>
                                          <select name="odmpro_update_csv_link[<?php echo $id ?>][tamplate_data_id]"  class="form-control">
                                              <option value="0" ><?php echo $entry_odmpro_tamplate_data_empty; ?></option>
                                          </select>
                                      <?php }else{ ?>
                                          <select name="odmpro_update_csv_link[<?php echo $id ?>][tamplate_data_id]"  class="form-control">
                                              
                                              <option value="0" ><?php echo $entry_select; ?></option>
                                              
                                                  <?php foreach($odmpro_update_csv_link_tamplate_data as $tamplate_data_key => $tamplate_data){ ?>
                                              
                                                        <option value="<?php echo $tamplate_data_key ?>" ><?php echo $tamplate_data['name']; ?></option>
                                                      
                                                  <?php } ?>
                                                  
                                          </select>
                                      <?php } ?>
                                      </div>
                                  </td>
                                  <td>
                                      <input class="form-control" name="odmpro_update_csv_link[<?php echo $id ?>][token]" value="" />
                                  </td>
                                  <td>
                                        <select name="odmpro_update_csv_link[<?php echo $id ?>][status]"  class="form-control">
                                              
                                            <option value="0" ><?php echo $entry_update_csv_link_status_0; ?></option>
                                            <option value="1" ><?php echo $entry_update_csv_link_status_1; ?></option>
                                            <option value="3" ><?php echo $entry_update_csv_link_status_3; ?></option>
                                                  
                                        </select>
                                  </td>
                              </tr>
                        </tbody>
                    </table>
                
                <h2><?php echo $entry_update_csv_link_title ?></h2>
                
                <?php if($odmpro_update_csv_link){ ?>
                
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th><?php echo $column_update_csv_link_template_data ?></th>
                            <th><?php echo $column_update_csv_link_token ?></th>
                            <th><?php echo $column_update_csv_link_status ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <?php foreach( $odmpro_update_csv_link as $link_data ){ ?>
                        
                            <?php $id = $link_data['id']; ?>
                            
                            <input name="odmpro_update_csv_link[<?php echo $id ?>][id]" type="hidden" value="<?php echo $id ?>" />
                            
                            <tr>
                                <td class="text-left">
                                    <div class="input-group">
                                    <?php if(!$odmpro_update_csv_link_tamplate_data){ ?>
                                        <select name="odmpro_update_csv_link[<?php echo $id ?>][tamplate_data_id]"  class="form-control">
                                            <option value="0" ><?php echo $entry_odmpro_tamplate_data_empty; ?></option>
                                        </select>
                                    <?php }else{ ?>
                                        <select name="odmpro_update_csv_link[<?php echo $id ?>][tamplate_data_id]"  class="form-control">

                                                <?php foreach($odmpro_update_csv_link_tamplate_data as $tamplate_data_key => $tamplate_data){ ?>
                                                
                                                    <?php if($link_data['tamplate_data_id'] && $link_data['tamplate_data_id']==$tamplate_data_key){ ?>

                                                        <option selected="" value="<?php echo $tamplate_data_key ?>" ><?php echo $tamplate_data['name']; ?></option>
                                                      
                                                    <?php }else{ ?>
                                                        
                                                        <option value="<?php echo $tamplate_data_key ?>" ><?php echo $tamplate_data['name']; ?></option>
                                                    
                                                    <?php } ?>

                                                <?php } ?>

                                        </select>
                                    <?php } ?>
                                    </div>
                                </td>
                                <td>
                                    <input class="form-control" name="odmpro_update_csv_link[<?php echo $id ?>][token]" value="<?php echo $link_data['token'] ?>" />
                                </td>
                                <td>
                                      <select name="odmpro_update_csv_link[<?php echo $id ?>][status]"  class="form-control">
                                          
                                          <option value="0" ><?php echo $entry_update_csv_link_status_0; ?></option>
                                          
                                          <?php if($link_data['status'] && $link_data['status']==1){ ?>
                                            
                                                <option selected="" value="1" ><?php echo $entry_update_csv_link_status_1; ?></option>

                                                <option value="3" ><?php echo $entry_update_csv_link_status_3; ?></option>
                                            
                                            <?php }elseif($link_data['status'] && $link_data['status']==3){ ?>
                                            
                                                <option value="1" ><?php echo $entry_update_csv_link_status_1; ?></option>

                                                <option selected=""  value="3" ><?php echo $entry_update_csv_link_status_3; ?></option>
                                            
                                            <?php }else{ ?>
                                            
                                                <option value="1" ><?php echo $entry_update_csv_link_status_1; ?></option>

                                                <option value="3" ><?php echo $entry_update_csv_link_status_3; ?></option>
                                            
                                            <?php } ?>

                                      </select>
                                </td>
                            </tr>
                              <tr>
                                    <td class="text-right"><?php echo $column_update_csv_link_link ?></td>
                                    <td colspan="2">
                                        <input style="width:60%"  class="form-control"  readonly="" onclick="$(this).select()" value="<?php echo HTTP_CATALOG.'index.php?route='.$path_oc_version_feed.'/odmpro_update_csv_link&token='.$link_data['token'] ?>"/>
                                    </td>
                              </tr>
                              <tr>
                                    <td class="text-right"><?php echo $column_update_csv_link_link_export ?></td>
                                    <td colspan="2">
                                        <input style="width:60%"  class="form-control"  readonly="" onclick="$(this).select()" value="<?php echo HTTP_CATALOG.'index.php?route='.$path_oc_version_feed.'/odmpro_update_csv_link&export=1&token='.$link_data['token'] ?>"/>
                                    </td>
                              </tr>
                        <?php } ?>
                    </tbody>
                </table>
                
                <?php } else { ?>
                
                    <div class="alert alert-success"><?php echo $entry_update_csv_link_empty ?></div>
                
                <?php } ?>
                
                </form>
                
            </div>        
            <div id="tab-welcome-extecom" class="tab-pane" >
                
                <h2>Регистрация продукта</h2>
                <div class="alert alert-success">Для регистрации продукта отправьте запрос на почту welcome@ocext.com. Пожалуйста, в запросе укажите 1 домен, и 1 поддомен данного домена (если необходимо), электронную почту покупателя. Если вы используете 2 копии - скидка на вторую копию 30%. Если вы используете 3 и более копий - скидка на 2 и последующие 50%. Укажите количество копий в запросе для получения купона на скидку от количества</div>
                <form method="post" enctype="multipart/form-data" id="reg_anycsvxls_form" >
                    <table class="table table-hover">
                    <tr>
                            
                            <td><?php echo $text_csv_ocext_dmpro_key; ?></td>
                            <td>
                                <input name="csv_ocext_dmpro_key" value="<?php if(isset($csv_ocext_dmpro_key)) { echo $csv_ocext_dmpro_key; } else { echo ''; } ?>" class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $text_csv_ocext_dmpro_email; ?></td>
                            <td>
                                <input name="csv_ocext_dmpro_email" value="<?php if(isset($csv_ocext_dmpro_email)) { echo $csv_ocext_dmpro_email; } else { echo ''; } ?>" class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div align="left">
                                    <a onclick="$('#reg_anycsvxls_form').submit();" class="btn btn-primary"><i class="fa fa-save"></i>  Сохранить</a>
                                    <br><br>
                                </div>
                            </td>
                        </tr>
                        
                </table>
                </form>
                <hr>
                <div id="tab-welcome-extecom-window"></div>
                <hr>
                
                <?php if ((!$error_warning) && (!$success)) { ?>
                
                    <div id="ocext_notification" class="alert alert-info"><i class="fa fa-info-circle"></i>
                        
                            <div id="ocext_loading"><img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /></div>
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            
                    </div>
                <?php } ?>
                
            </div>
        </div>
        
    </div>        
    </div>
</div>
</div>
<script type="text/javascript"><!--

function update_link(id,left,center,right){
    $(id).val(left+center+right);
}
    
function showHide(selector){
    if($(selector).css('display')=='none'){
        $(selector).show(250);
    }else{
        $(selector).hide(250);
    }
}

var getTypesDataColumnsAdditional_start = true;

function delay(f, ms) {

  return function() {
    var savedThis = this;
    var savedArgs = arguments;

    setTimeout(function() {
      f.apply(savedThis, savedArgs);
    }, ms);
  };

}

var getTypesDataColumnsAdditional_delay = delay(getTypesDataColumnsAdditional, 700);

function getTypesDataColumnsAdditional(db_table___db_column,field,id_td,type_process){
    $(id_td).html('<div id="ocext_loading_'+id_td+'"><img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /></div>').show();
    if(getTypesDataColumnsAdditional_start===false){
		
        getTypesDataColumnsAdditional_delay(db_table___db_column,field,id_td,type_process);
        return;
		
    }
    getTypesDataColumnsAdditional_start = false;
    
    $.ajax({
            type: 'post',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/getTypesDataColumnAdditional&type_process='+type_process+'&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>&field='+field+'&db_table___db_column='+db_table___db_column,
            data: $('#tamplate_data_form_'+type_process+' input:text, #tamplate_data_form_'+type_process+' input:hidden, #tamplate_data_form_'+type_process+' input:checkbox:checked, #tamplate_data_form_'+type_process+' select'),
            dataType: 'html',
            success: function(response) {
                if(response!=''){
                    $(id_td).show(100);
                    $(id_td).html(response);
                }else{
                    $(id_td).hide();
                }
                getTypesDataColumnsAdditional_start = true;
            },
            failure: function(response){
               getTypesDataColumnsAdditional_start = true;     
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                getTypesDataColumnsAdditional_start = true;
            }
    });
}


var start = 0;
var first_start = 0;
var finished = 0;
var limit = 0;
var total = 0;
var num_process = <?php echo time(); ?>;

function startExport(new_start,first_row){
    
    var errors = false;
    
    if(errors===true){
        return;
    }
    
    if(limit==0 && start==0){
        start = parseInt($('input[name=\'odmpro_tamplate_data[start]\']').val()) - 1;
        first_start = parseInt($('input[name=\'odmpro_tamplate_data[start]\']').val()) - 1;
        if(start<0){
            start = 0;
        }
        if(first_start<0){
            first_start = 0;
        }
        
        limit = parseInt($('input[name=\'odmpro_tamplate_data[limit]\']').val());
        $('input[name=\'odmpro_tamplate_data[limit]\']').prop('readOnly',true);
        $('input[name=\'odmpro_tamplate_data[start]\']').prop('readOnly',true);
        $('#startExport').hide();
        $('#importStartMessages').html('<div class="alert alert-info"><i class="fa fa-info-circle"></i>&nbsp;&nbsp;<img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /><button type="button" class="close" data-dismiss="alert">&times;</button>&nbsp;&nbsp;<?php echo $text_import_start ?>: <b><?php echo $text_wite ?></b> / <b><?php echo $text_wite ?></b></div>');
    }else{
        finished = start+limit-first_start;
        new_start = parseInt(new_start);
        start = new_start;
    }
    
    $.ajax({
            type: 'post',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/startExport&num_process='+num_process+'&first_row='+first_row+'&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>&start='+start,
            data: $('#tamplate_data_form_export input:text, #tamplate_data_form_export input:hidden, #tamplate_data_form_export input:checkbox:checked, #tamplate_data_form_export select'),
        <?php if($debug_mode){ ?>
            dataType: 'html',
            success: function(json) {
                $('#exportStartMessages').html('Извините, включен режим отладки. Sorry, debug mode is enabled<br><br>'+json);
                $('#startExport').show();
                $("#startExportLoading").html('');
                start = 0;
                total = 0;
                first_start = 0;
                limit = 0;
                finished = 0;
                num_process = num_process+1;
                return;
        <?php }else{ ?>
            dataType: 'json',
            beforeSend: function(){
                $("#startExportLoading").html('<img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" />');
            },
            success: function(json) {
        <?php } ?>
    
                if(json['error']!=''){
                    $('#exportStartMessages').html('<div class="alert alert-danger">'+json['error']+'</div>');
                    $('#startExport').show();
                    $("#startExportLoading").html('');
                    start = 0;
                    total = 0;
                    first_start = 0;
                    limit = 0;
                    finished = 0;
                    num_process = num_process+1;
                    return;
                }
                
                if(json['success']!=''){
                    $('#exportStartMessages').html('<div class="alert alert-success">'+json['success']+'</div>');
                    $('input[name=\'odmpro_tamplate_data[limit]\']').prop('readonly',false);
                    $('input[name=\'odmpro_tamplate_data[start]\']').prop('readonly',false);
                    $('#startExport').show();
                    $("#startExportLoading").html('');
                    start = 0;
                    total = 0;
                    first_start = 0;
                    limit = 0;
                    finished = 0;
                    num_process = num_process+1;
                    return;
                }
                if(json['total']!=''){
                    total = parseInt(json['total']) - first_start;
                    if(total<0){
                        total = 0;
                    }
                    $('#exportStartMessages').html('<div class="alert alert-info"><i class="fa fa-info-circle"></i>&nbsp;&nbsp;<img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /><button type="button" class="close" data-dismiss="alert">&times;</button>&nbsp;&nbsp;<?php echo $text_import_start ?>: : <b>'+finished+'</b> / <b>'+total+'</b></div>');
                    startExport(start+limit,0);
                }
            },
            failure: function(response){
                <?php if($debug_mode){ ?>
                    
                    alert(response);
            
                <?php } ?>
            },
            error: function(xhr, ajaxOptions, thrownError) {
                
                <?php if($debug_mode){ ?>
                    
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            
                <?php } ?>
            }
    });
    
}

function startImport(new_start){
    
    var errors = false;
    
    if($("select[name='odmpro_tamplate_data[type_change]']").val()==0){
        $("select[name='odmpro_tamplate_data[type_change]']").addClass('error-border');
        errors = true;
    }else{
        $("select[name='odmpro_tamplate_data[type_change]']").removeClass('error-border');
    }
    if(errors===true){
        return;
    }
    
    if(limit==0 && start==0){
        start = parseInt($('input[name=\'odmpro_tamplate_data[start]\']').val()) - 1;
        first_start = parseInt($('input[name=\'odmpro_tamplate_data[start]\']').val()) - 1;
        if(start<0){
            start = 0;
        }
        if(first_start<0){
            first_start = 0;
        }
        
        limit = parseInt($('input[name=\'odmpro_tamplate_data[limit]\']').val());
        $('input[name=\'odmpro_tamplate_data[limit]\']').prop('readOnly',true);
        $('input[name=\'odmpro_tamplate_data[start]\']').prop('readOnly',true);
        $('#startImport').hide();
        $('#importStartMessages').html('<div class="alert alert-info"><i class="fa fa-info-circle"></i>&nbsp;&nbsp;<img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /><button type="button" class="close" data-dismiss="alert">&times;</button>&nbsp;&nbsp;<?php echo $text_import_start ?>: <b><?php echo $text_wite ?></b> / <b><?php echo $text_wite ?></b></div>');
    }else{
        finished = start+limit-first_start;
        new_start = parseInt(new_start);
        start = new_start;
    }
    
    $.ajax({
            type: 'post',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/startImport&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>&num_process='+num_process+'&start='+start,
            data: $('#tamplate_data_form_import input:text, #tamplate_data_form_import input:hidden, #tamplate_data_form_import input:checkbox:checked, #tamplate_data_form_import select'),
        <?php if($debug_mode){ ?>
            dataType: 'html',
            success: function(json) {
                $('#importStartMessages').html('Извините, включен режим отладки. Sorry, debug mode is enabled<br><br>'+json);
                $('#startImport').show();
                $("#startExportLoading").html('');
                start = 0;
                total = 0;
                first_start = 0;
                limit = 0;
                finished = 0;
                num_process = num_process+1;
                return;
        <?php }else{ ?>
            dataType: 'json',
            success: function(json) {
        <?php } ?>
    
                if(json['error']!=''){
                    $('#importStartMessages').html('<div class="alert alert-danger">'+json['error']+'</div>');
                    $('#startImport').show();
                    start = 0;
                    total = 0;
                    first_start = 0;
                    limit = 0;
                    finished = 0;
                    num_process = num_process+1;
                    return;
                }
                
                if(json['success']!=''){
                    $('#importStartMessages').html('<div class="alert alert-success">'+json['success']+'</div>');
                    $('input[name=\'odmpro_tamplate_data[limit]\']').prop('readonly',false);
                    $('input[name=\'odmpro_tamplate_data[start]\']').prop('readonly',false);
                    $('#startImport').show();
                    start = 0;
                    total = 0;
                    first_start = 0;
                    limit = 0;
                    finished = 0;
                    num_process = num_process+1;
                    return;
                }
                if(json['total']!=''){
                    total = parseInt(json['total']) - first_start;
                    if(total<0){
                        total = 0;
                    }
                    $('#importStartMessages').html('<div class="alert alert-info"><i class="fa fa-info-circle"></i>&nbsp;&nbsp;<img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /><button type="button" class="close" data-dismiss="alert">&times;</button>&nbsp;&nbsp;<?php echo $text_import_start ?>: : <b>'+finished+'</b> / <b>'+total+'</b></div>');
                    startImport(start+limit);
                }
            },
            failure: function(response){
                <?php if($debug_mode){ ?>
                    
                    alert(response);
            
                <?php } ?>
            },
            error: function(xhr, ajaxOptions, thrownError) {
                
                <?php if($debug_mode){ ?>
                    
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            
                <?php } ?>
            }
    });
    
}

function openElementOnNameValue(name_open,value_this,value_open,element){
    if(value_open==value_this){
        $(element + "[name='"+name_open+"']").show();
    }else{
        $(element + "[name='"+name_open+"']").hide();
        $(element + "[name='"+name_open+"'] option[value='0']").prop('selected', true);
    }
}

function setTemplateData(type_action,type_process){
    
    $("#setTemplateData").empty();
    
    $("#setTemplateData").before('<div id="ocext_loading_setTemplateData"><img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /></div>').show();
    
    $.ajax({
            type: 'post',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/setTemplateData&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>&type_action='+type_action,
            data: $('#tamplate_data_form_'+type_process+' input:text, #tamplate_data_form_'+type_process+' input:hidden, #tamplate_data_form_'+type_process+' input:checkbox:checked, #tamplate_data_form_'+type_process+' select'),
            <?php if(!$debug_mode){ ?>
            dataType: 'json',
            <?php }else{ ?>
            dataType: 'html',
            <?php } ?>
            success: function(json) {
                
                <?php if($debug_mode){ ?>
                    alert(json);
                <?php } ?>
                
                if(json['success']!=''){
                    $('#setTemplateData').html(json['success']);
                }
                if(json['error']!=''){
                    $('#setTemplateData').html(json['error']);
                }
                if(type_action=='save'){
                    
                    var new_option = '<option value="'+json['odmpro_tamplate_data_id']+'">'+json['odmpro_tamplate_data_name']+'</option>';
                    $("select[name='odmpro_tamplate_data[id]']").append(new_option);
                    $("select[name='odmpro_tamplate_data[id]'] option[value='"+json['odmpro_tamplate_data_id']+"']").prop('selected', true);
                    $("#setTemplateDataTypeAction option[value='update']").prop('selected', true);
                    
                }
                if(type_action=='delete'){
                    $("select[name='odmpro_tamplate_data[id]'] option[value='"+json['odmpro_tamplate_data_id_delete']+"']").remove();
                }
                $('#ocext_loading_setTemplateData').remove();
                $("#setTemplateDataBtn").removeClass('setTemplateDataBtnNeedSave');
            },
            failure: function(response){
                
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
}

function setNewTypesDataColumns(field_last,id_td_last,field_new,type_process,this_name,template_id){
    
    id_td = new Date().getTime();
    $("#type_data_column_"+id_td_last).empty();
    $("#type_data_column_"+id_td_last).attr('id',"type_data_column_"+id_td);
    $("select[name='odmpro_tamplate_data[type_data]["+field_last+"]']").attr('onchange',"getTypesDataColumns(this.value,'#type_data_column_"+id_td+"','"+field_new+"','"+type_process+"')");
    $("select[name='odmpro_tamplate_data[type_data]["+field_last+"]']").attr('name',"odmpro_tamplate_data[type_data]["+field_new+"]");
    $("select[name='odmpro_tamplate_data[type_data]["+field_new+"]']").val('0');
    $("input[name='"+this_name+"']").attr('onchange',"setNewTypesDataColumns('"+field_new+"','"+id_td+"',this.value,'"+type_process+"',this.name);");
    $("input[name='"+this_name+"']").attr('name',"odmpro_tamplate_data[export_field_name]["+template_id+"]["+field_new+"]");
    
}

function getTypesDataColumns(type_data,id_td,field,type_process){
    $(id_td).html('<div id="ocext_loading_'+id_td+'"><img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /></div>').show();
    $.ajax({
            type: 'post',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/getTypesData&type_process='+type_process+'&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>&field='+field+'&type_data='+type_data,
            data: $('#tamplate_data_form_'+type_process+' input:text, #tamplate_data_form_'+type_process+' input:hidden, #tamplate_data_form_'+type_process+' input:checkbox:checked, #tamplate_data_form_'+type_process+' select'),
            dataType: 'html',
            success: function(response) {
                $(id_td).html(response);
            },
            failure: function(response){
                    
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
    getTypesDataGeneralSetting(type_process);
}

function getTypesDataGeneralSetting(type_process){
    
    $.ajax({
            type: 'post',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/getTypesDataGeneralSetting&type_process='+type_process+'&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>',
            data: $('#tamplate_data_form_'+type_process+' input:text, #tamplate_data_form_'+type_process+' input:hidden, #tamplate_data_form_'+type_process+' input:checkbox:checked, #tamplate_data_form_'+type_process+' select'),
            dataType: 'html',
            beforeSend: function(){
                $("#typesDataGeneralSetting").html('<div id="ocext_loading_typesDataGeneralSetting"><img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /></div>').show();
            },
            success: function(response) {
                $("#typesDataGeneralSetting").html(response);
            },
            failure: function(response){
                    
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
}

function updateSaveButton(type_process){

    $('#tamplate_data_form_'+type_process+' input:text, #tamplate_data_form_'+type_process+' input:hidden, #tamplate_data_form_'+type_process+' input:checkbox:checked, #tamplate_data_form_'+type_process+' select').change(function(){
        $("#setTemplateDataBtn").addClass('setTemplateDataBtnNeedSave');
        $("#setTemplateData").hide();
    });

}

function changeTypeData(){
    $('.select-type-data').each(function(){
        if(this.value!=0){
            $(this).change();
        }
    });
    
}

function hideColumn(){

    $('.select-type-data').each(function(){
        
        if($("input[name='odmpro_tamplate_data[hide_column]']").is(":checked")){
        
            if(this.value==0){
                
                $(this).parent('div').parent('td').parent('tr').hide();
                
            }else{
            
                $(this).parent('div').parent('td').parent('tr').show(150);
            
            }
        
        }else{
            
            $(this).parent('div').parent('td').parent('tr').show(150);
        
        }
        
        
    });
        

}

function changeTypeDataColumn(data_column_class){
    if(data_column_class===0){
        $('.select-type-data-column').each(function(){
            if(this.value!=0){
                $(this).change();
            }
        });
    }else{
        $('.'+data_column_class).change();
    }
    hideColumn();
}

function getStepTwoSettings(type_process,status_continuation){
    $("#stepTwoSettings_"+type_process).before('<div id="ocext_loading_stepTwoSettings'+type_process+'"><img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /></div>');
    $.ajax({
            type: 'post',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/getStepTwoSettings&status_continuation='+status_continuation+'&type_process='+type_process+'&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>',
            data: $('#tamplate_data_form_'+type_process+' input:text, #tamplate_data_form_'+type_process+' input:hidden, #tamplate_data_form_'+type_process+' input:checkbox:checked, #tamplate_data_form_'+type_process+' select'),
            dataType: 'html',
            success: function(response) {
                $('#stepTwoSettings_'+type_process).html(response);
                $('#ocext_loading_stepTwoSettings'+type_process).remove();
            },
            failure: function(response){
                    //alert(response);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
}

function getProcessHistoryStatus(odmpro_tamplate_data_id,supplier_name,type_process){
    return;
    processes_history_status_get = setInterval(function() {
    
        $.ajax({
                type: 'post',
                url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/getProcessHistoryStatus&supplier_name='+supplier_name+'&odmpro_tamplate_data_id='+odmpro_tamplate_data_id+'&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>',
                data: $('#tamplate_data_form_'+type_process+' input:text, #tamplate_data_form_'+type_process+' input:hidden, #tamplate_data_form_'+type_process+' input:checkbox:checked, #tamplate_data_form_'+type_process+' select'),
                dataType: 'html',
                success: function(response) {
                    $('#stepTwoSettings_'+type_process).html(response);
                },
                failure: function(response){
                        //alert(response);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
        });
    
    }, 500);
    
}

function getStepOneSettings(format_data,tamplate_data,type_process){
    $("#stepOneSettings_"+type_process).before('<div id="ocext_loading_stepOneSettings'+type_process+'"><img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /></div>');
    $("#stepTwoSettings_"+type_process).empty();
    $.ajax({
            type: 'post',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/getStepOneSettings&type_process='+type_process+'&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>',
            data: 'tamplate_data='+tamplate_data+'&format_data='+format_data,
            dataType: 'html',
            success: function(response) {
                
                $('#stepOneSettings_'+type_process).html(response);
                
                $('#ocext_loading_stepOneSettings'+type_process).remove();
                
            },
            failure: function(response){
                
            },
            error: function(xhr, ajaxOptions, thrownError) {
                
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                
            }
    });
}    
    

function getUniqueParams(){
    $("#unique_param").hide();
    
    $(".unique_param_type_row").hide();
    $('.select-type-data').each(function(){
        if(this.value!=0){
            $("#unique_param_"+this.value).show(150);
            $("#unique_param").show(150);
        }
    
    });

}
    
$(document).ready(function() {
    $("a[href=\'#<?php echo $open_tab ?>\']").click();
    
    <?php if($demo_mode){ ?>
    
        $("select[name='odmpro_format_data']").val('csv');
        $("select[name='odmpro_format_data']").change();
                    
    <?php } ?>
    
});

function getNotifications() {
	$.ajax({
            type: 'GET',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/getNotifications&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>',
            dataType: 'json',
            success: function(json) {
                    if (json['error']) {
                            $('#ocext_notification').html('<i class="fa fa-info-circle"></i><button type="button" class="close" data-dismiss="alert">&times;</button> '+json['error']);
                    } else if (json['message'] && json['message']!='' ) {
                            $('#ocext_notification').html('<i class="fa fa-info-circle"></i><button type="button" class="close" data-dismiss="alert">&times;</button> '+json['message']);
                    }else{
                        $('#ocext_notification').remove();
                    }
            },
            failure: function(){
                    $('#ocext_notification').remove();
            },
            error: function() {
                    $('#ocext_notification').remove();
            }
    });
}
getNotifications();
function getWelcomeWindow() {
	$.ajax({
            type: 'GET',
            url: 'index.php?route=<?php echo $path_oc_version; ?>/csv_ocext_dmpro/getWelcomeWindow&<?php echo $token_name; ?>=<?php echo ${$token_name}; ?>',
            dataType: 'html',
            success: function(html) {
                $('#tab-welcome-extecom-window').html(html);
            },
            failure: function(){
                $('#tab-welcome-extecom-window').html();
            },
            error: function() {
                $('#tab-welcome-extecom-window').html();
            }
    });
}
//--></script> 
<?php echo $footer; ?>