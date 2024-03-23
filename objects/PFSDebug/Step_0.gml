//Feather disable GM2017
if (keyboard_check_pressed(vk_numpad2)) {
    instance_destroy(PFSFightSystem);
}
if (keyboard_check_pressed(vk_numpad1) and !instance_exists(PFSFightSystem)) {
    instance_create_depth(0, 0, 0, PFSFightSystem);
}
