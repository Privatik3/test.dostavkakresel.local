<?php if ($option_values) { ?>
<div class="selector-window">
	<div class="col-md-9">
	<div class="filters">
		<?php echo $button;?>
	</div>
    <?php
        /* DEFAULT OPTION */
        foreach($option_values as $key=>$option) {
            $sort[$key]  = $option['isDefault'];
        }
        array_multisort($sort, SORT_DESC, $option_values);
        //die(json_encode($option_values));
        /* DEFAULT OPTION */
    ?>
	<!--<div id="descriptions">
		<div class="cat_description cat_4">TEST</div>
	</div>-->
	<?php echo $descriptions;?>
	<div id="options">
		
		<?php foreach ($option_values as $option) { ?>
			<div class="option_wrap <?php echo $option['class'];?> lazyload">
				
                    <div class="option_wrap_img" data-default="<?php echo($option['isDefault']); ?>" data-toggle="false_tooltip" title="<?php echo $text_add?>">
                        <img class="preloader" src="<?php echo $preloader;?>">
                        <img data-img="<?php echo $option['image'];?>" src="<?php echo $preloader;?>" style="display: none;">
                        <div class="option_controls">
                            <span class="fa fa-search option-img" data-img="<?php echo $option['thumb'];?>" data-toggle="tooltip" title="<?php echo $text_zoom?>"></span>
                            <!--<span class="fa fa-plus" data-default="<?php echo($option['isDefault']); ?>" data-toggle="tooltip" title="<?php echo $text_add?>"></span>-->
                            <span class="fa fa-check"></span>
                        </div>
                        
                        <input hidden type="radio" data-prefix="<?php echo $option['price_prefix'];?>" data-price="<?php echo $option['price_value'];?>" name="option" value="<?php echo $option['product_option_value_id'];?>">
                    </div>
				<div class="option-text">
					<span><?php echo $option['price'];?></span>
					<span><?php echo $option['stock'];?></span>
					<div><?php echo $option['text'];?></div>
				</div>
				

			</div>
		<?php }?>
	</div>
	<style>
		.preloader {
			width: <?php echo $preloader_width;?>px!important;
			height: <?php echo $preloader_height;?>px!important;
		}
	</style>
	<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-body">
	            <img class="img-responsive">
	        </div>
	    </div>
	    <div class="modal-body-close" onclick="$('#myModal').modal('hide');">
	    	<span class="fa fa-times"></span>
	    </div>
	  </div>
	</div>
	<div id="pagination" class="pagination-results"></div>
	</div>
	<div class="col-md-3 info">
		<div class="product_info">
			<?php echo $heading_title; ?>
			<img class="product_info_img" src="<?php echo $image; ?>" title="<?php echo html_entity_decode($heading_title); ?>">
			<?php if ($price) { ?>
				<ul class="list-unstyled">
					<?php if (!$special) { ?>
						<li>
							<h2 id="fc-product-price"><?php echo $price; ?></h2>
						</li>
					<?php } else { ?>
						<li class="fc-product-price1">
							<h2 id="fc-product-special"><?php echo $special; ?></h2>
						</li>
						<li  class="fc-product-price2"><span id="fc-product-price" style="text-decoration: line-through;"><?php echo $price; ?></span></li>
						
					<?php } ?>
					<?php if ($tax) { ?>
						<br/><li class="fc-product-price3"><?php echo $text_tax; ?></li>
						<li class="fc-product-price3" id="fc-product-tax"><?php echo $tax; ?></li></li>
					<?php } ?>
				</ul>
			<?php } ?>
			<input type="hidden" name="fc_product_id" value="<?php echo $product_id;?>">
			<input type="hidden" name="product_id" value="<?php echo $product_id;?>">
		</div>
		<div class="selected_list">
		<?php if ($selected_opt) { ?>
		
		
			<?php foreach ($selected_opt as $key => $opt) { ?>
				<?php if($key != $option_id) { ?>
                <div class="selected_item">
                    <!--<h2 class="selected title"><?php echo $opt['option_name'];?></h2>-->
                    <div class="selected-option">
                        <div class="option_wrap_img">
                            <img src="<?php echo $opt['image'];?>" />
                        </div>
                        <div class="option-text">
                            <span><?php echo $opt['price'];?></span>
                            <div>
                                <?php echo $opt['text'];?>
                            </div>
                            <span class="fa fa-search option-img" data-img="<?php echo $opt['thumb'];?>" data-toggle="modal" data-target="#myModal">	
                                            </span>
                        </div>
                        <input hidden data-price="" data-prefix="" name="option[<?php echo $key;?>]" type="radio" value="<?php echo $opt['product_option_value_id']?>">
                    </div>
                </div>
				<?php } ?>
			<?php } ?>
		
		<?php } ?>
			<div class="selected_item">
				<h2 class="selected title"><?php //echo $option_name; ?></h2>
				<div id="selected-option" class="selected-option">
					<?php if ($selected_opt && array_key_exists($option_id, $selected_opt)) { ?>
					
					<div class="option_wrap_img">
						<img src="<?php echo $selected_opt[$option_id]['image']?>"/>						
					</div>
					
					<input hidden data-prefix="<?php echo $selected_opt[$option_id]['price_prefix']?>" data-price="<?php echo $selected_opt[$option_id]['price_value']?>" name="option[<?php echo $option_id;?>]" type="radio" value="<?php echo $selected_opt[$option_id]['product_option_value_id']?>">
					
					<div class="option-text">
					<?php if(isset($selected_opt[$option_id])) { ?>
						<span><?php echo $selected_opt[$option_id]['price'];?></span>
						<div><?php echo $selected_opt[$option_id]['text'];?></div>
					<?php } ?>
					</div>
					<span class="fa fa-times" data-toggle="tooltip" title="<?php echo $text_delete?>"></span>					
					<script>
						$('#options input[value="<?php echo $selected_opt[$option_id]['product_option_value_id']?>"]').attr('checked', true).closest('.option_wrap').addClass('selected');
					</script>
					<?php } else { ?>
					<div class="option_wrap_img"></div>
					<input hidden name="option[<?php echo $option_id;?>]" type="radio" value="">
					<div class="option-text"></div>
					<span class="fa fa-times" data-toggle="tooltip" title="<?php echo $text_delete?>"></span>
					<?php } ?>
				</div> 
			</div>
            <div class="submit">
                <button onclick="$.magnificPopup.close()" class="fc_submit button btn-lg">Подтвердить</button>
            </div>
		</div>
	</div>

	<script>
			var init_flag = true;

			$('#selected-option input').on('change', function () {
				$.ajax({
					type: 'POST',
					url: 'index.php?route=extension/module/fabrickchoice/updateprice',
					data: $('.info input'),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#fc-product-special').html(json.new_price.special);
							$('#fc-product-tax').html(json.new_price.tax);
							$('#fc-product-price').html(json.new_price.price);
						}
					}
				});
			});

			$('#selected-option .fa-times').on('click', function () {
					$('#selected-option .option_wrap_img').html('');
					$('#selected-option .option-text').html('');
					$('#selected-option input').val('');
					$('#selected-option input').trigger('change');
					$('#options .option_wrap.selected').removeClass('selected');
					$('[data-default=\'1\'').click();
					//$('[data-default=\'1\'').parents('.option_wrap').addClass('selected')
			});

			$('#options .option_wrap_img .fa-plus,#options  .option_wrap_img').click(function () {
				var input = $(this).closest('.option_wrap_img').find('input');
				input.attr('checked', true);
				$('#selected-option input').val(input.val())
                    .attr('data-prefix', input.attr('data-prefix'))
                    .attr('data-price', input.attr('data-price'));
				var src = $(this).closest('.option_wrap_img').find('img[data-img]').attr('data-img');
				$('#selected-option .option_wrap_img').html('<img src="' + src + '">');
				$('#selected-option .option-text').html($(this).closest('.option_wrap').find('.option-text').html());
				$('#selected-option input').change();
				$('#options .selected').removeClass('selected');
				$(this).closest('.option_wrap').addClass('selected');
			});

			$('.option_wrap_img .fa-search').click(function () {
				$('#myModal').modal();
				$('.modal-body img').attr('src',$(this).attr('data-img'));
			});

			$('.filters div').each(function (index, element) {

				var $gr = $(element).isotope({
					// options
					itemSelector: '.' + $(element).attr('class')  + '> div',
					layoutMode: 'fitRows'
				});

				$(element).parent().children('button:not(.all)').on('click', function () {
					var filterValue = $(this).attr('data-filter');
					$gr.isotope({ filter: filterValue });
				});

				$(element).parent().children('button.all').on('click', function () {
					$gr.isotope({ filter: 'none' });
				});

				$gr.isotope({ filter: 'none' });
			});

			var itemsOfPagination = '.option_wrap';

			if (window.innerWidth <= 640) {
				var itemsOnPage = 4;
			} else if (window.innerWidth > 320 && window.innerWidth <= 768) {
				var itemsOnPage = 9;
			} else if (window.innerWidth > 768 && window.innerWidth <= 992) {
				var itemsOnPage = 12;
			} else {
				var itemsOnPage = 15;
			}

			var dispayedItems = null;
			var hiddenItems = null;

			$main_grid = $('#options').isotope();
			$('#descriptions div').each(function (index, element) {
				//element.css('display', 'none');
			})
			$('.filters button').on('click', function (e) {
				var filterValue = $(this).attr('data-filter');
				$main_grid.isotope('destroy');
				$('#options > div, #descriptions > div').not(filterValue).css('display', 'none');
				$('#options').find(filterValue).css('display', 'inherit');
				var elem = $(e.target);
				
				if(elem.hasClass('flag')) {
					$('#descriptions').find(filterValue).css('display', 'inline-block');//console.log(e.target)
				}
				else 
					$('#descriptions').find(filterValue).css('display', 'none');
					initMainGrid(filterValue);

				$(this).siblings('button.checked').removeClass('checked');
				$(this).addClass('checked');

			});

			if (!$('.filters button').length) {
				var filterValue = '.option_wrap';
				initMainGrid(filterValue);
			}

			function initMainGrid(filterValue) {

				$main_grid.isotope({
					itemSelector: filterValue,
					layoutMode: 'fitRows'
				});
				init_pagination();
				remove_lazyload();
			}

			function remove_lazyload() {
				$($main_grid.data('isotope').filteredItems).each(function (index, element) {
					if ($(element.element).hasClass('lazyload')){
						var img = $(element.element).find('img[data-img]');
						img.attr('src', img.attr('data-img'));
						img.one('load', function () {
							$(element.element).find('.preloader').remove();
							img.removeAttr('style');
						});

						$(element.element).removeClass('lazyload');
					}
				});
			}

			function init_pagination() {

				var num_items = $main_grid.isotope('getFilteredItemElements').length;

				if (num_items > itemsOnPage) {

					var count = 0;
					$.each($main_grid.isotope('getFilteredItemElements'), function (index, element) {
						if ((index%itemsOnPage) == 0) {count++;}
						$(element).attr('data-page', count);
					});

						$('#pagination').pagination({
							items: num_items,
							itemsOnPage: itemsOnPage,
							cssStyle: '',
							listStyle: 'pagination',
							prevText: '',
							nextText: '',
							displayedPages: 3,
							edges: 3,
							onPageClick: function (pageNumber, event) {
								$main_grid.isotope({ filter: '[data-page="'+pageNumber+'"]' });
								remove_lazyload();
								return false;
							}
						});
						$main_grid.isotope({ filter: '[data-page="1"]' });
				} else {
					$('#pagination').pagination('destroy');
				}

			}
			$('.filters button:first').click();
            <?php if (!$selected_opt) { ?>
				$('[data-default=\'1\'').click();
            <?php } ?>
			$('#selected-option input').trigger('change');

	</script>
</div>
<?php } ?>

