$fn=100;

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

casethickness = 2;
casel = 110;
casew = 70;
caseh = 30;
topw = cos(20) * casew;

potholed = 7;
potnobd = 14.5;
potbodyd = 16.3;
potbodyl = 7.25;
potshaftl = 14.5;
potshaftd = potholed;
potnobl = 17.4;

powerd = 11.5;
powerl = 12;

buttonbodyl = 15.2;
buttond = 16;

// Arduino mounting points
nanonuth = 1.3 * 1.25;
nanonutd = 3.2;
nanomounth = nanonuth * 2;
nanomountw = nanonutd * 2;

// LCD dimensions
lcdl = 80;
lcdw = 36;
lcdthickness = 1.6;
lcdholeoffset = 2.5;
lcdholed = 2.5;
lcddispl = 71.5;
lcddispw = 27;
lcddispthickness = 8;

arduinodims =
	[43.18, //nanolen
	 18.542, //nanowidth
	 1.778, //nanoholed
	 1.542, //nanoholeoffset
	 1.6]; //nanothickness

nanolen = arduinodims[0];
nanowidth = arduinodims[1];
nanoholed = arduinodims[2];
nanoholeoffset = arduinodims[3];
nanothickness = arduinodims[4];

module arduinonano() {
	translate([nanolen/-2,nanowidth/-2,nanothickness/-2])	
	difference() {
		cube([nanolen,nanowidth,nanothickness]);
	
		for (i=[[nanoholeoffset,nanoholeoffset],
				[nanoholeoffset,nanowidth - nanoholeoffset],
				[nanolen - nanoholeoffset,nanoholeoffset],
				[nanolen - nanoholeoffset,nanowidth - nanoholeoffset],]) {
			translate([i[0],i[1],-1])
			cylinder(d=nanoholed, nanothickness * 2);
		}
	}
}


module potentiometer(mockup=true) {
	if (mockup) {
		%color("LightSteelBlue", 0.4)
		union() {
			cylinder(d=potbodyd, potbodyl);
			translate([0,0,potbodyl])
			cylinder(d=potshaftd, potshaftl);
			translate([0,0,potbodyl + casethickness + 2])
			cylinder(d=potnobd, potnobl);
		}
	}
	color("Violet", 0.6)
	cylinder(d=potholed, potbodyl + potshaftl);
}

// Begin Case
difference() {
	union() { 
		difference() {
			cube([casel, casew, caseh]);
			translate([casethickness, casethickness, -1 * (caseh - 1)])
			cube([casel - 2 * casethickness, casew - 2 * casethickness, 2 * caseh]);
		}
		
		difference() {
		translate([0,0,caseh])
		rotate([20,0,0])
		translate([0,0,-1 * caseh])
		difference() {
			cube([casel, topw, caseh]);
			translate([casethickness, casethickness, -1 * (caseh + casethickness)])
			cube([casel - 2 * casethickness, topw - 2 * casethickness, 2 * caseh]);
		}
		
			translate([-1,6,0])
			cube([2 * casel, 2 * casew, caseh]);

			translate([0,7,caseh/2 -1])
			rotate([20,0,0])
			translate([-1,-6,caseh/-2])
			cube([2 * casel, 10, caseh]);
		}
	} 
	
	
	
	// Panel holes
	translate([0,0,caseh])
	rotate([20,0,0]) {
		translate([casel - lcdl - 6 - potnobd/2,topw - 3 - lcdw/2,-1 * potbodyl - casethickness])
		potentiometer();

		translate([casel - lcdl/2 - 3 + 4 + buttond/2,buttond/2 + 6,-1.1 * casethickness])
		cylinder(d=buttond, casethickness * 2);

		translate([casel - lcdl/2 - 3 - 4 - buttond/2,buttond/2 + 6,-1.1 * casethickness])
		cylinder(d=buttond, casethickness * 2);

		translate([0,0,-2 * casethickness])
//		translate([casel - 3 - lcdl + (lcdl - lcddispl)/2, topw -  - 6 - lcdw - (lcdw - lcddispw)/2,0])
		translate(lcdpos)
		translate([(lcdl - lcddispl - 1)/2, (lcdw - lcddispw - 1)/2,0])
		cube([lcddispl + 1, lcddispw + 1, casethickness * 3]);
	}

	translate([powerl/-2, casew - casew/5, caseh/3])
	rotate([0,90,0])
	cylinder(d=powerd, powerl);
}
// End Case




module nanomount() {
	translate([nanomountw/-2, nanomountw/-2, nanomounth/-2])
	difference() {
		union() {
			cube([nanomountw, nanomountw, nanomounth]);
			difference() {
				translate([0,nanomountw,0])
				rotate([-30,0,0])
				translate([0,-3,0])
				cube([nanomountw, nanomountw * 2, nanomounth]);
	
				translate([-1,-1,nanomounth])
				cube([1000,1000,1000]);
				translate([-1,-1,-1000])
				cube([1000,1000,1000]);
			}
		}
		
		translate([nanonutd,nanonutd,nanonuth/2 - 0.5])
		hexagon(nanonutd, nanonuth + 1);
		
		translate([(2 * nanonutd - (2*nanonutd/sqrt(3)))/2,-0.1,-0.1])
		cube([2*nanonutd/sqrt(3), nanonutd + 0.1, nanonuth + 0.1]);
		
		translate([nanonutd, nanonutd,0])
		cylinder(d=1.6,nanonuth * 5);
	
	}
}

%translate([-1 * nanomounth,0,0])
translate([casel - casethickness - nanothickness/2,casew/2,caseh/2])
rotate([90,0,90])
arduinonano();

for (i=[[1,1],[1,-1],[-1,1],[-1,-1]]) {
	translate([0,i[0] * (nanolen/2 - nanoholeoffset),
				 i[1] * (nanowidth/2 - nanoholeoffset)])
	translate([casel - casethickness - nanomounth/2,casew/2,caseh/2])
	rotate([110,0,0])
	rotate([0,-90,0])
	nanomount();
}



module qc1602a() {
	difference() {
		cube([lcdl,lcdw,lcdthickness]);

		for (i=[[0,0],[0,1],[1,0],[1,1]]) {
			translate([lcdholeoffset + i[0] * (lcdl - 2 * lcdholeoffset),
					   lcdholeoffset + i[1] * (lcdw - 2 * lcdholeoffset), -1])
			cylinder(d=lcdholed, lcdthickness * 2);
		}

	}
	translate([(lcdl - lcddispl)/2,(lcdw - lcddispw)/2,lcdthickness])
	cube([lcddispl,lcddispw,lcddispthickness]);
}

lcdpos = [casel - lcdl - 3, topw - lcdw - 3,0];

lcdmountsize = 7;
lcdmounth = lcddispthickness - casethickness;

translate([0,0,caseh])
rotate([20,0,0])
translate(lcdpos) {
	translate([0,0,-1 * lcdthickness - lcdmounth - casethickness])
	%qc1602a();

	difference() {
		for (i=[[0,0],[0,1],[1,0],[1,1]]) {
			translate([i[0] * (lcdl - 2 * lcdholeoffset),i[1] * (lcdw - 2 * lcdholeoffset),0])
			translate([lcdholeoffset - lcdmountsize/2,lcdholeoffset - lcdmountsize/2,-1 * lcdmounth - casethickness])
			difference() {
				cube([lcdmountsize,lcdmountsize,lcdmounth]);
				translate([lcdmountsize/2,lcdmountsize/2,0])
				cylinder(d=2.5, lcdmounth);
	
				translate([lcdmountsize/2,lcdmountsize/2,lcdmounth/2])
				hexagon(5,2.2);
	
				translate([lcdmountsize/2 - 2.5,-1 * lcdmountsize/2,lcdmounth/2 - 1.1])
				cube([5,5,2.2]);
			}

		}
			translate([(lcdl - lcddispl - 1)/2,(lcdw - lcddispw - 1)/2,-1 * lcdmounth - casethickness - 1])

			cube([lcddispl + 1, lcddispw + 1, casethickness * 5]);
	}
}



