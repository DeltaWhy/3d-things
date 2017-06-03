w = 40;
leg_w = 35;
ro = 100;
ri = 40;
th = 3;
angle = 55;
cup_angle = 50;
clearance = 15;

translate([0, 0, clearance])
rotate([90, angle-90, 0])
difference() {
    intersection() {
        cylinder(r = ro, h = w + 2*th, center = true, $fn=100);
        translate([-th, -th, -(w/2 + th)]) cube([ro+th, ro+th, w + 2*th]);
    }
    
    intersection() {
        cylinder(r = ro, h = w, center = true, $fn=100);
        translate([0, 0, -w/2]) cube([ro, ro, w]);
    }
    
    cylinder(r = ri, h = w + 2*th, center = true, $fn=60);
    
    offset = (ro-ri)/1.8 + ri;
    translate([cos(cup_angle)*offset, sin(cup_angle)*offset, -w/2 - th])
        rotate([0, 0, cup_angle-90]) cup(w+3*th);
}

leg_offset = (ro-ri)/4 + ri;
leg1_x = cos(90-angle) * leg_offset;
leg1_z = sin(90-angle) * leg_offset + clearance;
leg1_l = 1/sin(angle) * leg1_z;
leg2_x = cos(180-angle) * leg_offset;
leg2_z = sin(180-angle) * leg_offset + clearance;
leg2_l = 1/sin(90-angle) * leg2_z;
translate([leg1_x, 0, leg1_z])
rotate([0, 90+angle, 0]) translate([0, 0, leg1_l/2]) {
    cube([th, leg_w, leg1_l], center=true);
    translate([0, 0, leg1_l/2]) rotate([90, 0, 0]) cylinder(r=th/2, h=leg_w, center=true, $fn=10);
}
translate([leg2_x, 0, leg2_z])
rotate([0, 180+angle, 0]) translate([0, 0, leg2_l/2]) {
    cube([th, leg_w, leg2_l], center=true);
    translate([0, 0, leg2_l/2]) rotate([90, 0, 0]) cylinder(r=th/2, h=leg_w, center=true, $fn=10);
}

//color([50, 0, 0]) rotate([0, 0, -45]) cup(th);
module cup(th) {
    resize([0, 0, th])
    scale([0.5, 0.5, 1])
        intersection() {
            translate([60, -50, 0])
                import("coffee-cup3.stl", convexity=5);
            cube([120, 120, th], center=true);
        }
}

//rotate([90, 5, 0]) cup(w+2*th);
//cup(w+2*th);