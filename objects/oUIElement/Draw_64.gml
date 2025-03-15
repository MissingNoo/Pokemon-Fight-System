//draw_rectangle(x, y, x + width, y + height, 1);

//draw_text(x, y, name);

if (draw_back)
{
	draw_sprite_stretched(sButton, 0, x, y, width, height);
}

// Draw image (e.g. an icon)
if (image != -1)
{
	draw_sprite_stretched(image, index, x, y, width, height);
}

// Draw bar image (e.g. for health bars)
if (bar_image != -1)
{
	draw_sprite_stretched_ext(bar_image, 0, x, y, width * bar_level, height, bar_colour, 1);
}

// Draw text, can optionally be centred
if (text != "" and element == undefined)
{
	var str = "";
	if (center_text)
	{
		str = "[fa_center][fa_middle]";
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
	}
	//draw_set_color(c_black);
	scribble($"{str}[Fnt][c_black]{text}").scale(0.1).draw(x + (width / 2) * center_text, y + (height / 2) * center_text);
	//draw_text(x + (width / 2) * center_text, y + (height / 2) * center_text, text);
	draw_set_color(c_white);
	if (center_text)
	{
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}

if (element != undefined) {
    element.draw();
}