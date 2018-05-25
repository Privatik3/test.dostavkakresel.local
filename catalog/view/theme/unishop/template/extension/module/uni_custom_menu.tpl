<?php if($head){ ?><h3 class="heading"><span><?php echo $head; ?></span></h3><?php } ?>
<?php if ($custom_menu) { ?>
	<div class="row">
			<div id="custom_menu" class="col-xs-12">
				<ul class="nav navbar-nav">
					<?php foreach($custom_menu as $menu){ ?>
					<?php if (in_array($menu['id'], $in_module)) { ?>					
						<?php if($menu['sub_menu']){ ?>
							<li class="has_chidren">
								<a href="<?php echo $menu['link'] ?>">
									<?php if($menu['image']) { ?><img src="<?php echo $menu['image']; ?>" alt="<?php echo $menu['name']; ?>" /><?php } ?>
									<?php echo $menu['name']; ?> <i class="fa fa-chevron-down" aria-hidden="true"></i>
								</a>
								<div class="dropdown-menu">
									<div class="dropdown-inner <?php echo $menu['name']; echo count($menu['sub_menu']); echo $menu['column'];  ?>">
										<?php foreach (array_chunk($menu['sub_menu'], ceil(count($menu['sub_menu']) / $menu['column'])) as $children) { ?>
											<ul class="list-unstyled <?php if ($menu['column']) {echo 'column';} ?>">
												<?php foreach ($children as $child) { ?>
													<li>
														<a href="<?php echo $child['link']; ?>"><i class="fa fa-level-up visible-xs visible-sm" aria-hidden="true"></i><?php echo $child['name']; ?></a>
														<?php if ($child['sub_menu']) { ?>
															<div class="dropdown-menu">
																<div class="dropdown-inner">
																	<ul class="list-unstyled">
																		<?php foreach ($child['sub_menu'] as $child) { ?>
																			<li><a href="<?php echo $child['link']; ?>"><i class="fa fa-level-up visible-xs visible-sm" aria-hidden="true"></i><?php echo $child['name']; ?></a></li>
																		<?php } ?>
																	</ul>
																</div>
															</div>
														<?php } ?>
													</li>
												<?php } ?>
											</ul>
										<?php } ?>
									</div>
								</div>
							</li>
						<?php } else { ?>
							<li>
								<a href="<?php echo $menu['link']; ?>">
									<?php if($menu['image']) { ?><img src="<?php echo $menu['image']; ?>" alt="<?php echo $menu['name']; ?>" /><?php } ?>
									<?php echo $menu['name']; ?>
								</a>
							</li>
						<?php } ?>
					<?php } ?>
					<?php } ?>
				</ul>
			</div>
	</div>
<?php } ?>