draw_back = false;
image = -1;
index = irandom(10);
bar_image = -1;
bar_colour = -1;
bar_level = random_range(0, 1);
center_text = false;
if (data[$ "text"] != undefined) {
    text = data[$ "text"];
}

if (string_contains(name, "root")) {
    draw_back = true;
}

if (string_contains(name, "center")) {
    center_text = true;
}

element = undefined;
if (string_contains(name, "textbox")) {
    element = new textbox();
}
if (string_contains(name, "button")) {
    element = new button(text);
}
if (element != undefined) {
    if (data[$ "f"] != undefined) {
        element.set_function(data.f);
    }
    element.position(x, y, x + width, y + height);
}