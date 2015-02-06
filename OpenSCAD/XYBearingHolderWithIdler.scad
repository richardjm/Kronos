include <MCAD/boxes.scad>
include <inc/Utils.scad>

$fn=100;

boxY = 57.5;

topOfBearing = 20-8;
bearingOD = 22.2;
bearingHeight = 7;
bearingInset = 2;

pivotBoltD = 3.2;

fillet = 2.5;

// 624ZZ idler
idlerD = 21;
idlerBoltD = 4.3;
idlerNutR=4.1;
idlerNutDepth=4;

difference()
{
	union()
	{
        translate([bearingInset+5,-6-idlerD/2,10])
             roundedBox([23,10,20], radius=fillet, sidesonly=true);
        translate([bearingInset,0,0])
            roundedCylinder(h=topOfBearing,r=16,rr=fillet);
		translate([-8,-(boxY-50)/2,10])
			roundedBox([16,boxY,20],radius=fillet, sidesonly=true);
		translate([-16,-(boxY-50)/2-boxY/2,0])
            cube([8,boxY,20]);
	};
    
    translate([bearingInset,0,topOfBearing-bearingHeight-1-M3NutHeight])
        M3Nut();
        //cylinder(h=pivotNutDepth, r=pivotNutR, $fn=6);
    // Through hole
    translate([bearingInset,0,-0.1])
        cylinder (h=21,r = pivotBoltD / 2);
    // Through hole rod clearance
    translate([bearingInset,0,topOfBearing-bearingHeight-1])
        cylinder (h=21,r = 7);
    // Bearing
    translate([bearingInset,0,topOfBearing-bearingHeight])
        cylinder (h=bearingHeight,r = bearingOD/2);
    // Cutout above bearing
    translate([bearingInset,0,topOfBearing - 0.001])
        roundedCylinder (h=20, r=14, rr=fillet, bottom=true);
    // Screw holes
    translate([0,-26.5,10])
        rotate([0,-90,0])
        M5ScrewHole();
    translate([0,19,10])
        rotate([0,-90,0])
        M5ScrewHole();
    // Idler screw hole and nut trap
    translate([bearingInset+idlerD/2,-6-idlerD/2,-0.5])
        cylinder(r=idlerBoltD/2,h=21);
    translate([bearingInset+idlerD/2,-6-idlerD/2,-0.5])
        M4Nut();
        //cylinder(h=idlerNutDepth, r=idlerNutR, $fn=6);
}
