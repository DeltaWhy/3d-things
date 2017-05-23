bearing_h = 7;
bearing_r = 11;
bearing_ri = 4;

hub_thickness = 5;
wheel_r = 80;
tire_r = 5;
rim_ri = 69;
spoke_r = 3;
crank_thickness = 3;
crank_l = 55;
axle_l = 60;

module ring(h, ri, ro) {
    difference() {
        cylinder(h, r=ro, center=true);
        cylinder(h, r=ri, center=true);
    }
}

module ring2(h, ri, t) {
    difference() {
        cylinder(h, r=ri+t, center=true);
        cylinder(h, r=ri, center=true);
    }
}

module wheel() {
    // hub
    ring(bearing_h, bearing_ri, bearing_r+hub_thickness);
    //cylinder(h=bearing_h, r=bearing_r+hub_thickness, center=true);
    
    // tire
    rotate_extrude() {
        translate([wheel_r, 0, 0])
        circle(tire_r);
    }

    // rim
    ring(bearing_h, rim_ri, wheel_r);

    // spokes
    for (a = [0:18:360]) {
        rotate([90, 0, a])
        translate([0, 0, bearing_r])
        cylinder(h=wheel_r-bearing_r, r=spoke_r, center=false);
    }
    
    // axle
    cylinder(h=axle_l/2, r=bearing_ri, center=false);
}

module crank() {
    difference() {
        union() {
            translate([0, crank_l/2, 0]) cube([(bearing_r+crank_thickness)*2, crank_l, bearing_h], center=true);
            translate([0, crank_l, 0]) cylinder(h=bearing_h, r=bearing_r+crank_thickness, center=true);
            cylinder(h=bearing_h, r=bearing_r+crank_thickness, center=true);
        }
        translate([0, crank_l, 0]) cylinder(h=bearing_h, r=bearing_r, center=true);
        cylinder(h=bearing_h, r=bearing_ri, center=true);
    }

    
    //pin
    //translate([0, 0, -7.5]) cylinder(h=15, r=1.5, center=true);
}
crank_z = axle_l/2 - bearing_h/2;

tube_r = 5;
fork_h = 95;
fork_w = 30;
post_h = 95;
module frame() {
    difference() {
        union() {
            translate([0, 0, fork_w/2])
                rotate([90, 0, -90])
                cylinder(h=fork_h, r=tube_r);
            translate([0, 0, -fork_w/2])
                rotate([90, 0, -90])
                cylinder(h=fork_h, r=tube_r);
            translate([-fork_h, 0, 0])
                cylinder(h=fork_w, r=tube_r, center=true);
            translate([-fork_h, 0, fork_w/2])
                sphere(r=tube_r);
            translate([-fork_h, 0, -fork_w/2])
                sphere(r=tube_r);
            translate([-fork_h, 0, 0])
                rotate([90, 0, -90])
                cylinder(h=post_h, r=tube_r);
            translate([0, 0, fork_w/2])
                cylinder(h=bearing_h, r=bearing_r+hub_thickness, center=true);
            translate([0, 0, -fork_w/2])
                cylinder(h=bearing_h, r=bearing_r+hub_thickness, center=true);
        }
        cylinder(h=fork_w+2*bearing_h, r=bearing_r, center=true);
    }
}

module pedal() {
    cylinder(h=bearing_h+1.5, r=bearing_ri);
    translate([0, 0, bearing_h+2+25]) difference() {
        cube([bearing_ri*2+1.5, 30, 50], center=true);
        translate([0, -8, 0]) cube([bearing_ri*2+1.5, 6, 38], center=true);
        translate([0, 8, 0]) cube([bearing_ri*2+1.5, 6, 38], center=true);
    }
}

module seat() {
    translate([-100, 0, 0]) intersection() {
        ring(h=50, ri=95, ro=105);
        translate([100, 0, 0]) cube([50, 110, 50], center=true);
    }
    //cube([10, 80, 50], center=true);
}


// Assembled
/*
color("green") wheel();
// second axle
translate([0, 0, -axle_l/2]) cylinder(h=axle_l/2, r=bearing_ri, center=false);

translate([0, 0, crank_z]) crank();
rotate([180, 0, 0]) translate([0, 0, crank_z]) crank();

frame();

translate([0, crank_l, 25]) pedal();
rotate([180,0,0]) translate([0, crank_l, 25]) pedal();

translate([-(fork_h+post_h), 0, 0]) seat();
*/

// exploded
$fs=2;
$fa=12;
wheel();
translate([100, 0, 0]) rotate([90, 0, 0]) cylinder(h=axle_l/2, r=bearing_ri);
translate([125, 0, 0]) crank();
translate([160, 0, 0]) crank();
translate([0, 120, 0]) rotate([0, 0, 180]) {
    frame();
    translate([-(fork_h+post_h), 0, 0]) seat();
}
translate([125, -50, 0]) rotate([0, 90, 0]) pedal();
translate([125, -100, 0]) rotate([0, 90, 0]) pedal();