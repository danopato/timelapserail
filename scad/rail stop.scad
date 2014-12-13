$fn=100;

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}


emtd = 23.4;
thickness = 5;

tiethickness = 0.5 * thickness;

%translate([0,50,0])
rotate([90,0,0])
cylinder(d=emtd, 100);


difference() {
	union() {
		translate([emtd/-2, 0, 0])
		cube([emtd, thickness, 0.75 * emtd]);

		translate([0,thickness,emtd * 0.75])
		rotate([90,0,0])
		cylinder(d=emtd, thickness);

		translate([0,0,emtd/8])
		rotate([90,0,0])
		cylinder(d=emtd, thickness * 4);
	}

	translate([0,50,0])
	rotate([90,0,0])
	cylinder(d=emtd, 100);

	translate([0,(tiethickness + thickness)/2,1])
	rotate([90,0,0])
	difference() {
		cylinder(d=1.5 * emtd, tiethickness);
		translate([0,0,-1])
		cylinder(d=1.25 * emtd, 3 * thickness);
	}


	translate([-2 * emtd, -5 * thickness, -0.9 * emtd])
	cube([4 * emtd, 10 * thickness, emtd]);

}

