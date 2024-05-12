if (npc == "0" or text == "0") { exit; }
draw_sprite_stretched(sDialogWindow, 0, dialogBoxX, dialogBoxY, dialogBoxEndX, dialogBoxEndY);

//Feather disable once GM1041
scr = scribble("[c_black]" + lexicon_text($"NPC.{npc}.Falas.{text}"))
		  .scale(dialogFontSize)
		  .wrap(dialogWrap, dialogBoxEndY - 20);

scr.draw(dialogTextX, dialogTextY, typist)
var _currentText = array_get_index(optionsFalas, text);
if (is_array(options) and showOptions and canInteract and _currentText != -1) {
	var _yoffset = 0;
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	var _len = array_length(options[_currentText]);
	for (var i = 0; i < _len; ++i) {
		var _x = dialogAnswerX;
		var _y = dialogAnswerY + _yoffset;
		var _opt = options[_currentText][i][0];
		var _w = string_width(_opt) + 5;
		var _h = string_height(_opt) / 2 + 3;
		var _color = selectedOption == i ? c_black : c_white;
		var _colorreq = selectedOption == i ? c_white : c_black;
		draw_rectangle_color(_x - _w, _y - _h, _x + _w, _y + _h, _colorreq, _colorreq, _colorreq, _colorreq, false);
		draw_rectangle_color(_x - _w, _y - _h, _x + _w, _y + _h, _color, _color, _color, _color, true);
	    draw_text_color(_x, _y, _opt, _color, _color, _color, _color, 1);
		_yoffset += dialogAnswerOffset;
		_len = array_length(options[_currentText]);
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}