slider_w = 2;
slider_l = 5;
fader_w = 9;
fader_l = 22;
fader_hmax = 4.35;
centerline_l = 9.9;
centerline_w = 0.9;
centerline_h = 3.9;
outer_curve_l = 5.30;
outer_curve_base = 0.9;
outer_curve_h = fader_hmax - outer_curve_base;
fader_hmin = 3.45;
ridge_w = 0.2;
ridge_d = 0.2;
outer_wall = 1;

inner_curve_l = fader_l - 2*outer_curve_l;
inner_curve_h = fader_hmax-fader_hmin;
inner_curve_r = (pow(inner_curve_l/2, 2) + pow(inner_curve_h, 2))/(2*inner_curve_h);
outer_curve_z = (pow(fader_l/2, 2) - pow(inner_curve_l/2, 2) - pow(outer_curve_h, 2))/outer_curve_h/2;
outer_curve_r = sqrt(pow(fader_l/2, 2) + pow(outer_curve_z, 2));

// basic curve
module base() {
    intersection() {
        difference() {
            translate([0, 0, fader_hmax/2]) cube([fader_w, fader_l, fader_hmax], center=true);
            translate([0, 0, fader_hmin+inner_curve_r]) rotate([0, 90, 0]) cylinder(h=fader_w+1, r=inner_curve_r, center=true, $fn=100);
        }
        translate([0, 0, outer_curve_base-outer_curve_z]) rotate([0, 90, 0])
            cylinder(h=fader_w+1, r=outer_curve_r, center=true, $fn=100);
    }
}

module ridge() {
    cube([fader_w, ridge_w, ridge_d*2], center=true);
}

// add texture
module textured() {
    difference() {
        base();
        for(a=[5,10,15,20]) {
            translate([0, 0, fader_hmin+inner_curve_r])
                rotate([a, 0, 0]) translate([0, 0, -inner_curve_r])
                ridge();
            translate([0, 0, fader_hmin+inner_curve_r])
                rotate([-a, 0, 0]) translate([0, 0, -inner_curve_r])
                ridge();
        }
    }

}

module cutout() {
    cube([fader_w-2*outer_wall, inner_curve_l, 2*(fader_hmin-outer_wall)], center=true);
}
difference() {
    textured();
    cutout();
}
translate([0, 0, centerline_h/2])
    cube([centerline_l, centerline_w, centerline_h], center=true);