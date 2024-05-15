if (npc == "0" or text == "0") { exit; }
draw_sprite_stretched(dialogSprite, 0, dialogBoxX, dialogBoxY, dialogBoxEndX, dialogBoxEndY);
//Feather disable once GM1041
scr = scribble(lexicon_text_struct($"NPC.{npc}.Falas.{text}", struc))
		  .scale(dialogFontSize)
		  .line_spacing($"{dialogSpacing}%")
		  .wrap(dialogWrap, dialogBoxEndY - 20);

scr.draw(dialogTextX, dialogTextY, typist)
var _currentText = array_get_index(optionsFalas, text);
if (is_array(options) and showOptions and canInteract and _currentText != -1) {
	var _yoffset = 0;
	draw_set_valign(fa_middle);
	var _len = array_length(options[_currentText]);
	draw_sprite_stretched(sDialogAnswer, 0, dialogAnswerX, dialogAnswerY, dialogAnswerEndX, dialogAnswerEndY);
	for (var i = 0; i < _len; ++i) {
		var _x = dialogAnswerX;
		var _y = dialogAnswerY + _yoffset;
		var _opt = options[_currentText][i][0];
		var _w = string_width(_opt) + 5;
		var _h = string_height(_opt) / 2 + 3;
		var _color = c_white;
		if (selectedOption == i) {
			//Feather disable once GM2017
		    draw_sprite_ext(PFSOptionSelected, 0, _x + dialogAnswerTextX - 8, _y + dialogAnswerTextY - 3, 2, 2, 0, c_white, 1);
		}
	    draw_text_transformed_color(_x + dialogAnswerTextX, _y + dialogAnswerTextY, _opt, dialogAnswerScale, dialogAnswerScale, 0, _color, _color, _color, _color, 1);
		_yoffset += dialogAnswerOffset;
		_len = array_length(options[_currentText]);
	}
	draw_set_valign(fa_top);
}