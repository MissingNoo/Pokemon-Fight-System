#region GUI Functions
function gui_x_percent(percent) {
    var guiw = display_get_gui_width();
    return guiw * (percent / 100);
}

function gui_y_percent(percent) {
    var guih = display_get_gui_height();
    return guih * (percent / 100);
}

function gui_click(x, y, w, h) {
    if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, w, h) and device_mouse_check_button_pressed(0, mb_left)) {
        return true;
    }
    return false;
}
#endregion

#region Trace
#macro trace repeat (__trace_pre(_GMFILE_, ":" + string(_GMLINE_) + ":")) __trace
global.__trace_buf = -1;
global.__trace_map = -1;
function __trace_pre(_file, _line) {
    var _buf = global.__trace_buf;
    if (_buf == -1) {
        _buf = buffer_create(1024, buffer_grow, 1);
        global.__trace_buf = _buf;
        global.__trace_map = ds_map_create();
    } else buffer_seek(_buf, buffer_seek_start, 0);
    var _pre = global.__trace_map[?_file];
    if (_pre == undefined) {
        _pre = __trace_parse(_file);
        global.__trace_map[?_file] = _pre;
    }
    buffer_write(_buf, buffer_text, _pre);
    buffer_write(_buf, buffer_text, _line);
    return 1;
}
function __trace() {
    if (os_get_config() != "Debug") {
        return;
    }
    var _buf = global.__trace_buf;
    for (var i = 0; i < argument_count; i++) {
        buffer_write(_buf, buffer_u8, ord(" "));
        buffer_write(_buf, buffer_text, string(argument[i]));
    }
    buffer_write(_buf, buffer_u8, 0);
    buffer_seek(_buf, buffer_seek_start, 0);
    show_debug_message(buffer_read(_buf, buffer_string));
}
function __trace_parse(_file) {
    if (string_starts_with(_file, "gml_GlobalScript_")) {
        return string_delete(_file, 1, 17);
    }
    if (string_starts_with(_file, "gml_Object_")) {
        return string_delete(_file, 1, 11);
    }
    return _file;
}
#endregion

function sine_wave(time, period, amplitude, midpoint) {
    return sin(time * 2 * pi / period) * amplitude + midpoint;
}

function sine_between(time, period, minimum, maximum) {
    var midpoint = mean(minimum, maximum);
    var amplitude = maximum - midpoint;
    return sine_wave(time, period, amplitude, midpoint);
}

function approach(val1, val2, amount) {
    if (val1 < val2) {
        return min(val1 + amount, val2);
    } else {
        return max(val1 - amount, val2);
    }
}

/// @desc Converts x,y in game world to gui x,y
/// @param {real} _x x position in game world
/// @param {real} _y y position in game world
/// @returns {array<Real>} array contains x,y position in gui
function worldxy_to_guixy(_x, _y){
	var cl = camera_get_view_x(view_camera[0])
	var ct = camera_get_view_y(view_camera[0])

	var off_x = _x - cl // x is the normal x position
	var off_y = _y - ct // y is the normal y position
	// convert to gui
	var off_x_percent = off_x / camera_get_view_width(view_camera[0])
	var off_y_percent = off_y / camera_get_view_height(view_camera[0])
       
	var gui_x = off_x_percent * display_get_gui_width()
	var gui_y = off_y_percent * display_get_gui_height()
	return [gui_x,gui_y];
}

function mouse_in_area_gui(area) {
    return point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), area[0], area[1], area[2], area[3]);
}

function mouse_in_area(area) {
    return point_in_rectangle(CardGame.wc.x, CardGame.wc.y, area[0], area[1], area[2], area[3]);
}

function draw_rectangle_area(area, outline, color = [c_black, c_white], alpha = 1) {
    draw_set_alpha(alpha);
    draw_set_color(color[0]);
    draw_rectangle(area[0], area[1], area[2], area[3], false);
    draw_set_color(color[1]);
    draw_rectangle(area[0], area[1], area[2], area[3], true);
    draw_set_color(c_white);
    draw_set_alpha(1);
}

function draw_surface_part_area(surf, area) {
    draw_surface_part(surf, area[0], area[1], area[2] - area[0], area[3] - area[1], area[0], area[1]);
}

global.listboxopen = false;

function textbox() constructor {
    text = "";
    selected = false;
    area = [0, 0, 0, 0];
    func = function(){};
    
    static position = function(x, y, xx, yy) {
        area = [x, y, xx, yy];
        return self;
    }
    
    static set_function = function(f) {
        func = f;
        return self;
    }
    
    static tick = function() {
        if (device_mouse_check_button_released(0, mb_left) and gui_can_interact()) {
            if (mouse_in_area_gui(area)) {
                if (os_type == os_android) {
                    keyboard_virtual_show(kbv_type_default, kbv_returnkey_default, kbv_autocapitalize_none, false);
                }
                keyboard_lastchar = "";
                keyboard_lastkey = vk_nokey;
                selected = true;
                global.currenttextbox = self;
            } else {
                selected = false;
            }
        }
        if (selected) {
            if (keyboard_lastchar != "") {
                text += keyboard_lastchar;
                keyboard_lastchar = "";
                func();
            }
            if (keyboard_lastkey == vk_backspace) {
                text = string_copy(text, 1, string_length(text) - 2);
                //text = string_delete(text, string_length(text) - 1, 1); 
                keyboard_lastkey = vk_nokey;
            }
            
        }
        return self;
    }
    
    static draw = function() {
        tick();
        //draw_set_color(c_black);
        //draw_rectangle_area(area, false, [c_black, selected ? c_yellow : c_white]);
        draw_sprite_stretched(sInput, 0, area[0], area[1], area[2] - area[0], area[3] - area[1]);
        scribble($"[Fnt][c_black] {text}").scale_to_box(area[2] - area[0] - string_width("X") - 2, area[3] - area[1] - 3, true).draw(area[0], area[1]);
        //draw_set_color(c_white);
        return self;
    }
}

function button(_text) constructor {
    text = _text;
    area = [0, 0, 0, 0];
    enabled = true;
    gui = true;
    func = function(){};
    
    static set_gui = function(boolean) {
        gui = boolean;
        return self;
    }
    
    static set_enabled = function(boolean) {
        enabled = boolean;
        return self;
    }
    
    static position = function(x, y, xx, yy) {
        area = [x, y, xx, yy];
        return self;
    }
    
    static set_function = function(f) {
        func = f;
        return self;
    }
    
    static on_click = function() {
        if (enabled and (gui ? mouse_in_area_gui(area) : mouse_in_area(area)) and device_mouse_check_button_released(0, mb_left) and gui_can_interact()) {
            func();
        }
        return self;
    }
    
    static draw = function() { 
        on_click();
        //draw_set_color(c_black);
        //draw_rectangle_area(area, false);
        //draw_set_color(c_white);
        //draw_rectangle_area(area, true);
        var _y = area[1];
        var held = false; 
        if (enabled and ((!gui and mouse_in_area(area)) or (gui and mouse_in_area_gui(area))) and device_mouse_check_button(0, mb_left)) {
            held = true;
            _y += 3;
        }
        draw_sprite_stretched(sButton, held, area[0], area[1], area[2] - area[0], area[3] - area[1]);
        var alpha = enabled ? 1 : 0.5;
        scribble($"[Fnt][alpha,{alpha}][c_black][fa_center]{text}").scale_to_box(area[2] - area[0] - string_width("X") - 2, area[3] - area[1] - 3, true).draw(area[0] + ((area[2] - area[0]) / 2), _y - 2);
        return self;
    }
}

function listbox() constructor {
    selected = "";
    list = [];
    open = false;
    area = undefined;
    openarea = undefined;
    text = "";
    func_on_select = function(){};
    
    static position = function(x, y, xx, yy) {
        area = [x, y, xx, yy];
        openarea = variable_clone(area);
        return self;
    }
    
    static on_select = function(f) {
        func_on_select = f;
        return self;
    }
    
    static add_item = function(name) {
        array_push(list, name);
        return self;
    }
    
    static remove_item = function(name) {
        array_delete(list, array_get_index(list, name), 1);
        return self;
    }
    
    static on_click = function() {
        if (device_mouse_check_button_released(0, mb_left)) {
            if (mouse_in_area_gui(area) and gui_can_interact()) {
                global.listboxopen = true;
                open = true;
            //} else if (!mouse_in_area_gui(openarea)) {
            } else {
                global.listboxopen = false;
                open = false;
            }
        }
        return self;
    }
    
    static draw = function() {
        openarea[1] = area[1] + (area[3] - area[1]) + 2;
        on_click();
        //draw_set_color(c_black);
        //draw_rectangle_area(area, false);
        //draw_set_color(c_white);
        //draw_rectangle_area(area, true);
        draw_sprite_stretched(sInput, 0, area[0], area[1], area[2] - area[0], area[3] - area[1]);
        scribble($"[Fnt][c_black] {text}").scale_to_box(area[2] - area[0] - string_width("X") - 2, area[3] - area[1] - 3, true).draw(area[0], area[1]);
        if (open) {
            draw_sprite_stretched(sInput, 0, openarea[0], openarea[1], openarea[2] - openarea[0], openarea[3] - openarea[1]);
            //draw_set_color(c_black);
            //draw_rectangle_area(openarea, false);
            //draw_set_color(c_white);
            //draw_rectangle_area(openarea, true);
            var _y = openarea[1];
            for (var offset = 0, i = 0; i < array_length(list); i++) {
                _y = openarea[1] + offset; 
                var click_area = [openarea[0], _y, openarea[2], openarea[3]];
                if (mouse_in_area_gui(click_area) and device_mouse_check_button_pressed(0, mb_left)) {
                    text = list[i];
                    func_on_select();
                }
                scribble($"[Fnt][c_black] {list[i]}").scale(0.40).draw(openarea[0], _y);
                offset += 40;
                if (openarea[3] < _y) {
                    openarea[3] = _y + offset + 10;
                }
            }
            openarea[3] = _y + 50;
        } 
        return self;
    }
}

function gui_can_interact() {
    return !global.listboxopen;
}

global.currenttextbox = undefined;