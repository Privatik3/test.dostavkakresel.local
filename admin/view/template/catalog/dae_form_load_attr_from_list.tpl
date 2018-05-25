<div class="modal-dialog" id="dae_form_load_attr_from_list">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h4 class="modal-title"><?php echo $dae_form_load_attr_from_list_title;?></h4>

    </div>

    <div class="modal-body">
      <table class="table">
        <?php foreach ($devos_attributes as $devos_attribute_group) { ?>
          <tr>
            <td><span style="cursor:pointer;" class = "dae_attribute_group_one" data-dae-attribute-group-id-one="<?php echo $devos_attribute_group['attribute_group_id']; ?>"><strong><?php echo $devos_attribute_group['attribute_group']; ?></strong></span></td>
            <td>
            <?php foreach ($devos_attribute_group['attributes'] as $devos_attribute) { ?>
              <span style="padding: 0px 3px;cursor:pointer;" class = "dae_attribute_one" data-dae-attribute-one="<?php echo $devos_attribute['attribute_id']; ?>" data-dae-attribute-group="<?php echo $devos_attribute_group['attribute_group']; ?>"><?php echo $devos_attribute['name']; ?></span><span>&bull;</span>
            <?php } ?>
            </td>
          </tr>
        <?php } ?>
        </table>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
    </div>
  </div>
</div>
<script>

</script>