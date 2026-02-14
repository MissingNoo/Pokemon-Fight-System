///State Machine
state = new SnowState("Foe_Enter");
state.add("Foe_Enter",{
	step : function (){
		other_offset = approach(other_offset, 0, 5);
		if (other_offset == 0) {
			state.change("Player_Enter");
		}
	}
});
state.add("Player_Enter", {
	enter: function () {
		state.change("Menu");
	},
	step : function () {}
});

state.add("Menu", {
	enter : function () {
		battleui.set_data("info_area_panel_transparent", {image: PFSBehindBar});
		battleui.set_data("info_area2_panel_transparent", {image: PFSOptionsMenu});
		option = 0;
	}, 
	step : function () {
		var ud = -(input_check_pressed("up") * 2) + (input_check_pressed("down") * 2);
		var lr = -input_check_pressed("left") + input_check_pressed("right");
		option = clamp(option + lr + ud, 0, 3);
		if (input_check_pressed("accept")) {
			switch (option) {
				case 0:
					state.change("Use_Move");
					break;
			}
		}
	}
});

state.add("Use_Move", {
	enter : function () {
		battleui.set_data("info_area_panel_transparent", {image: PFSMoveWindow});
		battleui.set_data("info_area2_panel_transparent", {image: sBlank});
	},
	step : function () {
		var ud = -(input_check_pressed("up") * 2) + (input_check_pressed("down") * 2);
		var lr = -input_check_pressed("left") + input_check_pressed("right");
		if (option + ud + lr >= 0 and option + ud + lr < array_length(PlayerTeam[self_out].moves)) {
			option = option + lr + ud;
		}
		if (input_check_pressed("cancel")) {
			state.change("Menu");
		}
	}
});