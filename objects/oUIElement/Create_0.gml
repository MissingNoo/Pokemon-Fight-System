editor_area = [0, 0, 0, 0];
editor_area2 = [0, 0, 0, 0];
original_depth = depth;
edit_node = undefined;
edit_element = undefined;
resizing = noone;
deltimer = 10;
draw_back = false;
bimg = 0;
image = -1;
index = irandom(10);
bar_image = -1;
bar_colour = -1;
bar_level = random_range(0, 1);
center_text = false;
draggable = false;
dragging = false;
if (data[$ "text"] != undefined) {
    text = data[$ "text"];
}

if (data[$ "image"] != undefined) {
	var spr = asset_get_index(data.image);
	if (spr != -1 and sprite_exists(spr)) {
	    image = spr;
	}
}

if (string_contains(name, "root")) {
    draw_back = true;
}

if (string_contains(name, "label")) {
	type = "label";
	//name = string_replace(name, "label", "");
}

if (string_contains(name, "draggable")) {
    draggable = true;
}

if (string_contains(name, "panel")) {
	type = "panel";
    //draw_back = !string_contains(name, "transparent");
    draw_back = false;
	bimg = 1;
	//name = string_replace(name, "panel", "");
}

if (string_contains(name, "center")) {
    center_text = true;
	//name = string_replace(name, "center", "");
}

element = undefined;
if (string_contains(name, "textbox")) {
	type = "textbox";
    element = new textbox();
	element.only_numbers = !string_contains(name, "char");
	//name = string_replace(name, "textbox", "");
}
if (string_contains(name, "button")) {
	type = "button";
    element = new button(text);
	//name = string_replace(name, "button", "");
}
if (string_contains(name, "listbox")) {
	type = "listbox";
	element = new listbox();
	element.dept = depth;
	if (data[$ "options"] != undefined) {
	    for (var i = 0; i < array_length(data.options); ++i) {
		    element.add_item(data.options[i]);
		}
	}
	//name = string_replace(name, "listbox", "");
}
//name = string_replace_all(name, "-", "");

if (element != undefined) {
	element.owner = self;
	if (data[$ "sprite"] != undefined) {
	    element.set_sprite(data.sprite);
	}
    if (data[$ "f"] != undefined) {
        element.set_function(data.f);
    }
    element.position(x, y, x + width, y + height);
	if (data[$ "selected"] != undefined) {
	    element.text = data.selected;
	}
	if (data[$ "text"] != undefined) {
	    element.text = data[$ "text"];
	}
	//if (type == "listbox") {
	//    show_message(element);
	//}	
}