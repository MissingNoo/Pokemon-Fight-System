randomize();
global.blackfade[0] = 1;
global.blackfade[1] = 0;
global.debug = string_contains(os_get_config(), "Debug");
#macro DEBUGMODE global.debug