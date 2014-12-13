include <bolts.scad>

$fn=100;
//$fn=10;

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

drawframe = false;
drawtruck = true;
drawbrace = false;

offset = 5;

bearing = "608";
dims = DIN625_1_dims(key=bearing, type="open", part_mode="default");
bearingdia = get_dim(dims,"d2");
bearinglen = get_dim(dims,"B");
axledia = 7.9375;
axlelen = 25.4;
shrouddia = 1.1 * bearingdia;
shroudlen = 1.25 * bearinglen;
truckwidth = 1.1 * shrouddia;
truckdepth = 0.6 * shrouddia;
truckheight = 1.2 * axlelen;

nutwidth = 9.5;
screwdia = 4.8;

// BEGIN TRUCK
if (drawtruck) {
	union() {
		translate([0,offset,truckwidth])
		rotate([0,90,0]) {
			difference() {
				cube([truckwidth, truckdepth, truckheight]);
				translate([truckwidth/2,axledia * 0.2,(truckheight - axlelen)/2])
				union() {
					cylinder(d=axledia,axlelen);
					translate([0,0,(axlelen - shroudlen)/2])
					cylinder(d=shrouddia,shroudlen);
				}
			}
		}
		difference() {
			cylinder(r=truckdepth + offset,truckwidth);
	
			translate([0,0,-1])
			cylinder(r=offset,2 * truckwidth);
	
			translate([0,-0.5 * truckheight * 10,-1])
			cube(truckheight * 10);
	
			translate([-1 * truckheight * 10 + 1,-1 * truckheight * 10,-1])
			cube(truckheight * 10);
	
			translate([-1 * truckheight * 10 + 1,-1,-10 * truckheight + 2/3 * truckwidth])
			cube(truckheight * 10);
	
			rotate([0,0,20])
			translate([0,truckdepth/2 + offset,truckwidth])
			rotate([0,180,0])
			union() {
				hexagon(5.5 * 0.98,3);
				cylinder(d=3,20);
			}
	
			rotate([0,0,70])
			translate([0,truckdepth/2 + offset,truckwidth])
			rotate([0,180,0])
			union() {
				hexagon(5.5 * 0.98,3);
				cylinder(d=3,20);
			}
		}
	} 
} // END TRUCK

color("RosyBrown", 0.6)
if (drawframe) {
	translate([0,offset,0])
	translate([(truckheight)/2,axledia * 0.2,truckwidth/2]) 
	rotate([0,90,0]){
		translate([0,0,-1 * bearinglen/2])
		cylinder(d=bearingdia,bearinglen);
//		RadialBallBearing(key="608", type="open", part_mode="default");
		translate([0,0,-1 * axlelen/2])
		cylinder(d=axledia,axlelen);
	}

//EMT
	translate([4 + 23.4/2,-4 + -1 * 23.4/2,-2.5 * truckwidth])
	cylinder(d=23.4,5 * truckwidth);

//Cross-brace
	translate([-2.5 * truckwidth,offset+truckdepth + 15,truckwidth / 2])
	rotate([0,90,0])
	cylinder(d=12.7,5 * truckwidth);
}



if (drawframe) {
	translate([0,0,truckwidth])
	rotate([180,0,-90])
	// BEGIN TRUCK
	color("LightCyan",0.9)
	union() {
		translate([0,offset,truckwidth])
		rotate([0,90,0]) {
			difference() {
				cube([truckwidth, truckdepth, truckheight]);
				translate([truckwidth/2,axledia * 0.2,(truckheight - axlelen)/2])
				union() {
					cylinder(d=axledia,axlelen);
					translate([0,0,(axlelen - shroudlen)/2])
					cylinder(d=shrouddia,shroudlen);
				}
			}
		}
		difference() {
			cylinder(r=truckdepth + offset,truckwidth);
			translate([0,0,-1])
			cylinder(r=offset,2 * truckwidth);
			translate([0,-0.5 * truckheight * 10,-1])
			cube(truckheight * 10);
			translate([-1 * truckheight * 10 + 1,-1 * truckheight * 10,-1])
			cube(truckheight * 10);
			translate([-1 * truckheight * 10,-1,-10 * truckheight + 2/3 * truckwidth])
			cube(truckheight * 10);
			rotate([0,0,20])
			translate([0,truckdepth/2 + offset,truckwidth])
			rotate([0,180,0])
			union() {
				hexagon(5.5 * 0.98,3);
				cylinder(d=3,20);
			}
	
			rotate([0,0,70])
			translate([0,truckdepth/2 + offset,truckwidth])
			rotate([0,180,0])
			union() {
				hexagon(5.5 * 0.98,3);
				cylinder(d=3,20);
			}

		}
		color("RosyBrown", 0.6)
		translate([0,offset,0])
		translate([(truckheight)/2,axledia * 0.2,truckwidth/2]) 
		rotate([0,90,0]){
			translate([0,0,-1 * bearinglen/2])
			cylinder(d=bearingdia,bearinglen);
	//		RadialBallBearing(key="608", type="open", part_mode="default");
			translate([0,0,-1 * axlelen/2])
			cylinder(d=axledia,axlelen);
		}

	} // END TRUCK
}

thickness = truckwidth / 6;
roddia = 13;
washerdia = 27;
standoff = 1.1 * (washerdia + roddia)/2;

if (drawbrace) {
	
	color("OrangeRed") {
	translate([0,0,-1 / 3 * truckwidth])
			difference() {
				cylinder(r=truckdepth + offset,truckwidth);
				translate([0,0,-1])
				cylinder(r=offset,2 * truckwidth);
				translate([0,-0.5 * truckheight * 10,-1])
				cube(truckheight * 10);
				translate([-1 * truckheight * 10 + 1,-1 * truckheight * 10,-1])
				cube(truckheight * 10);
				translate([-1 * truckheight * 10,-1,-10 * truckheight + 2/3 * truckwidth])
				cube(truckheight * 10);
				rotate([0,0,20])
				translate([0,truckdepth/2 + offset,truckwidth + 5])
				rotate([0,180,0])
				union() {
					cylinder(d=3,20);
				}
		
				rotate([0,0,70])
				translate([0,truckdepth/2 + offset,truckwidth + 5])
				rotate([0,180,0])
					cylinder(d=3,20);
	
			}
	
	difference() {
		translate([0,-5 + offset + truckdepth + roddia * 0.9 + 2 * thickness,.9*roddia + (truckwidth - 1.8*roddia)/2])
		rotate([90,0,-90])
		difference() {
			union() {
				cylinder(r=roddia * 0.9, 2 * thickness);
				translate([0,standoff / -2,0]) 
				cube([standoff + 10,standoff,2 * thickness]);
	
	//			translate([0,-0.9 * roddia,0]) cube([1.8 * roddia,0.9 * roddia * 2,2 * thickness]);
			}
			translate([0,0,-1])
			cylinder(r=roddia / 2,20);
			translate([6 + standoff + roddia,truckwidth/2,0])
			rotate([90,0,0])
			cylinder(r=truckdepth + offset,truckwidth);
	
		}
			cylinder(r=truckdepth + offset,truckwidth);
	}
	}
}	
	
