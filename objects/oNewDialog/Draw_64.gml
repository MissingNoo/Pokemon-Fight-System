ui.foreach(function(name, pos, data) {
	var spr = data[$ "image"] != undefined ? asset_get_index(data.image) : undefined;
    spr = (spr != undefined and spr != -1) ? spr : sBlank;
	var _x = pos.left, _y = pos.top, _w = pos.width, _h = pos.height;
	switch (name) {
        case "text":
            scr = scribble(lexicon_text_struct($"NPC.{npc}.Falas.{text}", DialogData))
    		  .scale(font_size)
    		  .line_spacing($"{spacing}%")
    		  .wrap(_w, _h);
            scr.draw(_x, _y, typist);
	    default:
			draw_sprite_stretched(spr, 0, _x, _y, _w, _h);
	        break;
	}
});