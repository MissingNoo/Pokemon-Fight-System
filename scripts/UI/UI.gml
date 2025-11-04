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

global.game_uis.battle = {
      "flex":0.0,
      "border":0.0,
      "name":"window_panel_transparent",
      "left":0.0,
      "padding":0.0,
      "top":0.0,
      "width":720.0,
      "data":{
      },
      "height":480.0,
      "nodes":[
        {
          "name":"Battle_area_panel_transparent",
          "minHeight":336.0,
          "maxHeight":336.0,
          "minWidth":720.0,
          "padding":0.0,
          "data":{
            "image":"PFSBattleBgs"
          },
          "maxWidth":720.0,
          "height":60.0,
          "nodes":[
            {
              "padding":0.0,
              "data":{
              },
              "height":60.0,
              "name":"blank5",
              "flex":1.0
            },
            {
              "name":"tpanel_transparent",
              "flexDirection":"row",
              "padding":0.0,
              "data":{
              },
              "nodes":[
                {
                  "name":"blank3",
                  "padding":10.0,
                  "width":60.0,
                  "data":{
                  },
                  "flex":1.0,
                  "margin":0.0
                },
                {
                  "name":"enemy_poke_life_panel",
                  "minHeight":87.0,
                  "maxHeight":87.0,
                  "minWidth":300.0,
                  "padding":6.0,
                  "width":300.0,
                  "maxWidth":300.0,
                  "data":{
                    "image":"PFSEnemyHpBar"
                  },
                  "height":87.0,
                  "nodes":[
                    {
                      "name":"panel_86009",
                      "flexDirection":"row",
                      "padding":10.0,
                      "width":265.0,
                      "data":{
                        "image":"sButto"
                      },
                      "height":37.0,
                      "nodes":[
                        {
                          "name":"enemy_poke_name",
                          "padding":0.0,
                          "width":60.0,
                          "data":{
                          },
                          "height":20.0,
                          "flex":1.2999999523162842
                        },
                        {
                          "name":"enemy_poke_level",
                          "padding":0.0,
                          "width":60.0,
                          "data":{
                          },
                          "height":20.0,
                          "flex":0.10000000149011612
                        }
                      ],
                      "flex":0.0
                    },
                    {
                      "marginBottom":34.0,
                      "marginLeft":110.0,
                      "marginTop":8.0,
                      "name":"enemy_hp_bar",
                      "padding":0.0,
                      "width":144.0,
                      "data":{
                        "image":"PFSPokemonScreenHPValue"
                      },
                      "height":10.0,
                      "flex":0.0
                    }
                  ]
                },
                {
                  "padding":10.0,
                  "width":60.0,
                  "data":{
                  },
                  "name":"blank6",
                  "flex":7.0
                },
                {
                  "name":"enemy_poke_spr",
                  "minHeight":192.0,
                  "maxHeight":192.0,
                  "minWidth":192.0,
                  "padding":10.0,
                  "width":60.0,
                  "maxWidth":192.0,
                  "data":{
                  },
                  "flex":1.0
                },
                {
                  "padding":10.0,
                  "width":60.0,
                  "data":{
                  },
                  "name":"blank4",
                  "flex":5.0
                }
              ],
              "flex":2.0
            },
            {
              "padding":0.0,
              "data":{
              },
              "height":60.0,
              "name":"blank4",
              "flex":1.0
            },
            {
              "name":"bpanel_transparent",
              "flexDirection":"row",
              "padding":0.0,
              "data":{
              },
              "height":60.0,
              "nodes":[
                {
                  "padding":10.0,
                  "width":60.0,
                  "data":{
                  },
                  "name":"blank1",
                  "flex":15.0
                },
                {
                  "name":"own_poke_spr",
                  "minHeight":0.0,
                  "maxHeight":192.0,
                  "minWidth":192.0,
                  "padding":10.0,
                  "width":60.0,
                  "maxWidth":192.0,
                  "data":{
                  },
                  "flex":1.0
                },
                {
                  "border":0.0,
                  "name":"blank7",
                  "padding":10.0,
                  "width":60.0,
                  "data":{
                  },
                  "flex":15.0
                },
                {
                  "name":"own_poke_life_panel",
                  "minHeight":111.0,
                  "maxHeight":111.0,
                  "minWidth":312.0,
                  "padding":10.0,
                  "width":312.0,
                  "maxWidth":312.0,
                  "data":{
                    "image":"PFSPlayerHpBar"
                  },
                  "height":111.0,
                  "nodes":[
                    {
                      "marginLeft":23.0,
                      "marginTop":-4.0,
                      "name":"panel_82508",
                      "maxHeight":39.0,
                      "flexDirection":"row",
                      "padding":10.0,
                      "data":{
                      },
                      "marginRight":5.0,
                      "height":60.0,
                      "nodes":[
                        {
                          "name":"poke_name",
                          "padding":0.0,
                          "width":58.0,
                          "data":{
                          },
                          "height":23.0,
                          "flex":1.2999999523162842
                        },
                        {
                          "name":"poke_level",
                          "padding":0.0,
                          "width":60.0,
                          "data":{
                          },
                          "height":20.0,
                          "flex":0.10000000149011612
                        }
                      ]
                    },
                    {
                      "marginLeft":133.0,
                      "marginTop":6.0,
                      "name":"hp_bar",
                      "padding":0.0,
                      "width":144.0,
                      "data":{
                        "image":"PFSPokemonScreenHPValue"
                      },
                      "height":9.0,
                      "flex":0.0
                    }
                  ]
                },
                {
                  "padding":10.0,
                  "width":60.0,
                  "data":{
                  },
                  "name":"blank2",
                  "flex":0.10000000149011612
                }
              ],
              "flex":2.0
            }
          ],
          "flex":3.0
        },
        {
          "flex":0.0,
          "margin":0.0,
          "name":"info_area_panel_transparent",
          "flexDirection":"row",
          "minWidth":720.0,
          "padding":0.0,
          "data":{
            "image":"PFSBehindBar"
          },
          "maxWidth":720.0,
          "height":144.0,
          "nodes":[
            {
              "name":"panel_37675_transparent",
              "padding":10.0,
              "width":60.0,
              "data":{
              },
              "nodes":[
                {
                  "name":"panel_31795",
                  "flexDirection":"row",
                  "padding":10.0,
                  "data":{
                  },
                  "height":60.0,
                  "nodes":[
                    {
                      "padding":10.0,
                      "width":60.0,
                      "data":{
                      },
                      "name":"mname0",
                      "flex":1.0
                    },
                    {
                      "padding":10.0,
                      "width":60.0,
                      "data":{
                      },
                      "name":"mname1",
                      "flex":1.0
                    }
                  ],
                  "flex":1.0
                },
                {
                  "name":"panel_93020",
                  "flexDirection":"row",
                  "padding":10.0,
                  "data":{
                  },
                  "height":60.0,
                  "nodes":[
                    {
                      "padding":10.0,
                      "width":60.0,
                      "data":{
                      },
                      "name":"mname2",
                      "flex":1.0
                    },
                    {
                      "padding":10.0,
                      "width":60.0,
                      "data":{
                      },
                      "name":"mname3",
                      "flex":1.0
                    }
                  ],
                  "flex":1.0
                }
              ],
              "flex":1.0
            },
            {
              "name":"info_area2_panel_transparent",
              "minHeight":144.0,
              "maxHeight":144.0,
              "minWidth":360.0,
              "padding":10.0,
              "width":360.0,
              "maxWidth":360.0,
              "data":{
              },
              "height":144.0,
              "flex":1.0
            }
          ]
        }
      ]
    }