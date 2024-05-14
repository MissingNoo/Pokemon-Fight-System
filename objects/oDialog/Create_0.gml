typist = scribble_typist();
typist.in(1, 0);
//typist.function_on_complete()
scribble_typists_add_event("showoptions", function(){showOptions = true;});
canDestroy = false;
alarm[0] = 10;
scr = scribble("");
canInteract = false;
showOptions = false;
selectedOption = 0;
enum Interactions {
	Destroy,
	NextPage,
	AcceptOption,
	Skip
}
acceptedOption = "";
interaction = Interactions.NextPage;

#region Dialog
canOpenDialog = true;
dialogBoxX = 10;
DebugManager.debug_add_config(self, {
	text : "dialogBoxX",
	type : DebugTypes.UpDown,
	variable : "dialogBoxX",
	//func: function(){},
	page : "Start"
});
dialogBoxY = 345;
DebugManager.debug_add_config(self, {
	text : "dialogBoxY",
	type : DebugTypes.UpDown,
	variable : "dialogBoxY",
	//func: function(){},
	page : "Start"
});
dialogBoxEndX = 700;
DebugManager.debug_add_config(self, {
	text : "dialogBoxEndX",
	type : DebugTypes.UpDown,
	variable : "dialogBoxEndX",
	//func: function(){},
	page : "Start"
});
dialogBoxEndY = 125;
DebugManager.debug_add_config(self, {
	text : "dialogBoxEndY",
	type : DebugTypes.UpDown,
	variable : "dialogBoxEndY",
	//func: function(){},
	page : "Start"
});
dialogTextX = 40;
DebugManager.debug_add_config(self, {
	text : "dialogTextX",
	type : DebugTypes.UpDown,
	variable : "dialogTextX",
	//func: function(){},
	page : "Start2"
});
dialogTextY = 370;
DebugManager.debug_add_config(self, {
	text : "dialogTextY",
	type : DebugTypes.UpDown,
	variable : "dialogTextY",
	//func: function(){},
	page : "Start2"
});
dialogFontSize = 1;
DebugManager.debug_add_config(self, {
	text : "dialogFontSize",
	type : DebugTypes.UpDown,
	variable : "dialogFontSize",
	//func: function(){},
	page : "Start2"
});
dialogWrap = 630;
DebugManager.debug_add_config(self, {
	text : "dialogWrap",
	type : DebugTypes.UpDown,
	variable : "dialogWrap",
	//func: function(){},
	page : "Start2"
});
#region Respostas
dialogAnswerX = 500;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerX",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerX",
	//func: function(){},
	page : "Start3"
});
dialogAnswerY = 210;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerY",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerY",
	//func: function(){},
	page : "Start3"
});
dialogAnswerEndX = 180;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerEndX",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerEndX",
	//func: function(){},
	page : "Start3"
});
dialogAnswerEndY = 120;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerEndY",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerEndY",
	//func: function(){},
	page : "Start3"
});
dialogAnswerScale = 1;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerScale",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerScale",
	//func: function(){},
	page : "Start3"
});
dialogAnswerTextX = 35;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerTextX",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerTextX",
	//func: function(){},
	page : "Start3"
});
dialogAnswerTextY = 42;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerTextY",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerTextY",
	//func: function(){},
	page : "Start3"
});
dialogAnswerOffset = 45;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerOffset",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerOffset",
	//func: function(){},
	page : "Start3"
});
#endregion
#endregion

function nextPage(){
	if (scr.get_page() < scr.get_page_count()) {
		scr.page(scr.get_page() + 1);
		show_debug_message("Next page");
		interaction = Interactions.Skip;
	}
}