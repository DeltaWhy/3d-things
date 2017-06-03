include <measurements.scad>;

peg_fudge_r = 0.5;
peg_fudge_d = 1.5;
hole_fudge_r = 1;
hole_fudge_d = 1;
testfit_d = foot_d + hole_fudge_d + 2;
base_height = 50;

module peg() {
    cylinder(h=hole_d-peg_fudge_d, r=hole_r-peg_fudge_r);
}
module hole() {
    cylinder(h=2*(foot_d+hole_fudge_d), r=foot_r+hole_fudge_r, center=true);
}

module base_l(height) {
    difference() {
        union() {
            cube([kb_l_l5, feet_l[0][1]+foot_dia+3, height]);
            cube([foot_dia+3, kb_w, height]);
            piece1_w = kb_w-feet_l[1][1] + foot_dia + 3;
            translate([0, kb_w-piece1_w, 0]) cube([kb_l_l1, piece1_w, height]);
        }
        for (coord = feet_l)
            translate(coord) translate([0, 0, height]) hole();
    }
    for (coord = holes_l)
        translate(coord) translate([0, 0, height]) peg();
}
module testfit_l() { base_l(testfit_d); }
testfit_l();

module testfit_r() {
    difference() {
        union() {
            translate([kb_r_l1-kb_r_l5, 0, 0]) cube([kb_r_l5, feet_r[0][1]+foot_dia+3, testfit_d]);
            translate([kb_r_l1-foot_dia-3, 0, 0]) cube([foot_dia+3, kb_w, testfit_d]);
            piece1_w = kb_w-feet_r[1][1] + foot_dia + 3;
            translate([0, kb_w-piece1_w, 0]) cube([kb_r_l1, piece1_w, testfit_d]);
        }
        for (coord = feet_r)
            translate(coord) translate([0, 0, testfit_d]) hole();
    }
    for (coord = holes_r)
        translate(coord) translate([0, 0, testfit_d]) peg();
}
translate([20, -30, 0]) testfit_r();