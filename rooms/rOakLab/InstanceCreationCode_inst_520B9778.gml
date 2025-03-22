options = {
    "Charmander" : [
        {
            name : "Yes",
            go_to : "CharmanderChosen",
            f : function() {
    			PlayerTeam[0] = __PFS_generate_pokemon(PFS.Pokes[4])
		    }
        }, 
        {
            name : "No",
            f : function() {
                instance_destroy(oNewDialog);
            }
        }
    ],
    "CharmanderChosen" : [
        {
            name : "Yes",
            f : function() {
			    PlayerData.got_starter = true;
			    instance_create_depth(0, 0, -1000, oNickname, {pokemon : PlayerTeam[0], 
                    f : function() {
				        instance_destroy(oNewDialog);
			        }}
                );
            }
        }, 
        {
            name : "No",
            f : function() {
                instance_destroy(oNewDialog);
            }
        }
    ]
}