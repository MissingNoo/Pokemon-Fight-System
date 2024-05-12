typist = scribble_typist();
typist.in(1, 0);
typist.function_on_complete(function(){showOptions = true;})
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
dialogFontSize = 2;
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
dialogAnswerX = 10;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerX",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerX",
	//func: function(){},
	page : "Start2"
});
dialogAnswerY = 10;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerY",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerY",
	//func: function(){},
	page : "Start2"
});
dialogAnswerOffset = 30;
DebugManager.debug_add_config(self, {
	text : "dialogAnswerOffset",
	type : DebugTypes.UpDown,
	variable : "dialogAnswerOffset",
	//func: function(){},
	page : "Start2"
});
#endregion
#endregion