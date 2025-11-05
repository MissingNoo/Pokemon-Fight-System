uistr = {
  "nodes":[
    {
      "width":100.0,
      "height":125.0,
      "data":{
        "image":"sDialogWindow2"
      },
      "flexDirection":"row",
      "nodes":[
        {
          "margin":30.0,
          "name":"pokespr",
          "marginLeft":60.0,
          "padding":10.0,
          "width":60.0,
          "data":{
          },
          "height":60.0
        },
        {
          "nodes":[
            {
              "flex":1.0,
              "margin":5.0,
              "data":{
              },
              "name":"pkmnname",
              "marginRight":40.0
            },
            {
              "flex":1.0,
              "margin":5.0,
              "name":"nameinput",
              "padding":10.0,
              "data":{
              },
              "height":60.0,
              "marginRight":40.0
            }
          ],
          "flex":1.0,
          "name":"panel_19993",
          "padding":10.0,
          "width":60.0,
          "data":{
          }
        }
      ],
      "flex":1.0,
      "margin":10.0,
      "name":"panel_base2",
      "left":0.0,
      "padding":0.0,
      "top":0.0
    }
  ],
  "name":"base",
  "left":439.0,
  "top":259.0,
  "width":720.0,
  "data":{
  },
  "height":480.0,
  "flexDirection":"row"
}
nickname = pokemon.internalName;
if (pokemon[$ "nickname"] != undefined) {
    nickname = pokemon.nickname
}
keyboard_string = nickname;
surf = surface_create(64, 64);

ui = new window(uistr, false);
ui.fit_to_gui();