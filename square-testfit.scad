// hole
difference() {
    cylinder(h=7, r=11);
    translate([0, 0, 3.5]) cube([8, 8, 7], center = true);
}

// pin
translate([20, 0, 0]) {
    cylinder(h=21, r=4);
    translate([0, 0, 10.5]) cube([8, 8, 7], center = true);
}
translate([35, 0, 0]) {
    difference() {
        union() {
            cylinder(h=21, r=3.875);
            translate([0, 0, 10.5]) cube([7.75, 7.75, 7], center = true);
        }
        translate([0, 0, 20]) cylinder(h=1, r=1);
    }
}
translate([50, 0, 0]) {
    difference() {
        union() {
            cylinder(h=21, r=7.875/2);
            translate([0, 0, 10.5]) cube([7.875, 7.875, 7], center = true);
        }
        translate([0, 0, 20]) cylinder(h=1, r=0.5);
    }
}
translate([65, 0, 0]) {
    difference() {
        union() {
            cylinder(h=21, r=7.5/2);
            translate([0, 0, 10.5]) cube([7.5, 7.5, 7], center = true);
        }
        translate([0, 0, 20]) cylinder(h=1, r=1.5);
    }
}

translate([0, 30, 0]) difference() {
    cylinder(h=7, r=11);
    translate([0, 0, 3.5]) cube([8.25, 8.25, 7], center = true);
    translate([6, 6, 6]) cylinder(h=1, r=1);
}

translate([0, 60, 0]) difference() {
    cylinder(h=7, r=11);
    translate([0, 0, 3.5]) cube([8.5, 8.5, 7], center = true);
    translate([6, 6, 6]) cylinder(h=1, r=1.5);
}