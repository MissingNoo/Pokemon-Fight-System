screen = 0;
alpha = 1;
lerpto = 1;
lerping = false;
lerped = false;
blackalpha = 0;
blacklerp = 0;
blacklerping = false;
scale = 3;
ini_open("Game.ini");
if (ini_read_real("Game", "SeenLecture", false)) {
    room_goto(rPlayerHouse2f);
}
ini_close();