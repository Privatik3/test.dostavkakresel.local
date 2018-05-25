<?php if ($reviews) { ?>
	<?php foreach ($reviews as $review) { ?>
		<div class="review_list">
			<div class="name_date">
				<div class="name"><i class="fa fa-user" aria-hidden="true"></i><span><?php echo $review['author']; ?></span></div>
				<div class="rating">
					<?php for ($i = 1; $i <= 5; $i++) { ?>
						<?php if ($review['rating'] < $i) { ?>
							<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
						<?php } else { ?>
							<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
						<?php } ?>
					<?php } ?>
				</div>
				<div class="date"><?php echo $review['date_added']; ?></div>
			</div>
			<?php if($show_plus_minus_review && $review['plus']) { ?>
				<div class="plus">
					<div><i class="fa fa-plus" aria-hidden="true"></i><?php echo $text_plus; ?></div>
					<?php echo $review['plus']; ?>
				</div>
			<?php } ?>
			<?php if($show_plus_minus_review && $review['minus']) { ?>
				<div class="minus">
					<div><i class="fa fa-minus" aria-hidden="true"></i><?php echo $text_minus; ?></div>
					<?php echo $review['minus']; ?>
				</div>
			<?php } ?>
			<div class="comment">
				<?php if($show_plus_minus_review && $review['plus'] || $review['minus']) { ?><div><i class="fa fa-comment" aria-hidden="true"></i><?php echo $text_comment; ?></div><?php } ?>
				<?php echo $review['text']; ?>
			</div>
			<?php if (isset($review['admin_reply']) && $review['admin_reply'] != '') { ?> 
				<div class="admin_reply">
					<div><i class="fa fa-reply" aria-hidden="true"></i><span><?php echo $text_admin_reply; ?></span></div>
					<?php echo $review['admin_reply']; ?>
				</div>
			<?php } ?>
		</div>
	<?php } ?>
<?php } else { ?>
	<p><?php echo $text_no_reviews; ?></p>
<?php } ?>
<div class="review_pagination">
	<div class="text-right"><?php echo $pagination; ?></div>
	<div class="text-right"><button class="btn btn-primary" onclick="$('#form-review').slideToggle();"><?php echo $text_write; ?></button></div>
</div>
