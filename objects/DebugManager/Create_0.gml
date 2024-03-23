show = false;
x = 100;
y = 100;
vara = 1;
varb = 1;
maxsize = 0;
maxwidth = 0;
step = 0.01;
minimized = false;
xx = x;
yy = 0;
checkbox = false;
variables = [];
yyStep = [50, 20, 30];
enum DebugTypes {
	UpDown,
	Checkbox,
	Button
}
page = 0;
pagenames = ["Battle", "Dialogo", "Respostas"];
/**
 * debug_add_config() Add an entry to the debug menu
 * @param {String} text Description
 * @param {Any*} type UpDown/Checkbox/Button
 * @param {Id.Instance} instance Instance wich contains the variable
 * @param {any*} variable Variable wich will be interacted with by the debug menu
 * @param {function} [func]=function(){} Function that will be executed in a debug_text_button when clicked
 */
 //feather disable GM2017
function debug_add_config(text, type, instance, variable, func = function(){}, page = ""){
	for (var i = 0; i < array_length(DebugManager.variables); ++i) {
	    if (DebugManager.variables[i].text == text) {
		    return;
		}
	}
	var _page = array_get_index(DebugManager.pagenames, page)
	array_push(DebugManager.variables, {text, type, instance, variable, func, page : _page});
}

function same_line(){
	//Feather disable once GM1041
	variables[array_length(variables) - 1][$ "sameLine"] = true
}

a = 0;