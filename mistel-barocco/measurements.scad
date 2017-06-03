kb_w = 118;
kb_d1 = 18;
kb_d2 = 27;
kb_l_l1 = 120;
kb_l_l2 = 130;
kb_l_l3 = 134;
kb_l_l4 = 144;
kb_l_l5 = 134;
kb_w1 = 32;
kb_w2 = 19;
kb_w3 = 19;
kb_w4 = 19;
kb_w5 = 30;
kb_r_l1 = 178;
kb_r_l2 = 168;
kb_r_l3 = 164;
kb_r_l4 = 154;
kb_r_l5 = 164;

hole_dia = 5.4;
hole_r = hole_dia/2;
hole_d = 14.2;
foot_dia = 8.5;
foot_r = foot_dia/2;
foot_d = 2.5;
foot_d2 = 1.5;

holes_l = [
    [5+hole_r, 3+hole_r, 0],
    [4.25+hole_r, kb_w-2.5-hole_r, 0],
    [kb_l_l5-4.5-hole_r, 3+hole_r, 0],
    [kb_l_l1-4.4-hole_r, kb_w-2.5-hole_r, 0]
];
feet_l = [
    [12+foot_r, 2.5+foot_r, 0],
    [2+foot_r, kb_w-9.5-foot_r, 0],
    [kb_l_l5-11.5-foot_r, 2.5+foot_r, 0],
    [kb_l_l1-2.5-foot_r, kb_w-9.5-foot_r, 0]
];

holes_r = [
    [kb_r_l1-kb_r_l5+4.5+hole_r, 3+hole_r, 0],
    [4.1+hole_r, kb_w-2.5-hole_r, 0],
    [kb_r_l1-4.5-hole_r, 3+hole_r, 0],
    [kb_r_l1-4.0-hole_r, kb_w-2.5-hole_r, 0]
];
feet_r = [
    [kb_r_l1-kb_r_l5+12+foot_r, 2.5+foot_r, 0],
    [2+foot_r, kb_w-9.5-foot_r, 0],
    [kb_r_l1-11.5-foot_r, 2.5+foot_r, 0],
    [kb_r_l1-2-foot_r, kb_w-9.5-foot_r, 0]
];