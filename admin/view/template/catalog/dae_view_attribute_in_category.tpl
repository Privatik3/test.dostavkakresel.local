<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="button" form="form-attribute" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary" id="form-submit"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $dae_lang_heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">

    <div class="alert alert-danger alert-error hidden"><i class="fa fa-exclamation-circle"></i> <span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <div class="alert alert-success hidden"><i class="fa fa-exclamation-circle"></i> <span></span> 
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <div class="alert alert-info hidden"><i class="fa fa-exclamation-circle"></i> <span></span> 
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $dae_view_attr_in_cat_header; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
          <div class="row">
            <div class="col-md-6"> 
                <div class="row">
                  <div class="col-xs-12">
                    <label class="control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_view_a_in_c_category_help;?>"><?php echo $dae_view_a_in_c_category;?></span></label>                    
                  </div>
                  <div class="col-xs-12">          
                    <input type="text" name="category_name" id="category_name"  value="" placeholder="" class="form-control" autocomplete="off">
                    <input type="hidden" name="category_id[]" id="category_id"  value="">
                  </div>
                </div>
                <div class="row">
                  <div class="col-xs-12">
                    <label class="control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_view_a_in_c_category_more_help;?>"><?php echo $dae_view_a_in_c_category_more;?></span></label>                    
                  </div>
                  <div class="col-xs-12">          
                    <input type="text" name="categories_name" id="categories_name"  value="" placeholder="" class="form-control" autocomplete="off">
                    <div id="dae_box_category" class="well well-sm" style="height: 461px; overflow: auto;margin-bottom: 0px;">                 
                      </div>
                  </div>
                </div>
            </div>
            <div class="col-md-6">
              <div class="row">
                <div class="col-xs-12">
                  <label class="control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_view_a_in_c_template_help;?>"><?php echo $dae_view_a_in_c_template;?></span></label>
                </div>                
                <div class="col-xs-12">
                  <input type="text" name="setting[template]" id="template"  value="" placeholder="" class="form-control" autocomplete="off">                 
                </div>
                <div class="col-xs-12">
                  <label class="control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_view_a_in_c_group_attribute_help;?>"><?php echo $dae_view_a_in_c_group_attribute;?></span></label>
                </div>                
                <div class="col-xs-8 col-sm-8">
                  <input type="text" name="attribute_group_name" id="attribute_group_name"  value="" placeholder="" class="form-control" autocomplete="off">
                  <input type="hidden" name="attribute_group_id" id="attribute_group_id"  value="">
                </div>
                <div class="col-xs-4 col-sm-4">
                  <button type="button" data-toggle="tooltip" title="<?php echo $dae_view_a_in_c_button_add_attribute_group_help; ?>" class="btn btn-primary" id="add-attributes-for-group"><i class="fa fa-plus"></i></button>
                  <button type="button" data-toggle="tooltip" title="<?php echo $dae_view_a_in_c_button_view_attribute_group_help; ?>" class="btn btn-primary" id="view-attributes-for-group"><i class="fa fa-eye"></i></button>
                </div>
              </div>
              <div class="row" id="box-attributes-for-group">
              </div>
              <div class="row">
                <div class="col-xs-12">
                  <label class="control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_view_a_in_c_attribute_list_help;?>"><?php echo $dae_view_a_in_c_attribute_list;?></span></label>                    
                </div>
                <div class="col-xs-12">          
                  <input type="text" name="attributes_name" id="attributes_name"  value="" placeholder="" class="form-control" autocomplete="off">
                  <div id="dae_box_attribute" class="well well-sm" style="height: 400px; overflow: auto;margin-bottom: 0px;"></div>
                </div>
              </div>
            </div>
          </div>			
        </form>
      </div>
    </div>
  </div>
</div>

<?php echo $footer; ?>
<script>
  var dae_attribute_for_group = [];//список атрибутов, полученный при выборе группы атрибутов

  function a_i_c_addAttribute(attribute_id, attribute_name, attribute_group){
    $('#dae_box_attribute' + attribute_id).remove();        
    $('#dae_box_attribute').append('<div id="dae_box_attribute' + attribute_id + '"><i class="fa fa-minus-circle"></i> ' + attribute_group+' > '+attribute_name + '<input type="hidden" name="attribute_id[]" value="' + attribute_id + '" /></div>');
  }
  
  /*
    Клик по кнопке "Добавить все атрибуты группы"
  */
  $('body').on('click','#add-attributes-for-group', function(){
    for (var key in dae_attribute_for_group){
      a_i_c_addAttribute(dae_attribute_for_group[key]['attribute_id'], dae_attribute_for_group[key]['name'], dae_attribute_for_group[key]['attribute_group']);     
    }
    //отметим все чекбоксы, если было их отображение
    $('div#box-attributes-for-group input').each(function(){
      var attribute_id = $(this).val();
      if($('div').is('#dae_box_attribute'+attribute_id))
        $(this).prop('checked', true);
      else
        $(this).prop('checked', false);
    });
  });
  /*
    Клик по кнопке "Отобразить атрибуты группы"
  */
  $('body').on('click','#view-attributes-for-group', function(){
    $('#box-attributes-for-group').html('');
    var html = '';
    var checked = '';

    for (var key in dae_attribute_for_group){
      if($('div').is('#dae_box_attribute'+dae_attribute_for_group[key]['attribute_id']))
        checked = ' checked = "checked"';
      else
        checked = '';
      html += ' <div class="col-sm-4">';
      //html += '   <div class="form-group">';
      html += '     <div class="checkbox">';
      html += '       <label>';
      html += '         <input type="checkbox" name="temp_attribute_id[]" value="'+dae_attribute_for_group[key]['attribute_id']+'" '+checked+' data-attribute-group="' + dae_attribute_for_group[key]['attribute_group'] + '" data-attribute-name="' + dae_attribute_for_group[key]['name'] + '"/> '+dae_attribute_for_group[key]['name'];
      html += '       <label>';
      html += '     </div>';
      //html += '   </div>';      
      html += ' </div>';     
    }
    $('#box-attributes-for-group').html(html);
  });
  /*
    Клик по чекбоксу с атрибутом - добавление атрибута к категории
  */
  $('body').on('change', '#box-attributes-for-group input', function(){
    var attribute_id = $(this).val();
    if($(this).prop("checked")){      
      var attribute_name = $(this).data('attribute-name');
      var attribute_group = $(this).data('attribute-group');
      a_i_c_addAttribute(attribute_id, attribute_name, attribute_group);
    }else{
      $('#dae_box_attribute' + attribute_id).remove();  
    }
  });
  /*
    Изменение поля ввода группы атрибутов
  */
  $('#attribute_group_name').change(function(){
    if($(this).val() == ''){
      $('#attribute_group_id').val(0);
      dae_attribute_for_group=[];
      //очистка поля с чекбоксами атрибутов
      $('#box-attributes-for-group').html('');
    }
  });
  /*
    Автозавершение и выбор группы атрибутов
  */
  $('#attribute_group_name').autocomplete({
    'source': function(request, response) {
      $.ajax({
        url: 'index.php?route=catalog/devos_attribute_ext/autocompleteAttributeGroups&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
        dataType: 'json',     
        success: function(json) {
          response($.map(json, function(item) {
            return {
              label: item['name'],
              value: item['attribute_group_id']
            }
          }));
        }
      });
    },
    'select': function(item) {
      $('#attribute_group_name').val(item['label']);
      $('#attribute_group_id').val(item['value']);
      //загрузка привязанных атрибутов
      $.ajax({
        url: 'index.php?route=catalog/devos_attribute_ext/autocompleteAttribute&token=<?php echo $token; ?>',
        data: {filter_attribute_group:item['value'],filter_name:''},
        dataType: 'json',     
        success: function(json) {
          dae_attribute_for_group = json;
        }
      });
      
    }
  });
  /*
    Автозавершение и выбор категории
  */
  $('#category_name').autocomplete({
      'source': function(request, response) {
        $.ajax({
          url: 'index.php?route=catalog/devos_attribute_ext/autocompleteCategory&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
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
      'select': function(item) {
        $('#category_name').val(item['label']);
        $('#category_id').val(item['value']);
        //загрузка привязанных атрибутов
        $.ajax({
          url: 'index.php?route=catalog/devos_attribute_ext/loadViewAttributeByCategory&token=<?php echo $token; ?>',
          data: {category_id:item['value']},
          dataType: 'json',     
          success: function(json) {
            $('.alert').addClass('hidden');
            $('#dae_box_attribute').html('');
            $('#template').val('');
            if(json.type=='info'){               
                $('.alert-info'+' span').text(json.message);
                $('.alert-info').removeClass('hidden');       
            }else{
                var attributes = json.data.attributes;
                for (var tmp_group_id in attributes){
                  var attribute_group = attributes[tmp_group_id]['attribute_group'];
                  for (var tmp_attr_index in attributes[tmp_group_id]['attributes']){
                    var attribute_name = attributes[tmp_group_id]['attributes'][tmp_attr_index]['name'];
                    var attribute_id = attributes[tmp_group_id]['attributes'][tmp_attr_index]['attribute_id'];
                    a_i_c_addAttribute(attribute_id, attribute_name, attribute_group);
                    
                  }
                }
                //если выведен список атрибутов группы - обновим у них галочку
                $('div#box-attributes-for-group input').each(function(){
                  var attribute_id = $(this).val();
                  if($('div').is('#dae_box_attribute'+attribute_id))
                    $(this).prop('checked', true);
                  else
                    $(this).prop('checked', false);
                });
                //вывод настроек(шаблона)
                if('template' in json.data.setting)
                  $('#template').val(json.data.setting['template']);
            }
          }
        });
        
      }
    });
  /*
    Автозавершение и выбор дополнительных категорий
  */
  $('#categories_name').autocomplete({
      'source': function(request, response) {
        $.ajax({
          url: 'index.php?route=catalog/devos_attribute_ext/autocompleteCategory&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
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
      'select': function(item) {
        $('#categories_name').val('');        
        $('#dae_box_category' + item['value']).remove();        
        $('#dae_box_category').append('<div id="dae_box_category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="category_id[]" value="' + item['value'] + '" /></div>');         
      }
    });
  /*
    Автозавершение и выбор атрибутов
  */
    $('#attributes_name').autocomplete({
      'source': function(request, response) {
        $.ajax({
          url: 'index.php?route=catalog/devos_attribute_ext/autocompleteAttribute&token=<?php echo $token; ?>',
          data:{filter_attribute_group:$('#attribute_group_id').val(), filter_name:encodeURIComponent(request)},
          dataType: 'json',
          success: function(json) {
            
            response($.map(json, function(item) {
              return {
                category: item.attribute_group,
                label: item.name,
                value: item.attribute_id
              }
            }));
          }
        });
      },
      'select': function(item) {        
        $('#attributes_name').val('');
        a_i_c_addAttribute(item['value'], item['label'], item['category']);
      }
    });
      /*
    * Удаление списков
    */
    $('form').on('click','.fa-minus-circle',  function() {

      $(this).parent().remove();
      //обновление чекбоксов при удалении элемента
      $('div#box-attributes-for-group input').each(function(){
        var attribute_id = $(this).val();
        if($('div').is('#dae_box_attribute'+attribute_id))
          $(this).prop('checked', true);
        else
          $(this).prop('checked', false);
      });
    });
    /*
    * Отправка формы
    */
    $('#form-submit').click(function(){
      $('.alert').addClass('hidden');     

      $('.alert-info span').text('<?php echo $dae_text_wait;?>');
      $('.alert-info').removeClass('hidden');
      var form = $('#form');
      $.ajax({
        url: form.attr('action'),
        type: "POST",
        data: form.serialize(),
        dataType: 'json',
        success: function(json) {
          $('.alert').addClass('hidden');
          $('.alert-'+json.type+' span').text(json.message);
          $('.alert-'+json.type).removeClass('hidden');         
        }       
      });
      return false;
    });
</script>