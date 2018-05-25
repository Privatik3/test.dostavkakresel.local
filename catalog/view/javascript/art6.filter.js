document.addEventListener('DOMContentLoaded', FilterInit);

function FilterInit () {
	filter = document.forms['art6-filter'];

	if (!filter) return;

	var elements = filter.elements;

	if (!elements) return;

	setFilter = filter.elements['set_filter'];

	if (!setFilter) return;

	stop_set = null;

	setFilter.addEventListener('click', SetFilter);

	[ ].forEach.call(elements, function (el) {
		if (el.type == "checkbox")
			el.addEventListener('click', SetFilter);
		else
			el.addEventListener('blur', SetFilter);
	});

	var filter_sliders = filter.getElementsByClassName('art6-filter__form-box--slider');
	if (filter_sliders)
		[].forEach.call(filter_sliders, function (slider) {
			var inputs = slider.getElementsByClassName('art6-filter__form-box__params-item');

			[ ].forEach.call(inputs, function (input) {
				var _input = input.getElementsByTagName("input")[0];

				var value = +_input.value.replace(/\s+/g, "");

				if (value) {
					var arName = _input.name.split("_");
					var direct = arName[arName.length - 1].toLowerCase();

					var slider_box = slider.getElementsByClassName('art6-filter__form-box__slider')[0];
					var slider_bottom = slider_box.getElementsByClassName('art6-filter__form-box__slider-after')[0];
					var slider_button = slider_box.getElementsByClassName('art6-filter__form-box__slider-buttons__' + direct)[0];
					var slider_width = slider_box.offsetWidth - slider_button.offsetWidth;

					var button_from = slider_box.getElementsByClassName('art6-filter__form-box__slider-buttons__from')[0];
					var button_to = slider_box.getElementsByClassName('art6-filter__form-box__slider-buttons__to')[0];

					var numberMin = +slider_box.dataset.min;
					var numberMax = +slider_box.dataset.max;

					if (value < numberMin) value = numberMin;
					if (value <= numberMin) _input.value = "";
					
					if (value > numberMax) value = numberMax;
					if (value >= numberMax) _input.value = "";

					var showResult = value;
					var result = showResult - numberMin;
					var percentMove = result / (numberMax - numberMin) * 100;
					var moveX = percentMove / 100 * slider_width;

					slider_button.style.left = moveX + "px";
					slider_button.dataset.offsetleft = moveX;

					if (direct == "from") slider_bottom.style.left = moveX + "px";
					else slider_bottom.style.right = slider_width - moveX + "px";
				}
			});
		});

	checkBoxes = filter.getElementsByClassName('art6-filter__form-box--check');
	[ ].forEach.call(checkBoxes, function (box) {
		var title = box.getElementsByClassName('art6-filter__form-box__title')[0];
		var boxParams = box.getElementsByClassName('art6-filter__form-box__params')[0];
		var boxItemsActive = boxParams.getElementsByClassName('art6-filter__form-box__params-item--active');

		if (boxItemsActive.length > 0) {
			title.classList.add('active');
			boxParams.classList.remove('art6-filter__form-box__params--hidden');
		}

		var boxTitle = box.getElementsByClassName('art6-filter__form-box__title')[0];
		boxTitle.addEventListener('click', ParamsHidden);

		var checkTitles = box.getElementsByClassName('art6-filter__form-box__params-item__title');
		if (checkTitles)
			[ ].forEach.call(checkTitles, function (title) {
				title.addEventListener('click', CheckActive);
			});
	});

	selectBoxes = filter.querySelectorAll('.art6-filter__form-box--select .art6-filter__form-box__params');
	if (selectBoxes) {
		[ ].forEach.call(selectBoxes, function (select) {
			select.addEventListener('click', selectBoxesOpen);
		});
	}

	document.addEventListener('mousedown', SliderButtonDown);
	
	document.querySelector(".product-filter-button").addEventListener('click', OpenFilter);
}

// functions
function selectBoxesOpen(e) {
	e.preventDefault();

	var show = this.classList.contains("show"),
		options = this.querySelectorAll(".art6-filter__form-box__params-item");

	if (show) {
		this.classList.remove("show");
		document.removeEventListener("click", selectBoxesClose);
	} else {
		this.classList.add("show");
	}

	[ ].forEach.call(options, function (option) {
		option.addEventListener("click", selectBoxesCheck);
		option.addEventListener("click", SetFilter);
	});
	document.addEventListener("click", selectBoxesClose);
}
function selectBoxesCheck(e) {
	var active = this.classList.contains("art6-filter__form-box__params-item--active"),
		field = this.querySelector("input"),
		options = this.parentElement.querySelectorAll(".art6-filter__form-box__params-item");

	[ ].forEach.call(options, function (option) {
		option.classList.remove("art6-filter__form-box__params-item--active");
		option.querySelector("input").checked = false;
	});

	if (!active) {
		this.classList.add("art6-filter__form-box__params-item--active");
		field.checked = true;
	}
}
function selectBoxesClose(e) {
	if (!e.target.classList.contains("art6-filter__form-box__params") && !getParent(e.target, {class: "art6-filter__form-box__params"})) {
		var selectBoxes = filter.querySelectorAll('.art6-filter__form-box--select .art6-filter__form-box__params');

		[ ].forEach.call(selectBoxes, function (select) {
			select.classList.remove("show");
		});
		
		document.removeEventListener("click", selectBoxesClose);
	}
}

function ParamsHidden () {
	var title = this;
	var parent = title.parentElement;
	var params = parent.getElementsByClassName('art6-filter__form-box__params')[0];
	var paramsHidden = params.classList.contains('art6-filter__form-box__params--hidden');

	[ ].forEach.call(checkBoxes, function (box) {
		var _params = box.getElementsByClassName('art6-filter__form-box__params')[0];
		var inputs = _params.getElementsByTagName('input');

		var input_active = false;
		[ ].forEach.call(inputs, function (input) {
			if (input.checked) {
				input_active = true;
				return;
			}
		});

		if (!input_active)
			_params.classList.add('art6-filter__form-box__params--hidden');
	});
		
	if (paramsHidden) {
		title.classList.add('active');
		params.classList.remove('art6-filter__form-box__params--hidden');
	} else {
		params.classList.add('art6-filter__form-box__params--hidden');
		title.classList.remove('active');
	}
}

function CheckActive () {
	var title = this;
	var titleFor = title.getAttribute('for');
	var check = filter.elements[titleFor];
	var parent = title.parentElement;
		
	if (check.checked) {
		check.checked = false;
		parent.classList.remove('art6-filter__form-box__params-item--active');
	} else {
		check.checked = true;
		parent.classList.add('art6-filter__form-box__params-item--active');
	}
}

function SliderButtonDown (e) {
	if (stop_set)
		clearTimeout(stop_set);

	var elem = e.target;
	var needButton = false;

	if (elem.classList.contains('art6-filter__form-box__slider-buttons__from')) {
		needButton = "from";
	} else if (elem.classList.contains('art6-filter__form-box__slider-buttons__to')) {
		needButton = "to";
	}

	if (!needButton) return;

	elem.addEventListener('dragstart', function() { return; });

	window["dragObject"] = {};
	window["dragObject"].box = getParent(elem, {class: "art6-filter__form-box__slider"});
	window["dragObject"].box_width = window["dragObject"].box.offsetWidth;
	window["dragObject"].elem = elem;
	window["dragObject"].input = getParent(elem, {class: "art6-filter__form-box--slider"}).getElementsByClassName('art6-filter__form-box__params-item--' + needButton)[0].getElementsByTagName('input')[0];
	window["dragObject"].min = +window["dragObject"].box.dataset.min.replace(/\s+/g, "");
	window["dragObject"].max = +window["dragObject"].box.dataset.max.replace(/\s+/g, "");
	window["dragObject"].elemCoords = getCoords(elem);
	window["dragObject"].shiftX = e.pageX - window["dragObject"].elemCoords.left;
	window["dragObject"].boxCoords = getCoords(window["dragObject"].box);
	window["dragObject"].buttonside = needButton;
	window["dragObject"].elem.dataset.offsetleft = e.pageX - window["dragObject"].shiftX - window["dragObject"].boxCoords.left;

	document.addEventListener('mousemove', SliderButtonMove);
	document.addEventListener('mouseup', SetFilter);
	//document.addEventListener('mouseup', SliderButtonUp);
}

function SliderButtonMove (e) {
	if (!window["dragObject"].elem) return;

	var slider_bottom = window["dragObject"].box.getElementsByClassName('art6-filter__form-box__slider-after')[0];

	var moveX = e.pageX - window["dragObject"].shiftX - window["dragObject"].boxCoords.left;
	
	if (moveX < 0) moveX = 0;

	if (slider_bottom.offsetWidth <= window["dragObject"].elem.offsetWidth * 2) {
		moveX = window["dragObject"].elem.dataset.offsetleft;
		
		var newMoveX = e.pageX - window["dragObject"].shiftX - window["dragObject"].boxCoords.left;
		
		if (window["dragObject"].buttonside == "to" && newMoveX > moveX) {
			moveX = newMoveX;
		} else if (window["dragObject"].buttonside == "from" && newMoveX < moveX) {
			moveX = newMoveX;
		}
	}

	var rightEdge = window["dragObject"].box_width - window["dragObject"].elem.offsetWidth;

	if (moveX >= rightEdge) {
		moveX = rightEdge;
	}

	window["dragObject"].moveX = moveX;

	window["dragObject"].percentMove = moveX * 100 / rightEdge;
	window["dragObject"].percentPrice = (window["dragObject"].max - window["dragObject"].min) * window["dragObject"].percentMove / 100;
	window["dragObject"].result = window["dragObject"].percentPrice + window["dragObject"].min;

	var showResult = "";
	if (window["dragObject"].result > window["dragObject"].min && window["dragObject"].result < window["dragObject"].max) {
		showResult = number_format(window["dragObject"].result, 1, ".", " ");
	}
	
	window["dragObject"].elem.style.left = moveX + 'px';
	window["dragObject"].elem.dataset.offsetleft = moveX;
	
	window["dragObject"].input.value = showResult;

	if (window["dragObject"].buttonside == "from"){
		slider_bottom.style.left = moveX + "px";
	} else {
		slider_bottom.style.right = rightEdge - moveX + "px";
	}
}

function SliderButtonUp () {
	document.onmousemove = document.onmouseup = null;

	if (!window["dragObject"] || !window["dragObject"].box) return;

	var oldBox = window["dragObject"].box;
	
	window["dragObject"] = {};
	window["dragObject"].box = oldBox;
}

function OpenFilter () {
	window["filterContainer"] = filter.parentNode;
	
	window["filterContainer"].classList.toggle("active");
	document.body.classList.toggle('filter');
	
	window["firstClick"] = 1;
	document.addEventListener("click", CloseFilter);
}

function CloseFilter (e) {
	if (!firstClick && window["filterContainer"] && !getParent(e.target, {class: "art6-filter"}) && !e.target.classList.contains("art6-filter")) {
		window["filterContainer"].classList.remove("active");
		document.body.style.overflow = "inherit";
		document.body.classList.remove('filter');
		
		window["filterContainer"] = null;
		document.removeEventListener("click", CloseFilter);
	}
	
	window["firstClick"] = 0;
}

function SetFilter (e) {
	e.preventDefault();

	if (stop_set)
		clearTimeout(stop_set);
	
	if (window["dragObject"])
		SliderButtonUp();

	stop_set = setTimeout(function () {
		var action = filter.action;
		var elements = filter.elements;

		var urlGetParams = getURLVars() || {};

		[ ].forEach.call(elements, function (elem) {
			var type = elem.type;

			if (type == "checkbox" && elem.checked) {
				urlGetParams[elem.name] = elem.value;
			} else if (type == "text" && elem.value.length > 0) {
				urlGetParams[elem.name] = elem.value;
			} else {
				urlGetParams[elem.name] = "";
			}
		});

		if (Object.keys(urlGetParams).length > 0) {
			var urlParamsString = "?";

			for (var key in urlGetParams) {
				urlParamsString += (urlGetParams[key] != "" ? key + "=" + urlGetParams[key] + "&" : "");
			}

			urlParamsString += "&set_filter=Y";

			var document_root = action.split("?")[0];

			location = document_root + urlParamsString;
		}
	}, 1000);

	return false;
}

function ClearFilter (e) {
	e.preventDefault();

	var elements = filter.elements;

	var urlGetParams = getURLVars();

	if (urlGetParams) {
		var elements = filter.elements;
		var elementsShow = {};
				
		[ ].forEach.call(elements, function (elem) {
			urlGetParams[elem.name] = "";
		});

		if (Object.keys(urlGetParams).length > 0) {
			var urlParamsString = "?";

			for (var key in urlGetParams) {
				urlParamsString += (urlGetParams[key] != "" ? key + "=" + urlGetParams[key] + "&" : "");
			}

			urlParamsString = urlParamsString.slice(0, -1);

			var document_root = location.href.split("?")[0];
					
			location.href = document_root + urlParamsString;
		}
	}
		
	return false;
}

function getParent (elem, arParams, bool)
{
	var parentEl = elem.parentElement || elem.parentNode,
		bool = (typeof bool == "boolean") ? bool : true;

	if (isBody(parentEl) || isBody(elem)) return false;

	if (typeof arParams == 'object') 
	{
		parentEl = (arParams.tag) ?
			(parentEl.localName == arParams.tag) ? parentEl : getParent(parentEl, arParams, bool)
		: (arParams.class) ?
			(parentEl.classList.contains(arParams.class)) ? parentEl : getParent(parentEl, arParams, bool)
		: (arParams.id) ?
			(parentEl.id == arParams.id) ? parentEl : getParent(parentEl, arParams, bool)
		: false;
	}

	return parentEl;
}

function isBody (elem) 
{
	if (elem.tagName != 'BODY') return false;
	return true;
}

function getCoords(elem) {
	var box = elem.getBoundingClientRect();

	return {
		top: box.top + pageYOffset,
		bottom: box.bottom + pageXOffset,
		left: box.left + pageXOffset,
		right: box.right + pageXOffset
	};
}

function getURLVars() {
	var value = [];

	var query = String(document.location).split('?');if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');

			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}

		return value;
	}
}

function getURLVar(key) {
	var value = getURLVars();

	if (value[key]) {
		return value[key];
	} else {
		return '';
	}
}

function number_format(number, decimals, dec_point, thousands_sep) {
	number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
	
	var n = !isFinite(+number) ? 0 : +number,
		prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
		sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
		dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
		s = '';
	
	var toFixedFix = function(n, prec) {
		var k = Math.pow(10, prec);
		
		return '' + (Math.round(n * k) / k).toFixed(prec);
	};
	
	s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
	
	if (s[0].length > 3) {
		s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
	}
	
	if ((s[1] || '').length < prec) {
		s[1] = s[1] || '';
		
		s[1] += new Array(prec - s[1].length + 1)
			.join('0');
	}
	
	return s.join(dec);
}