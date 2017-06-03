bearing_h = 7;
bearing_r = 11;
bearing_ri = 4;

hub_thickness = 5;
wheel_r = 50;
tire_r = 5;
rim_ri = 45;
spoke_r = 2;
crank_thickness = 2;
crank_l = 30;
axle_l = 50;

module cylinder_outer(h,r,center,fn){
    fudge = 1/cos(180/fn);
    cylinder(h=h,r=r*fudge,center=center,$fn=fn);
}
   
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
        translate([0, crank_l, 0]) cylinder_outer(h=bearing_h, r=bearing_r, center=true, fn=30);
        cylinder_outer(h=bearing_h, r=bearing_ri, center=true, fn=13);
    }

    
    //pin
    //translate([0, 0, -7.5]) cylinder(h=15, r=1.5, center=true);
}
crank_z = axle_l/2 - bearing_h/2;

tube_r = 4;
fork_h = 63;
fork_w = 25;
post_h = 60;
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
        cylinder_outer(h=fork_w+2*bearing_h, r=bearing_r, center=true, fn=30);
    }
}

pedal_l = 20;
pedal_w = 15;

module pedal() {
    cylinder(h=bearing_h+2.5, r=bearing_ri);
    translate([0, 0, bearing_h+1.5+pedal_l/2]) difference() {
        cube([6, pedal_w, pedal_l], center=true);
        translate([0, -3.25, 0]) cube([6, 4.5, 16], center=true);
        translate([0, 3.25, 0]) cube([6, 4.5, 16], center=true);
        
        //translate([0, -8, 0]) cube([bearing_ri*2+1.5, 6, 38], center=true);
        //translate([0, 8, 0]) cube([bearing_ri*2+1.5, 6, 38], center=true);
    }
}

module seat() {
    translate([-50, 0, 0]) intersection() {
        ring(h=25, ri=48, ro=52);
        translate([50, 0, 0]) cube([25, 65, 25], center=true);
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

translate([0, crank_l, crank_z-bearing_h/2]) pedal();
rotate([180,0,0]) translate([0, crank_l, crank_z-bearing_h/2]) pedal();

translate([-(fork_h+post_h), 0, 0]) seat();
*/

// exploded
/*
$fs=2;
$fa=12;
*/
//wheel();
translate([70, 0, 0]) cylinder(h=axle_l/2, r=bearing_ri);
translate([70, 20, 0]) cylinder(h=axle_l/2, r=bearing_ri);
// fudged axles
translate([70, 40, 0]) cylinder(h=axle_l/2-bearing_h/2, r=bearing_ri);
translate([70, 40, axle_l/2-bearing_h/2]) cylinder(h=bearing_h/2, r=bearing_ri-0.0625);
translate([70, 60, 0]) cylinder(h=axle_l/2-bearing_h/2, r=bearing_ri);
translate([70, 60, axle_l/2-bearing_h/2]) cylinder(h=bearing_h/2, r=bearing_ri-0.125);
translate([70, 80, 0]) cylinder(h=axle_l/2-bearing_h/2, r=bearing_ri);
translate([70, 80, axle_l/2-bearing_h/2]) cylinder(h=bearing_h/2, r=bearing_ri-0.25);
translate([70, -20, 0]) cylinder(h=axle_l/2-bearing_h/2, r=bearing_ri);
translate([70, -20, axle_l/2-bearing_h/2]) cylinder(h=bearing_h/2, r=bearing_ri-0.5);

/*translate([95, 0, 0]) crank();
translate([130, 0, 0]) crank();
translate([0, 100, 0]) rotate([0, 0, 180]) {
    frame();
    translate([-(fork_h+post_h), 0, 0]) seat();
}
translate([125, -30, 0]) rotate([180, 0, 0]) pedal();
translate([105, -30, 0]) rotate([180, 0, 0]) pedal();*/