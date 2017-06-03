rect_depth = 385.515;
rect_width = 522.174;
rect_height = 100;

curve_radius = 25.803;

total_width = rect_width + 2*curve_radius;
total_depth = rect_depth + 2*curve_radius;

slope = PI/12 * 180/PI;
echo(slope);
screw_radius = 11.63/2;
nut_radius = 11.63;
module nut_hole() {
    cylinder(r=nut_radius, h=5*rect_height, center=true);
}

module main_base() {
    difference() {
        translate([0, 0, rect_height/2]) {
            union() {
                cube([total_width, rect_depth, rect_height], center=true);
                cube([rect_width, total_depth, rect_height], center=true);
                translate([rect_width/2, rect_depth/2, 0]) cylinder(r=curve_radius, h=rect_height, center=true);
                translate([rect_width/-2, rect_depth/2, 0]) cylinder(r=curve_radius, h=rect_height, center=true);
                translate([rect_width/-2, rect_depth/-2, 0]) cylinder(r=curve_radius, h=rect_height, center=true);
                translate([rect_width/2, rect_depth/-2, 0]) cylinder(r=curve_radius, h=rect_height, center=true);
            }
        }
        translate([rect_width/2 + 4, rect_depth/2 + 4 + 3.225, 345]) nut_hole();
        translate([rect_width/2 + 4 - 205, rect_depth/2 + 4 + 5, 345]) nut_hole();
        translate([rect_width/2 + 4 + 15.603, rect_depth/2 + 4 - 247.059, 345]) nut_hole();
        translate([rect_width/2 + 4 - 223.712, rect_depth/2 + 4 - 395, 345]) nut_hole();
    }
}
//main_base();

shift_down_height = (rect_height - (total_width/2 * tan(slope))) * cos(slope);

module flush_top() {
    translate([0, 0, -shift_down_height*0]) rotate([0, -slope, 0]) {
        union() {
            main_base();
            translate([0, 0, -100]) main_base();
        }
    }
}
//flush_top();

module tent() {
    scale(25.4/90) difference() {
        flush_top();
        translate([0, 0, -250]) cube([700, 700, 500], center=true);
        translate([-375, 0, -0]) cube([700, 700, 500], center=true);
        translate([0, 0, 100]) cube([0.9*rect_width, 0.95*rect_depth, 300], center=true);
    }
}

union() {
    tent();
    translate([50, -20, 0]) mirror([1, 0, 0]) tent();
}