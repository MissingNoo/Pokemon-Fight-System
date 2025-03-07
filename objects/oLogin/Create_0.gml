global.username = "";
global.password = "";
//show_debug_overlay(true);

ui = {
    "name" : "root",
    "left" : room_width / 2 - (250 / 2),
    "top": room_height / 2 - (200 / 2),
    "position" : "absolute",
    "width" : 250,
    "height" : 200,
    "padding" : 10,
    "nodes" : [
        {  
            "flex": 1,
            "rowGap" : 10,
            "nodes" : [
                { "name" : "center_label", "height":20, "data" : { "text" : "Login" }},
                {
                    "name" : "textbox_username", 
                    "marginInline" : 30, 
                    "flex" : 1,
                    "data" : {
                        "f" : function() {
                            global.username = global.currenttextbox[$ "text"];
                        }
                    }
                },
                {
                    "name" : "textbox_password", 
                    "marginInline" : 30, 
                    "flex" : 1,
                    "data" : {
                        "f" : function() {
                            global.password = global.currenttextbox[$ "text"];
                        }
                    }
                },
                {
                    "flex" : 1,
                    "flexDirection" : "row",
                    "nodes" : [
                        {
                            "name" : "button_accept", 
                            "height" : 30, 
                            "marginInline" : 10, 
                            "flex" : 1,
                            "data" : {
                                "f" : function() {
                                    new packet(Contype.Login)
                                    .write(buffer_text, global.username)
                                    .write(buffer_text, global.password)
                                    .send();
                                },
                                "text" : "Accept"
                            },
                        },
                        {
                        "name" : "button_register", 
                            "height" : 30, 
                            "marginInline" : 10, 
                            "flex" : 1,
                            "data" : {
                                "f" : function() {
                                    new packet(Contype.Register)
                                    .write(buffer_text, global.username)
                                    .write(buffer_text, global.password)
                                    .send();
                                },
                                "text" : "Register"
                            }
                        }
                    ],
                },
                {}
            ]
        }
    ]
}

n_root = create_ui(ui);