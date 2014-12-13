include <MCAD/motors.scad>
$fn=100;

mountsize = 60;
thickness = 3;
mountingboltdia = 5;

mountholeoffset = 0.45 * mountsize;

difference() {
	union() {
		translate([-1 * mountsize/2,-1 * mountsize/2,0])
		cube([mountsize, mountsize, thickness]);

		translate([2*mountsize/5, 2*mountsize/5, 0])
		cylinder(r=mountsize/4, thickness);

		translate([2*mountsize/5, -2*mountsize/5, 0])
		cylinder(r=mountsize/4, thickness);

		translate([-2*mountsize/5, 2*mountsize/5, 0])
		cylinder(r=mountsize/4, thickness);

		translate([-2*mountsize/5, -2*mountsize/5, 0])
		cylinder(r=mountsize/4, thickness);
	}

	translate([0,0,-1])
	linear_extrude(height=2*thickness)
	stepper_motor_mount(17, 0, mochup=true);

	translate([mountholeoffset, mountholeoffset, -1])
	cylinder(d=mountingboltdia, thickness * 2);

	translate([mountholeoffset, -1 * mountholeoffset, -1])
	cylinder(d=mountingboltdia, thickness * 2);

	translate([ -1 * mountholeoffset, mountholeoffset, -1])
	cylinder(d=mountingboltdia, thickness * 2);

	translate([ -1 * mountholeoffset,  -1 * mountholeoffset, -1])
	cylinder(d=mountingboltdia, thickness * 2);
}

cradleheight = 25;
cradlesize = mountsize + 4 * mountingboltdia;

for (i=[[1,1],[1,-1],[-1,1],[-1,-1]]) {
	translate([i[0] * mountholeoffset, i[1] * mountholeoffset, thickness])
	difference() {
		cylinder(d=mountingboltdia*2,cradleheight);
	
		translate([0,0,-1])
		cylinder(d=mountingboltdia,2 * cradleheight);
	}
}

translate([0,0, thickness + cradleheight])
difference() {
	union() {
		translate([-1 * mountsize/2,-1 * mountsize/2,0])
		cube([mountsize, mountsize, thickness]);

		translate([2*mountsize/5, 2*mountsize/5, 0])
		cylinder(r=mountsize/4, thickness);

		translate([2*mountsize/5, -2*mountsize/5, 0])
		cylinder(r=mountsize/4, thickness);

		translate([-2*mountsize/5, 2*mountsize/5, 0])
		cylinder(r=mountsize/4, thickness);

		translate([-2*mountsize/5, -2*mountsize/5, 0])
		cylinder(r=mountsize/4, thickness);
	}

	translate([mountholeoffset, mountholeoffset, -1])
	cylinder(d=mountingboltdia, thickness * 2);

	translate([mountholeoffset, -1 * mountholeoffset, -1])
	cylinder(d=mountingboltdia, thickness * 2);

	translate([ -1 * mountholeoffset, mountholeoffset, -1])
	cylinder(d=mountingboltdia, thickness * 2);

	translate([ -1 * mountholeoffset,  -1 * mountholeoffset, -1])
	cylinder(d=mountingboltdia, thickness * 2);

	hull() {
		cylinder(d=mountingboltdia, thickness * 2);
		translate([mountingboltdia * 2,0,-1])
		cylinder(d=mountingboltdia, thickness * 2);
	}

	translate([-3 * mountingboltdia,0,-1])
	cylinder(d=mountingboltdia, thickness * 2);
}



