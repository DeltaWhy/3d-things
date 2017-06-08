include <measurements.scad>;

peg_fudge_r = 0.5;
peg_fudge_d = 5;
hole_fudge_r = 1;
hole_fudge_d = 1;
testfit_d = foot_d + hole_fudge_d + 2;
base_height = 60;
curve_r = 5;
tent_angle = 9.5;
tilt_angle = 0;

module peg() {
    cylinder(h=4, r=hole_r-peg_fudge_r);
}
module hole() {
    cylinder(h=2*(foot_d+hole_fudge_d), r=foot_r+hole_fudge_r, center=true);
}

module base_l(height) {
    difference() {
        union() {
            translate([curve_r, 0, 0]) cube([kb_l_l5-curve_r, feet_l[0][1]+foot_dia+3, height]);
            translate([0, curve_r, 0]) cube([foot_dia+3, kb_w - 2*curve_r, height]);
            piece1_w = kb_w-feet_l[1][1] + foot_dia + 3;
            translate([curve_r, kb_w-piece1_w, 0]) cube([kb_l_l1-curve_r, piece1_w, height]);
            translate([curve_r, curve_r, 0]) cylinder(r=curve_r, h=height);
            translate([curve_r, kb_w-curve_r, 0]) cylinder(r=curve_r, h=height);
        }
        for (coord = feet_l)
            translate(coord) translate([0, 0, height]) hole();
    }
    for (coord = holes_l)
        translate(coord) translate([0, 0, height]) peg();
}
module testfit_l() { base_l(testfit_d); }
module tent_l() {
    difference() {
        translate([0, kb_w, 5]) rotate([tilt_angle, -tent_angle, 0]) translate([0, -kb_w, -base_height])
            base_l(base_height);
        translate([0, 0, -base_height]) cube([kb_l_l5*1.2, kb_w, base_height]);
    }
}
tent_l();

module base_r(height) {
    difference() {
        union() {
            translate([kb_r_l1-kb_r_l5, 0, 0]) cube([kb_r_l5-curve_r, feet_r[0][1]+foot_dia+3, height]);
            translate([kb_r_l1-foot_dia-3, curve_r, 0]) cube([foot_dia+3, kb_w-2*curve_r, height]);
            piece1_w = kb_w-feet_r[1][1] + foot_dia + 3;
            translate([0, kb_w-piece1_w, 0]) cube([kb_r_l1-curve_r, piece1_w, height]);
            translate([kb_r_l1-curve_r, curve_r, 0]) cylinder(r=curve_r, h=height);
            translate([kb_r_l1-curve_r, kb_w - curve_r, 0]) cylinder(r=curve_r, h=height);
        }
        for (coord = feet_r)
            translate(coord) translate([0, 0, height]) hole();
    }
    for (coord = holes_r)
        translate(coord) translate([0, 0, height]) peg();
}
module testfit_r() { base_r(testfit_d); }
//translate([20, -30, 0]) base_r(base_height);
module tent_r() {
    difference() {
        translate([0, kb_w, 5]) rotate([tilt_angle, tent_angle, 0]) translate([-kb_r_l1, -kb_w, -base_height])
            base_r(base_height);
        translate([-kb_r_l1*1.2, 0, -base_height])
            cube([kb_r_l1*1.2, kb_w, base_height]);
    }
}
//translate([kb_r_l1, -30, 0]) tent_r();
translate([kb_r_l1/cos(tent_angle) + 20, -30, 0]) tent_r();