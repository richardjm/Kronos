include <MCAD/boxes.scad>
include <inc/Utils.scad>

$fn=100;

// A couple of settings to allow for wiggle room
bearingOD = 22.2;

fillet = 2.5;

difference()
{
	union()
	{
		roundedCylinder(h=9.5,r=16,rr=fillet);
		translate([-8,0,10])
			roundedBox([16,50,20],radius=fillet, sidesonly=true);
		translate([-16,-25,0]) cube([8,50,20]);
	};
	union()
	{
		// Through hole
      translate([0,0,-0.1]) cylinder (h=2.5,r = 7);
		// Bearing
		translate([0,0,2]) cylinder (h=7.6,r = bearingOD/2);
		// Cutout above bearing
		translate([0,0,9.501])
			roundedCylinder (h=10.6, r=14, rr=fillet, bottom=true);
		// Screw holes
		translate([0,-19,10]) rotate([0,-90,0]) M5x20ScrewHole();
		translate([0,19,10]) rotate([0,-90,0]) M5x20ScrewHole();
	};
}
