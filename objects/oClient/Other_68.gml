//show_debug_message(ds_map_values_to_array(async_load));
var buffer = buffer_read(ds_map_values_to_array(async_load)[0], buffer_string);
if (buffer == "") { exit; }
var arr = string_split(buffer, ";", true);
array_pop(arr);
array_foreach(arr, function(_element, _index){
	try {
		var _json = json_parse(_element);
		if (_json.uid == oPlayer.uid) {
		    exit;
		}
		//if (_json.type != 0) {
		//    show_debug_message($"Buffer: {_element}");
		//}
		//show_debug_message($"Json: {json_stringify(_json, true)}");
		switch (_json.type) {
		    case Contype.Join:
		        oPlayer.uid = _json.uid;
		        break;
		    case Contype.Update:
				//show_debug_message($"Got {_json.name} data from server");
		        var _found = noone;
				var _id = _json.uid;
				with (oSlave) {
				    if (uid == _id) {
						if (_json.room != room_get_name(room)) {
						    instance_destroy();
							break;
						}
					    _found = self;
					}
				}
				if (_found != noone) {
					_found.name = _json.name;
				    _found.placeToGo[0] = _json.x;
				    _found.placeToGo[1] = _json.y;
				}
				else {
					if (string_lower(_json.room) == string_lower(room_get_name(room))) {
						instance_create_depth(0, 0, oPlayer.depth, oSlave, {name : _json.name, uid : _json.uid, x : _json.x, y : _json.y, placeToGo : [_json.x, _json.y]});
					}
				}
		        break;
		}
	}
	catch (err) { show_debug_message(err)}
});
