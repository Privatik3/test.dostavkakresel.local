<h1><?php echo $heading_title; ?></h1>
<?php
foreach ($category_info as $category_info_item) {
    ?>
<div class="mainCat"></div>

<div class="col-md-4 mainCat-item">
    <div class="mainCat-item-pic">
        <a href="<?php echo $category_info_item['href']; ?>">
            <img src="<?php echo $category_info_item['img']; ?>" class="img-responsive thumbnail"
                 alt="<?php echo $category_info_item['name']; ?>">
        </a>

    </div>
    <div class="mainCat-item-subcat">
        <div class="mainCat-item-name">
            <b><a href="<?php echo $category_info_item['href'] ?>"><?php echo $category_info_item['name']; ?></a></b>
        </div>
        <div class="mainCat-item-subcat">
            <?php
        $i = 0;
        $slash = 0;
        if (isset($category_info_item['subcat'])) {
            foreach ($category_info_item['subcat'] as $category_info_itemSubcat) {
                if (count($category_info_item['subcat']) != $i + 1) $slash = 1; else $slash = 0;
                ?>
            <a href="<?php echo $category_info_itemSubcat['href']; ?>"><?php echo $category_info_itemSubcat['name']; ?></a> <?php if ($slash) echo '/'; ?>
            <?php
                $i++;
            }
            $i = 0;
        }
        ?>
        </div>
    </div>
</div>

<?php
}
?>
<div class="clearfix"></div>