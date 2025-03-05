var socket_id = ds_map_find_value(async_load, "id");
if (socket_id = socket) {
    var type = ds_map_find_value(async_load, "type");
    switch (type) {
        case network_type_connect:
        {
            var success = ds_map_find_value(async_load, "succeeded");
            if (success = 0) {
                connected = -1;
            } else {
                new packet(Contype.Login)
                .write(buffer_string, "Airgeadlamh")
                .write(buffer_string, "123")
                .send();
                new packet(Contype.Ping).send();
                alarm[0] = -1;
                alarm[1] = 60 * 1;
            }
            break;
        }
        case network_type_data:
        { 
            var read_buffer = ds_map_find_value(async_load, "buffer");
            
            //trace($"received message {constant}\nbuffer: {read_buffer}");
            while (true) {
                //trace($"{buffer_tell(read_buffer)}:{buffer_get_size(read_buffer)}");
                if (buffer_tell(read_buffer) >= buffer_get_size(read_buffer)) {
                    break;
                }
                var constant = buffer_read(read_buffer, buffer_u16);
                trace($"Constant: {constant}");
                
                switch (constant)
                {
                    case Contype.ServerPing:
                        new packet(Contype.Ping).send();
                        break;
                    case Contype.Ping:
                        ping = ping_step;
                        alarm[0] = -1;
                        alarm[1] = 60;
                        break;
                }
            }
            break;
        }
    }

}

//var buffer = buffer_read(ds_map_values_to_array(async_load)[0], buffer_string);
//if (buffer == "") { exit; }
//var arr = string_split(buffer, ";", false);
//array_pop(arr);
//array_foreach(arr, function(_element, _index){
	//try {
		//show_debug_message("");
		//show_debug_message($"1: {_element}");
		//show_debug_message("");
		//var _json = json_parse(_element);
		//if (_json[$ "x"] != undefined) {
		    //_json.x = real(_json.x);
		//}
		//if (_json[$ "y"] != undefined) {
		    //_json.y = real(_json.y);
		//}
		//if (_json[$ "uid"] != undefined) {
		    //_json.uid = real(_json.uid);
		//}
		//if (_json[$ "type"] != undefined) {
		    //_json.type = real(_json.type);
		//}
		//if (instance_exists(oPlayer) and _json.uid == oPlayer.uid) {
		    //exit;
		//}
		//switch (int64(_json.type)) {
		    //case Contype.Join:
		        //oPlayer.uid = _json.uid;
		        //break;
				//
		    //case Contype.Update:
		        //var _found = noone;
				//var _id = _json.uid;
				//with (oSlave) {
				    //if (uid == _id) {
						//if (_json.room != room_get_name(room)) {
						    //instance_destroy();
							//break;
						//}
					    //_found = self;
					//}
				//}
				//if (_found != noone) {
					//_found.name = _json.name;
				    //_found.placeToGo[0] = _json.x;
				    //_found.placeToGo[1] = _json.y;
				//}
				//else {
					//if (string_lower(_json.room) == string_lower(room_get_name(room))) {
						//instance_create_depth(0, 0, oPlayer.depth, oSlave, {name : _json.name, uid : _json.uid, x : _json.x, y : _json.y, placeToGo : [_json.x, _json.y]});
					//}
				//}
		        //break;
				//
			//case Contype.GetCharacters:
				//oClient.loggedin = true;
				//oClient.characters = string_split(_json.characters, ";");
				//break;
		//}
	//}
	//catch (err) { show_debug_message(err)}
//});
