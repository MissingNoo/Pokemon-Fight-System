global.blackfade[0] = lerp(global.blackfade[0], global.blackfade[1], 0.1);
if (global.blackfade[0] == global.blackfade[1] and global.blackfade[1] == 1) {
    global.blackfade[1] = 0;
}