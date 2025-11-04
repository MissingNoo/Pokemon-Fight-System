ui = new window(global.game_uis.login);
username = new textbox();
username.set_align(fa_center, fa_middle);
username.backtext = "username";
password = new textbox();
password.set_align(fa_center, fa_middle);
password.backtext = "password";
login = new button("Login");
login.set_function(method(self, function() {
	new packet("login")
	.write("username", username.text)
	.write("passwordhash", sha1_string_unicode(password.text))
	.send();
}));
register = new button("Register");
register.set_function(method(self, function() {
	new packet("register")
	.write("username", username.text)
	.write("passwordhash", sha1_string_unicode(password.text))
	.send();
}));

ui.add_draw("title", 
	AirUIFunctionStart
		scribble("[c_black][fa_center][fa_middle]LOGIN").fit_to_box(_w, _h).draw(_x + _w / 2, _y + _h / 2);
	AirUIFunctionEnd
);
ui.add_draw("user_label", 
	AirUIFunctionStart
	scribble("[c_black][fa_center][fa_middle]Username").draw(_x + _w / 2, _y + _h / 2);
	AirUIFunctionEnd
);
ui.add_draw("pass_label", 
	AirUIFunctionStart
	scribble("[c_black][fa_center][fa_middle]Password").draw(_x + _w / 2, _y + _h / 2);
	AirUIFunctionEnd
);
ui.add_draw("username", 
	AirUIFunctionStart
	username.position_area(area);
	username.draw();
	AirUIFunctionEnd
);
ui.add_draw("password", 
	AirUIFunctionStart
	password.position_area(area);
	password.draw();
	AirUIFunctionEnd
);
ui.add_draw("login", 
	AirUIFunctionStart
	login.position_area(area);
	login.draw();
	AirUIFunctionEnd
);
ui.add_draw("register", 
	AirUIFunctionStart
	register.position_area(area);
	register.draw();
	AirUIFunctionEnd
);
ui.finish();