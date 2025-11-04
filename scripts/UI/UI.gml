#macro Lorem "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas efficitur neque vitae dolor commodo, vitae pretium massa tincidunt. Cras non mattis elit. Quisque finibus ligula turpis, et placerat erat efficitur eget. Quisque ex justo, scelerisque ac dignissim nec, malesuada vel quam. Etiam ut felis arcu. Nulla facilisi. Etiam euismod viverra lectus, quis gravida eros iaculis id. Nullam gravida, augue id efficitur ullamcorper, nulla ligula commodo metus, in ultrices erat ante a velit. In vehicula mollis justo, et luctus dolor. Nullam nec efficitur nibh. Maecenas sagittis sem vitae mi rutrum, ac mattis eros molestie. Etiam elit magna, pharetra eu accumsan non, cursus in turpis. Pellentesque in fermentum mi, nec fermentum elit."
global.game_uis = {};
global.game_uis.main_menu = {
	"name": "main_panel",
	"left": 275.0,
	"top": 50.0,
	"width": 1280.0,
	"data": {},
	"height": 720.0,
	"nodes": [
		{
			"name": "top_panel_grid",
			"flexDirection": "row",
			"left": 0.0,
			"flex": 1.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"nodes": [
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel1",
				},
				{
					"margin": 0.0,
					"name": "grid_panel2",
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				},
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel3",
				}
			],
		},
		{
			"name": "middle_panel_grid",
			"flexDirection": "row",
			"left": 0.0,
			"flex": 1.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"nodes": [
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel4",
				},
				{
					"margin": 0.0,
					"name": "grid_panel5",
					"flexDirection": "row",
					"border": 0.0,
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {"image": ""},
				},
				{
					"name": "grid_panel6",
					"flexBasis": 0.0,
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				}
			],
		},
		{
			"name": "bottom_panel_grid",
			"flexDirection": "row",
			"left": 0.0,
			"flex": 1.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"nodes": [
				{
					"margin": 0.0,
					"name": "grid_panel7",
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				},
				{
					"name": "grid_panel8",
					"flexDirection": "row",
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"nodes": [
						{
							"name": "panel_68989",
							"flex": 1.0,
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"height": 60.0,
						},
						{
							"name": "menu_options",
							"flex": 4.0,
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"marginTop": -43.0,
							"marginBottom": 128.0,
						},
						{
							"name": "panel_39867",
							"flex": 1.0,
							"padding": 10.0,
							"width": 60.0,
							"data": {},
							"height": 60.0,
						}
					],
				},
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel9",
				}
			],
		}
	],
};

global.game_uis.rooms = {
	"name": "main_panel",
	"nodes": [
		{
			"flex": 1.0,
			"name": "top_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel1",
				},
				{
					"flex": 1.0,
					"name": "grid_panel2",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"margin": 0.0,
				},
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel3",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		},
		{
			"flex": 1.0,
			"name": "middle_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel4",
				},
				{
					"flex": 1.0,
					"name": "grid_panel5",
					"nodes": [
						{
							"flex": 1.0,
							"name": "join_panel",
							"nodes": [
								{
									"padding": 0.0,
									"width": 60.0,
									"data": {},
									"height": 16.0,
									"name": "join_label",
								},
								{
									"name": "code_panel",
									"nodes": [
										{
											"flex": 1.0,
											"name": "code_label",
											"padding": 10.0,
											"width": 60.0,
											"data": {},
											"height": 25.0,
										},
										{
											"flex": 1.0,
											"name": "spacer",
											"padding": 10.0,
											"width": 60.0,
											"data": {},
											"height": 25.0,
										},
										{
											"marginRight": 4.0,
											"name": "code_input",
											"marginLeft": 0.0,
											"top": 0.0,
											"width": 152.0,
											"data": {},
											"height": 25.0,
										},
										{
											"top": 0.0,
											"width": 160.0,
											"data": {},
											"height": 25.0,
											"name": "join_button",
										},
										{
											"padding": 10.0,
											"width": 32.0,
											"marginLeft": 5.0,
											"data": {},
											"height": 25.0,
											"name": "reload_button",
										}
									],
									"marginTop": 14.0,
									"marginBottom": 0.0,
									"padding": 10.0,
									"data": {"tags": ["fg"]},
									"height": 41.0,
									"flexDirection": "row",
								},
								{
									"flex": 1.0,
									"name": "panel_51891",
									"nodes": [
										{
											"name": "filters",
											"marginTop": 10.0,
											"minWidth": 211.0,
											"padding": 10.0,
											"width": 60.0,
											"data": {"tags": ["fg"]},
										},
										{
											"flex": 1.0,
											"name": "room_panel",
											"nodes": [
												{
													"flex": 1.0,
													"padding": 10.0,
													"marginRight": 12.0,
													"data": {},
													"name": "room_list",
												}
											],
											"marginLeft": 5.0,
											"marginTop": 10.0,
											"padding": 10.0,
											"width": 60.0,
											"data": {"tags": ["fg"]},
										}
									],
									"padding": 0.0,
									"data": {},
									"height": 60.0,
									"flexDirection": "row",
								}
							],
							"marginTop": -98.0,
							"marginBottom": 0.0,
							"maxHeight": 361.0,
							"padding": 10.0,
							"minHeight": 435.0,
							"data": {"tags": ["bg"]},
						}
					],
					"border": 0.0,
					"minWidth": 515.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"margin": 0.0,
				},
				{
					"flex": 1.0,
					"flexBasis": 0.0,
					"name": "grid_panel6",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		},
		{
			"flex": 1.0,
			"name": "bottom_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"name": "grid_panel7",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"margin": 0.0,
				},
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel8",
				},
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel9",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		}
	],
	"left": 275.0,
	"top": 50.0,
	"width": 1280.0,
	"data": {"image": "sJoin"},
	"height": 720.0,
};

global.game_uis.create = {
	"name": "main_panel",
	"nodes": [
		{
			"flex": 1.0,
			"name": "top_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel1",
				},
				{
					"flex": 1.0,
					"name": "grid_panel2",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"margin": 0.0,
				},
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel3",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		},
		{
			"flex": 1.0,
			"name": "middle_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel4",
				},
				{
					"flex": 1.0,
					"nodes": [
						{
							"flex": 1.0,
							"name": "create_panel",
							"nodes": [
								{
									"padding": 10.0,
									"width": 90.0,
									"data": {"text": "[c_black][fa_middle]Create game"},
									"height": 30.0,
									"name": "create_label",
								},
								{
									"flex": 1.0,
									"marginRight": 8.0,
									"name": "options_panel",
									"nodes": [
										{
											"flex": 0.0,
											"name": "name_panel",
											"nodes": [
												{
													"padding": 0.0,
													"width": 140.0,
													"data": {
														"text": "[c_black][fa_middle]Join game",
													},
													"name": "display_label",
												},
												{
													"flex": 1.0,
													"padding": 10.0,
													"width": 30.0,
													"data": {},
													"name": "spacer_n",
												},
												{
													"padding": 10.0,
													"maxWidth": 540.0,
													"flex": 4.0,
													"data": {},
													"name": "name_input",
												}
											],
											"marginTop": 0.0,
											"padding": 0.0,
											"data": {},
											"height": 22.0,
											"flexDirection": "row",
										},
										{
											"name": "type_panel",
											"nodes": [
												{
													"padding": 10.0,
													"width": 60.0,
													"data": {
														"text": "[c_black][fa_middle]Type:",
													},
													"name": "type_label",
												},
												{
													"flex": 1.0,
													"padding": 10.0,
													"width": 60.0,
													"data": {},
													"name": "panel_58488",
												},
												{
													"padding": 10.0,
													"width": 180.0,
													"data": {},
													"name": "type_selection",
												}
											],
											"marginTop": 7.0,
											"padding": 0.0,
											"data": {},
											"height": 22.0,
											"flexDirection": "row",
										},
										{
											"name": "maxplayer_panel",
											"nodes": [
												{
													"padding": 10.0,
													"width": 60.0,
													"data": {
														"text": "[c_black][fa_middle]Max Players:",
													},
													"name": "panel_80175",
												},
												{
													"flex": 1.0,
													"padding": 10.0,
													"width": 60.0,
													"name": "panel_86844",
												},
												{
													"padding": 10.0,
													"width": 180.0,
													"data": {},
													"name": "maxp_selection",
												}
											],
											"marginTop": 7.0,
											"padding": 0.0,
											"data": {},
											"height": 22.0,
											"flexDirection": "row",
										},
										{
											"name": "request_panel",
											"nodes": [
												{
													"padding": 10.0,
													"width": 60.0,
													"data": {
														"text": "[c_black][fa_middle]Request to join:",
													},
													"name": "panel_87494",
												},
												{
													"flex": 1.0,
													"padding": 10.0,
													"width": 60.0,
													"data": {},
													"name": "panel_52992",
												},
												{
													"padding": 10.0,
													"width": 180.0,
													"data": {},
													"name": "request_selection",
												}
											],
											"marginTop": 7.0,
											"padding": 0.0,
											"data": {},
											"height": 22.0,
											"flexDirection": "row",
										},
										{
											"flex": 1.0,
											"name": "end_spacer",
											"padding": 0.0,
											"width": 60.0,
											"data": {},
											"height": 0.0,
										},
										{
											"flex": 0.0,
											"name": "end_panel",
											"nodes": [
												{
													"flex": 1.0,
													"name": "spacer",
													"padding": 10.0,
													"width": 60.0,
													"data": {},
													"margin": 9.0,
												},
												{
													"padding": 0.0,
													"width": 60.0,
													"marginRight": 50.0,
													"data": {},
													"name": "create_b_panel",
													"nodes": [
														{
															"flex": 1.0,
															"name": "create_b_spacer",
															"padding": 10.0,
															"width": 60.0,
															"data": {},
															"height": 60.0,
														},
														{
															"flex": 0.0,
															"name": "create_button",
															"padding": 10.0,
															"width": 165.0,
															"data": {},
															"height": 40.0,
														}
													],
												}
											],
											"marginTop": 0.0,
											"padding": 0.0,
											"top": 0.0,
											"data": {},
											"height": 60.0,
											"flexDirection": "row",
											"margin": 0.0,
										}
									],
									"marginLeft": 6.0,
									"marginTop": 8.0,
									"marginBottom": 10.0,
									"padding": 10.0,
									"data": {"tags": ["fg"]},
									"height": 150.0,
								}
							],
							"padding": 10.0,
							"data": {"tags": ["bg"]},
						}
					],
					"border": 0.0,
					"minWidth": 511.0,
					"width": 60.0,
					"data": {},
					"height": 302.0,
					"name": "grid_panel5",
					"padding": 0.0,
					"minHeight": 0.0,
					"margin": 0.0,
				},
				{
					"flex": 1.0,
					"flexBasis": 0.0,
					"name": "grid_panel6",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 633.0,
			"flexDirection": "row",
		},
		{
			"flex": 1.0,
			"name": "bottom_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"name": "grid_panel7",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"margin": 0.0,
				},
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel8",
				},
				{
					"flex": 1.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"name": "grid_panel9",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": -27590.0,
			"flexDirection": "row",
		}
	],
	"left": 275.0,
	"top": 50.0,
	"width": 1280.0,
	"data": {"image": "sCreate"},
	"height": 720.0,
};

global.game_uis.login = {
	"name": "main_panel",
	"nodes": [
		{
			"flex": 1.0,
			"name": "top_panel_grid",
			"nodes": [
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel1",
				},
				{
					"flex": 1.0,
					"name": "grid_panel2",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"margin": 0.0,
				},
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel3",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		},
		{
			"flex": 1.0,
			"name": "middle_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"name": "grid_panel4",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"margin": 0.0,
				},
				{
					"alignItems": "center",
					"flex": 1.0,
					"name": "grid_panel5",
					"border": 0.0,
					"nodes": [
						{
							"name": "login_panel",
							"nodes": [
								{
									"padding": 10.0,
									"data": {"tags": ["fg"]},
									"height": 25.0,
									"name": "title",
									"margin": 5.0,
								},
								{
									"flex": 1.0,
									"name": "body_panel",
									"nodes": [
										{
											"flex": 1.0,
											"name": "user_label",
											"padding": 10.0,
											"width": 60.0,
											"data": {},
											"height": 60.0,
											"alignSelf": "center",
										},
										{
											"padding": 10.0,
											"data": {"tags": ["input"]},
											"height": 60.0,
											"name": "username",
										},
										{
											"flex": 1.0,
											"name": "pass_label",
											"marginTop": 5.0,
											"padding": 10.0,
											"width": 60.0,
											"minHeight": 0.0,
											"data": {},
											"height": 60.0,
											"alignSelf": "center",
										},
										{
											"padding": 10.0,
											"data": {"tags": ["input"]},
											"height": 60.0,
											"name": "password",
										},
										{
											"name": "btn_panel",
											"nodes": [
												{
													"padding": 10.0,
													"width": 60.0,
													"flex": 1.0,
													"data": {},
													"name": "spacer1",
												},
												{
													"padding": 10.0,
													"width": 60.0,
													"flex": 3.0,
													"data": {"tags": ["button"]},
													"name": "login",
												},
												{
													"flex": 1.0,
													"name": "spacer3",
													"padding": 10.0,
													"width": 60.0,
													"data": {},
													"height": 60.0,
												},
												{
													"padding": 10.0,
													"width": 60.0,
													"flex": 3.0,
													"data": {"tags": ["button"]},
													"name": "register",
												},
												{
													"padding": 10.0,
													"width": 60.0,
													"flex": 1.0,
													"data": {},
													"name": "spacer2",
												}
											],
											"left": 0.0,
											"padding": 5.0,
											"data": {},
											"height": 60.0,
											"flexDirection": "row",
										}
									],
									"padding": 10.0,
									"data": {},
									"height": 60.0,
								}
							],
							"padding": 0.0,
							"top": -30.0,
							"width": 450.0,
							"data": {"tags": ["bg"]},
							"height": 300.0,
							"alignSelf": "center",
						}
					],
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"margin": 0.0,
				},
				{
					"flexBasis": 0.0,
					"flex": 1.0,
					"name": "grid_panel6",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		},
		{
			"flex": 1.0,
			"name": "bottom_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"name": "grid_panel7",
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"margin": 0.0,
				},
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel8",
				},
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel9",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		}
	],
	"left": 275.0,
	"top": 50.0,
	"width": 1280.0,
	"data": {},
	"height": 720.0,
};

global.game_uis.chat = {
	"name": "main_panel",
	"nodes": [
		{
			"flex": 1.0,
			"name": "top_panel_grid",
			"nodes": [
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel1",
				},
				{
					"flex": 1.0,
					"name": "grid_panel2",
					"margin": 0.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				},
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel3",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		},
		{
			"flex": 1.0,
			"name": "middle_panel_grid",
			"nodes": [
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel4",
				},
				{
					"flex": 1.0,
					"name": "grid_panel5",
					"margin": 0.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"border": 0.0,
				},
				{
					"flex": 1.0,
					"name": "grid_panel6",
					"flexBasis": 0.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		},
		{
			"flex": 1.0,
			"name": "bottom_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"name": "grid_panel7",
					"margin": 0.0,
					"nodes": [
						{
							"flex": 1.0,
							"name": "chat_panel",
							"margin": 10.0,
							"nodes": [
								{
									"padding": 10.0,
									"data": {"tags": ["fg"]},
									"flex": 1.0,
									"height": 60.0,
									"name": "messages",
								},
								{
									"padding": 10.0,
									"data": {"tags": ["input"]},
									"height": 25.0,
									"name": "text_input",
								}
							],
							"padding": 10.0,
							"data": {"tags": ["bg"]},
							"height": 60.0,
							"border": 0.0,
						}
					],
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				},
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel8",
				},
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel9",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		}
	],
	"left": 275.0,
	"top": 50.0,
	"width": 1280.0,
	"data": {},
	"height": 720.0,
};

global.game_uis.friend_list = {
	"name": "main_panel",
	"nodes": [
		{
			"flex": 1.0,
			"name": "top_panel_grid",
			"nodes": [
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel1",
				},
				{
					"flex": 1.0,
					"name": "grid_panel2",
					"margin": 0.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				},
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel3",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		},
		{
			"flex": 3.0,
			"name": "middle_panel_grid",
			"nodes": [
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel4",
				},
				{
					"flex": 3.0,
					"name": "grid_panel5",
					"margin": 0.0,
					"nodes": [
						{
							"flex": 1.0,
							"name": "friend_list_panel",
							"nodes": [
								{
									"flex": 0.0,
									"name": "title_panel",
									"nodes": [
										{
											"padding": 10.0,
											"width": 60.0,
											"flex": 1.0,
											"data": {},
											"name": "panel_21366",
										},
										{
											"padding": 10.0,
											"width": 60.0,
											"flex": 1.0,
											"data": {"tags": []},
											"name": "title",
										},
										{
											"padding": 10.0,
											"width": 60.0,
											"flex": 1.0,
											"data": {},
											"name": "panel_82408",
										}
									],
									"padding": 0.0,
									"data": {"tags": ["fg"]},
									"height": 40.0,
									"flexDirection": "row",
								},
								{
									"padding": 10.0,
									"data": {"tags": ["fg"]},
									"flex": 1.0,
									"name": "friend_list",
									"margin": 10.0,
								}
							],
							"padding": 10.0,
							"data": {"tags": ["bg"]},
							"height": 60.0,
						}
					],
					"padding": 0.0,
					"width": 60.0,
					"data": {},
					"border": 0.0,
				},
				{
					"flex": 1.0,
					"name": "grid_panel6",
					"padding": 0.0,
					"width": 60.0,
					"flexBasis": 0.0,
					"data": {},
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		},
		{
			"flex": 1.0,
			"name": "bottom_panel_grid",
			"nodes": [
				{
					"flex": 1.0,
					"name": "grid_panel7",
					"margin": 0.0,
					"padding": 0.0,
					"width": 60.0,
					"data": {},
				},
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel8",
				},
				{
					"padding": 0.0,
					"width": 60.0,
					"flex": 1.0,
					"data": {},
					"name": "grid_panel9",
				}
			],
			"left": 0.0,
			"padding": 0.0,
			"top": 0.0,
			"data": {},
			"height": 300.0,
			"flexDirection": "row",
		}
	],
	"left": 275.0,
	"top": 50.0,
	"width": 1280.0,
	"data": {},
	"height": 720.0,
};

global.game_uis.context_menu = {
	"nodes": [
		{"padding": 10.0, "data": {"tags": ["fg"]}, "height": 15.0, "name": "title"},
		{
			"padding": 10.0,
			"data": {"tags": ["fg"]},
			"height": 60.0,
			"name": "list",
			"marginTop": 5.0,
			"flex": 1.0,
		}
	],
	"name": "main_panel",
	"left": 275.0,
	"padding": 5.0,
	"top": 50.0,
	"width": 200.0,
	"data": {"tags": ["bg"]},
	"height": 300.0,
};

global.game_uis.stage = {
	"nodes": [
		{
			"padding": 0.0,
			"flex": 1.0,
			"nodes": [
				{
					"padding": 0.0,
					"positionType": "absolute",
					"nodes": [
						{
							"padding": 0.0,
							"flex": 1.0,
							"nodes": [
								{
									"minHeight": 31.0,
									"maxHeight": 0.0,
									"padding": 10.0,
									"maxWidth": 33.0,
									"flex": 1.0,
									"width": 60.0,
									"name": "coin",
									"data": {},
								},
								{
									"minHeight": 31.0,
									"maxHeight": 31.0,
									"padding": 10.0,
									"flex": 1.0,
									"width": 60.0,
									"name": "money",
									"data": {},
									"margin": 0.0,
								}
							],
							"name": "panel_12663",
							"height": 60.0,
							"data": {},
							"flexDirection": "row",
						},
						{
							"padding": 0.0,
							"flex": 1.0,
							"nodes": [
								{
									"marginTop": 1.0,
									"padding": 10.0,
									"maxWidth": 33.0,
									"flex": 1.0,
									"width": 60.0,
									"name": "killspr",
									"data": {},
								},
								{
									"marginTop": 1.0,
									"padding": 10.0,
									"flex": 1.0,
									"width": 60.0,
									"name": "kills",
									"data": {},
									"margin": 0.0,
								}
							],
							"name": "panel_54087",
							"height": 58.0,
							"data": {},
							"flexDirection": "row",
							"margin": 0.0,
						}
					],
					"width": 70.0,
					"name": "runinfo",
					"height": 65.0,
					"top": 32.0,
					"data": {},
					"left": 1052.0,
				},
				{
					"maxHeight": 41.0,
					"padding": 0.0,
					"flex": 1.0,
					"name": "xp",
					"height": 71.0,
					"data": {"image": "sExpBarBG"},
				},
				{
					"minHeight": 160.0,
					"maxHeight": 0.0,
					"padding": 0.0,
					"maxWidth": 0.0,
					"flex": 1.0,
					"nodes": [
						{
							"padding": 10.0,
							"width": 90.0,
							"name": "portrait",
							"height": 83.0,
							"top": 0.0,
							"data": {"image": "sUiPortraitFrame"},
						},
						{
							"marginTop": 89.0,
							"padding": 0.0,
							"positionType": "absolute",
							"marginLeft": 31.0,
							"width": 58.0,
							"name": "special_timer",
							"height": 18.0,
							"marginRight": 0.0,
							"data": {},
						},
						{
							"minHeight": 158.0,
							"maxHeight": 158.0,
							"padding": 0.0,
							"maxWidth": 319.0,
							"flex": 1.0,
							"nodes": [
								{
									"name": "hpbar",
									"height": 17.0,
									"padding": 0.0,
									"data": {},
								},
								{
									"padding": 4.0,
									"flex": 1.0,
									"nodes": [
										{
											"padding": 0.0,
											"flex": 1.0,
											"nodes": [
												{
													"name": "w0",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												},
												{
													"name": "w1",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												},
												{
													"padding": 10.0,
													"flex": 1.0,
													"width": 60.0,
													"name": "w2",
													"data": {},
													"flexDirection": "row",
												},
												{
													"name": "w3",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												},
												{
													"name": "w4",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												},
												{
													"name": "w5",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												}
											],
											"name": "weapons_panel",
											"height": 60.0,
											"data": {},
											"flexDirection": "row",
										},
										{
											"padding": 0.0,
											"flex": 1.0,
											"nodes": [
												{
													"name": "i0",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												},
												{
													"name": "i1",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												},
												{
													"name": "i2",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												},
												{
													"name": "i3",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												},
												{
													"name": "i4",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												},
												{
													"name": "i5",
													"padding": 10.0,
													"flex": 1.0,
													"data": {},
													"width": 60.0,
												}
											],
											"name": "items_panel",
											"height": 60.0,
											"data": {},
											"flexDirection": "row",
										}
									],
									"height": 60.0,
									"margin": 4.0,
									"marginTop": 13.0,
									"marginBottom": 8.0,
									"name": "panel_72420",
									"border": 0.0,
									"marginRight": 0.0,
									"data": {"image": "sItemsArea"},
								}
							],
							"width": 66.0,
							"height": 160.0,
							"marginLeft": 7.0,
							"name": "other_panel",
							"data": {},
							"minWidth": 319.0,
						},
						{
							"padding": 10.0,
							"flex": 1.0,
							"width": 60.0,
							"name": "panel_34362",
							"height": 60.0,
							"data": {},
						},
						{
							"padding": 9.0,
							"nodes": [
								{
									"marginTop": 4.0,
									"padding": 0.0,
									"marginBottom": 4.0,
									"marginLeft": 14.0,
									"width": 64.0,
									"name": "stage",
									"height": 12.0,
									"data": {},
								},
								{
									"marginTop": 2.0,
									"padding": 10.0,
									"width": 93.0,
									"name": "time",
									"height": 24.0,
									"data": {},
								}
							],
							"width": 109.0,
							"name": "stage_panel",
							"height": 60.0,
							"data": {},
						}
					],
					"height": 160.0,
					"flexDirection": "row",
					"marginTop": -13.0,
					"marginLeft": 8.0,
					"name": "info_panel",
					"top": 0.0,
					"data": {},
					"minWidth": 727.0,
					"left": 0.0,
				},
				{
					"padding": 10.0,
					"flex": 1.0,
					"width": 60.0,
					"name": "panel_8777",
					"height": 60.0,
					"data": {},
				},
				{
					"name": "buffs",
					"height": 60.0,
					"padding": 10.0,
					"data": {},
					"margin": 10.0,
				},
				{
					"padding": 10.0,
					"flex": 0.33000001311302185,
					"width": 60.0,
					"name": "panel_87397",
					"height": 60.0,
					"data": {},
				}
			],
			"width": "100%",
			"name": "panel_base",
			"height": "100%",
			"top": 0.0,
			"data": {"image": "gamae"},
			"margin": 0.0,
			"left": 0.0,
		}
	],
	"width": 1280.0,
	"name": "base",
	"height": 720.0,
	"top": 50.0,
	"data": {},
	"left": 275.0,
};
