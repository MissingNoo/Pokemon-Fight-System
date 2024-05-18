event_inherited();
image_speed = 0;
image_index = 1;
lastdir = 270
fsm = new SnowState("idle");
fsm.add("idle", {
	enter: function() {
		dir = lastdir;
	}
  })
  .add("talk", {
	  enter: function() {
		  lastdir = dir;
	  },
	  step: function() {
		dir = point_direction(x, y, oPlayer.x, oPlayer.y);
		if (!instance_exists(oDialog)) {
		    fsm.change("idle");
		}
    }
  });