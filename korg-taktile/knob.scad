fn = 100;
outer_wall = 1.35;
outer_ridge = 1.55 - 1.35;
ridge_count = 44;
bottom_dia = 14.5;
bottom_r = bottom_dia/2;
bottom_apothem = bottom_r * cos(180/fn);
top_dia = 12;
top_r = top_dia/2;
top_apothem = top_r * cos(180/fn);
height = 14.05;
angle = atan2(bottom_r-top_r, height);
slope_height = height/cos(angle);
notch_width = 1.30;
notch_depth = 1.90;
notch_height = 0.40;

stem_height = 14.90;
stem_wall = 1;
stem_inner_dia = 6;
stem_inner_r = stem_inner_dia/2;
stem_outer_r = stem_inner_r+stem_wall;
stem_outer_dia = stem_outer_r*2;
stem_gap = 1.7;
stem_inner_width = 4.5;

support_depth = 5;
support_wall = 1;

module ridge(w1, w2) {
    rotate([0, -angle, 0])
    polyhedron(
        points=[
            [0, w1/2, 0],
            [0, -w1/2, 0],
            [outer_ridge, 0, 0],
            [0, w2/2, slope_height-notch_height],
            [0, -w2/2, slope_height-notch_height],
            [outer_ridge, 0, slope_height-notch_height]
        ], faces=[
            [0, 1, 2],
            [0, 3, 4, 1],
            [4, 3, 5],
            [0, 2, 5, 3],
            [1, 4, 5, 2]
        ]);
}

// basic shape
difference() {
    union() {
        cylinder(h=height, d1=bottom_dia, d2=top_dia, $fn=fn);
        ridge_w1 = (PI*bottom_dia)/ridge_count;
        ridge_w2 = (PI*top_dia)/ridge_count;
        for(a=[360/ridge_count:360/ridge_count:360]) {
            //echo(a);
            translate([bottom_apothem*cos(a), bottom_apothem*sin(a), 0])
                rotate([0, 0, a])
                ridge(ridge_w1, ridge_w2);
        }
    }   
    cylinder(h=height-outer_wall, d1=bottom_dia-2*outer_wall, d2=top_dia-2*outer_wall);
    translate([top_r, 0, height])
        cube([(notch_depth-notch_width)*2, notch_width, notch_height*2], center=true);
    translate([top_r - (notch_depth-notch_width), 0, height])
        cylinder(r=notch_width/2, h=notch_height*2, center=true, $fn=10);
    translate([bottom_r, 0, 0])
        rotate([0, -angle, 0])
        translate([0, 0, height/2])
        cube([notch_height*2, notch_width, height], center=true);
}

// supports
module trapezoidal(l1, l2, w, h) {
    polyhedron(points=[
        [-w/2, -l1/2, 0],
        [w/2, -l1/2, 0],
        [w/2, l1/2, 0],
        [-w/2, l1/2, 0],
        [w/2, l2/2, h],
        [w/2, -l2/2, h],
        [-w/2, -l2/2, h],
        [-w/2, l2/2, h]
    ], faces=[
        [0, 1, 2, 3],
        [4, 5, 6, 7],
        [0, 6, 5, 1],
        [3, 2, 4, 7],
        [2, 1, 5, 4],
        [0, 3, 7, 6]
    ]);
}
support_ratio = (height-support_depth)/height;
support_base_dia = 2*(top_apothem + (bottom_apothem - top_apothem) * support_ratio);
translate([0, 0, support_depth]) trapezoidal(l1=support_base_dia, l2=top_apothem*2-0.2, w=stem_gap, h=height-support_depth);
translate([0, 0, support_depth]) 
    rotate([0, 0, 90])
    difference() {
        trapezoidal(l1=support_base_dia-2*notch_height, l2=top_dia-2*notch_height, w=stem_gap, h=height-support_depth-notch_height);
        translate([-stem_gap/2, 0, 0]) cube([stem_gap, support_base_dia/2, height-support_depth]);
    }
    
module stem() {
    difference() {
        cylinder(r=stem_inner_r+stem_wall, h=stem_height, $fn=20);
        difference() {
            cylinder(r=stem_inner_r/cos(180/20), h=stem_height, $fn=20);
            translate([stem_inner_width-stem_inner_r, -stem_inner_r, 0]) cube([stem_inner_width-stem_inner_r, stem_inner_dia, stem_height]);
        }
        translate([0, 0, stem_height/2])
            cube([stem_outer_dia, stem_gap, stem_height], center=true);
        translate([stem_inner_width-stem_inner_r+stem_wall, stem_gap/2+stem_wall, 0])
            cube([stem_outer_r, stem_outer_r, stem_height]);
        mirror([0, 1, 0])
            translate([stem_inner_width-stem_inner_r+stem_wall, stem_gap/2+stem_wall, 0])
            cube([stem_outer_r, stem_outer_r, stem_height]);
    }
}

translate([0, 0, height-stem_height]) rotate([0, 0, 180]) stem();