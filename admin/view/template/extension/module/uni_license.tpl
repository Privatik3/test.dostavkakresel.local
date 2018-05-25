<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
<div class="page-header">
<div class="container-fluid">
<div class="pull-right"></div>
<h1><?php echo $heading_title; ?></h1>
<div></div>
<ul class="breadcrumb">
<?php foreach ($breadcrumbs as $breadcrumb) { ?>
<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
<?php } ?>
</ul>
</div>
</div>
<div class="container-fluid">
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<style>
.content_new {line-height:1.7em;font-size:1.1em; background:#eee; padding:15px; border:solid 1px #ddd; border-radius:4px;}
.content_new > div {font-weight:700;color:#f00;}
#copyright {clear:both;text-align:left;}
</style>
<link href="view/stylesheet/unishop.css" property="stylesheet" rel="stylesheet" type="text/css" media="screen" />
<div id="module" class="content content_new">
<div>Ошибка! Дополнение не активировано.</div>
Для активации дополнения вам необходимо отправить в личные сообщения письмо с указанием <b>номера заказа</b> и <b>домена</b>, где работает (будет работать) дополнение.<br />
После проверки отправленных вами данных активация произведётся автоматически в течении 5-10 минут.
<div style="margin:5px 0 0;"></div>
<a class="button btn btn-primary" onclick="window.location.reload();">Обновить страницу</a>
</div>
</div>
</div>
<?php echo $footer; ?>