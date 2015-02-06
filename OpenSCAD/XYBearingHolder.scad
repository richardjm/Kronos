include <MCAD/boxes.scad>
include <inc/Utils.scad>

$fn=100;

topOfBearing = 20-8;
bearingOD = 22.2;
bearingHeight = 7;
bearingInset = 2;

pivotBoltD = 3.2;

fillet = 2.5;

difference()
{
	union()
	{
        translate([bearingInset,0,0])
            roundedCylinder(h=topOfBearing,r=16,rr=fillet);
		translate([-8,0,10])
			roundedBox([16,50,20],radius=fillet, sidesonly=true);
		translate([-16,-25,0])
            cube([8,50,20]);
	};
    
    translate([bearingInset,0,topOfBearing-bearingHeight-1-M3NutHeight])
        M3Nut();
    // Through hole
    translate([bearingInset,0,-0.1])
        cylinder (h=21,r = pivotBoltD / 2);
    // Through hole
    translate([bearingInset,0,topOfBearing-bearingHeight-1])        cylinder (h=21,r = 7);
    // Bearing
    translate([bearingInset,0,topOfBearing-bearingHeight])
        cylinder (h=bearingHeight,r = bearingOD/2);
    // Cutout above bearing
    translate([bearingInset,0,topOfBearing - 0.001])
        roundedCylinder (h=20, r=14, rr=fillet, bottom=true);
    // Screw holes
    translate([0,-19,10]) rotate([0,-90,0]) M5ScrewHole();
    translate([0,19,10]) rotate([0,-90,0]) M5ScrewHole();
}
