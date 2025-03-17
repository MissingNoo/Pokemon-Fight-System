pokemon_out = 0;

#region systems
//ParticleSystem1
ps = part_system_create();
part_system_draw_order(ps, true);

//Emitter
ptype1 = part_type_create();
part_type_shape(ptype1, pt_shape_spark);
part_type_size(ptype1, 1, 1, 0, 0);
part_type_scale(ptype1, 1, 1);
part_type_speed(ptype1, 5, 5, 0, 0);
part_type_direction(ptype1, 0, 360, 0, 0);
part_type_gravity(ptype1, 0, 270);
part_type_orientation(ptype1, 0, 0, 0, 0, false);
part_type_colour3(ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(ptype1, 1, 1, 1);
part_type_blend(ptype1, false);
part_type_life(ptype1, 20, 40);
part_system_automatic_draw(ps, false);
can_restart_particle = true;
#endregion

enum battle_animations {
	battle_start
}

current_animation = battle_animations.battle_start;

#region animations
playerthrow = new animated_sprite(sPlayerBallThrow);
draw_ball = false;
bally = undefined;
bally_end = 0;
#endregion

#region hp offset
hp_offset = 500;
enemy_sprite_offset = 700;
enemy_alpha = 0.20;

pokemon_offset = 700;
player_offset = 0;
show_player_hp = false;
pokemon_released = false;
#endregion

fsm = new SnowState("Battle_Start");

fsm.add("Animation", {
	enter : function() {
		can_restart_particle = true;
		draw_ball = true;
	},
	step : function() {
		switch (current_animation) {
		    case battle_animations.battle_start:
				pokemon_offset = approach(pokemon_offset, 0, 5);
				enemy_sprite_offset = approach(enemy_sprite_offset, 0, 5);
				if (enemy_sprite_offset <= 135) {
				    enemy_alpha = approach(enemy_alpha, 1, 0.10);
				}
				if (enemy_sprite_offset == 0) {
				    hp_offset = approach(hp_offset, 0, 5);
				}
				if (pokemon_offset == 0) {
					if (playerthrow.subimg > 3) {
					    player_offset = approach(player_offset, -300, 4);
						bally ??= 185;
						bally = approach(bally, bally_end, 3);
					}
					playerthrow.animate();
				}
		        break;
		}
	}
});

fsm.add("Battle_Start", {
	enter : function() {
		fsm.change("Animation");
	},
	step : function() {
	}
});




str =     {
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
                        "image":"sButto\b"
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
                  "name":"blank\b\b6",
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
                          "flex":1.0
                        },
                        {
                          "padding":0.0,
                          "width":16.0,
                          "data":{
                          },
                          "height":23.0,
                          "name":"poke_level"
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
              "height":60.0,
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


surf = surface_create(720, 480);
battleui = new window(str, false);