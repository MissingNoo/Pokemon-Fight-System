if (is_undefined(enemyPokemon)) {
	instance_destroy();
}
EnemyTeam = enemyPokemon;
pfs_debug_message("Starting Battle");

event_user(0);
event_user(1);
event_user(2);
event_user(3);
event_user(4);
event_user(5);

dbg = dbg_view("Battle", true);
create_view_from_instance(self);
