include <MCAD/boxes.scad>
include <inc/Utils.scad>

$fn=100;

// Overall fillet size
fillet = 2.5;

// Main box size (Attached with M5x20)
boxX = 14;
boxY = 50;
boxYExtra = 8.4;

// Rod and bearing (608ZZ)
bearingOD = 22.2;
bearingHeight = 7;
topOfBearing = 20-8;
rodCentre = 18 - boxX;

// Rod pivot (M3)
pivotBoltD = 3.2;

// Backside idler (625ZZ)
idlerD = 16;
idlerBoltD = 5.2;
idlerInsert = 2;

// GT2 18 tooth pully
pulleyD1 = 17;
pulleyD2 = 13;

// Location of the backside idler
idlerLocation = [idlerD/2+pulleyD2/2,-pulleyD2/2-idlerD/2,0];

module block(x,y,z,rr=fillet)
{
    hull()
    {
        cube([1,1,z]);
        translate([0,y-1,0])
            cube([1,1,z]);
        translate([x-rr,y-rr,0])
            cylinder(r=rr,h=z);
        translate([x-rr,rr,0])
            cylinder(r=rr,h=z);
    };
}

// Whole system is centered on the rod
difference()
{
	union()
	{
        // Main block
        translate([-boxX-rodCentre,-boxY/2-boxYExtra,0])
            block(x=boxX,y=boxY+boxYExtra,z=20);
        // Idler support solid
        translate(idlerLocation)
            hull()
            {
                cylinder(r=idlerD/2,h=20-idlerInsert);
                translate([-idlerLocation[0]-boxX-rodCentre+1,-idlerD/2,0])
                    cube([1,idlerD,20-idlerInsert]);
            };
        // Bearing holder
        roundedCylinder(h=topOfBearing,r=16,rr=fillet);
	};
    
    // Cutout above bearing
    translate([0,0,topOfBearing-0.4])
        union(){
            roundedCylinder (h=20, r=14, rr=fillet, bottom=true);
            // Pulley visualisation
            %cylinder(r=pulleyD1/2,h=8);
            translate([0,0,8])
                %cylinder(r=pulleyD2/2,h=8);
            translate([0,0,16])
                %cylinder(r=pulleyD1/2,h=2);
        };
    // Bearing
    translate([0,0,topOfBearing-bearingHeight])
        cylinder (h=21,r = bearingOD/2);
    // Through hole rod clearance
    translate([0,0,topOfBearing-bearingHeight-1])
        cylinder (h=21,r = 7);
    // Pivot nut
    translate([0,0,topOfBearing-bearingHeight-1-M3NutHeight])
        M3Nut();
    // Through hole
    translate([0,0,-0.1])
        cylinder (h=21,r = pivotBoltD / 2);
        
    // Screw holes
    translate([-rodCentre,-boxY/2+6-boxYExtra,10])
        rotate([0,-90,0])
        M5ScrewHole();
    translate([-rodCentre,boxY/2-6,10])
        rotate([0,-90,0])
        M5ScrewHole();
        
    // Idler screw hole and nut trap
    translate(idlerLocation)
        union(){
            // Idler
            translate([0,0,20-idlerInsert])
                %cylinder(r=idlerD/2,h=12);
            // Bolt hole
            translate([0,0,M5NylockHeight+0.4])
                cylinder(r=idlerBoltD/2,h=15);
            // Nut trap
            translate([0,0,-0.01])
                M5Nylock();
        };
}
