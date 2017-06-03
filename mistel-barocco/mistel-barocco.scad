include <measurements.scad>;
use <testfit.scad>;

module foot() {
    rotate([180, 0, 0]) cylinder(h=foot_d, r=foot_r);
}

// left half
module kb_l() {
    difference() {
        union() {
            translate([0, kb_w5+kb_w4+kb_w3+kb_w2, 0]) cube([kb_l_l1, kb_w1, kb_d1]);
            translate([0, kb_w5+kb_w4+kb_w3, 0]) cube([kb_l_l2, kb_w2, kb_d1]);
            translate([0, kb_w5+kb_w4, 0]) cube([kb_l_l3, kb_w3, kb_d1]);
            translate([0, kb_w5, 0]) cube([kb_l_l4, kb_w4, kb_d1]);
            cube([kb_l_l5, kb_w5, kb_d1]);
        }
        for (coord = holes_l)
            translate(coord) cylinder(h=hole_d, r=hole_r);
    }
    for (coord = feet_l)
        translate(coord) foot();
}
kb_l();

// right half
module kb_r() {
    difference() {
        union() {
            translate([0, kb_w5+kb_w4+kb_w3+kb_w2, 0]) cube([kb_r_l1, kb_w1, kb_d1]);
            translate([kb_r_l1-kb_r_l2, kb_w5+kb_w4+kb_w3, 0]) cube([kb_r_l2, kb_w2, kb_d1]);
            translate([kb_r_l1-kb_r_l3, kb_w5+kb_w4, 0]) cube([kb_r_l3, kb_w3, kb_d1]);
            translate([kb_r_l1-kb_r_l4, kb_w5, 0]) cube([kb_r_l4, kb_w4, kb_d1]);
            translate([kb_r_l1-kb_r_l5, 0, 0]) cube([kb_r_l5, kb_w5, kb_d1]);
        }
        for (coord = holes_r)
            translate(coord) cylinder(h=hole_d, r=hole_r);
    }
    for (coord = feet_r)
        translate(coord) foot();
}
translate([kb_l_l1 + 19, 0, 0]) {
    kb_r();
}

translate([0, 0, -20]) {
    testfit_l();
}
translate([kb_l_l1 + 19, 0, -20]) {
    testfit_r();
}