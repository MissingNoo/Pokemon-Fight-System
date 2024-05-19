//feather disable GM2017
show = false;
x = 100;
y = 100;
vara = 1;
varb = 1;
maxsize = 0;
maxwidth = 0;
step = 1;
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
pagenames = ["Start"];
function debug_add_config(instance, struct){
	var text = struct[$ "text"];
	var type = struct[$ "type"];
	var variable = struct[$ "variable"];
	var func = struct[$ "func"]; 
	var page = struct[$ "page"];
	for (var i = 0; i < array_length(DebugManager.variables); ++i) {
	    if (DebugManager.variables[i].text == text) {
		    return;
		}
	}
	var _page = array_get_index(DebugManager.pagenames, page);
	if (_page == -1) {
		array_push(DebugManager.pagenames, page);
		_page = array_get_index(DebugManager.pagenames, page);
	}
	array_push(DebugManager.variables, {text, type, instance, variable, func, page : _page});
	//show_message(DebugManager.variables[array_length(DebugManager.variables) - 1]);
}

function same_line(){
	//Feather disable once GM1041
	variables[array_length(variables) - 1][$ "sameLine"] = true
}

valuetest = 0;
DebugManager.debug_add_config(self, {
	text : "Value Test",
	type : DebugTypes.UpDown,
	variable : "valuetest",
	//func: function(){},
	page : "Start"
});
checkboxtest = false;
DebugManager.debug_add_config(self, {
	text : "Checkbox Test",
	type : DebugTypes.Checkbox,
	variable : "checkboxtest",
	//func: function(){},
	page : "Start"
});
checkboxtestsameline = false;
DebugManager.debug_add_config(self, {
	text : "Checkbox Test SameLine",
	type : DebugTypes.Checkbox,
	variable : "checkboxtestsameline",
	//func: function(){},
	page : "Start"
});
DebugManager.same_line();
DebugManager.debug_add_config(self, {
	text : "Button Test",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){show_message_async("Button")},
	page : "Start"
});
DebugManager.debug_add_config(self, {
	text : "Button Test SameLine",
	type : DebugTypes.Button,
	//variable : "checkboxtest",
	func: function(){show_message_async("Button 2")},
	page : "Start"
});
DebugManager.same_line();
a = 0;
b = 0;
c = 0;
d = 0;
DebugManager.debug_add_config(self, {
	text : "a",
	type : DebugTypes.UpDown,
	variable : "a",
	//func: function(){},
	page : "Battle"
});
DebugManager.debug_add_config(self, {
	text : "b",
	type : DebugTypes.UpDown,
	variable : "b",
	//func: function(){},
	page : "Battle"
});
DebugManager.debug_add_config(self, {
	text : "c",
	type : DebugTypes.UpDown,
	variable : "c",
	//func: function(){},
	page : "Battle"
});
DebugManager.debug_add_config(self, {
	text : "d",
	type : DebugTypes.UpDown,
	variable : "d",
	//func: function(){},
	page : "Battle"
});