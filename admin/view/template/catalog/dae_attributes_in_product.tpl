<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">        
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $dae_lang_heading_title; ?></h1>
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
    <div class="alert alert-info hidden"><i class="fa fa-check-circle"></i>
      <span></span>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $dae_lang_auto_load_prod; ?></h3>
      </div>
      <div class="panel-body">
        <p class="text-danger"><?php echo $dae_help_ain_warning;?></p>
        <form method="POST" action="<?php echo $action_add_attributes_product;?>" id="form">

            <div class="row">
              <div class="col-md-6">
                <div class="row">
                  <!-- выбор категорий --> 
                  <div class="col-md-12">
                    <div class="form-group">
                      <div class="row">
                        <div class="col-md-12">
                          <label class="control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_help_ain_category;?>"><?php echo $dae_text_ain_category;?></span></label>
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="all_category" value="1"/> <?php echo $dae_text_all_category;?>
                            </label>
                          </div>
                        </div>
                        <div class="col-md-12" id="category_">          
                          <input type="text" name="category_" value="" placeholder="" class="form-control" autocomplete="off">
                          <div id="dae_box_category" class="well well-sm" style="height: 150px; overflow: auto;margin-bottom: 0px;">                 
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- Добавляемые товары --> 
                  <div class="col-md-12">
                    <div class="form-group">
                      <div class="row">
                        <div class="col-md-12">
                          <label class="control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_help_ain_product;?>"><?php echo $dae_text_ain_product;?></span></label>
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" name="all_product" value="1"/> <?php echo $dae_text_all_product;?>
                            </label>
                          </div>
                        </div>
                        <div class="col-md-12" id = "product_">          
                          <input type="text" name="product_" value="" placeholder="" class="form-control" autocomplete="off">
                          <div id="dae_box_product" class="well well-sm" style="height: 150px; overflow: auto;margin-bottom: 0px;">                 
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- Игнорируемые товары -->
                  <div class="col-md-12">
                    <div class="form-group">
                      <div class="row">
                        <label class="col-md-12 control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_help_ain_product_ignore;?>"><?php echo $dae_text_ain_product_ignore;?></span></label>
                        <div class="col-md-12" id="product_ignore_">          
                          <input type="text" name="product_ignore_" value="" placeholder="" class="form-control" autocomplete="off">
                          <div id="dae_box_product_ignore" class="well well-sm" style="height: 150px; overflow: auto;margin-bottom: 0px;">                 
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="row">
                  <div class="form-group">
                  <div class="col-xs-12">
                    <label class="control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_a_in_c_group_attribute_help;?>"><?php echo $dae_a_in_c_group_attribute;?></span></label>
                  </div>                
                  <div class="col-xs-8 col-sm-8">
                    <input type="text" name="attribute_group_name" id="attribute_group_name"  value="" placeholder="" class="form-control" autocomplete="off">
                    <input type="hidden" name="attribute_group_id" id="attribute_group_id"  value="">
                  </div>
                  <div class="col-xs-4 col-sm-4">
                    <button type="button" data-toggle="tooltip" title="<?php echo $dae_a_in_c_button_add_attribute_group_help; ?>" class="btn btn-primary" id="add-attributes-for-group"><i class="fa fa-plus"></i></button>
                    <button type="button" data-toggle="tooltip" title="<?php echo $dae_a_in_c_button_view_attribute_group_help; ?>" class="btn btn-primary" id="view-attributes-for-group"><i class="fa fa-eye"></i></button>
                  </div>
                  </div>
                </div>
                <div class="row" id="box-attributes-for-group">
                </div>
                <div class="row">
                  <div class="col-md-12">
                      <div class="form-group">
                        <div class="row">
                          <label class="col-md-12 control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_help_ain_attributes;?>"><?php echo $dae_text_ain_attributes;?></span></label>
                        <div class="col-md-12" id="attributes_">          
                          <input type="text" name="attributes_name" id="attributes_name" value="" placeholder="" class="form-control" autocomplete="off">
                          <div id="dae_box_attribute" class="well well-sm" style="height: 350px; overflow: auto;margin-bottom: 0px;">                 
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-12">
                    <label><?php echo $dae_text_ain_params_add;?></label>
                  </div>
                  <div class="col-md-12">
                    <div class="row">
                      <div class="col-md-4">
                        <div class="radio">
                          <label class="radio-inline control-label">
                            <input type="radio" name="params" value="1" checked="checked" /> <span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_help_ain_clear;?>"><?php echo $dae_text_ain_clear;?></span>
                          </label>
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="radio">
                          <label class="radio-inline control-label">
                            <input type="radio" name="params" value="2"/> <span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_help_ain_add_new;?>"><?php echo $dae_text_ain_add_new;?></span>
                          </label>
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="radio">
                          <label class="radio-inline control-label">
                            <input type="radio" name="params" value="3"/> <span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_help_ain_only_clear;?>"><?php echo $dae_text_ain_only_clear;?></span>
                          </label>
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="checkbox">
                          <label class="control-label">
                            <input type="checkbox" name="set_default" value="1"/> <span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_help_ain_set_default;?>"><?php echo $dae_text_ain_set_default;?></span>
                          </label>
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="checkbox "  >
                          <label class="control-label" >
                            <input type="checkbox" name="all_attribute" value="1"  data-critery="attribute" class="select-group"/> <span data-toggle="tooltip" title="" data-original-title="<?php echo $dae_help_ain_all_attribute;?>"><?php echo $dae_text_ain_all_attribute;?></span>
                          </label>
                        </div>
                      </div>
                    </div>
                  </div>    
                  <div class="col-md-12 text-right">
                    <button type="button" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary" id="submit-form"><?php echo $dae_text_button_add;?></button>
                  </div>       
                </div>
              </div>
            </div>
        </form>
      </div>
    </div>
  </div>
</div>
<div id="daeModalBox" class="modal fade"></div>
<script>
  var token = '<?php echo $token; ?>';
  var text_no_results = '<?php echo $text_no_results;?>';
  var devos_attributes_select = [];
  var dae_attribute_for_group = [];//список атрибутов, полученный при выборе группы атрибутов
  $(document).ready(function(){


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
    * автодополнение категорий
    */
    $('input[name="category_"]').autocomplete({
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
        $('input[name="category_"]').val('');
        
        $('#dae_box_category' + item['value']).remove();
        
        $('#dae_box_category').append('<div id="dae_box_category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="category[]" value="' + item['value'] + '" /></div>'); 
        
      }
    });
    $('input[name="all_category"]').click(function(){
      if($(this).prop('checked')){
        $('input[name="category_"]').prop("disabled", true);
      }else{
        $('input[name="category_"]').prop("disabled", false);
      }
    });
    
    /*
    * автодополнение товаров
    */
    $('input[name="product_"]').autocomplete({
      'source': function(request, response) {
        $.ajax({
          url: 'index.php?route=catalog/devos_attribute_ext/autocompleteProduct&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
          dataType: 'json',     
          success: function(json) {
            response($.map(json, function(item) {
              return {
                label: item['name'],
                value: item['product_id']
              }
            }));
          }
        });
      },
      'select': function(item) {
        $('input[name="product_"]').val('');
        
        $('#dae_box_product' + item['value']).remove();
        
        $('#dae_box_product').append('<div id="dae_box_product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product[]" value="' + item['value'] + '" /></div>'); 
        
      }
    });
    $('input[name="all_product"]').click(function(){
      if($(this).prop('checked')){
        $('input[name="product_"]').prop("disabled", true);
      }else{
        $('input[name="product_"]').prop("disabled", false);
      }
    });

    /*
    * автодополнение товаров для игнора
    */
    $('input[name="product_ignore_"]').autocomplete({
      'source': function(request, response) {
        $.ajax({
          url: 'index.php?route=catalog/devos_attribute_ext/autocompleteProduct&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
          dataType: 'json',     
          success: function(json) {
            response($.map(json, function(item) {
              return {
                label: item['name'],
                value: item['product_id']
              }
            }));
          }
        });
      },
      'select': function(item) {
        $('input[name="product_ignore_"]').val('');
        
        $('#dae_box_product' + item['value']).remove();
        
        $('#dae_box_product_ignore').append('<div id="dae_box_product_ignore' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_ignore[]" value="' + item['value'] + '" /></div>'); 
        
      }
    });
    /*
    * Отправка формы
    */
    $('#submit-form').click(function(){
      $('.alert').addClass('hidden');
      $('.alert').removeClass('show');

      $('.alert-info span').text('<?php echo $dae_text_wait;?>');
      $('.alert-info').removeClass('hidden');
      $('.alert-info').addClass('show');
      var form = $('#form');
      $.ajax({
        url: form.attr('action'),
        type: "POST",
        data: form.serialize(),
        dataType: 'json',
        success: function(json) {
          $('.alert').addClass('hidden');
          $('.alert').removeClass('show');

          $('.alert-'+json.type).removeClass('hidden');
          $('.alert-'+json.type).addClass('show');
          $('.alert-'+json.type+' span').text(json.message);

          
        }       
      });
    });
    /*
    * Удаление списков
    */
    $('form').on('click','.fa-minus-circle',  function() {
      $(this).parent().remove();
    });
    /*
    * Выделить атрибуты
    */
    $('.select-group').click(function(){
      var critery = $(this).data('critery');
      if($(this).prop('checked')){
        $('.'+critery).prop('checked', true);  
        $('.'+critery).parent().parent().addClass('bg-success');
      }else{
        $('.'+critery).prop('checked', false);
         $('.'+critery).parent().parent().removeClass('bg-success');
      }
     
    });
    $('input.attribute').click(function(){          
      if($(this).prop('checked')){        
        $(this).parent().parent().addClass('bg-success');
      }else{        
         $(this).parent().parent().removeClass('bg-success');
      }
     
    });
    /*
    * Автозагрузка атрибутов
    */
    //var form = $('#form input');
    //var array_field = form.serialize();

    $('#attributes_name').autocomplete({
      'source': function(request, response) {
        console.log($('#form input[name="attribute_id[]"]').serialize());
        $.ajax({
          url: 'index.php?route=catalog/devos_attribute_ext/autocompleteAttribute&token=<?php echo $token; ?>'+'&filter_name=' +  encodeURIComponent(request),
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
        $('#dae_box_attribute' + item['value']).remove();        
        $('#dae_box_attribute').append('<div id="dae_box_attribute' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['category']+' > '+item['label'] + '<input type="hidden" name="attribute_id[]" value="' + item['value'] + '" /></div>');
      }
    });
  });
</script>
<?php echo $footer; ?>