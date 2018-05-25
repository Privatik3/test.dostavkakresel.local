<?php
/**
* @version     1.6.0
* @module      WebRotate 360 Product Viewer for OpenCart
* @author      WebRotate 360 LLC
* @copyright   Copyright (C) 2016 WebRotate 360 LLC. All rights reserved.
* @license     GNU General Public License version 2 or later (http://www.gnu.org/copyleft/gpl.html).
*/
?>

<?php
    error_reporting(E_ALL);
    ini_set('display_errors', '1');
?>

<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" onclick="submitGrid(); $('#form-webrotate').submit();"  form="form-banner" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i>Edit WebRotate 360 Settings</h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-webrotate" class="form-horizontal">
                    <div class="alert alert-info">
                        <i class="fa fa-info-circle"></i>&nbsp;&nbsp;&nbsp;Review the usage details <a href="http://www.webrotate360.com/products/cms-and-e-commerce-plugins/plugin-for-opencart.aspx" target="_blank" class="alert-link">here</a> or hover over the field names on the left to see additional information.
                    </div>
                    <fieldset>
                        <legend>General viewer settings</legend>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="webrotate360_status">
                               Module Enabled
                            </label>
                            <div class="col-sm-10">
                                <select name="webrotate360_status" class="form-control">
                                    <?php if ($webrotate360_status) { ?>
                                        <option value="1" selected="selected">Enabled</option>
                                        <option value="0">Disabled</option>
                                    <?php } else { ?>
                                        <option value="1">Enabled</option>
                                        <option value="0" selected="selected">Disabled</option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="divID">
                                <span data-toggle="tooltip" title="Class or id of an existing HTML element on a product page. #wr360embed is a default auto-created by webrotate vQmod when used with the default OpenCart v2.x template. If not using our def_product vQmod or if it doesn't work with your theme, enter an id or class of an existing product page element here. The module will replace any content under this element for configured products (see the table below).">Placeholder</span>
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="webrotate360_divID" id="divID" value="<?php echo $webrotate360_divID; ?>">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="viewerWidth">
                                <span data-toggle="tooltip" title="Viewer width in pixel or %. Popup mode requires pixel width (e.g 600px).">Width</span>
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="webrotate360_viewerWidth" id="viewerWidth" value="<?php echo $webrotate360_viewerWidth; ?>">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="viewerHeight">
                                <span data-toggle="tooltip" title="Viewer height in pixel (e.g 500px). If Base Width is configured below, the height will scale responsively.">Height</span>
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="webrotate360_viewerHeight" id="viewerHeight" value="<?php echo $webrotate360_viewerHeight; ?>">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="baseWidth">
                                <span data-toggle="tooltip" title="Original viewer width in pixel. If specified, this forces the viewer to scale its height relative to your original viewer width (Base Width). This setting only applies when viewer width is relative (%) which is not supported in the popup mode.">Base Width</span>
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="webrotate360_baseWidth" id="baseWidth" value="<?php echo $webrotate360_baseWidth; ?>">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="minHeight">
                                <span data-toggle="tooltip" title="If Base Width is configured, this is a minimum viewer height in pixel (e.g 300px).">Minimum Height</span>
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="webrotate360_minHeight" id="minHeight" value="<?php echo $webrotate360_minHeight; ?>">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="viewerInPopup">
                                <span data-toggle="tooltip" title="In the popup mode, a small thumbnail graphic is inserted inside the placeholder which activates a popup with a product view on click. Popup Gallery below should not be set to disabled for this to work. If using module's def_product vQmod, checking this setting will add an extra clickable thumbnail into the product gallery.
                                Demo thumb image is 74x74 by default and is located under /catalog/view/javascript/webrotate360 as 360thumb.png.">In Popup</span>
                            </label>
                            <div class="col-sm-10">
                                <select name="webrotate360_viewerInPopup" class="form-control" id="viewerInPopup">
                                    <?php if ($webrotate360_viewerInPopup) { ?>
                                        <option value="1" selected="selected">Yes</option>
                                        <option value="0">No</option>
                                    <?php } else { ?>
                                        <option value="1">Yes</option>
                                        <option value="0" selected="selected">No</option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="skinCSS">
                                <span data-toggle="tooltip" title="Selection of default viewer skins.">Viewer Skin</span>
                            </label>
                            <div class="col-sm-10">
                                <?php
                                    $viewerSkins = array("basic", "thin", "round", "retina", "empty");
                                ?>
                                <select id="skinCSS" class="form-control" name="webrotate360_skinCSS">
                                    <?php foreach($viewerSkins as $skin):?>
                                        <?php $selected = ($webrotate360_skinCSS == $skin) ? 'selected="selected"' : '' ?>
                                        <option value="<?php echo $skin?>" <?php echo $selected ?> ><?php echo $skin ?></option>
                                    <?php endforeach?>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="popupSkin">
                                <span data-toggle="tooltip" title="Choose one of the popup skins to enable the popup gallery. If enabled, the popup will be used for all of your product images if webrotate def_product vQmod is present (for compatible themes). Should not be disabled if 360 view is configured to launch inside the popup, i.e when In Popup is selected.">Popup Gallery</span>
                            </label>
                            <div class="col-sm-10">
                                <?php
                                    $popupSkins = array("disabled", "default", "light_rounded", "dark_rounded", "dark_square", "light_square", "facebook");
                                ?>
                                <select id="popupSkin" class="form-control" name="webrotate360_prettyPhotoSkin">
                                    <?php foreach($popupSkins as $skin):?>
                                        <?php $selected = ($webrotate360_prettyPhotoSkin == $skin) ? 'selected="selected"' : '' ?>
                                        <option value="<?php echo $skin?>" <?php echo $selected ?> ><?php echo $skin ?></option>
                                    <?php endforeach?>
                                </select>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset>
                        <legend>Miscellaneous</legend>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="useAnalytics">
                                <span data-toggle="tooltip" title="If Google Analytics is integrated in your store, this enables tracking of the viewer analytics events under your Google Analytics Dashboard (PRO and Enterprise).">Use Analytics (PRO)</span>
                            </label>
                            <div class="col-sm-10">
                                <select name="webrotate360_useAnalytics" class="form-control" id="useAnalytics">
                                    <?php if ($webrotate360_useAnalytics) { ?>
                                        <option value="1" selected="selected">Yes</option>
                                        <option value="0">No</option>
                                    <?php } else { ?>
                                        <option value="1">Yes</option>
                                        <option value="0" selected="selected">No</option>
                                    <?php } ?>
                                </select>
                             </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="apiCallback">
                                <span data-toggle="tooltip" title="To integrate with viewer API, enter the name of your JavaScript callback. The callback receives two parameters, e.g rotatorCallback(apiObj, isFullScreen). Only works when In Popup is not selected.">API Callback</span>
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="webrotate360_apiCallback" id="apiCallback" value="<?php echo $webrotate360_apiCallback; ?>">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="configFileURL">
                                <span data-toggle="tooltip" title="Master Config optionally allows having a single viewer (xml) configuration file for all 360 views in you store and only supply a URL path to the images folder of each product via Root Path in the table below. Root Path can point to an external server, CDN, etc. To activate, enter a URL of your master config (xml) file.">Master Config (PRO)</span>
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="webrotate360_configFileURL" id="configFileURL" value="<?php echo $webrotate360_configFileURL; ?>">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="licensePath">
                                <span data-toggle="tooltip" title="URL of license.lic on this server. The file is provided upon purchase. Use relative URL if your website doesn't always redirect to www (or no www).">License Path</span>
                            </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="webrotate360_licensePath" id="licensePath" value="<?php echo $webrotate360_licensePath; ?>">
                            </div>
                        </div>
                    </fieldset>
                    <fieldset>
                        <legend>Configure product views</legend>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="grid_custom_editing">
                                <span data-toggle="tooltip" title="Download our desktop software and publish 360 or 3D product views using your images then upload the published output to your OpenCart FTP. You only need to upload a single folder located under published/360_assets of your published SpotEditor project for each product view. Enter an absolute or relative URL of uploaded viewer configuration file (your-name.xml located under 360_assets/your-name) in the table below under Config File URL.">Products</span>
                            </label>
                            <div class="col-sm-10">
                                <div id="grid_custom_editing"></div>
                                <input type="hidden" id="submitProducts" name="submitProducts"/>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="./view/javascript/webrotate360/pqgrid/jquery-ui.min.js"></script>
<script type="text/javascript" src="./view/javascript/webrotate360/pqgrid/pqgrid.min.js"></script>
<link rel="stylesheet" href="./view/javascript/webrotate360/pqgrid/jquery-ui.css" />
<link rel="stylesheet" href="./view/javascript/webrotate360/pqgrid/themes/peach/pq-grid.css" />
<link rel="stylesheet" href="./view/javascript/webrotate360/pqgrid/pqgrid.css" />

<style type="text/css">

    #grid_custom_editing
    {
        margin: 1px auto 0 auto;
    }

    div.pq-grid *
    {
        font-family:'Open Sans', sans-serif;
        color:#666;
    }

	div.pq-grid-toolbar-search
    {
        text-align:left;
    }

    div.pq-grid-toolbar-search *
    {
        margin:1px 5px 1px 0;
        vertical-align:middle;       
    }

    div.pq-grid-toolbar-search .pq-separator
    {
       margin-left:10px;   
       margin-right:10px;   
    }

    div.pq-grid-toolbar-search select
    {
        height:18px;    
        position:relative;
    }

    div.pq-grid-toolbar-search input.pq-search-txt
    {
        width:180px;
        border:1px solid #b5b8c8;
        height:16px;
        padding:0 5px;
    }

    .pq-grid-header td
    {
        border:none;
    }

    div.pq-cell-selected-border
    {
        border-width:1px;
    }

    div.pq-grid-title
    {
        display: none;
    }

    div.panel-body .ui-corner-all,
    div.pq-grid .ui-corner-top,
    div.pq-grid .ui-corner-left,
    div.pq-grid .ui-corner-bottom,
    div.pq-grid .ui-corner-right
    {
        border-radius:0;
    }
</style>

<script type="text/javascript"><!--
    var COL_PRODUCT_ID = 0;
    var COL_NAME = 1;
    var COL_WR360_ENABLED = 2;
    var COL_CONFIG_FILE_URL = 3;
    var COL_ROOT_PATH = 4;
    var COL_MODIFIED = 5;
    var GRID_ELEMENT_NAME = "div#grid_custom_editing";

    $(document).ready(function (e){
     
        var pqSearch = {
            txt: "",
            rowIndices: [],
            curIndx: null,
            colIndx: 0,
            sortIndx: null,
            sortDir:null,
            results: null,

            prevResult: function () {
                var colIndx = this.colIndx,
                    rowIndices = this.rowIndices;
                if (rowIndices.length == 0) {
                    this.curIndx = null;
                }
                else if (this.curIndx == null || this.curIndx == 0) {
                    this.curIndx = rowIndices.length - 1;
                }
                else {
                    this.curIndx--;
                }
                this.updateSelection(colIndx);
            },
			
            nextResult: function () {
                var rowIndices = this.rowIndices;
                if (rowIndices.length == 0) {
                    this.curIndx = null;
                }
                else if (this.curIndx == null) {
                    this.curIndx = 0;
                }
                else if (this.curIndx < rowIndices.length - 1) {
                    this.curIndx++;
                }
                else {
                    this.curIndx = 0;
                }
                this.updateSelection();
            },
			
            updateSelection: function () {
                var colIndx = this.colIndx,
                    curIndx = this.curIndx,
                    rowIndices = this.rowIndices;
                if (rowIndices.length > 0) {
                    this.results.html("Selected " + (curIndx + 1) + " of " + rowIndices.length + " match(es).");
                }
                else {
                    this.results.html("Nothing found.");
                }
                wr360grid.pqGrid("setSelection", null);
                wr360grid.pqGrid("setSelection", { rowIndx: rowIndices[curIndx], colIndx: colIndx });
            },
			
            search: function () {
                var txt = $("input.pq-search-txt").val().toUpperCase(),
                    colIndx = $("select#pq-crud-select-column").val(),
                    DM = wr360grid.pqGrid("option", "dataModel"),
                    sortIndx = DM.sortIndx,
                    sortDir = DM.sortDir;
                if (txt == this.txt && colIndx == this.colIndx && sortIndx == this.sortIndx && sortDir == this.sortDir) {
                    return;
                }
                this.rowIndices = [], this.curIndx = null;
                this.sortIndx = sortIndx;
                this.sortDir = sortDir;
                if (colIndx != this.colIndx) {
                    wr360grid.pqGrid("option", "customData", null);
                    wr360grid.pqGrid("refreshColumn", { colIndx: this.colIndx });
                    this.colIndx = colIndx;
                }

                if (txt != null && txt.length > 0) {
                    txt = txt.toUpperCase();

                    var data = DM.data;
                    for (var i = 0; i < data.length; i++) {
                        var row = data[i];
                        var cell = row[this.colIndx].toUpperCase();
                        if (cell.indexOf(txt) != -1) {
                            this.rowIndices.push(i);
                        }
                    }
                }
                wr360grid.pqGrid("option", "customData", { foundRowIndices: this.rowIndices, txt: txt, searchColIndx: colIndx });
                wr360grid.pqGrid("refreshColumn", { colIndx: colIndx });
                this.txt = txt;
            },
			
            render: function (ui) {
                var rowIndxPage = ui.rowIndxPage,
                rowIndx = ui.rowIndx,
                rowData=ui.rowData,
                dataIndx = ui.dataIndx,
                colIndx = ui.colIndx,
                val = rowData[dataIndx];

                if (ui.customData) {
                    var rowIndices = ui.customData.foundRowIndices,
                    searchColIndx = ui.customData.searchColIndx,
                    txt = ui.customData.txt,
                    txtUpper = txt.toUpperCase(),
                    valUpper = val.toUpperCase();
                    if ($.inArray(rowIndx, rowIndices) != -1 && colIndx == searchColIndx) {
                        var indx = valUpper.indexOf(txtUpper);
                        if (indx >= 0) {
                            var txt1 = val.substring(0, indx);
                            var txt2 = val.substring(indx, indx + txt.length);
                            var txt3 = val.substring(indx + txt.length);
                            return txt1 + "<span style='background:yellow;color:#333;'>" + txt2 + "</span>" + txt3;
                        }
                        else {
                            return val;
                        }
                    }
                }
                return val;
            }
        }

        var dropDownEditor = function (ui, arr) {
            var $cell = ui.$cell, data = ui.data, rowIndx = ui.rowIndxPage, colIndx = ui.colIndx;
            var dataCell = $.trim(data[rowIndx][colIndx]);
            var str = "";
            for (var i = 0; i < arr.length; i++) {
                if (dataCell == arr[i])
                    str += "<option selected>" + arr[i] + "</option>";
                else
                    str += "<option>" + arr[i] + "</option>";
            }
            var $sel = $("<select>" + str + "</select>")
            .appendTo($cell);
        }
		
        var saveDropdownCell = function (ui) {
            var editCellData = ui.$cell.children().val();
            return editCellData;
        }
		
        var saveEditCell = function (ui) {
            var text = ui.$cell.children().html();
            return trimAllTrailingBRs(text);
        }

        var colM = [
            { title: "ID", width: 10, editable:false, render: function (ui) {return pqSearch.render(ui);} },
            { title: "Name", width: 200, editable:false, render: function (ui) {return pqSearch.render(ui);} },
            { title: "Enabled", width: 70,
                editor: function (ui) {
                    var arr = ['Yes', 'No'];
                    dropDownEditor(ui, arr);
                },
                getEditCellData: saveDropdownCell,
                render: function (ui) {return pqSearch.render(ui);}
            },
            { title: "Config File URL", width: 300, render: function (ui) {return pqSearch.render(ui);}
                ,getEditCellData: saveEditCell
            },
            { title: "Root Path (PRO only)", width: 300, render: function (ui) {return pqSearch.render(ui);}
                ,getEditCellData: saveEditCell
            }
        ];

        var dataModel = {
            location: "local",
            sorting: "local",
            sortIndx: 0,
            sortDir: "up",
            paging: "local",
            rPPOptions: [10, 20, 50],
            curPage: 1,
            rPP: 20
        }

        var newObj = {
            width: "100%",
            height: 630,
            dataModel: dataModel,            
            colModel: colM,
            selectionModel: { type: 'cell' },     
            editModel: { saveKey: '13' },
            columnBorders: true,
            numberCell: false,
            scrollModel:{pace: 'fast', horizontal: false}
        };
        
        var wr360grid = $(GRID_ELEMENT_NAME);
        
        wr360grid.on("pqgridrender", function (evt, obj) {
            var $toolbar = $("<div class='pq-grid-toolbar pq-grid-toolbar-search'></div>").appendTo($(".pq-grid-top", this));

            $("<span>Search</span>").appendTo($toolbar);

            $("<input type='text' class='pq-search-txt'/>").appendTo($toolbar).keyup(function (evt) {
                pqSearch.search();
                if (evt.keyCode == 38) {
                    pqSearch.prevResult();
                }
                else {
                    pqSearch.nextResult();
                }
            });

            $("<select id='pq-crud-select-column'>\
                <option value='0'>ID</option>\
                <option value='1' selected>Name</option>\
                <option value='2'>Enabled</option>\
                <option value='3'>Config File URL</option>\
                <option value='4'>Root Path</option>\
                </select>").appendTo($toolbar).change(function () {
                    pqSearch.search();
                    pqSearch.nextResult();
                });
				
            $("<span class='pq-separator'></span>").appendTo($toolbar);

            $("<button title='Previous Result'></button>")
				.appendTo($toolbar)
				.button({ icons: { primary: "ui-icon-circle-triangle-w" }, text: false }).bind("click", function (evt) {
					pqSearch.prevResult();
					return false;
				});
					
            $("<button title='Next Result'></button>")
				.appendTo($toolbar)
				.button({ icons: { primary: "ui-icon-circle-triangle-e" }, text: false }).bind("click", function (evt) {
					pqSearch.nextResult();
					return false;
				});
					
            $("<span class='pq-separator'></span>").appendTo($toolbar);

            pqSearch.results = $("<span class='pq-search-results'>Nothing found.</span>").appendTo($toolbar);
        });
        
        wr360grid.on("pqgridsort", function (evt, obj) {
            pqSearch.search();
            pqSearch.nextResult();
        });
        
        wr360grid.on("pqgridrowselect pqgridcellselect", function (evt, obj) {
            if (evt.originalEvent && evt.originalEvent.type == "click") {
                if (pqSearch.rowIndices.length > 0) {
                    pqSearch.results.html(pqSearch.rowIndices.length + " match(es).");
                }
            }
        });
                
        wr360grid.on("pqgridquiteditmode", function (evt, ui) {
            // Exclude esc and tab:
            if (evt.keyCode != 27 && evt.keyCode != 9) {
                wr360grid.pqGrid("saveEditCell");
            }
        });
		
        wr360grid.on("pqgridcellsave", function (evt, ui) {
            var data = ui.data, rowIndxPage = ui.rowIndxPage, dataIndx = ui.dataIndx, val = data[rowIndxPage][dataIndx];
            var productID = data[rowIndxPage][0];
            var dataModel = $(GRID_ELEMENT_NAME).pqGrid( "option", "dataModel" )
            $.each(dataModel.data, function(_ind, _data) {
                if (_data[COL_PRODUCT_ID] == productID) {
                    _data[COL_MODIFIED] = "1";
                    return false;
                }
            });
        });
        
        wr360grid.mouseleave(function (e) {
            wr360grid.pqGrid("saveEditCell");
        });

        $.getJSON("index.php?route=extension/module/webrotate360/getproducts&token=<?php echo $token; ?>",
            function(data){
                var arrProducts = [];
                $.each(data, function (index, value) {
                    var product = [];
                    $.each(value, function (ind, val) {
                        product.push(val);
                    });
                    arrProducts.push(product);
                });
                dataModel.data = arrProducts;
                wr360grid.pqGrid(newObj);
            }
        );
    });

    function submitGrid() {
        var submitValue = "";
        var productAdded = false;
        var dataModel = $(GRID_ELEMENT_NAME).pqGrid( "option", "dataModel" ); 
        $.each(dataModel.data, function(_ind, _data) {
            if (_data[COL_MODIFIED] == "1") {
                submitValue += '{"product_id":"' + _data[COL_PRODUCT_ID] + '",';
                submitValue += '"root_path":"' + trimAllTrailingBRs(_data[COL_ROOT_PATH]) + '",';
                submitValue += '"config_file_url":"' + trimAllTrailingBRs(_data[COL_CONFIG_FILE_URL]) + '",';
                submitValue += '"wr360_enabled":"' + _data[COL_WR360_ENABLED] + '"},';
            }
        });
        submitValue = submitValue.replace(/.$/, "");
        submitValue = "[" + submitValue + "]";
        $("#submitProducts").val(submitValue);
    }
    
    function trimAllTrailingBRs(str) {
        while (str.match(/<br>$/))
            str = str.replace(/<br>$/, "");
        return str;
    }
//-->
</script>

<?php echo $footer; ?>