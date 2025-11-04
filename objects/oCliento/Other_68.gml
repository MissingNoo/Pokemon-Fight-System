var socket_id = ds_map_find_value(async_load, "id");
//trace($"sid: {socket_id} : {socket}");
if (socket_id = socket) {
    var type = ds_map_find_value(async_load, "type");
    switch (type) {
        case network_type_connect:
        {
            var success = ds_map_find_value(async_load, "succeeded");
            trace($"Success: {success}");
            if (success = 0) {
                connected = -1;
            } else {
                new packet(Contype.Ping).send();
                alarm[0] = -1;
                alarm[1] = 60 * 1;
            }
            break;
        }
        case network_type_data:
        { 
            var read_buffer = ds_map_find_value(async_load, "buffer");
            while (true) {
                trace($"{buffer_tell(read_buffer)}:{buffer_get_size(read_buffer)}");
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
                    case Contype.Login:
                        instance_destroy(oUIElement);
                        instance_destroy(oLogin);
						//var a = "";
						//do {
						//    a += buffer_read(read_buffer, buffer_string);
						//} until (buffer_tell(read_buffer) == buffer_get_size(read_buffer));
						
						//PFS.playerPokemons[0] = __PFS_set_poke_data(a);
						//PFS.playerPokemons[1] = json_parse(base64_decode("eyJtb3ZlcyI6W3sicHAiOiIxNSIsImludGVybmFsTmFtZSI6IkhlYWRidXR0In0seyJwcCI6IjM1IiwiaW50ZXJuYWxOYW1lIjoiVGFja2xlIn0seyJwcCI6IjQwIiwiaW50ZXJuYWxOYW1lIjoiR3Jvd2wifSx7InBwIjoiNDAiLCJpbnRlcm5hbE5hbWUiOiJHcm93bCJ9XSwiZXZzIjp7ImF0dGFjayI6MC4wLCJkZWZlbnNlIjowLjAsImhwIjowLjAsImV2YXNpb24iOjAuMCwic3BhdHRhY2siOjAuMCwic3BkZWZlbnNlIjowLjAsInNwZWVkIjowLjAsImFjY3VyYWN5IjowLjB9LCJuYXR1cmUiOjEzLjAsInNoaW55IjpmYWxzZSwic3RhdHVzQWlsbWVudHMiOltdLCJpbnRlcm5hbE5hbWUiOiJTbG93YnJvIiwiZ2VuZGVyIjowLjAsImFiaWxpdHkiOltbMTIuMCwwLjBdLFswLjAsMC4wXSxbMTQ0LjAsMS4wXV19"));
						//PFS.playerPokemons[5] = json_parse(base64_decode("eyJtb3ZlcyI6W3siZWZmZWN0X2NoYW5jZSI6MzAuMCwicHJpb3JpdHkiOjAuMCwibWF4cHAiOiIxNSIsImlkZW50aWZpZXIiOiJoZWFkYnV0dCIsInR5cGUiOjAsImNhdGVnb3J5IjowLCJwcCI6IjE1IiwiYWNjdXJhY3kiOiIxMDAiLCJpZCI6MjkuMCwiZmxhZ3MiOlsxLjAsNC4wLDcuMF0sImludGVybmFsTmFtZSI6IkhlYWRidXR0IiwicHJvYmFiaWxpdHkiOiIwIiwiZGFtYWdlX2NsYXNzX2lkIjoyLjAsIm1wb3dlciI6IjcwIiwiZWZmZWN0X2lkIjozMi4wfSx7ImVmZmVjdF9jaGFuY2UiOjAuMCwicHJpb3JpdHkiOjAuMCwibWF4cHAiOiIzNSIsImlkZW50aWZpZXIiOiJ0YWNrbGUiLCJ0eXBlIjowLCJjYXRlZ29yeSI6MCwicHAiOiIzNSIsImFjY3VyYWN5IjoiMTAwIiwiaWQiOjMzLjAsImZsYWdzIjpbMS4wLDQuMCw3LjBdLCJpbnRlcm5hbE5hbWUiOiJUYWNrbGUiLCJwcm9iYWJpbGl0eSI6IjAiLCJkYW1hZ2VfY2xhc3NfaWQiOjIuMCwibXBvd2VyIjoiNDAiLCJlZmZlY3RfaWQiOjEuMH0seyJlZmZlY3RfY2hhbmNlIjoxMDAuMCwicHJpb3JpdHkiOjAuMCwibWF4cHAiOiI0MCIsImlkZW50aWZpZXIiOiJncm93bCIsInR5cGUiOjAsImNhdGVnb3J5IjoyLCJwcCI6IjQwIiwiYWNjdXJhY3kiOiIxMDAiLCJpZCI6NDUuMCwiZmxhZ3MiOls0LjAsNS4wLDcuMCw5LjAsMTQuMF0sImludGVybmFsTmFtZSI6Ikdyb3dsIiwicHJvYmFiaWxpdHkiOiIwIiwiZGFtYWdlX2NsYXNzX2lkIjoxLjAsIm1wb3dlciI6IiIsImVmZmVjdF9pZCI6MTkuMH0seyJlZmZlY3RfY2hhbmNlIjoxMDAuMCwicHJpb3JpdHkiOjAuMCwibWF4cHAiOiI0MCIsImlkZW50aWZpZXIiOiJncm93bCIsInR5cGUiOjAsImNhdGVnb3J5IjoyLCJwcCI6IjQwIiwiYWNjdXJhY3kiOiIxMDAiLCJpZCI6NDUuMCwiZmxhZ3MiOls0LjAsNS4wLDcuMCw5LjAsMTQuMF0sImludGVybmFsTmFtZSI6Ikdyb3dsIiwicHJvYmFiaWxpdHkiOiIwIiwiZGFtYWdlX2NsYXNzX2lkIjoxLjAsIm1wb3dlciI6IiIsImVmZmVjdF9pZCI6MTkuMH1dLCJ3ZWlnaHQiOiI3ODUiLCJiYXNlX2V4cGVyaWVuY2UiOiIxNzIiLCJvcmRlciI6IjEyNyIsImlzX2RlZmF1bHQiOiIxIiwiZWZmb3J0Ijp7ImhwIjowLjAsImRlZmVuc2UiOjIuMCwic3BhdHRhY2siOjAuMCwic3BkZWZlbnNlIjowLjAsInNwZWVkIjowLjAsImF0dGFjayI6MC4wfSwic3BlZWQiOjM3LjAsIndpbGRsZXZlbHJhbmdlIjpbNS4wLDEwMC4wXSwiY2FuTGVhcm4iOnsibGV2ZWwiOlt7ImlkIjoiMjkiLCJsZXZlbCI6IjI1In0seyJpZCI6IjMzIiwibGV2ZWwiOiIxIn0seyJpZCI6IjQ1IiwibGV2ZWwiOiIxIn0seyJpZCI6IjQ1IiwibGV2ZWwiOiI2In0seyJpZCI6IjUwIiwibGV2ZWwiOiIyMCJ9LHsiaWQiOiI1NSIsImxldmVsIjoiMTEifSx7ImlkIjoiOTMiLCJsZXZlbCI6IjE1In0seyJpZCI6Ijk0IiwibGV2ZWwiOiI1NCJ9LHsiaWQiOiIxMTAiLCJsZXZlbCI6IjM3In0seyJpZCI6IjEzMyIsImxldmVsIjoiNDcifSx7ImlkIjoiMTc0IiwibGV2ZWwiOiIxIn0seyJpZCI6IjI0MCIsImxldmVsIjoiNjEifSx7ImlkIjoiMjQ0IiwibGV2ZWwiOiI2NyJ9LHsiaWQiOiIyODEiLCJsZXZlbCI6IjEifSx7ImlkIjoiMzAzIiwibGV2ZWwiOiI0MSJ9LHsiaWQiOiIzNTIiLCJsZXZlbCI6IjI5In0seyJpZCI6IjQyOCIsImxldmVsIjoiMzQifV19LCJmbGluY2giOmZhbHNlLCJiYXNlIjp7ImhwIjoxNTcuMCwiZGVmZW5zZSI6MTI0LjAsInNwYXR0YWNrIjoxMDkuMCwic3BkZWZlbnNlIjo5MC4wLCJzcGVlZCI6MzcuMCwiYXR0YWNrIjo4My4wfSwiaWQiOiI4MCIsImhwIjoxNTcuMCwiaXZzIjp7ImF0dGFjayI6MTEuMCwiaHAiOjEwLjAsImV2YXNpb24iOjI3LjAsImRlZmVuc2UiOjI0LjAsInNwYXR0YWNrIjoxNi4wLCJzcGRlZmVuc2UiOjE0LjAsInNwZWVkIjo2LjAsImFjY3VyYWN5Ijo0LjB9LCJldnMiOnsiYXR0YWNrIjowLjAsImhwIjowLjAsImV2YXNpb24iOjAuMCwiZGVmZW5zZSI6MC4wLCJzcGF0dGFjayI6MC4wLCJzcGRlZmVuc2UiOjAuMCwic3BlZWQiOjAuMCwiYWNjdXJhY3kiOjAuMH0sIm5hdHVyZSI6MTMuMCwic2hpbnkiOmZhbHNlLCJiYXNlY2FsYyI6eyJocCI6OTUuMCwiZGVmZW5zZSI6MTEwLjAsInNwYXR0YWNrIjoxMDAuMCwic3BkZWZlbnNlIjo4MC4wLCJzcGVlZCI6MzAuMCwiYXR0YWNrIjo3NS4wfSwidGF1bnRlZCI6ZmFsc2UsImhlaWdodCI6IjE2IiwiaWRlbnRpZmllciI6InNsb3dicm8iLCJ0eXBlIjpbMiwxMF0sImxldmVsIjo0OS4wLCJzdGF0dXNBaWxtZW50cyI6W10sImF0dGFjayI6ODMuMCwiZGVmZW5zZSI6MTI0LjAsInNwYXR0YWNrIjoxMTAuMCwic3BkZWZlbnNlIjo5MC4wLCJpbnRlcm5hbE5hbWUiOiJTbG93YnJvIiwic3BlY2llc19pZCI6IjgwIiwiZ2VuZGVyIjowLCJhYmlsaXR5IjpbWzEyLjAsMC4wXSxbMC4wLDAuMF0sWzE0NC4wLDEuMF1dfQ=="));
						PFS.playerPokemons[0] = __PFS_generate_pokemon(PFS.Pokes[1]);
						PFS.playerPokemons[1] = __PFS_generate_pokemon(PFS.Pokes[10]);
						PFS.playerPokemons[2] = __PFS_generate_pokemon(PFS.Pokes[10]);
						PFS.playerPokemons[3] = __PFS_generate_pokemon(PFS.Pokes[1]);
						PFS.playerPokemons[4] = __PFS_generate_pokemon(PFS.Pokes[1]);
						PFS.playerPokemons[5] = __PFS_generate_pokemon(PFS.Pokes[80]);
						//var p0 = variable_clone(PlayerTeam[0]);
						//var _names = struct_get_names(p0);
						//global.keep = ["moves", "evs", "internalName", "gender", "ability", "statusAilments", "shiny", "nature", "pp"];
						//for (var i = 0; i < array_length(_names); ++i) {
						//    if (!array_contains(global.keep, _names[i])) {
						//	    struct_remove(p0, _names[i]);
						//	}
						//}
						//keepdata = function(e, i) {
						//	var _names = struct_get_names(e);
						//	for (var j = 0; j < array_length(_names); ++j) {
						//	    if (!array_contains(global.keep, _names[j])) {
						//		    struct_remove(e, _names[j]);
						//		}
						//	}
						//}
						//array_foreach(p0.moves, keepdata);
						//show_debug_message(base64_encode(json_stringify(p0)));
						//show_message("");
						//b = base64_encode(json_stringify(PlayerTeam[0]));
						//c = base64_encode(json_stringify(PlayerTeam[5]));
						
						//show_message(b == c);
						create_ui(global.player_info_ui);
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
