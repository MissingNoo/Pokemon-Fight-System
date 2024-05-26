surface_set_target(bagsurf);
//Feather disable GM2017
var _spr = sBlank;
var _subimg = 0;
var _startx = startPosition[0];
var _starty = startPosition[1];
var _x = _startx;
var _y = _starty;
draw_set_font(PFS.Fonts.PokeFont[3]);
draw_sprite_ext(sBagBG, 0, _startx + 1, _starty + 1, 3, 3, 0, c_white, 1);
draw_set_font(PFS.Fonts.PokeFont[3]);
var a = DebugManager.a;
var b = DebugManager.b;
var c = DebugManager.c;
var d = DebugManager.d;
var e = DebugManager.e;
switch (fsm.get_current_state()) {
    case "Items":
		tabselected = ItemType.Common_Item;
        _subimg = 0;
        break;
    case "KeyItems":
		tabselected = ItemType.Key_Item;
        _subimg = 1;
        break;
    case "Pokeballs":
		tabselected = ItemType.Poke_ball;
        _subimg = 2;
        break;
	default:
		tabselected = ItemType.Common_Item;
		_subimg = 0;
		break;
}
draw_sprite_ext(sBagButtons, _subimg, _startx + 10, _starty + 4, 3, 3, 0, c_white, drawalpha);
draw_sprite_ext(PlayerData.gender == Gender.Male ? sBagMale : sBagMale, _subimg, _startx + 122, _starty + 285 + bagoffset, 3, 3, 0, c_white, 1);
var _yoffset = 0;
var _totalitems = array_length(PlayerData.inventory.items);
for (var i = 0; i <= _totalitems; ++i) {
	var _string = "";
	if (i == _totalitems) {
		_string = "CANCEL";
	}
	else {
		if (PlayerInventory.items[i].itemType != tabselected) {
		    continue;
		}
		_string = lexicon_text($"Items.{PlayerInventory.items[i].name}.Name");
	}
	scribble(_string)
	.draw(_startx + 290, _starty + 38 + _yoffset);
	if (selecteditem == i) {
	    draw_sprite_ext(sBagSelected, fsn.get_current_state() == "Interacting" ? 1 : 0, _startx + 290, _starty + 38 + _yoffset, 3, 3, 0, c_white, 1);
	}
    _yoffset += 48;
}
var _string = "";
if (selecteditem == _totalitems) {
	_string = lexicon_text($"GUI.Bag.Close");
	_spr = sCloseBag;
	_subimg = 0;
}
else {
    _string = lexicon_text($"Items.{PlayerInventory.items[selecteditem].name}.Desc");
	_spr = PlayerInventory.items[selecteditem].sprite;
	_subimg = PlayerInventory.items[selecteditem].subimg;
}
scribble(_string)
	.wrap(550)
	.draw(_startx + 120, _starty + 354);
draw_sprite_ext(_spr, _subimg, _startx + 58, _starty + 410, 3, 3, 0, c_white, 1);
var _reccolor = #D6B552;
draw_rectangle_color(_startx + 265, _starty + 25, _startx + 696, _starty + 25 + reclerp, _reccolor, _reccolor, _reccolor, _reccolor, false);
if (fsn.get_current_state() == "Interacting") {
	var _optionsoffset = onBattle ? 0 : 90;
	_x = _startx + 500;
	_y = _starty + 350;
    draw_sprite_stretched(sDialogAnswer, 0, _x, _y - _optionsoffset, 214, 126 + _optionsoffset);
	_yoffset = 0;
	for (var i = 0; i < array_length(interactoptions); ++i) {
	    scribble(interactoptions[i]).draw(_x + 40, _y + _yoffset - _optionsoffset + 25);
		if (interactoption == i) {
		    draw_sprite_ext(sBagSelected, 0, _x + 40 - a, _y + _yoffset - _optionsoffset + 25, 3, 3, 0, c_white, 1);
		}
		_yoffset += 46;
	}
}
fsm.draw();
surface_reset_target();
if (surface_exists(bagsurf)) {
	draw_surface_ext(bagsurf, GW/2 - (windowSize[0] / 2), GH/2 - (windowSize[1] / 2), 3, 3, 0, c_white, 1);
}
