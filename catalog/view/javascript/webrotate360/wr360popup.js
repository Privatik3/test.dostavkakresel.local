/**
* @version     1.6.0
* @module      WebRotate 360 Product Viewer for OpenCart
* @author      WebRotate 360 LLC
* @copyright   Copyright (C) 2016 WebRotate 360 LLC. All rights reserved.
* @license     GNU General Public License version 2 or later (http://www.gnu.org/copyleft/gpl.html).
*/

function wr360QueryGetParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}

jQuery(document).ready(function() {
    var popup360Elm = jQuery("#wr360PlayerId20");
    if (popup360Elm.length == 1) {
        var configHeight = parseInt(wr360QueryGetParameterByName("height"));
        var iframeHeight = configHeight;

        var iframeElm = jQuery("#wr360frame_id", window.parent.document);
        if (iframeElm.length > 0)
            iframeHeight = iframeElm.attr("height");

        var realHeight = (iframeHeight < configHeight) ? iframeHeight : configHeight;
        jQuery(".viewerbox").css("height", realHeight + "px");

        popup360Elm.rotator( {
            licenseFileURL: wr360QueryGetParameterByName("lic"),
            graphicsPath: wr360QueryGetParameterByName("grphpath"),
            configFileURL: wr360QueryGetParameterByName("config"),
            rootPath: wr360QueryGetParameterByName("root"),
            googleEventTracking: wr360QueryGetParameterByName("analyt") === "1"
        });
    }
});


