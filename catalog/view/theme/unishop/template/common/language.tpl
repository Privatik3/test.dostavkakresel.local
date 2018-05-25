<?php if (count($languages) > 1) { ?>
<div class="pull-right">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language">
  <div class="btn-group">
    <button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
    <?php foreach ($languages as $language) { ?>
    <?php if ($language['code'] == $code) { ?>
	<i class="fa fa-globe" aria-hidden="true" title="<?php echo $language['name']; ?>"></i>
	<?php } ?>
    <?php } ?>
    <span class="hidden-xs"><?php echo $text_language; ?></span> <i class="fa fa-caret-down"></i></button>
    <ul class="dropdown-menu dropdown-menu-right">
      <?php foreach ($languages as $language) { ?>
      <li><a data-code="<?php echo $language['code']; ?>">
		<?php if(VERSION >= 2.2) { ?>
			<img src="<?php echo HTTPS_SERVER; ?>catalog/language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>">
			<?php echo $language['name']; ?>
		<?php } else { ?>
			<img src="<?php echo HTTPS_SERVER; ?>image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>">
			<?php echo $language['name']; ?>
		<?php } ?>
	  </a></li>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
</div>
<?php } ?>