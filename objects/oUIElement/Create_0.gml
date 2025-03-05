draw_back = false;
image = -1;
index = irandom(10);
text = "";
bar_image = -1;
bar_colour = -1;
bar_level = random_range(0, 1);
center_text = false;
if (text)
switch (name)
{
            // Display background for containers only
	case "weap": case "inv": case "score": case "play":
		draw_back = true;
	break;
	
	case "weap1":
		image = spr_weapon;
	break;
	
	case "weap_info1":
		text = "DUR 168";
	break;
	
	case "weap_info2":
		text = "LVL 26";
	break;
	
	case "weap_bar_health":
		bar_colour = merge_colour(c_red, c_gray, 0.4);
		bar_image = spr_bar;
	break;

            // More cases…
}