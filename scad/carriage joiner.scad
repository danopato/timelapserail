include <bolts.scad>

//RadialBallBearing(key="608", type="open", part_mode="default");
//!RadialBallBearing_dims(key="608", type="open", part_mode="default");

$fn=100;
nutwidth = 9.5;
screwdia = 4.8;
basewidth = nutwidth * 4;
thickness = 5;
roddia = 13;

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

difference() {
	union() {
		cylinder(r=basewidth/2, thickness);
		translate([0,-1 * basewidth / 2,0]) cube([basewidth/2,basewidth,thickness]);
		translate([basewidth/2,0,0]) cylinder(r=basewidth/2, thickness);
	}
	translate([-1 * basewidth / 5,basewidth / 6,-1])
	union() {
		hexagon(nutwidth * 0.98,7);
		cylinder(r=(screwdia / 2),20);
	}
	translate([basewidth / 1.5,basewidth / 6,-1])
	union() {
		hexagon(nutwidth * 0.98,7);
		cylinder(r=(screwdia / 2),20);
	}
	
	translate([1.1 * basewidth,-1.22 * basewidth,-1])
	rotate([0,0,45])
	cube(basewidth,2 * basewidth,2 * thickness);

	translate([-1.3 * basewidth,-0.5 * basewidth,-1 * thickness])
	rotate([0,0,-45])
	cube(basewidth,2 * basewidth,2 * thickness);

	translate([0.25 * basewidth,basewidth / 8,-1])
	rotate([0,0,45])
	cube(basewidth, basewidth, 2 * thickness);
}

translate([basewidth / 4,0,-8 - roddia/2])
rotate([0,270,90])
difference() {
	union() {
		cylinder(r=roddia * 0.9, 2 * thickness);
		translate([0,-0.9 * roddia,0]) 
		cube([1.4 * roddia,1.8 * roddia,2 * thickness]);
	}
	translate([0,0,-1])
	cylinder(r=roddia / 2,20);
}

