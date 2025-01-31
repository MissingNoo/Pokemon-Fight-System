#macro pokelatro global.latro
global.latro = {
    dragging : undefined,
    mouse_over : undefined,
    checkcard : undefined,
    totalselected : 0
}

function Card(_number, _type) constructor {
    played = false;
    number = _number;
    type = _type;
    mouse_over = false;
    dragging = false;
    selected = false;
    x = 0;
    y = 0;
    xdest = 0;
    ydest = 0;
    xoff = 0;
    yoff = 0;
    moved = false;
    draw_offset = 0;
    scored = false;
}

function Deck() constructor {
    cards = [];
    for (var i = 0; i <= 4; i++) {
        for (var j = 0; j <= 13; j++) {
            array_push(cards, new Card(j, i));
        }
    }
    show_debug_message(cards);
}

