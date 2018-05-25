<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $dae_lang_heading_title; ?></h1>
      <div class="pull-right">
        <span><?php echo $dae_lang_this_version.$dae_version;?></span>
        <span style="font-weight:bold;" id="last-version-text"></span>
        <a class="btn btn-default box-button" href="<?php echo $dae_url_documentation;?>" target="_blank"><i class="fa fa-file"></i> <?php echo $dae_lang_url_documentation;?></a>
      </div>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="alert alert-danger hidden"><i class="fa fa-exclamation-circle"></i>
      <span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>

    <div class="alert alert-success hidden"><i class="fa fa-check-circle"></i>
      <span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
  
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $dae_lang_text_list; ?></h3>
      </div>
      <div class="panel-body">
          <div class="row">
            <div class="col-sm-4">
              <ul id="dae-attribute-group" class="nav nav-pills nav-stacked">
              <?php foreach($attribute_groups as $attribute_group){?>
                <li class="" data-attribute_group_id="<?php echo $attribute_group['attribute_group_id'];?>" id="dae_attribute_group_<?php echo $attribute_group['attribute_group_id'];?>">
                  <a data-toggle="tab" href="#tab-dae-attribute<?php echo $attribute_group['attribute_group_id'];?>">
                    <?php if(isset($settings['dae_load_sortable']) && $settings['dae_load_sortable']){?>
                    <i class="fa fa-sort" aria-hidden="true" style="cursor: move;"></i>&nbsp;
                    <?php }?>
                    <i class="fa fa-pencil" onclick="daeViewFormAttributeGroup(<?php echo $attribute_group['attribute_group_id'];?>);"></i>&nbsp;
                    <i class="fa fa-minus-circle" onclick="daeDeleteAttributeGroup(<?php echo $attribute_group['attribute_group_id'];?>);"></i> <span id="attribute_group_name<?php echo $attribute_group['attribute_group_id'];?>"><?php echo  $attribute_group['name'];?></span> (<span id="attribute_group_count_value<?php echo $attribute_group['attribute_group_id'];?>"><?php echo (isset($list_attributes[$attribute_group['attribute_group_id']]))?count($list_attributes[$attribute_group['attribute_group_id']]['attributes']):0;?></span>)</a>
                </li>
              <?php }?>  
              <li class="dae-add-attribute-group">
                <button class="btn btn-primary" title="" data-toggle="tooltip" type="button" data-original-title="<?php echo $dae_button_add_attribute_group;?>" onclick="daeViewFormAttributeGroup(0);"><i class="fa fa-plus-circle"></i> <?php echo $dae_button_add_attribute_group;?></button>
              </li>
              </ul>
            </div>

            <div class="col-sm-8"> 
              <div class="row">
                  <div  class="col-sm-6">
                    <button type="button" class="btn btn-primary" onclick="daeViewFormAttribute(0);"><i class="fa fa-plus"></i> <?php echo $dae_form_attribute_title;?></button>
                  </div>
                  <div  class="col-sm-6 text-right">
                    <ul class="nav navbar-nav navbar-right" style="margin-right: 0px;">
                      <li class="dropdown">
                        <button id="drop1" href="#" class="dropdown-toggle btn btn-default" data-toggle="dropdown">
                          <?php echo $dae_menu;?>
                          <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                          <li><a href="<?php echo $url_generate_value;?>"><?php echo $dae_lang_auto_load_m; ?></a></li>
                          <li><a href="<?php echo $url_add_attributes_product;?>"><?php echo $dae_lang_auto_load_prod;?></a></li>
                          <li class="divider"></li>
                          <li><a href="<?php echo $url_a_to_cat;?>"><?php echo $dae_attr_in_cat_header;?></a></li>
                          <li><a href="<?php echo $url_view_a_to_cat;?>"><?php echo $dae_view_attr_in_cat_header;?></a></li>
                          <li class="divider"></li>
                          <li><a href="<?php echo $url_a_merge;?>" ><?php echo $dae_lang_a_merge;?></a></li>
                          <li><a href="<?php echo $url_service;?>" ><?php echo $dae_service_header;?></a></li>
                          <li class="divider"></li>
                          <li><a href="<?php echo $url_setup;?>"><i class="fa fa-cog"></i> <?php echo $dae_lang_setup;?></a></li>
                        </ul>
                      </li>
                    </ul>                    
                  </div>
              </div>
              <div class="tab-content dae-attribute-list-for-group">
                
                <?php foreach($attribute_groups as $attribute_group){?>
                <div id="tab-dae-attribute<?php echo $attribute_group['attribute_group_id'];?>" class="tab-pane fade">
                  <div class="table-responsive">
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <td class="text-left">&nbsp;</td>
                          <td class="text-left"><?php echo $dae_entry_name_attribute;?></td>
                          <td class="text-right"><?php echo $dae_sort_order;?></td>
                          <td class="text-right" style="width:230px;"><?php echo $dae_column_action; ?></td>
                        </tr>
                      </thead>
                      <tbody class="dae_attribute_sorted">
    
                        <?php if (isset($list_attributes[$attribute_group['attribute_group_id']])) { ?>
                          <?php foreach ($list_attributes[$attribute_group['attribute_group_id']]['attributes'] as $attribute) { ?>
                        <tr id="dae_attribute_<?php echo $attribute['attribute_id'];?>" >
                          <td class="text-center" style="cursor: move;">
                            <i class="fa fa-sort" aria-hidden="true" style="cursor: move;"></i>
                          </td>
                          <td class="text-left">
                            <span class="attribute_name"><?php echo $attribute['name']; ?></span>
                            <!-- если в настройках есть вывод ид атрибутов -->
                            <?php if(!empty($settings['dae_view_attr_id'])){ ?>
                              #<?php echo $attribute['attribute_id']; ?>
                            <?php } ?>
                            <br>
                            <!-- если в настройках есть вывод значений атрибутов -->
                            <?php if(!empty($settings['dae_view_val_attr'])){ ?>
                              <span style="color:#aaa;" id="dae_attribute_values_<?php echo $attribute['attribute_id'];?>">
                              <?php 
                                $list_values_tmp=array();
                                if(isset($list_attribute_values[$attribute['attribute_id']])){
                                  foreach($list_attribute_values[$attribute['attribute_id']]['values'] as $attribute_value) {
                                    //если в настройках есть вывод ид значений 
                                    if(!empty($settings['dae_view_attr_v_id'])){
                                      $attribute_value['text'] .= ' #' . $attribute_value['id'];
                                    }

                                    if($attribute_value['default'] == 1)
                                      $list_values_tmp[] = '<u>'.$attribute_value['text'].'</u>';
                                    else 
                                      $list_values_tmp[] = $attribute_value['text'];
                                  } 
                                }
                              ?>
                              <?php echo implode(' • ',$list_values_tmp);?>
                              </span>
                            <?php } ?>
                          </td>
                          <td class="text-right sort_order"><?php echo $attribute['sort_order']; ?></td>
                          <td class="text-right">
                            <a href="index.php?route=catalog/devos_attribute_ext/getTableAttributeValue&attribute_id=<?php echo $attribute['attribute_id'];?>&token=<?php echo $token;?>" type="button" data-toggle="tooltip" title="<?php echo $dae_lang_button_list_attr; ?>" class="btn btn-primary"><i class="fa fa-list"></i></a>
                            <button type="button" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary" onclick="daeViewFormAttribute(<?php echo $attribute['attribute_id'];?>);"><i class="fa fa-pencil"></i></button>
                            <button type="button" data-toggle="tooltip" title="<?php echo $button_replase; ?>" class="btn btn-primary" onclick="daeViewFormCorrection(<?php echo $attribute['attribute_id'];?>);"><i class="fa fa-retweet"></i></button>
                            <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="daeDeleteAttribute(<?php echo $attribute['attribute_id'];?>);" data-attribute_group_id="<?php echo $attribute_group['attribute_group_id'];?>"><i class="fa fa-trash-o"></i></button>
                          </td>
                        </tr>
                          <?php } ?>
                        <?php } else { ?>
                        <tr class="empty_attributes">
                          <td class="text-center" colspan="3"><?php echo $text_no_results; ?></td>
                        </tr>
                        <?php } ?>
                      
                      </tbody>
                    </table>
                  </div>
                </div>
                <?php } ?>      
              </div>
            </div>
          </div>  
        <div class="row">
          <div class="col-sm-6 text-left"><?php //echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php //echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
</div>
<div id="daeModalBox" class="modal fade"></div>
<script>
var token = '<?php echo $token; ?>';
var dae_entry_name_attribute = '<?php echo $dae_entry_name_attribute;?>';
var dae_sort_order = '<?php echo $dae_sort_order;?>';
var dae_column_action = '<?php echo $dae_column_action;?>';
var text_no_results = '<?php echo $text_no_results;?>';

  $(document).ready(function(){

    var dae_version ='<?php echo $dae_version;?>';
    var dae_lang_new_version = '<?php echo $dae_lang_new_version;?>';
    var dae_lang_update_error = '<?php echo $dae_lang_update_error;?>';
    var dae_lang_last_version = '<?php echo $dae_lang_last_version;?>';
    $.ajax({
      url: '<?php echo $dae_url_update;?>',
      method: "POST",
      data: "product=dae&version="+dae_version,
      dataType: 'json',
      success: function(data){
        if(Number(data.last_version) > Number(dae_version)){
          $('#last-version-text').html(dae_lang_new_version + data.last_version);
        }else{
          $('#last-version-text').html(dae_lang_last_version);
          
        }
      },
      error: function(data){
        if(Number(data.last_version) > Number(dae_version)){
          $('#last-version-text').html(dae_lang_update_error);
        }
      }
    });
    //$('#dae-attribute-group>li:first-child').trigger('click');
    $('#dae-attribute-group>li:first-child').addClass('active');
    $('.tab-content>div:first-child').addClass('active in');    
    $( ".dae_attribute_sorted" ).sortable({
      axis: 'y',
      update: function (event, ui) {
        var data = $(this).sortable('serialize');
        $.ajax({
          data: data,
          type: 'POST',
          url: 'index.php?route=catalog/devos_attribute_ext/sortedAttribute&token='+token,
        }); 
        var sort_order_i=0;
        $(this).find('tr td.sort_order').each(function(){
          $(this).html(sort_order_i);
          sort_order_i = sort_order_i+1;
        });          
      }
    });
    
    $( "#dae-attribute-group" ).sortable({
      axis: 'y',
      update: function (event, ui) {
        var data = $(this).sortable('serialize');
        $.ajax({
          data: data,
          type: 'POST',
          url: 'index.php?route=catalog/devos_attribute_ext/sortedAttributeGroup&token='+token,
        }); 
      }
    });
    
  });
  
  function daeReplaseCountForAG(attribute_group_id, value=1){
    var elem = $('span#attribute_group_count_value'+attribute_group_id);
    var count = Number($(elem).text());
    $(elem).text(count+value);
  }
  function daeDeleteAttributeGroup(attribute_group_id){
    if (confirm("Удалить группу атрибутов?")){
      $.ajax({
        url: 'index.php?route=catalog/devos_attribute_ext/deleteAttributeGroup&token='+token,
        type: "POST",
        data: 'attribute_group_id='+attribute_group_id,
        dataType: 'json',      
        success: function(json) {
          $(".alert").addClass('hidden');
          if(json.error == 0){//если удаление успешно
            //выведем сообщение
            $(".alert-success span").html(json.success);
            $(".alert-success").removeClass('hidden');
            //удалим его из списка
            $('li[data-attribute_group_id='+json.attribute_group_id+']').remove();
            $('div#tab-dae-attribute'+json.attribute_group_id).remove();
          }else{
            $(".alert-danger span").html(json.error_warning);
            $(".alert-danger").removeClass('hidden');
          }
        }
      });
    }
  }
  function daeViewFormAttributeGroup(attribute_group_id){
    $.ajax({
      url: 'index.php?route=catalog/devos_attribute_ext/getFormAttributeGroup&token='+token,
      dataType: 'json',
      data: 'attribute_group_id='+attribute_group_id,
      success: function(json) {
        $('#daeModalBox').html(json.body);
        $("#daeModalBox").modal('show');
      }
    });
  }
  function daeViewFormAttribute(attribute_id){
    $.ajax({
      url: 'index.php?route=catalog/devos_attribute_ext/getFormAttribute&token='+token,
      type: 'GET',
      dataType: 'json',
      data: 'place=attribute&attribute_id='+attribute_id,
      success: function(json) {
        $('#daeModalBox').html(json.body);
        $("#daeModalBox").modal('show');
      }
    });
  }
  function daeDeleteAttribute(attribute_id){
    if (confirm("Удалить атрибут?")){
      $('tr#dae_attribute_'+attribute_id+' button').tooltip('destroy');
      $.ajax({
        url: 'index.php?route=catalog/devos_attribute_ext/deleteAttribute&token='+token,
        type: "POST",
        data: 'attribute_id='+attribute_id,
        dataType: 'json',      
        success: function(json) {
          $(".alert").addClass('hidden');
          if(json.error == 0){//если удаление успешно
            //выведем сообщение
            $(".alert-success span").html(json.success);
            $(".alert-success").removeClass('hidden');
            //удалим его из списка
            $('tr#dae_attribute_'+attribute_id).remove();
            //обновим кол-во в группе
            daeReplaseCountForAG(json.attribute_group_id,-1);
          }else{
            $(".alert-danger span").html(json.error_warning);
            $(".alert-danger").removeClass('hidden');
          }
          
        }
      });
    }
  }
  function daeViewFormValue(attribute_id){
    $.ajax({
      url: 'index.php?route=catalog/devos_attribute_ext/getFormAttributeValue&token='+token,
      type: 'GET',
      dataType: 'json',
      data: 'place=attribute&attribute_id='+attribute_id,
      success: function(json) {
        $('#daeModalBox').html(json.body);
        $("#daeModalBox").modal('show');
      }
    });
  }
  function daeViewFormCorrection(attribute_id){
    $.ajax({
      url: 'index.php?route=catalog/devos_attribute_ext/getFormCorrectionAttributeValue&token='+token,
      type: 'GET',
      dataType: 'json',
      data: 'attribute_id='+attribute_id,
      success: function(json) {
        $('#daeModalBox').html(json.body);
        $("#daeModalBox").modal('show');
      }
    });
  }

</script>
<?php echo $footer; ?>