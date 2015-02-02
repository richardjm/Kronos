include <MCAD/boxes.scad>
include <inc/Utils.scad>

// 20x20 corner brace designed for M5x12 button head bolts
$fn=30;

blockSize = 25;
boltDepth = 6;
fillet = 2.5;
boltInset = 10;
cutBlock = blockSize-boltDepth*2;
unCutCorner = 8; // Relates to blockSize

difference()
{
	// Main block
	union()
	{
		difference()
		{
			cube([blockSize,blockSize,20]);
			// Main corner cut off
			rotate([0,0,45])
				translate([0,0,-1])
				cube([blockSize*2,blockSize,22]);
		};

		// First bolt head support
		translate([boltInset,boltDepth,10])
			rotate([90,-90,0])
			cylinder(h=boltDepth,r=M5HeadD/2);


		// Second bolt head support
		translate([blockSize-boltDepth,blockSize-boltInset,10])
			rotate([90,-90,90])
			cylinder(h=boltDepth,r=M5HeadD/2);

	};

	// Inner cutout
	translate([boltDepth,boltDepth,5])
		difference() {
			// Main inner block
			cube([cutBlock,cutBlock,10]);
			// Rounded corner within inner block
			translate([blockSize-boltDepth*2,0,5])
				roundedBox([unCutCorner,unCutCorner,30],radius=fillet);
		};

	// First screw hole
	translate([boltInset,boltDepth,10])
		rotate([90,-90,0])
		M5ScrewHole(d=20);

	// Second screw hole
	translate([blockSize-boltDepth,blockSize-boltInset,10])
	rotate([90,-90,90])
		M5ScrewHole(d=20);
};