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