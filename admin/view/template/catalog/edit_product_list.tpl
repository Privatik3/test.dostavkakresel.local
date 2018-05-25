<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
<style type="text/css">
	

.product-qty-col input{border-width:2px; border-style: solid}
.product-qty-col input.warning{border-color:orange}
.product-qty-col input.danger{border-color:red; }
.product-qty-col input.success{border-color:green; }
.product-edit-row{transition:background .5s;}
.product-edit-row td  div.product-save-button{visibility: hidden; }
.product-edit-row td.short-column{max-width:100px; }
.product-edit-row td.action-column>a, .product-edit-row td.action-column>div{float:left; margin:5px;}
.product-edit-row td input,.product-edit-row td select {width:100%; display:none; }
.product-edit-row.edit td input,.product-edit-row.edit td select {width:100%; display:block; }
.product-edit-row td>div:not(.product-save-button) {margin-bottom:10px; display:block; }
.product-edit-row.edit td>div:not(.product-save-button){display:none; }
.product-edit-row td>div.product-save-button{visibility: hidden }
.product-edit-row.edit:hover td>div.product-save-button{visibility: visible!important; }
.product-edit-row td  {text-align: center }
.product-edit-row.bg-success{    background-color:#aee67e!important; }
</style>
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
        <button type="submit" form="form-product" formaction="<?php echo $copy; ?>" data-toggle="tooltip" title="<?php echo $button_copy; ?>" class="btn btn-default"><i class="fa fa-copy"></i></button>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-product').submit() : false;"><i class="fa fa-trash-o"></i></button>
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
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              </div>
              <div class="form-group">
                <label class="control-label" for="input-model"><?php echo $entry_model; ?></label>
                <input type="text" name="filter_model" value="<?php echo $filter_model; ?>" placeholder="<?php echo $entry_model; ?>" id="input-model" class="form-control" />
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-price"><?php echo $entry_price; ?></label>
                <input type="text" name="filter_price" value="<?php echo $filter_price; ?>" placeholder="<?php echo $entry_price; ?>" id="input-price" class="form-control" />
              </div>
              <div class="form-group">
                <label class="control-label" for="input-quantity"><?php echo $entry_quantity; ?></label>
                <input type="text" name="filter_quantity" value="<?php echo $filter_quantity; ?>" placeholder="<?php echo $entry_quantity; ?>" id="input-quantity" class="form-control" />
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-status"><?php echo $entry_status; ?></label>
                <select name="filter_status" id="input-status" class="form-control">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!$filter_status && !is_null($filter_status)) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
              <div class="form-group">
                <label class="control-label" for="input-image"><?php echo $entry_image; ?></label>
                <select name="filter_image" id="input-image" class="form-control">
                  <option value="*"></option>
                  <?php if ($filter_image) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!$filter_image && !is_null($filter_image)) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
              <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-filter"></i> <?php echo $button_filter; ?></button>
            </div>
          </div>
        </div>
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-product">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                  <td class="text-center"><?php echo $column_image; ?></td>
                  <td class="text-left"><?php if ($sort == 'pd.name') { ?>
                    <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                    <?php } ?></td>
                  <td class="text-left"><?php if ($sort == 'p.model') { ?>
                    <a href="<?php echo $sort_model; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_model; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_model; ?>"><?php echo $column_model; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php if ($sort == 'p.price') { ?>
                    <a href="<?php echo $sort_price; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_price; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_price; ?>"><?php echo $column_price; ?></a>
                    <?php } ?></td>
                    <td class="text-right"><?php echo $discount_price ; ?></td>

                  <td class="text-right"><?php if ($sort == 'p.quantity') { ?>
                    <a href="<?php echo $sort_quantity; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_quantity; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_quantity; ?>"><?php echo $column_quantity; ?></a>
                    <?php } ?></td>
                  <td class="text-left"><?php if ($sort == 'p.status') { ?>
                    <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($products) { ?>
                <?php foreach ($products as $product) { ?>
                <tr class="product-edit-row product-row-<?=$product['product_id'];?>" data-product="<?=$product['product_id']; ?>">
                  <td class="text-center"><?php if (in_array($product['product_id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" />
                    <?php } ?></td>
                  <td class="text-center"><?php if ($product['image']) { ?>
                    <img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" class="img-thumbnail" />
                    <?php } else { ?>
                    <span class="img-thumbnail list"><i class="fa fa-camera fa-2x"></i></span>
                    <?php } ?></td>
                  <td class="text-left"><div><?php echo $product['name']; ?></div><input type="text" name="name" style="width:100%" value="<?php echo $product['name']; ?>"></td>
                  <td class="text-left short-column "><div><?php echo $product['model']; ?></div><input type="text" name="model" value="<?php echo $product['model']; ?>"></td>
                  <td class="text-right short-column  "><div><?php echo $product['price']; ?></div><input type="text" name="price" value="<?php echo $product['price']; ?>"></td>
                    <td class="text-right short-column "> <div><?php echo $product['special']; ?>  </div> <input type="text" name="special_price" value="<?php echo $product['special']; ?>"></td>

                    <td class="text-right product-qty-col short-column ">

                            <?php if ($product['quantity'] <= 0) { ?>
                            <div class=""> <?php echo $product['quantity']; ?></div>

                                <input type="text" name="quantity" class="warning" value="<?php echo $product['quantity']; ?>">
                        <?php } elseif ($product['quantity'] <= 5) { ?>
                               <div class=""><?php echo $product['quantity']; ?></div>
                             <input type="text" name="quantity" class="danger" value="<?php echo $product['quantity']; ?>">
                        <?php } else { ?>
                            <div class="">  <?php echo $product['quantity']; ?></div>
                             <input type="text" name="quantity" class="success" value="<?php echo $product['quantity']; ?>">
                        <?php } ?>

                            <select name="stock_status_id" id="stock_status_id">
                                <?php foreach ($stock_statuses as $stock_status) { ?>
                                    <?php if ($stock_status['stock_status_id'] == $product['stock_status_id']) { ?>
                                        <option value="<?php echo $stock_status['stock_status_id']; ?>" selected="selected"><?php echo $stock_status['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $stock_status['stock_status_id']; ?>"><?php echo $stock_status['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </td>

                  <td class="text-left">
  <div> <?php if ($product['status'])  echo $turn_on; else echo $turn_off; ?></div>

                      <select name="status" id="">
                          <?php if ($product['status']) { ?>
                              <option value="1" selected="selected"><?php echo $turn_on; ?></option>
                              <option value="0"><?php echo $turn_off; ?></option>
                          <?php } else { ?>
                              <option value="1"><?php echo $turn_on; ?></option>
                              <option value="0" selected="selected"><?php echo $turn_off; ?></option>
                          <?php } ?>
                      </select>

                  </td>
                  <td class="text-right clr-a action-column">
                      <div  data-toggle="tooltip" title="" class="btn btn-primary  product-save-button number-<?=$product['product_id']?>" data-original-title="Сохранить"><i class="fa fa-save"></i></div>
                      <a href="<?php echo $product['edit']; ?>"   data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	var url = 'index.php?route=catalog/product&token=<?php echo $token; ?>';

	var filter_name = $('input[name=\'filter_name\']').val();

	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_model = $('input[name=\'filter_model\']').val();

	if (filter_model) {
		url += '&filter_model=' + encodeURIComponent(filter_model);
	}

	var filter_price = $('input[name=\'filter_price\']').val();

	if (filter_price) {
		url += '&filter_price=' + encodeURIComponent(filter_price);
	}

	var filter_quantity = $('input[name=\'filter_quantity\']').val();

	if (filter_quantity) {
		url += '&filter_quantity=' + encodeURIComponent(filter_quantity);
	}

	var filter_status = $('select[name=\'filter_status\']').val();

	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}

  var filter_image = $('select[name=\'filter_image\']').val();

  if (filter_image != '*') {
    url += '&filter_image=' + encodeURIComponent(filter_image);
  }

	location = url;
});
//--></script>
    <script type="text/javascript"><!--
        function save(row)
        {
            var row=row.closest('.product-edit-row'),spec_price;
            row.removeClass('edit');
            product_id=row.data('product');

            $.ajax({
                url: 'index.php?route=catalog/edit_products/edit&token=<?php echo $token; ?>&product_id=' + product_id,
                type: 'post',
                data: $('.product-row-' + product_id + ' input , .product-row-' + product_id + ' select '),
                dataType: 'json',
                beforeSend: function () {
                    //  $('div.manuf-curr-block-'+manufacturer_id).addClass('loading');
                },
                complete: function () {
                    //   $('div.manuf-curr-block-'+manufacturer_id).removeClass('loading');

                },
                success: function (json) {
                    console.log(json);

                    if (json.error == 0) {
                        console.log('success changed');
                        row.addClass('bg-success');
                        setTimeout(function () {
                            row.removeClass('bg-success')
                        }, 2000)
                    }
                    $('.product-row-'+product_id+ ' td:nth-child(6) div').html('');

                    if(json.special_price.price!='undefined')
                        spec_price=json.special_price.price
                    else spec_price=' ';
                    $('.product-save-button' ).css('visibility','hidden');
                    $('.product-row-'+product_id+ ' td:nth-child(3) div').html(json.product['name']);
                    $('.product-row-'+product_id+ ' td:nth-child(4) div').html(json.product['model']);
                    $('.product-row-'+product_id+ ' td:nth-child(5) div').html(json.product['price']);
                    $('.product-row-'+product_id+ ' td:nth-child(6) div').html(spec_price);
                    $('.product-row-'+product_id+ ' td:nth-child(7) div').html(json.product['quantity']);
                    $('.product-row-'+product_id+ ' td:nth-child(8) div').html($('select[name=\'status\'] option:selected').html());
                    // $('.product-row-'+product_id+ ' td:nth-child(5) div').html(json.product['price']);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });

        }
        var product_id;
        $(document).ready(function() {
            $('.product-edit-row').on('click', function(){$('.product-edit-row').removeClass('edit'); $(this).addClass('edit');});
            $('.product-edit-row input[type=\'text\'], .product-edit-row select').on(' change, focus', function() {
                $('.product-edit-row  .product-save-button').css('visibility','hidden');
                product_id=$(this).closest('.product-edit-row').data('product');
                $('.product-save-button.number-'+product_id).css('visibility','visible');
                // console.log($('.product-row-'+product_id+' input , .product-row-'+product_id+' select '));




            });


            $('.product-edit-row input ').on('keydown', function(e) {
                    console.log(e);
                    if(e.keyCode==13)
                    {
                        e.preventDefault();
                        save($(this));
                        return false;
                    }
                }
            );


            $('.product-save-button').on('click', function() {
                save($(this));


            });

        });





        $('input[name=\'filter_name\']').autocomplete({
            'source': function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
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
                $('input[name=\'filter_name\']').val(item['label']);
            }
        });

        $('input[name=\'filter_model\']').autocomplete({
            'source': function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_model=' +  encodeURIComponent(request),
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['model'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            'select': function(item) {
                $('input[name=\'filter_model\']').val(item['label']);
            }
        });
        //--></script></div>
<?php echo $footer; ?>