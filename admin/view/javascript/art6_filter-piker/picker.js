jQuery(document).ready(function () {
	var pickerOpen = document.querySelectorAll(".pickerOpen-button");

	[].forEach.call(pickerOpen, function(picker) {
		picker.addEventListener("click", pickerOpenFunc);
	})
});

function pickerOpenFunc() {
	var self = this,
		htmlPicker = document.createElement("div"),
		line = document.createElement("div"),
		arrows = document.createElement("div"),
		left_arrow = document.createElement("div"),
		right_arrow = document.createElement("div"),
		block_picker = document.createElement("div"),
		img = document.createElement("img"),
		circle = document.createElement("div"),
		success = document.createElement("a"),
		out_color = document.createElement("div"),
		out_color_field = document.createElement("input"),
		fieldColor = self.querySelector('input[class="out_color_db"]'),
		color = fieldColor.value,
		out_id = self.dataset.id;

	// line
	left_arrow.classList.add("left_arrow");
	right_arrow.classList.add("right_arrow");

	arrows.id = "arrows";
	arrows.appendChild(left_arrow);
	arrows.appendChild(right_arrow);

	line.id = "line";
	line.appendChild(arrows);

	// block_picker
	img.onload = img.onerror = function () {
		img.classList.add("bk_img");
	}
	img.src = "https://lh3.googleusercontent.com/-8Dm4nhAOssQ/T_IqwyIFXmI/AAAAAAAAACA/4QKmS7s_otE/s256/bgGradient.png";

	circle.id = "circle";
	circle.classList.add("circle");

	block_picker.id = "block_picker";
	block_picker.appendChild(img);
	block_picker.appendChild(circle);

	// out_color
	out_color_field.classList.add("out_color_field");
	out_color_field.id = "out_color_field";
	out_color_field.type = "text";
	out_color_field.value = color;
	out_color_field.placeholder = "RGB(a) или HEX";
	out_color_field.addEventListener("keyup", colorKeyUp);

	out_color.classList.add("out_color");
	out_color.id = "out_color";
	out_color.style.backgroundColor = color;
	out_color.appendChild(out_color_field);

	success.classList.add("picker-success");
	success.href = "javascript:void(0)";
	success.innerHTML = "<i class=\"fa fa-save\"></i> Сохранить"
	success.addEventListener('click', pickerSuccessFunc.bind(self, out_id));

	// htmlPicker
	htmlPicker.classList.add("picker");
	htmlPicker.id = "primary_block";
	htmlPicker.appendChild(line);
	htmlPicker.appendChild(block_picker);
	htmlPicker.appendChild(out_color);
	htmlPicker.appendChild(success);

	document.body.classList.add("picker-open");
	document.body.appendChild(htmlPicker);
	document.addEventListener("click", pickerCloseFunc);

	this.style.backgroundColor = "#" + picker.init(self, out_id);
}
function pickerSuccessFunc(out_id) {
	var out_color_field = document.getElementById("out_color_field"),
		out_color_db = document.getElementById(out_id),
		color = out_color_field.value;

	this.style.backgroundColor = color;
	
	out_color_db.value = color;
	out_color_db.setAttribute("value", color);

	document.getElementById("primary_block").remove();
	document.body.classList.remove("picker-open");
}
function colorKeyUp(e) {
	var key = e.key,
		out_color = document.getElementById("out_color");

	out_color.style.backgroundColor = this.value;
}
function pickerCloseFunc(e) {
	if (e.target.matches("body") && !e.target.matches(".pickerOpen-button *")) {
		document.getElementById("primary_block").remove();
		document.body.classList.remove("picker-open");
	}
}

var picker = {
	V: 100,
	S: 100,
	status: false,

	init: function (self, out_id) {
		var id_elements = { primary: "primary_block", arrows: "arrows", block: "block_picker", circle: "circle", line: "line" };

		var s = { h: 180, w: 20, th: id_elements.arrows, bk: id_elements.block, line: id_elements.line };
		/*
		Параметры передаваемые через обьект "s" обьекту "Line"
		h - высота линни Hue
		w- ширина линни Hue
		th  - id для елмента в котором находяться стрелки || ползунок для управление шкалой Hue
		bk - id блока главного блока с изображение и изменяемым фоном
		*/
		Line.init(s); //отрисовка линий hue и привязка событий

		var b = { block: id_elements.block, circle: id_elements.circle };
		/*
		Параметры передаваемые через обьект "b" обьекту "Block"
		id - id блока выбора цвета (основной блок)
		c - круг для перемещения по основнoму блоку(для выбора цвета)
		*/
		Block.init(b); // привязка событий к блоку и кругу для управления

		picker.out_color = document.getElementById("out_color");
		picker.out_color_field = document.getElementById("out_color_field");
	}
};

var Line = {

	Hue: 0,

	init: function (elem) {

		var canvaLine, cAr, pst, bk, t = 0; ;

		canvaLine = Line.create(elem.h, elem.w, elem.line, "cLine");
		
		cAr = document.getElementById(elem.th);
		bk = document.getElementById(elem.bk);

		Line.posit = function (e) {
			var top, rgb;

			top = mouse.pageY(e) - pst;
			top = (top < 0) ? 0 : top;
			top = (top > elem.h) ? elem.h : top;

			cAr.style.top = top - 2 + "px";
			t = Math.round(top / (elem.h / 360));
			t = Math.abs(t - 360);
			t = (t == 360) ? 0 : t;

			Line.Hue = t;

			bk.style.backgroundColor = "rgb(" + convert.hsv_rgb(t, 100, 100) + ")";
			picker.out_color.style.backgroundColor = "rgb(" + convert.hsv_rgb(t, picker.S, picker.V) + ")";
			picker.out_color_field.value = "rgb(" + convert.hsv_rgb(t, picker.S, picker.V) + ")";
		}
		// события перемещения по линии
		cAr.onmousedown = function () {
			pst = Obj.positY(canvaLine);
			document.onmousemove = function (e) { Line.posit(e); }
		}

		cAr.onclick = Line.posit;

		canvaLine.onclick = function (e) { Line.posit(e) };

		canvaLine.onmousedown = function () {
			pst = Obj.positY(canvaLine);
			document.onmousemove = function (e) { Line.posit(e); }
		}
		document.onmouseup = function () {
			document.onmousemove = null;
			cAr.onmousemove = null;
		}
	},


	create: function (height, width, line, cN) {
		var canvas = document.createElement("canvas");

		canvas.width = width;
		canvas.height = height;

		canvas.className = cN;

		document.getElementById(line).appendChild(canvas);

		Line.grd(canvas, height, width);

		return canvas;
	},

	grd: function (canva, h, w) {
		var gradient, hue, color, canva, gradient1;

		canva = canva.getContext("2d");

		gradient = canva.createLinearGradient(w / 2, h, w / 2, 0);

		hue = [[255, 0, 0], [255, 255, 0], [0, 255, 0], [0, 255, 255], [0, 0, 255], [255, 0, 255], [255, 0, 0]];

		for (var i = 0; i <= 6; i++) {
			color = 'rgb(' + hue[i][0] + ',' + hue[i][1] + ',' + hue[i][2] + ')';
			gradient.addColorStop(i * 1 / 6, color);
		};

		canva.fillStyle = gradient;
		canva.fillRect(0, 0, w, h);
	}
};

var Block = {

	init: function (elem) {

		var circle, block, colorO, bPstX, bPstY, bWi, bHe, cW, cH, pxY, pxX;

		circle = document.getElementById(elem.circle);
		block = document.getElementById(elem.block);
		cW = circle.offsetWidth;
		cH = circle.offsetHeight;
		bWi = block.offsetWidth - cW;
		bHe = block.offsetHeight - cH;
		pxY = bHe / 100;
		pxX = bWi / 100;

		Block.cPos = function (e) {

			var top, left, S, V;

			document.ondragstart = function () { return false; }

			document.body.onselectstart = function () { return false; }

			left = mouse.pageX(e) - bPstX - cW / 2;
			left = (left < 0) ? 0 : left;
			left = (left > bWi) ? bWi : left;

			circle.style.left = left + "px";

			S = Math.ceil(left / pxX);

			top = mouse.pageY(e) - bPstY - cH / 2;
			top = (top > bHe) ? bHe : top;

			top = (top < 0) ? 0 : top;

			circle.style.top = top + "px";

			V = Math.ceil(Math.abs(top / pxY - 100));

			if (V < 50) circle.style.borderColor = "#fff";

			else circle.style.borderColor = "#000";

			picker.S = S;

			picker.V = V;

			picker.out_color.style.backgroundColor = "rgb(" + convert.hsv_rgb(Line.Hue, S, V) + ")";
			picker.out_color_field.value = "rgb(" + convert.hsv_rgb(Line.Hue, S, V) + ")";
			picker.out_color_field.setAttribute('value', "rgb(" + convert.hsv_rgb(Line.Hue, S, V) + ")");
			
			var _res = convert.hsv_rgb(Line.Hue, S, V);
			_res = _res[0].toString(16) + "" + _res[1].toString(16) + "" + _res[2].toString(16);
			//console.log(_res);
		}

		block.onclick = function (e) { Block.cPos(e); }
		block.onmousedown = function () {
			document.onmousemove = function (e) {
				bPstX = Obj.positX(block);
				bPstY = Obj.positY(block);
				Block.cPos(e);
			}
		}

		document.onmouseup = function () {
			document.onmousemove = null;
		}
	}

};

var convert = {

	hsv_rgb: function (H, S, V) {

		var f, p, q, t, lH;

		S /= 100;
		V /= 100;

		lH = Math.floor(H / 60);

		f = H / 60 - lH;
		p = V * (1 - S);
		q = V * (1 - S * f);
		t = V * (1 - (1 - f) * S);

		switch (lH) {

			case 0: R = V; G = t; B = p; break;
			case 1: R = q; G = V; B = p; break;
			case 2: R = p; G = V; B = t; break;
			case 3: R = p; G = q; B = V; break;
			case 4: R = t; G = p; B = V; break;
			case 5: R = V; G = p; B = q; break;
		}

		return [parseInt(R * 255), parseInt(G * 255), parseInt(B * 255)];
	}

};	