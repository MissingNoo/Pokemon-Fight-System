randomize();
function string_contains(str, contain){
	for (var i = 1; i < string_length(str); ++i) {
		show_debug_message("");
		show_debug_message($"{string_copy(str, i, 1)} : {string_copy(contain, 1, 1)}");
	    if (string_copy(str, i, 1) == string_copy(contain, 1, 1)) {
		    if (string_copy(str, i, string_length(contain)) == contain) {
				show_debug_message("contain");
			    return true;
			}
		}
	}
	return false;
}
global.blackfade[0] = 1;
global.blackfade[1] = 0;
global.debug = string_contains(os_get_config(), "Debug");
#macro DEBUGMODE global.debug