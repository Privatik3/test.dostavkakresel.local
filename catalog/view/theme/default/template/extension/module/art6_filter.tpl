<?php if ($arFilters): ?>
<div class="art6-filter">
	<div class="art6-filter__title"><?php echo $heading_title; ?></div>

	<form class="art6-filter__form" name="art6-filter" action="<?php echo $action?>" method="get" enctype="multipart/form-data">
		<?php foreach($arFilters as $filter) { ?>
			<?php if ($filter['view'] == "S"):?>
				<div class="art6-filter__form-box art6-filter__form-box--slider">
					<div class="art6-filter__form-box__title"><?php echo $filter['name']; ?></div>

					<div class="art6-filter__form-box__params">
						<div class="art6-filter__form-box__params-item art6-filter__form-box__params-item--from">
							<label for="arFilter_S_<?php echo $filter['attribute_id']; ?>_FROM" class="art6-filter__form-box__params-item__title">От</label>
							<input type="text" name="arFilter_S_<?php echo $filter['attribute_id']; ?>_FROM" value="<?php if(isset($_REQUEST['arFilter_S_'.$filter['attribute_id'].'_FROM'])){echo $_REQUEST['arFilter_S_'.$filter['attribute_id'].'_FROM'];}else{echo $filter['text']['min'];}?>" id="arFilter_S_<?php echo $filter['attribute_id'];?>_FROM">
						</div>
						<div class="art6-filter__form-box__params-item art6-filter__form-box__params-item--to">
							<label for="arFilter_S_<?php echo $filter['attribute_id']; ?>_TO" class="art6-filter__form-box__params-item__title">До</label>
							<input type="text" name="arFilter_S_<?php echo $filter['attribute_id']; ?>_TO" value="<?php if(isset($_REQUEST['arFilter_S_'.$filter['attribute_id'].'_TO'])){echo $_REQUEST['arFilter_S_'.$filter['attribute_id'].'_TO'];}else{echo $filter['text']['max'];}?>" id="arFilter_S_<?php echo $filter['attribute_id']; ?>_TO">
						</div>
					</div>
					<div class="art6-filter__form-box__slider" data-min="<?php echo $filter['text']['min']; ?>" data-max="<?php echo $filter['text']['max']; ?>">
						<div class="art6-filter__form-box__slider-before"></div>
						<div class="art6-filter__form-box__slider-after"></div>
						<div class="art6-filter__form-box__slider-buttons">
							<span class="art6-filter__form-box__slider-buttons__from"></span>
							<span class="art6-filter__form-box__slider-buttons__to"></span>
						</div>
						<div class="art6-filter__form-box__slider-text">
							<span class="art6-filter__form-box__slider-text__from"><?php echo $filter['text']['min']; ?></span>
							<span class="art6-filter__form-box__slider-text__to"><?php echo $filter['text']['max']; ?></span>
						</div>
					</div>
				</div>
			<?php elseif ($filter['view'] == "C"):?>
				<div class="art6-filter__form-box art6-filter__form-box--check">
					<?php if ($filter['open_filter']) { ?>
					<div class="art6-filter__form-box__title active"><?php echo $filter['name']; ?></div>
					<div class="art6-filter__form-box__params">
					<?php } else { ?>
					<div class="art6-filter__form-box__title"><?php echo $filter['name']; ?></div>
					<div class="art6-filter__form-box__params art6-filter__form-box__params--hidden">
					<?php } ?>
						<?php foreach($filter['text'] as $key => $text) { ?>
							<div class="art6-filter__form-box__params-item<?php echo $filter['active'][$key]?>">
								<label for="arFilter_C_<?php echo $filter['attribute_id']?>_<?php echo $key?>" class="art6-filter__form-box__params-item__title"><?php echo $text; ?></label>
								<input type="checkbox" name="arFilter_C_<?php echo $filter['attribute_id']?>_<?php echo $key?>" value="<?php echo $text?>" id="arFilter_C_<?php echo $filter['attribute_id']?>_<?php echo $key?>"<?php echo ($filter['active'][$key] ?' checked="checked"' :''); ?>>
							</div>
						<?php } ?>
					</div>
				</div>
			<?php elseif ($filter['view'] == "C_h"):?>
				<div class="art6-filter__form-box art6-filter__form-box--check">
					<?php if ($filter['open_filter']) { ?>
					<div class="art6-filter__form-box__title active"><?php echo $filter['name']; ?></div>
					<div class="art6-filter__form-box__params">
					<?php } else { ?>
					<div class="art6-filter__form-box__title"><?php echo $filter['name']; ?></div>
					<div class="art6-filter__form-box__params art6-filter__form-box__params--hidden">
					<?php } ?>
						<?php foreach($filter['text'] as $key => $text) { ?>
							<div class="art6-filter__form-box__params-item<?php echo $filter['active'][$key]?> horizontal">
								<label for="arFilter_C_<?php echo $filter['attribute_id']; ?>_<?php echo $key; ?>" class="art6-filter__form-box__params-item__title"><?php echo $text; ?></label>
								<input type="checkbox" name="arFilter_C_<?php echo $filter['attribute_id']; ?>_<?php echo $key; ?>" value="<?php echo $text; ?>" id="arFilter_C_<?php echo $filter['attribute_id']; ?>_<?php echo $key; ?>"<?php echo ($filter['active'][$key] ?' checked="checked"' :''); ?>>
							</div>
						<?php } ?>
					</div>
				</div>
			<?php elseif ($filter['view'] == "checkbox"):?>
				<div class="art6-filter__form-box art6-filter__form-box--check">
					<?php if ($filter['open_filter']) { ?>
					<div class="art6-filter__form-box__title active"><?php echo $filter['name']; ?></div>
					<div class="art6-filter__form-box__params">
					<?php } else { ?>
					<div class="art6-filter__form-box__title"><?php echo $filter['name']; ?></div>
					<div class="art6-filter__form-box__params art6-filter__form-box__params--hidden">
					<?php } ?>
						<?php foreach($filter['text'] as $key => $text) { ?>
							<div class="art6-filter__form-box__params-item<?php echo $filter['active'][$key]?>">
								<label for="arFilter_O_<?php echo $filter['option_group_id']; ?>_<?php echo $key; ?>" class="art6-filter__form-box__params-item__title"><?php echo $text; ?></label>
								<input type="checkbox" name="arFilter_O_<?php echo $filter['option_group_id']; ?>_<?php echo $key; ?>" value="<?php echo $text; ?>" id="arFilter_O_<?php echo $filter['option_group_id']; ?>_<?php echo $key; ?>"<?php echo ($filter['active'][$key] ?' checked="checked"' :''); ?>>
							</div>
						<?php } ?>
					</div>
				</div>
			<?php elseif ($filter['view'] == "Sel"):?>
				<div class="art6-filter__form-box art6-filter__form-box--select">
					<div class="art6-filter__form-box__title"><?php echo $filter['name']; ?></div>
				
					<div class="art6-filter__form-box__params">
						<div class="art6-filter__form-box__params-item">
							<label class="art6-filter__form-box__params-item__title">Выберете нужное</label>
							<input type="checkbox" checked="checked" name="" value="">
						</div>
						<?php $i = 0; foreach($filter['text'] as $key => $text) { ?>
							<?php if($filter['active'][$key]) { ?>
							<div class="art6-filter__form-box__params-item<?php echo $filter['active'][$key]; ?>">
								<label for="arFilter_C_<?php echo $filter['attribute_id']; ?>_<?php echo $key; ?>" class="art6-filter__form-box__params-item__title"><?php echo $text; ?></label>
								<input type="checkbox" checked="checked" name="arFilter_C_<?php echo $filter['attribute_id']; ?>_<?php echo $key; ?>" value="<?php echo $text?>" id="arFilter_C_<?php echo $filter['attribute_id']; ?>_<?php echo $key; ?>">
							</div>
							<?php } else { ?>
							<div class="art6-filter__form-box__params-item">
								<label for="arFilter_C_<?php echo $filter['attribute_id']; ?>_<?php echo $key; ?>" class="art6-filter__form-box__params-item__title"><?php echo $text; ?></label>
								<input type="checkbox" name="arFilter_C_<?php echo $filter['attribute_id']; ?>_<?php echo $key; ?>" value="<?php echo $text?>" id="arFilter_C_<?php echo $filter['attribute_id']; ?>_<?php echo $key; ?>"<?php echo ($filter['active'][$key] ?' checked="checked"' :''); ?>>
							</div>
							<?php } ?>
						<?php $i++; } ?>
					</div>
				</div>
			<?php elseif ($filter['view'] == "Col"):?>
				<div class="art6-filter__form-box art6-filter__form-box--check art6-filter__form-box--color">
					<?php if ($filter['open_filter']) { ?>
					<div class="art6-filter__form-box__title active"><?php echo $filter['name']; ?></div>
					<div class="art6-filter__form-box__params">
					<?php } else { ?>
					<div class="art6-filter__form-box__title"><?php echo $filter['name']; ?></div>
					<div class="art6-filter__form-box__params art6-filter__form-box__params--hidden">
					<?php } ?>
						<?php foreach($filter['text'] as $key => $text) { ?>
							<div class="art6-filter__form-box__params-item<?php echo $filter['active'][$key]?>">
								<style>label[for="arFilter_C_<?php echo $filter['attribute_id']?>_<?php echo $key?>"]::before { background-color: <?php echo $filter['color'][$key]; ?>!important; }</style>
								<label for="arFilter_C_<?php echo $filter['attribute_id']?>_<?php echo $key?>" class="art6-filter__form-box__params-item__title"><?php echo $text; ?></label>
								<input type="checkbox" name="arFilter_C_<?php echo $filter['attribute_id']?>_<?php echo $key?>" value="<?php echo $text?>" id="arFilter_C_<?php echo $filter['attribute_id']?>_<?php echo $key?>"<?php echo ($filter['active'][$key] ?' checked="checked"' :''); ?>>
							</div>
						<?php } ?>
					</div>
				</div>
			<?php endif; ?>
		<?php } ?>

		<div class="art6-filter__form-box art6-filter__form-box--buttons">
			<a href="<?php echo $clear?>" class="art6-filter__form-box__button-reset"><?php echo $button_clear; ?></a>
			<button type="submit" name="set_filter" class="art6-filter__form-box__button-submit" value="Y"><?php echo $button_filter; ?></button>
		</div>
	</form>
</div>
<?php endif; ?>