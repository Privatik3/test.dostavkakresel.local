;(function($){var $window=$(window);var options={};var zindexvalues=[];var lastclicked=[];var scrollbarwidth;var bodymarginright=null;var opensuffix='_open';var closesuffix='_close';var stack=[];var transitionsupport=null;var opentimer;var iOS=/(iPad|iPhone|iPod)/g.test(navigator.userAgent);var methods={_init:function(el){var $el=$(el);var options=$el.data('popupoptions');lastclicked[el.id]=false;zindexvalues[el.id]=0;if(!$el.data('popup-initialized')){$el.attr('data-popup-initialized','true');methods._initonce(el)}if(options.autoopen){setTimeout(function(){methods.show(el,0)},0)}},_initonce:function(el){var $el=$(el);var $body=$('body');var $wrapper;var options=$el.data('popupoptions');var css;bodymarginright=parseInt($body.css('margin-right'),10);transitionsupport=document.body.style.webkitTransition!==undefined||document.body.style.MozTransition!==undefined||document.body.style.msTransition!==undefined||document.body.style.OTransition!==undefined||document.body.style.transition!==undefined;if(options.type=='tooltip'){options.background=false;options.scrolllock=false}if(options.backgroundactive){options.background=false;options.blur=false;options.scrolllock=false}if(options.scrolllock){var parent;var child;if(typeof scrollbarwidth==='undefined'){parent=$('<div style="width:50px;height:50px;overflow:auto"><div/></div>').appendTo('body');child=parent.children();scrollbarwidth=child.innerWidth()-child.height(99).innerWidth();parent.remove()}}if(!$el.attr('id')){$el.attr('id','j-popup-'+parseInt((Math.random()*100000000),10))}$el.addClass('popup_content');$body.prepend(el);$el.wrap('<div id="'+el.id+'_wrapper" class="popup_wrapper" />');$wrapper=$('#'+el.id+'_wrapper');$wrapper.css({opacity:0,visibility:'hidden',position:'absolute'});if(iOS){$wrapper.css('cursor','pointer')}if(options.type=='overlay'){$wrapper.css('overflow','auto')}$el.css({opacity:0,visibility:'hidden',display:'inline-block'});if(options.setzindex&&!options.autozindex){$wrapper.css('z-index','1001')}if(!options.outline){$el.css('outline','none')}if(options.transition){$el.css('transition',options.transition);$wrapper.css('transition',options.transition)}$el.attr('aria-hidden',true);if((options.background)&&(!$('#'+el.id+'_background').length)){$body.prepend('<div id="'+el.id+'_background" class="popup_background"></div>');var $background=$('#'+el.id+'_background');$background.css({opacity:0,visibility:'hidden',backgroundColor:options.color,position:'fixed',top:0,right:0,bottom:0,left:0});if(options.setzindex&&!options.autozindex){$background.css('z-index','1000')}if(options.transition){$background.css('transition',options.transition)}}if(options.type=='overlay'){$el.css({textAlign:'left',position:'relative',verticalAlign:'middle'});css={position:'fixed',width:'100%',height:'100%',top:0,left:0,textAlign:'center'};if(options.backgroundactive){css.position='relative';css.height='0';css.overflow='visible'}$wrapper.css(css);$wrapper.append('<div class="popup_align" />');$('.popup_align').css({display:'inline-block',verticalAlign:'middle',height:'100%'})}$el.attr('role','dialog');var openelement=(options.openelement)?options.openelement:('.'+el.id+opensuffix);$(openelement).each(function(i,item){$(item).attr('data-popup-ordinal',i);if(!item.id){$(item).attr('id','open_'+parseInt((Math.random()*100000000),10))}});if(!($el.attr('aria-labelledby')||$el.attr('aria-label'))){$el.attr('aria-labelledby',$(openelement).attr('id'))}if(options.action=='hover'){options.keepfocus=false;$(openelement).on('mouseenter',function(event){methods.show(el,$(this).data('popup-ordinal'))});$(openelement).on('mouseleave',function(event){methods.hide(el)})}else{$(document).on('click',openelement,function(event){event.preventDefault();var ord=$(this).data('popup-ordinal');setTimeout(function(){methods.show(el,ord)},0)})}if(options.closebutton){methods.addclosebutton(el)}if(options.detach){$el.hide().detach()}else{$wrapper.hide()}},show:function(el,ordinal){var $el=$(el);if($el.data('popup-visible'))return;if(!$el.data('popup-initialized')){methods._init(el)}$el.attr('data-popup-initialized','true');var $body=$('body');var options=$el.data('popupoptions');var $wrapper=$('#'+el.id+'_wrapper');var $background=$('#'+el.id+'_background');callback(el,ordinal,options.beforeopen);lastclicked[el.id]=ordinal;setTimeout(function(){stack.push(el.id)},0);if(options.autozindex){var elements=document.getElementsByTagName('*');var len=elements.length;var maxzindex=0;for(var i=0;i<len;i++){var elementzindex=$(elements[i]).css('z-index');if(elementzindex!=='auto'){elementzindex=parseInt(elementzindex,10);if(maxzindex<elementzindex){maxzindex=elementzindex}}}zindexvalues[el.id]=maxzindex;if(options.background){if(zindexvalues[el.id]>0){$('#'+el.id+'_background').css({zIndex:(zindexvalues[el.id]+1)})}}if(zindexvalues[el.id]>0){$wrapper.css({zIndex:(zindexvalues[el.id]+2)})}}if(options.detach){$wrapper.prepend(el);$el.show()}else{$wrapper.show()}opentimer=setTimeout(function(){$wrapper.css({visibility:'visible',opacity:1});$('html').addClass('popup_visible').addClass('popup_visible_'+el.id);$wrapper.addClass('popup_wrapper_visible')},20);if(options.scrolllock){$body.css('overflow','hidden');if($body.height()>$window.height()){$body.css('margin-right',bodymarginright+scrollbarwidth)}}if(options.backgroundactive){$el.css({top:($window.height()-($el.get(0).offsetHeight+parseInt($el.css('margin-top'),10)+parseInt($el.css('margin-bottom'),10)))/2+'px'})}$el.css({'visibility':'visible','opacity':1});if(options.background){$background.css({'visibility':'visible','opacity':options.opacity});setTimeout(function(){$background.css({'opacity':options.opacity})},0)}$el.data('popup-visible',true);methods.reposition(el,ordinal);$el.data('focusedelementbeforepopup',document.activeElement);if(options.keepfocus){$el.attr('tabindex',-1);setTimeout(function(){if(options.focuselement==='closebutton'){$('#'+el.id+' .'+el.id+closesuffix+':first').focus()}else if(options.focuselement){$(options.focuselement).focus()}else{$el.focus()}},options.focusdelay)}$(options.pagecontainer).attr('aria-hidden',true);$el.attr('aria-hidden',false);callback(el,ordinal,options.onopen);if(transitionsupport){$wrapper.one('transitionend',function(){callback(el,ordinal,options.opentransitionend)})}else{callback(el,ordinal,options.opentransitionend)}},hide:function(el){if(opentimer)clearTimeout(opentimer);var $body=$('body');var $el=$(el);var options=$el.data('popupoptions');var $wrapper=$('#'+el.id+'_wrapper');var $background=$('#'+el.id+'_background');$el.data('popup-visible',false);if(stack.length===1){$('html').removeClass('popup_visible').removeClass('popup_visible_'+el.id)}else{if($('html').hasClass('popup_visible_'+el.id)){$('html').removeClass('popup_visible_'+el.id)}}stack.pop();if($wrapper.hasClass('popup_wrapper_visible')){$wrapper.removeClass('popup_wrapper_visible')}if(options.keepfocus){setTimeout(function(){if($($el.data('focusedelementbeforepopup')).is(':visible')){$el.data('focusedelementbeforepopup').focus()}},0)}$wrapper.css({'visibility':'hidden','opacity':0});$el.css({'visibility':'hidden','opacity':0});if(options.background){$background.css({'visibility':'hidden','opacity':0})}$(options.pagecontainer).attr('aria-hidden',false);$el.attr('aria-hidden',true);callback(el,lastclicked[el.id],options.onclose);if(transitionsupport&&$el.css('transition-duration')!=='0s'){$el.one('transitionend',function(e){if(!($el.data('popup-visible'))){if(options.detach){$el.hide().detach()}else{$wrapper.hide()}}if(options.scrolllock){setTimeout(function(){$body.css({overflow:'visible','margin-right':bodymarginright})},10)}callback(el,lastclicked[el.id],options.closetransitionend)})}else{if(options.detach){$el.hide().detach()}else{$wrapper.hide()}if(options.scrolllock){setTimeout(function(){$body.css({overflow:'visible','margin-right':bodymarginright})},10)}callback(el,lastclicked[el.id],options.closetransitionend)}},toggle:function(el,ordinal){if($(el).data('popup-visible')){methods.hide(el)}else{setTimeout(function(){methods.show(el,ordinal)},0)}},reposition:function(el,ordinal){var $el=$(el);var options=$el.data('popupoptions');var $wrapper=$('#'+el.id+'_wrapper');var $background=$('#'+el.id+'_background');ordinal=ordinal||0;if(options.type=='tooltip'){$wrapper.css({'position':'absolute'});var $tooltipanchor;if(options.tooltipanchor){$tooltipanchor=$(options.tooltipanchor)}else if(options.openelement){$tooltipanchor=$(options.openelement).filter('[data-popup-ordinal="'+ordinal+'"]')}else{$tooltipanchor=$('.'+el.id+opensuffix+'[data-popup-ordinal="'+ordinal+'"]')}var linkOffset=$tooltipanchor.offset();if(options.horizontal=='right'){$wrapper.css('left',linkOffset.left+$tooltipanchor.outerWidth()+options.offsetleft)}else if(options.horizontal=='leftedge'){$wrapper.css('left',linkOffset.left+$tooltipanchor.outerWidth()-$tooltipanchor.outerWidth()+options.offsetleft)}else if(options.horizontal=='left'){$wrapper.css('right',$window.width()-linkOffset.left-options.offsetleft)}else if(options.horizontal=='rightedge'){$wrapper.css('right',$window.width()-linkOffset.left-$tooltipanchor.outerWidth()-options.offsetleft)}else{$wrapper.css('left',linkOffset.left+($tooltipanchor.outerWidth()/2)-($el.outerWidth()/2)-parseFloat($el.css('marginLeft'))+options.offsetleft)}if(options.vertical=='bottom'){$wrapper.css('top',linkOffset.top+$tooltipanchor.outerHeight()+options.offsettop)}else if(options.vertical=='bottomedge'){$wrapper.css('top',linkOffset.top+$tooltipanchor.outerHeight()-$el.outerHeight()+options.offsettop)}else if(options.vertical=='top'){$wrapper.css('bottom',$window.height()-linkOffset.top-options.offsettop)}else if(options.vertical=='topedge'){$wrapper.css('bottom',$window.height()-linkOffset.top-$el.outerHeight()-options.offsettop)}else{$wrapper.css('top',linkOffset.top+($tooltipanchor.outerHeight()/2)-($el.outerHeight()/2)-parseFloat($el.css('marginTop'))+options.offsettop)}}else if(options.type=='overlay'){if(options.horizontal){$wrapper.css('text-align',options.horizontal)}else{$wrapper.css('text-align','center')}if(options.vertical){$el.css('vertical-align',options.vertical)}else{$el.css('vertical-align','middle')}}},addclosebutton:function(el){var genericCloseButton;if($(el).data('popupoptions').closebuttonmarkup){genericCloseButton=$(options.closebuttonmarkup).addClass(el.id+'_close')}else{genericCloseButton='<button class="popup_close '+el.id+'_close" title="Close" aria-label="Close"><span aria-hidden="true">?</span></button>'}if($el.data('popup-initialized')){$el.append(genericCloseButton)}}};var callback=function(el,ordinal,func){var options=$(el).data('popupoptions');var openelement=(options.openelement)?options.openelement:('.'+el.id+opensuffix);var elementclicked=$(openelement+'[data-popup-ordinal="'+ordinal+'"]');if(typeof func=='function'){func.call($(el),el,elementclicked)}};$(document).on('keydown',function(event){if(stack.length){var elementId=stack[stack.length-1];var el=document.getElementById(elementId);if($(el).data('popupoptions').escape&&event.keyCode==27){methods.hide(el)}}});$(document).on('click',function(event){if(stack.length){var elementId=stack[stack.length-1];var el=document.getElementById(elementId);var closeButton=($(el).data('popupoptions').closeelement)?$(el).data('popupoptions').closeelement:('.'+el.id+closesuffix);if($(event.target).closest(closeButton).length){event.preventDefault();methods.hide(el)}if($(el).data('popupoptions').blur&&!$(event.target).closest('#'+elementId).length&&event.which!==2&&$(event.target).is(':visible')){methods.hide(el);if($(el).data('popupoptions').type==='overlay'){event.preventDefault()}}}});$(document).on('focusin',function(event){if(stack.length){var elementId=stack[stack.length-1];var el=document.getElementById(elementId);if($(el).data('popupoptions').keepfocus){if(!el.contains(event.target)){event.stopPropagation();el.focus()}}}});$.fn.popup=function(customoptions){return this.each(function(){$el=$(this);if(typeof customoptions==='object'){var opt=$.extend({},$.fn.popup.defaults,customoptions);$el.data('popupoptions',opt);options=$el.data('popupoptions');methods._init(this)}else if(typeof customoptions==='string'){if(!($el.data('popupoptions'))){$el.data('popupoptions',$.fn.popup.defaults);options=$el.data('popupoptions')}methods[customoptions].call(this,this)}else{if(!($el.data('popupoptions'))){$el.data('popupoptions',$.fn.popup.defaults);options=$el.data('popupoptions')}methods._init(this)}})};$.fn.popup.defaults={type:'overlay',autoopen:false,background:true,backgroundactive:false,color:'black',opacity:'0.5',horizontal:'center',vertical:'middle',offsettop:0,offsetleft:0,escape:true,blur:true,setzindex:true,autozindex:false,scrolllock:false,closebutton:false,closebuttonmarkup:null,keepfocus:true,focuselement:null,focusdelay:50,outline:false,pagecontainer:null,detach:false,openelement:null,closeelement:null,transition:null,tooltipanchor:null,beforeopen:null,onclose:null,onopen:null,opentransitionend:null,closetransitionend:null}})(jQuery);

$(function() {
	select_view();

	$('#list-view').on('click', function() {
		list_view();
	});
	
	$('#grid-view').on('click', function() {
		grid_view();
	});
	
	$('#compact-view').on('click', function() {
		compact_view();
	});

	$(document).on('keydown', '#collapse-checkout-option input[name=\'email\'], #collapse-checkout-option input[name=\'password\']', function(e) {
		if (e.keyCode == 13) {
			$('#collapse-checkout-option #button-login').trigger('click');
		}
	});
	
	$(window).scroll(function(){		
		if($(this).scrollTop()>190) {
			$('.scroll_up').addClass('show');
		}else{
			$('.scroll_up').removeClass('show');
		}
	});
	
	$('header .dropdown-menu').mouseover(function() {
	    $(this).attr('style', 'display:block');
	}).mouseout(function () {
	    $(this).removeAttr('style');
	});
	
	if($(window).width() < 767) {
		$('#menu li').removeClass('open');
		$('#grid-view').trigger('click');
		m_filter();
	}

	
	$(window).resize(function(){
		m_filter();
	});
	
	$('#menu span.visible-xs').on('click', function() {
		$(this).parent().toggleClass('open');
		$(this).next().toggleClass('open');
	});
	
	if($(window).width() > 768) {
		$('[data-toggle=\'tooltip\']').tooltip({container:'body', trigger:'hover'});
		$(document).ajaxStop(function() {
			$('[data-toggle=\'tooltip\']').tooltip({container:'body', trigger:'hover'});
		});
	}
	
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		autoheight();
	});
	
	$('.add_to_cart.disabled').each(function(){
		$(this).attr('disabled', true);
	});
	
	$(document).ajaxStop(function() {
		if($('#column-left #filterpro_box').length || $('#column-left .mfilter-box').length) {
			select_view();
			add_additional_img();
		}
	});
	
	$('.text-danger').each(function() {
		var element = $(this).parent().parent();

		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	$('#language li a').on('click', function(e) {
		e.preventDefault();
		$('#language input[name=\'code\']').attr('value', $(this).attr('data-code'));
		$('#language').submit();
	});
	
	$('#currency li a').on('click', function(e) {
		e.preventDefault();
		$('#currency input[name=\'code\']').attr('value', $(this).attr('data-code'));
		$('#currency').submit();
	});
	
	$('body').on('click', '#search ul li', function () {
		$('#search .cat_id button span').text($(this).text());
		$('#search input[name=\'filter_category_id\']').val($(this).attr('data-id'));
	});

	$('body').on('click', '.search', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';
		var value = $(this).parent().parent().find('input[name=\'search\']').val();
		if (value) {
			url += '&search=' + encodeURIComponent(value);
		}
		var filter_category_id = $(this).parent().parent().find('input[name=\'filter_category_id\']').val();
		if (filter_category_id > 0) {url += '&category_id=' + encodeURIComponent(filter_category_id);}
		location = url;
	});

	$('body').on('keydown', '#search input[name=\'search\']', function(e) {
		if (e.keyCode == 13) {
			$(this).parent().find('button.search').trigger('click');
		}
	});
	
	$('body').on('input', 'div input[name=\'search\']', function(e) {
		if($('div input[name=\'search\']').not($(this))) {
			$('div input[name=\'search\']').val($(this).val());
		}
	});
	
	$('#search_phrase a').on('click', function() {
		$(this).parent().prev().find('.form-control.input-lg').val($(this).text());
		$(this).parent().prev().find('.search').trigger('click');
	});
	
	top_menu();
	add_additional_img();
	fly_menu_enabled = 0;
});

function list_view() {
	$('#content .product-grid > .clearfix').remove();
	$('#content .product-grid, #content .product-price').attr('class', 'product-layout product-list col-xs-12');
	localStorage.setItem('display', 'list');
}

function grid_view() {
	cols = $('#column-right, #column-left').length;
	menu = $('.breadcrumb.col-md-offset-4.col-lg-offset-3').length;

	if (cols == 2) {
		$('.product-grid, .product-list, .product-price').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
	} else if (cols == 1 || menu == 1) {
		$('.product-grid, .product-list, .product-price').attr('class', 'product-layout product-grid col-lg-4 col-md-6 col-sm-6 col-xs-12');
	} else {
		$('.product-grid, .product-list, .product-price').attr('class', 'product-layout product-grid col-lg-3 col-md-4 col-sm-4 col-xs-12');
	}
		
	autoheight();
		
	localStorage.setItem('display', 'grid');
}
	
function compact_view() {
	$('#content .row > .product-list, #content .row > .product-grid').attr('class', 'product-layout product-price col-xs-12');
	if(!$('.product-price .product-thumb div .caption').length) {
		$('.product-price .caption').wrap('<div></div>');
	}
	localStorage.setItem('display', 'compact');
}

function select_view() {
	if (localStorage.getItem('display') == 'list') {
		list_view();
	} else if (localStorage.getItem('display') == 'compact')  {
		compact_view();
	} else {
		grid_view();
	}
}

function module_type_view(type, id) {
	var items = [[0, 1], [580, 2], [720, 3], [1050, 4]];
	var columns = ($('#column-left '+id).length || $('#column-right '+id).length);
	
	block_resize = function() {
		if($(id).parent().parent().parent().hasClass('tab-content')) {
			var width = $(id).parent().parent().parent().width()+20;
		} else {
			var width = $(id).width();
		}
		
		width = Math.floor(parseFloat(width))

		if (type == 'grid' && !columns) {	
			for (i = 0; i < items.length; i += 1) {
				if (items[i][0] <= width) {
					itemsNEW = parseFloat(items[i][1]);
				}
			}
			$(id).find('.product-layout-1').attr('style', 'float:left;width:'+(Math.floor(width / itemsNEW)-0.2)+'px;padding:0 10px');
			autoheight();
		} else {
			$(id).owlCarousel({
				responsiveBaseWidth: id,
				itemsCustom: items,
				autoPlay: false,
				mouseDrag:false,
				navigation: true,
				navigationText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>'],
				pagination: false,
				afterUpdate: function () {
					autoheight();
				}
			});
		}
    }
	
	block_resize();
    $(window).resize(block_resize);
}

function autoheight() {
	var product_row = $('.product-thumb').closest('.row');
	// $product = $('.product-thumb');
	$news = $('.news');
	$article = $('.article_module');

	max_height_div('.home_banner');
	max_height_div($('.category_list').find('p'));

	product_row.each(function () {

		$product = $(this).find('.product-thumb');
		max_height_div($product.find('.caption > a'));
		max_height_div($product.find('.attribute, .description'));
		max_height_div($product.find('.option'));
		max_height_div($product.find('.reviews-description'));
	});

	
	max_height_div($news.find('.name'));
	max_height_div($news.find('.description'));
	
	max_height_div($article.find('.name'));
	max_height_div($article.find('.description'));
}

function max_height_div(div) {
	block_height = function() {
		$(div).height('auto');
		var maxheight = 0;
		
		if($(div).length) {
			$(div).each(function(){
				if($(this).height() > maxheight) {
					maxheight = $(this).height();
				}
			});
			$(div).height(maxheight);
		}
	}
	
	block_height();
	$(window).resize(block_height);
}

function top_menu() {
	menu = function() {
		if(!$('#top-links2 ul').length && $(window).width() < 992) {
			$('#top-links ul').clone().appendTo('#top-links2');
			$('#top-links2 ul').addClass('dropdown-menu dropdown-menu-left');
		}
	}
	
	menu();
	$(window).resize(menu);
}

function fly_menu(fly_menu_product) {
	
	fly_menu_enabled = 1;
	
	menu = function() {	
		product = '';	price = '';	button = ''; menu = '';	search = '';
		
		if(!$('#menu_wrap').length && $(window).width() > 992) {
			if(fly_menu_product && $('#product').length) {
				var button = '<button type="button" class="'+$('#product #button-cart').attr('class')+'">'+$('#product #button-cart').html()+'</button>';
				var product = '<div class="product_wrap col-md-8 col-lg-8"><div><div class="product_name">'+$('#product h1').html()+'</div>'+$('#product .price li:first').html()+''+button+'</div></div>';
			} else {
				var menu = '<div class="menu_wrap col-md-4 col-lg-3"><div id="menu">'+$('header #menu').html()+'</div></div>';
				var search = '<div id="search_w" class="search_wrap col-md-4 col-lg-5"><div id="search" class="search_form input-group">'+$('#div_search #search').html()+'</div></div>';
			}
			
			var phone = '<div class="phone_wrap col-md-2 col-lg-2"><div id="phone">'+$('header #phone').html()+'</div></div>';
			var account = '<div class="account_wrap col-md-1 col-lg-1"><div id="account">'+$('#top #account').html()+'</div></div>';
			var cart = '<div class="cart_wrap col-md-1 col-lg-1"><div id="cart">'+$('header #cart').html()+'</div></div>';
			
			$('#menu').after('<div id="menu_wrap"><div class="container"><div class="row">'+menu+' '+search+' '+product+' '+phone+' '+account+' '+cart+'</div></div></div>');
			
			$('.product_wrap button').click(function() {
				$('#button-cart').click();
			});
			
			if (product) {
				scroll_text('#menu_wrap .product_wrap .product_name', '#menu_wrap .product_wrap .product_name span');
			}
		
			$(window).scroll(function(){
				if($(this).scrollTop() > 190) {
					$('#menu, #menu_wrap').addClass('show');
					$('#div_search #search').attr('id', 'search_');
				} else {
					$('#menu, #menu_wrap').removeClass('show');
					$('#div_search #search_').attr('id', 'search');
				}
			});
		}
	}
	
	
	$(window).scroll(function(){
		if($(this).scrollTop() > 100) {
			menu();
		}
	});
	$(window).resize(menu);
}

function fly_cart() {
	if(!fly_menu_enabled) {
		$(window).scroll(function(){		
			if($(window).width() > 992) {
				if($(this).scrollTop()>100) {
					$('#cart').addClass('fly');
				}else{
					$('#cart').removeClass('fly');
				}
				if($(this).scrollTop()>190) {
					$('#cart').addClass('fly2');
				}else{
					$('#cart').removeClass('fly2');
				}
			}
		});
	}
}

function fly_callback(text) {
	$('body').append('<div class="fly_callback" onclick="callback()"><i class="fa fa-phone" aria-hidden="true"></i></div>');
	
	$fly_callback = $('.fly_callback');
	
	if(text) {
		$fly_callback.attr('title', text).attr('data-toggle', 'tooltips');
		$('[data-toggle=\'tooltips\']').tooltip({container: 'body', trigger:'hover'});
	}
	$(window).scroll(function(){		
		if($(this).scrollTop()>190) {
			$fly_callback.addClass('show');
		}else{
			$fly_callback.removeClass('show');
		}
	});
}

function add_additional_img() {
	$('.image a > img, .thumbnails a > img').each(function () {
		if ($(this).attr('data-status')) {
			$(this).addClass('greyimage').after('<div class="product_status status_'+$(this).attr('data-status-id')+'">'+$(this).attr('data-status')+'</div>');
		}
		if ($(this).attr('data-additional')) {
			$(this).addClass('main').after('<img src="'+$(this).attr('data-additional')+'" class="additional img-responsive" title="'+$(this).attr('alt')+'" />');
		}		
	});
}

function change_opt_img(all, product_page) {
	if(all) {
		$('.product-thumb .option span.img').bind('click', function() {
			$(this).parent().parent().parent().parent().prev().find('a img:first').attr('src', $(this).attr('data-thumb'));
			$(this).parent().parent().parent().parent().parent().prev().find('a img:first').attr('src', $(this).attr('data-thumb'));
		});
	}
	if(product_page) {
		$('#product.row .option input[type=\'radio\'] + .img').on('click', function() {
			$('#product.row .thumbnails li:first a').attr('href', $(this).attr('data-full'));
			$('#product.row .thumbnails li:first img').attr('src', $(this).attr('data-thumb'));
		});
	}
}

function m_filter() {
	if($(window).width() < 767) {
		if($('#column-left #filterpro_box').size()) {
			$('#column-left #filterpro_box').css('height', $(window).height());
			$('#column-left').after('<div id="filterpro_box_open">'+$('#filterpro_box .heading span').text()+'</div');
			if(!$('.app_filter').size()) {
			$('#filterpro_box').append('<div style="margin:15px 0; text-align:center"><button class="app_filter btn btn-primary">Применить</button></div>'); 
			}
			$('#filterpro_box_open').on('click', function() {
				$('#column-left, #filterpro_box_open').addClass('show');
			});
			
			$('.app_filter, .clear_filter').on('click', function() {
				$('#column-left, #filterpro_box_open').removeClass('show');
				scroll_to('h1.heading');
			});
		}
	
		if($('#column-left #megafilter-box').size()) {
			$('#column-left #megafilter-box').css('height', $(window).height());
			$('#column-left').after('<div id="megafilter_box_open">Фильтр</div');
			if(!$('.app_filter').size()) {
				$('.mfilter-box').append('<div style="margin:15px 0; text-align:center"><button class="app_filter btn btn-primary">Применить</button></div>'); 
			}
			$('#megafilter_box_open').on('click', function() {
				$('#column-left, #megafilter_box_open').addClass('show');
			});
			
			$('.app_filter, .clear_filter').on('click', function() {
				$('#column-left, #megafilter_box_open').removeClass('show');
				scroll_to('h1.heading');
			});
		}
	} else {
		$('.app_filter, #filterpro_box_open, #megafilter_box_open').remove();
		$('#column-left #filterpro_box, #column-left #megafilter_box').removeAttr('style');
	}
}

function quantity(p_id, minimum, flag) {
    var input = $('#input-quantity');
	var minimum = parseFloat(minimum);
	if(flag == '+') {
		input.val(parseFloat(input.val())+1);
	}
	if(flag == '-') {
		if(input.val() > minimum) {
			input.val(parseFloat(input.val())-1);
		}
	}
}

function banner_link(link) {
	$('body').append('<div class="popup_banner"></div>');
	
	$popup_banner = $('.popup_banner');
	
	$popup_banner.popup({
		transition: 'all 0.3s', 
		closetransitionend: function () {
			$(this).remove();
		}
	});
	$popup_banner.load(link+' #content', function() {
		$popup_banner.append('<i class="fa fa-times close" onclick="$(\'.popup_banner\').popup(\'hide\');"></i>');
		$popup_banner.popup('show');
	});
}

function quick_order(id) {
	$.ajax({
		url: 'index.php?route=unishop/quick_order&id='+id,
		type: 'get',
		dataType: 'html',
		success: function(data) {
			$('.show_quick_order').html(data);
			$('#quick_order').popup('show');
		}
	});
}

function add_quick_order() {
	$.ajax({
		url: 'index.php?route=unishop/quick_order/add_order',
		type: 'post',
		data: $('#quick_order input, #quick_order textarea').serialize(),
		dataType: 'json',
		beforeSend: function() {
			$('.add_quick_order').button('loading');
		},
		complete: function() {
			$('.add_quick_order').button('reset');
		},
		success: function(json) {				
			if (json['success']) {
				$('#quick_order #product').html('<div class="row"><div class="col-xs-12">'+json['success']+'</div></div>')
			}
			if (json['error']) {
				$('.add_quick_order').before($('<div class="row"><div class="col-xs-12"><div class="text-danger" style="float:none;margin:0 auto;">'+json['error']+'</div><hr /></div></div>').fadeIn().delay(3000).fadeOut());
			}
		}
	});
}

function callback(reason, id) {
	if(typeof(reason) == 'undefined') {reason = '';}
	if(typeof(id) == 'undefined') {id = '';}
	
	$.ajax({
		url: 'index.php?route=unishop/request&reason='+reason+'&id='+id,
		type: 'get',
		dataType: 'html',
		success: function(data) {
			$('.show_callback').html(data);
			$('#callback').popup('show');
		}
	});
}

function send_callback() {
	$.ajax({
		url: 'index.php?route=unishop/request/mail',
		type: 'post',
		data: $('.callback input, .callback textarea').serialize(),
		dataType: 'json',
		beforeSend: function() {
			$('.callback_button').button('loading');
		},
		complete: function() {
			$('.callback_button').button('reset');
		},
		success: function(json) {	
			if (json['success']) {
				$('#callback > div').html($('<div class="callback_success">'+json['success']+'</div>').fadeIn());
			}
			
			$('#callback .text-danger, #callback hr').remove();

			if (json['error']) {
				for (i in json['error']) {
					$('.callback_button').before('<div class="text-danger" style="margin:-5px auto 10px;">'+json['error'][i]+'</div>');
				}
			}
		}
	});
}

function login() {
	$.ajax({
		url: 'index.php?route=unishop/login_register',
		type: 'get',
		dataType: 'html',
		success: function(data) {
			$('.show_login_register').html(data);
			$('#popup_login').popup('show');
		}
	});
}

function send_login() {
	$.ajax({
		url: 'index.php?route=unishop/login_register/login',
		type: 'post',
		data: $('#popup_login input, #popup_login textarea').serialize(),
		dataType: 'json',
		beforeSend: function() {
			$('.login_button').button('loading');
		},
		complete: function() {
			$('.login_button').button('reset');
		},
		success: function(json) {
			if (json['redirect']) {
				if(window.location.pathname == '/logout/') {
					location = json['redirect'];
				} else {
					window.location.reload();
				}
			}
			
			$('#popup_login .text-danger').remove();
			
			if (json['error']) {
				$('.login_button').before($('<div class="text-danger" style="margin:0 auto 10px;">'+json['error']+'</div>'));
			}
		}
	});
}

function register() {
	$.ajax({
		url: 'index.php?route=unishop/login_register',
		type: 'get',
		dataType: 'html',
		success: function(data) {
			$('.show_login_register').html(data);
			$('#popup_register').popup('show');
		}
	});
}

function send_register() {
	$.ajax({
		url: 'index.php?route=unishop/login_register/register',
		type: 'post',
		data: $('.popup_register input, .popup_register textarea').serialize(),
		dataType: 'json',
		beforeSend: function() {
			$('.register_button').button('loading');
		},
		complete: function() {
			$('.register_button').button('reset');
		},
		success: function(json) {				
			if (json['redirect']) {
				location = json['redirect'];
			}
			if (json['appruv']) {
				$('.popup_register').html($('<div class="register_success">'+json['appruv']+'</div>').fadeIn());
			}
			
			$('#popup_register .text-danger').remove();

			if (json['error']) {
				for (i in json['error']) {
					$('.register_button').before('<div class="text-danger" style="margin:0 auto 10px;">' + json['error'][i] + '</div>');
				}
			}
		}
	});
}

function scroll_to(hash) {		
	var destination = $(hash).offset().top-100;
	$('html, body').animate({scrollTop: destination}, 400);
}

function scroll_text(target_div, target_text) {	
	$(target_div).mouseover(function () {
	    $(this).stop();
	    var boxWidth = $(this).width();
	    var textWidth = $($(target_text), $(this)).width();

	    if (textWidth > boxWidth) {
	        $(target_text).animate({left: -((textWidth+20) - boxWidth)}, 800);
	    }
	}).mouseout(function () {
	    $(target_text).stop().animate({left: 0}, 800);
	});
}

function uni_live_search(show_image, show_description, show_rating, show_price, show_limit, all_results, empty_results) {
	data_id = 'div_search';
	$('body').on('click', function() {$('.live-search').hide();});
	$('header .form-control.input-lg').attr('autocomplete', 'off')
	
	$('body').on('input click', 'header .form-control.input-lg', function() {
		data_id = $(this).parent().parent().attr('id');
		if(!$('.'+data_id).size()) {
			$(this).parent().after('<div id="live-search" class="live-search '+data_id+'"><ul></ul></div>');
		}	
			
		if ($(this).val().length >= 3) {
			$.ajax({
				url: 'index.php?route=unishop/search&filter_name='+$('#'+data_id+' input[name=\'search\']').val()+'&category_id='+$('#'+data_id+' input[name=\'filter_category_id\']').val(),
				dataType: 'json',
				beforeSend: function() {$('.'+data_id+' ul').html('<li style="text-align:center;"><i class="fa fa-spinner" aria-hidden="true"></i></li>');},
				complete: function() {$('.'+data_id+' ul').html();},
				success: function(result) {
					var products = result.products;
					$('.'+data_id+' ul li').remove();
					if (!$.isEmptyObject(products)) {								
						$(products).each(function(index, product) {
							html = '';
							html += '<li onclick="location=\''+product.url+'\'">';
							if (product.image && show_image) {html += '<div class="product-image"><img alt="'+product.name+'" src="'+product.image+'"></div>';}
							html += '<div class="product-name">'+product.name;
							if (show_description || show_rating) {
								html += '<p>';
								if (show_description) {html += '<span>'+product.description+'</span>';}
								if (show_rating) {
									html += '<span class="rating">';
									for(var i=1; i <= 5; i++) {
										if(product.rating < i) {
											html += '<i class="fa fa-star-o"></i>';
										} else {
											html += '<i class="fa fa-star"></i>';
										}
									}
									html += '</span>';
								}
								html += '</p>';
							}
							html += '</div>';
							if(show_price){
								if (product.special) {
									html += '<div class="product-price"><span class="special">'+product.price+'</span><span class="price">'+product.special+'</span></div>';
								} else {
									html += '<div class="product-price"><span class="price">'+product.price+'</span></div>';
								}
							}
							html += '</li>';
							$('.'+data_id+' ul').append(html);
						});
						if(parseFloat(show_limit) < parseFloat(result.products_total)) {
							var description = '';
							if(show_description) {
								var description = '&description=true';
							}
							$('.'+data_id+' ul').append('<li style="text-align:center;"><a href="index.php?route=product/search&search='+$('#'+data_id+' input[name=\'search\']').val()+''+description+'">'+all_results+' ('+result.products_total+')</a></li>');
						}
					} else {
						$('.'+data_id+' ul').html('<li style="text-align:center;padding:5px 0;">'+empty_results+'</li>');
					}
					$('.'+data_id).css('display', 'block');
				}
			});
		}
	});
}

// Cart add remove functions
var cart = {
	'add': function(product_id, quantity, quick_order) {
		if (quick_order) {
			var options = $('.options input[type=\'text\'], .options input[type=\'radio\']:checked, .options input[type=\'checkbox\']:checked, .options select, .options textarea');
			var data = options.serialize() + '&product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1);
		} else {
			if ($('#option_'+product_id).children().size() > 0) {
				var options = $('#option_'+product_id+' input[type=\'radio\']:checked, #option_'+product_id+' input[type=\'checkbox\']:checked, #option_'+product_id+' select');
				var data = options.serialize() + '&product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1);
			} else {
				var data = 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1);
			}
		}
		
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: data,
			dataType: 'json',
			success: function(json) {
				$('.text-danger').remove();

				if (json['redirect'] && !quick_order && !options) {
					location = json['redirect'];
				}
				
				$('.form-group').removeClass('has-error');

				if (json['error']) {
					if (json['error']['option']) {
						for (i in json['error']['option']) {
							var element = $('#input-option' + i.replace('_', '-'));

							if (element.parent().hasClass('input-group')) {
								element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
							} else {
								element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
							}
						}
					}
				}

				if (json['success']) {
					$('.tooltip').remove();
					if (quick_order) {
						add_quick_order();
					} else {
						$('#content').parent().before('<div id="add_to_cart_success">'+json['success_new']+'</div>');
						$('#add_to_cart_success').popup({
							transition: 'all 0.3s',
							onclose: function () {
							setTimeout(function () {
								$('html, body').find('.tooltip').remove();
							}, 50);
							},
							closetransitionend: function () {
								$(this).remove();
							}
						});
						$('#add_to_cart_success').popup('show');
						$('#cart > button').html('<i class="fa fa-shopping-basket"></i><span id="cart-total">' + json['total_items'] + '</span>');
						$('#cart > ul').load('index.php?route=common/cart/info ul li');
					}
					$('#cart').addClass('show');
					replace_button(product_id);
				}
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	},
	'update': function(key, quantity) {
		$('#cart, #cart .dropdown-menu').addClass('open2');
		$.ajax({
			url: 'index.php?route=checkout/cart/edit',
			type: 'post',
			data: 'quantity[' + key + ']='+quantity,
			dataType: 'html',
			success: function(data) {
				$('#cart, .cart_wrap #cart').load('index.php?route=common/cart/info #cart > *');
				
				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					$('#content').load('index.php?route=checkout/cart #content > *');
				}
				
				p_array();
				
				$('#cart, .cart_wrap #cart').addClass('open').removeClass('open2');
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	},
	'remove': function(key, product_id) {
		//$('#cart, #cart .dropdown-menu').addClass('open2');
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				//setTimeout(function () {
					$('#cart > button').html('<i class="fa fa-shopping-basket"></i><span id="cart-total">' + json['total_items'] + '</span>');
				//}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else if (getURLVar('route') == 'checkout/unicheckout') {
					cart_update();
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
				
				return_button(product_id);
				$('#cart, .cart_wrap #cart').removeClass('show');
				//$('#cart').addClass('open').removeClass('open2');
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	}
}

var voucher = {
	'add': function() {

	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				//setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				//}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
				
				if (getURLVar('route') == 'checkout/unicheckout') {
					update_checkout();
				}
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	}
}

var wishlist = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=account/wishlist/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				$('#wishlist-total span').html(json['total']);
				$('#wishlist-total').attr('title', json['total']);

				//$('html, body').animate({ scrollTop: 0 }, 'slow');
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	},
	'remove': function() {

	}
}

var compare = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=product/compare/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

					$('#compare-total').html(json['total']);

					//$('html, body').animate({ scrollTop: 0 }, 'slow');
				}
			},
	        error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        }
		});
	},
	'remove': function() {

	}
}

$(document).delegate('.agree', 'click', function(e) {
	e.preventDefault();

	$('#modal-agree').remove();

	var element = this;

	$.ajax({
		url: $(element).attr('href'),
		type: 'get',
		dataType: 'html',
		success: function(data) {
			html  = '<div id="modal-agree" class="modal">';
			html += '  <div class="modal-dialog">';
			html += '    <div class="modal-content">';
			html += '      <div class="modal-header">';
			html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
			html += '        <h4 class="modal-title">' + $(element).text() + '</h4>';
			html += '      </div>';
			html += '      <div class="modal-body">' + data + '</div>';
			html += '    </div';
			html += '  </div>';
			html += '</div>';

			$('body').append(html);

			$('#modal-agree').modal('show');
		}
	});
});

function getURLVar(key) {
	var value = [];

	var query = String(document.location).split('?');

	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');

			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}

		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
}