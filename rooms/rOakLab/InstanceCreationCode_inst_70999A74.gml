options = {
    "Bulbasaur" : [
        {
            name : "Yes",
            go_to : "BulbasaurChosen",
            f : function() {
    			PlayerTeam[0] = __PFS_generate_pokemon(PFS.Pokes[1])
		    }
        }, 
        {
            name : "No",
            f : function() {
                instance_destroy(oDialog);
            }
        }
    ],
    "BulbasaurChosen" : [
        {
            name : "Yes",
            f : function() {
			    PlayerData.got_starter = true;
			    instance_create_depth(0, 0, -1000, oNickname, {pokemon : PlayerTeam[0], 
                    f : function() {
				        instance_destroy(oDialog);
			        }}
                );
            }
        }, 
        {
            name : "No",
            f : function() {
                instance_destroy(oDialog);
            }
        }
    ]
}