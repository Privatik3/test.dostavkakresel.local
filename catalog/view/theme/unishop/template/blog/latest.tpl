<?php echo $header; ?>
<div class="container">
	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
		<div id="content" class="<?php echo $class; ?> showcase-list"><?php echo $content_top; ?>
		<h1><?php echo $heading_title; ?></h1>
			<?php if ($articles) { ?>
				<div class="row">
					<div class="col-xs-12"><hr /></div>
					<div class="col-xs-12 col-sm-4 col-md-3 col-lg-2 hidden-xs"></div>
					<div class="col-xs-6 col-sm-5 col-md-4 col-lg-4 col-md-offset-2 col-lg-offset-3 text-right">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-sort"></i><span class="hidden-xs hidden-sm hidden-md"><?php echo $text_sort; ?></span></span>
							<select id="input-sort" class="form-control" onchange="location = this.value;">
								<?php foreach ($sorts as $sorts) { ?>
									<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
										<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
									<?php } else { ?>
										<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="col-xs-6 col-sm-3 col-md-3 col-lg-3 text-right">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-eye"></i><span class="hidden-xs hidden-sm hidden-md"><?php echo $text_limit; ?></span></span>
							<select id="input-limit" class="form-control" onchange="location = this.value;">
								<?php foreach ($limits as $limits) { ?>
									<?php if ($limits['value'] == $limit) { ?>
										<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
									<?php } else { ?>
										<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
									<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="col-xs-12"><hr /></div>
				</div>
				<div class="row">  
					<div class="article_list">
						<?php foreach ($articles as $article) { ?>
							<div class="image_description row">
								<div class="image col-xs-12 col-sm-12 col-md-3"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" class="img-responsive" onclick="location='<?php echo $article['href']; ?>'" style="cursor:pointer" /></div>
								<div style="margin:0 0 10px" class="col-xs-12 visible-xs"></div>
								<div class="col-xs-12 col-sm-12 col-md-9">
									<h4 onclick="location='<?php echo $article['href']; ?>'" style="cursor:pointer"><?php echo $article['name']; ?></h4>
									<div class="description"><?php echo $article['description']; ?></div>
									<div class="row">
										<div class="col-xs-12"><hr /></div>
										<div class="col-xs-3"><a href="<?php echo $article['href']; ?>"><?php echo $button_more; ?></a></div>
										<div class="posted col-xs-9">
											<span><i class="fa fa-calendar" aria-hidden="true"></i><?php echo $article['date_added']; ?></span>
											<span><i class="fa fa-eye" aria-hidden="true"></i><?php echo $article['viewed']; ?></span>
										</div>
									</div>
								</div>
							</div>
							<hr />
						<?php } ?>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
					<!-- <div class="col-sm-6 text-right"><?php //echo $results; ?></div> -->
				</div>
			<?php } else { ?>
				<p><?php echo $text_empty; ?></p>
				<div class="buttons">
					<div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
				</div>
			<?php } ?>
			<?php echo $content_bottom; ?>
		</div>
		<?php echo $column_right; ?>
	</div>
</div>
<?php echo $footer; ?>