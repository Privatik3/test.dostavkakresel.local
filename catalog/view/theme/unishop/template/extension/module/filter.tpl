<h3 class="heading"><span><?php echo $heading_title; ?></span></h3>
<div id="filter_default" class="panel panel-default">
    <?php foreach ($filter_groups as $filter_group) { ?>
    <h5 class="heading"><span><?php echo $filter_group['name']; ?></span></h5>
      <div id="filter-group<?php echo $filter_group['filter_group_id']; ?>">
        <?php foreach ($filter_group['filter'] as $filter) { ?>
        <div class="checkbox">
          <label>
            <?php if (in_array($filter['filter_id'], $filter_category)) { ?>
            <input type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" checked="checked" id="<?php echo $filter_group['filter_group_id']; ?>_<?php echo $filter['filter_id']; ?>" />
            <label for="<?php echo $filter_group['filter_group_id']; ?>_<?php echo $filter['filter_id']; ?>"></label>
			<?php echo $filter['name']; ?>
            <?php } else { ?>
            <input type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" id="<?php echo $filter_group['filter_group_id']; ?>_<?php echo $filter['filter_id']; ?>" />
			<label for="<?php echo $filter_group['filter_group_id']; ?>_<?php echo $filter['filter_id']; ?>"></label>
            <?php echo $filter['name']; ?>
            <?php } ?>
          </label>
        </div>
        <?php } ?>
      </div>
    <?php } ?>
  <div class="panel-footer text-right">
    <button type="button" id="button-filter" class="btn btn-default btn-xs"><?php echo $button_filter; ?></button>
  </div>
</div>
<script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	filter = [];

	$('input[name^=\'filter\']:checked').each(function(element) {
		filter.push(this.value);
	});

	location = '<?php echo $action; ?>&filter=' + filter.join(',');
});
//--></script>
