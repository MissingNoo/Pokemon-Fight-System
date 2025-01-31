deck = new Deck();
deck.cards = array_shuffle(deck.cards);
gamesurf = surface_create(1920, 1080);
chips = 0;
mult = 0;
hands = 0;
discards = 0;
money = 0;
ante = 0;
cround = 0;

handsize = 8;
hand = [];
hand_position = [100, 30];

card_width = 158;
card_height = 214;
card_distance = 130;
number_pos = [0, 3, 2];
type_pos = [20, 50, 0.3];
approach_speed = 20;

played_hand = [];
played_position = [400, 500];
discarded = [];

update_hand_pos = function() {
    for (var offset = 0, i = 0; i < array_length(hand); i++) {
        hand[i].x = hand_position[0] + offset;
        hand[i].y = hand_position[1];
        hand[i].xdest = hand[i].x;
        hand[i].ydest = hand[i].y;
        offset += card_distance;
    }
}

update_played_hand_pos = function() {
    for (var offset = 0, i = 0; i < array_length(played_hand); i++) {
        played_hand[i].xdest = played_position[0] + offset;
        played_hand[i].ydest = played_position[1];
        offset += card_distance + 50;
    }
}

draw_card = function(x, y, card) {
    card.x = approach(card.x, card.xdest, approach_speed);
    card.y = approach(card.y, card.ydest, 50);
    y -= card.draw_offset;
    if (!card.played and fsm.get_current_state() == "Game") {
        if (card.selected) {
            y -= 10;
        }
        if (pokelatro.mouse_over == card) {
            if (!card.selected) {
                y -= 10;
            }
            if (device_mouse_check_button_pressed(0, mb_left)) {
                card.xoff = mouse_x - x;
                card.yoff = mouse_y - y;
            }
            if (device_mouse_check_button_released(0, mb_left) and !card.moved and abs(mouse_y - card.y) < card_height + 20) {
                if (card.selected) {
                    card.selected = false;
                    pokelatro.totalselected--;
                }
                else if (pokelatro.totalselected < 5) {
                    card.selected = true;
                    pokelatro.totalselected++;
                }
            }
            if (device_mouse_check_button(0, mb_left)) {
                x = mouse_x - card.xoff;
                y = mouse_y - card.yoff;
                pokelatro.checkcard = card;
                var pos = array_find_index(hand, function (e, i) {
                    return e == pokelatro.checkcard;
                });
                if (pos != -1) {
                    if (pos + 1 < array_length(hand) and x > hand[pos + 1].x) {
                        card.moved = true;
                        hand[pos + 1].xdest -= card_distance;
                        card.xdest += card_distance;
                        var sub = hand[pos + 1];
                        hand[pos + 1] = card;
                        hand[pos] = sub;
                    } 
                    if (pos - 1 != -1 and x < hand[pos - 1].x) {
                        card.moved = true;
                        hand[pos - 1].xdest += card_distance;
                        card.xdest -= card_distance;
                        var sub = hand[pos - 1];
                        hand[pos - 1] = card;
                        hand[pos] = sub;
                    } 
                }
                card.x = x;
                card.y = y;
            }
        }
    }
    draw_set_color(c_gray);
    draw_roundrect_ext(x, y + card.draw_offset, x + card_width, y + card_height, 5, 5, false);
    draw_set_color(c_white);
    draw_roundrect_ext(x, y, x + card_width, y + card_height, 5, 5, false);
    draw_set_color(c_gray);
    draw_roundrect_ext(x, y, x + card_width, y + card_height, 5, 5, true);
    draw_set_color(c_white);
    scribble($"[sPokeSelectFont1]{card.number}").scale(number_pos[2]).draw(x + number_pos[0], y + number_pos[1]);
    draw_sprite_ext(sPFSTypeIcons, card.type, x + type_pos[0], y + type_pos[1], type_pos[2], type_pos[2], 0, c_white, 1);
    if (!point_in_rectangle(mouse_x, mouse_y, card.x, card.y, card.x + card_width, card.y + card_height) and pokelatro.mouse_over == card and !device_mouse_check_button(0, mb_left)) { 
        pokelatro.mouse_over = undefined;
        card.mouse_over = false;
        card.moved = false;
        }
    if (point_in_rectangle(mouse_x, mouse_y, card.x, card.y, card.x + card_width, card.y + card_height) and pokelatro.mouse_over == undefined) { 
        pokelatro.mouse_over = card;
        card.mouse_over = true;
    }
    else {
        card.mouse_over = false;
    }
}

draw_card_array = function (e, i) {
    Pokelatro.draw_card(e.x, e.y, e);
}


fsm = new SnowState("Game");
fsm.add("Game", {
    enter : function () {
        for (var i = array_length(hand); i < handsize; i++) {
            array_push(hand, array_shift(deck.cards));
        }
        array_sort(hand, true);
        update_hand_pos();
        approach_speed = 20;
    },
    step : function () {
        if (keyboard_check_pressed(vk_enter)) {
            for (var i = array_length(hand) - 1; i >= 0; i--) {
                if (hand[i].selected) {
                    hand[i].played = true;
                    array_push(played_hand, hand[i]);
                    array_delete(hand, i, 1);
                }
            }
            array_reverse(played_hand);
            update_played_hand_pos();
            pokelatro.totalselected = 0;
            fsm.change("PlayCard");
        }
        
    },
    draw : function() {
        scribble(chips).scale(2).draw(10, 10);
        //draw_sprite(Sprite127, 0, 0, 0);
        array_foreach(hand, draw_card_array);
        array_foreach(played_hand, draw_card_array);
    }
});
fsm.add_child("Game", "PlayCard", {
    enter : function() {
        current_card = 0;
        max_card = array_length(played_hand) - 0.5;
        goingback = false;
        wentback = false;
        approach_speed = 80;
    },
    step : function() {
        current_card = approach(current_card, max_card, 0.025);
        if (current_card == max_card and !wentback) {
            wentback = true;
            goingback = true;
            current_card = 0;
        }
        if (played_hand[floor(current_card)].draw_offset == 0 and !goingback) {
            played_hand[floor(current_card)].draw_offset = 10;
            if (!played_hand[floor(current_card)].scored) {
                played_hand[floor(current_card)].scored = true;
                chips += played_hand[floor(current_card)].number;
            }
        }
        else if (goingback) {
            played_hand[floor(current_card)].draw_offset = 0;
        }
        if (goingback and current_card == max_card) {
            var allgone = true;
            for (var i = 0; i < array_length(played_hand); i++) {
                played_hand[i].xdest = 2000;
                if (played_hand[i].x != 2000) {
                    allgone = false;
                }
            }
            if (allgone) {
                discarded = array_concat(discarded, played_hand);
                played_hand = []; 
                fsm.change("Game");
            }
        }
        
    },
    draw : function() {
        fsm.inherit();
        var cur_card = played_hand[floor(current_card)];
        if (!goingback) {
            scribble($"+{cur_card.number}").scale(2).draw(cur_card.x + (card_width / 2), cur_card.y - 60);
        }
        draw_text(10, 40, $"goingback:{goingback}\ncurrent_card:{current_card}\nmax_card:{max_card}");
    }
});