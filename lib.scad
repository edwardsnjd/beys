//////////////////////////
// parameters
//////////////////////////
layer_diam = 60;
layer_thickness = 10;

disc_inner = 20;
disc_outer = 40;
disc_thickness = 5;

driver_diam = 10;
tip_radius = driver_diam / 2;
driver_height = 10;
driver2_point_diam = 1;

decoration_count = 5;
hole_depth = layer_thickness / 3;

$fn = 64;

module energy_layer() {
    cylinder(d=layer_diam, h=layer_thickness);
}

module spikes() {
    for (i = [0:decoration_count])
        rotate([0,0,i*360/decoration_count])
            translate([layer_diam/2 - 10,0,0])
                cylinder(h=3, r1=3, r2=0);
}

module holes() {
    for (i = [0:decoration_count])
        rotate([0,0,360/decoration_count/2 + i*360/decoration_count])
            translate([layer_diam/2 - 10,0,0])
                cylinder(h=hole_depth+1, r=3);
}

module forge_disc() {
    difference() {
        cylinder(d=disc_outer, h=disc_thickness);
        cylinder(d=disc_inner, h=disc_thickness+1);
    }
}

module driver() {
    union() {
        cylinder(d=driver_diam, h=driver_height-tip_radius);
        translate([0,0,driver_height-tip_radius])
            sphere(r=tip_radius);
    }
}

module driver2() {
    cylinder(h=driver_height, r1=driver_diam/2, r2=driver2_point_diam);
}

module bey1() {
    difference() {
        union() {
            translate([0,0,0]) energy_layer();
            translate([0,0,layer_thickness]) spikes();
            translate([0,0,layer_thickness]) driver();
        }
        translate([0,0,layer_thickness-hole_depth]) holes();
    }
}

module bey2() {
    difference() {
        union() {
            translate([0,0,0]) energy_layer();
            translate([0,0,layer_thickness]) spikes();
            translate([0,0,layer_thickness]) driver2();
        }
        translate([0,0,layer_thickness-hole_depth]) holes();
    }
}