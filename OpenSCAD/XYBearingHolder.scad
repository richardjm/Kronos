use <MCAD/boxes.scad>

$fn=100;

// A couple of settings to allow for wiggle room
bearingOD = 22.2;

M5ScrewHoleD = 5.2;
M5HeadD = 9;

fillet = 2.5;

module ScrewHole()
{
	screwDepth = 20;
	screwHoleR = M5ScrewHoleD / 2;
	union()
	{
		translate([0,0,-1]) cylinder(screwDepth + 1,screwHoleR,screwHoleR);
		translate([0,-screwHoleR,-1]) cube([screwHoleR,M5ScrewHoleD,screwDepth + 1]);
		translate([0,0,-screwDepth-0.001]) cylinder(h=screwDepth, r=M5HeadD/2);
	}
}

module roundedCylinder(h,r,rr,bottom)
{
	fn = 30;
	if (bottom)
	{
		translate([0,0,rr]) cylinder(h = h - rr,r = r );
   	cylinder(h = h, r = r - rr);

		rotate_extrude(convexity = 10)
		translate([r - rr, rr, 0])
		circle(r = rr, $fn = fn);
	}
	else
	{
   	cylinder(h = h - rr,r = r );
   	cylinder(h = h, r = r - rr);

		rotate_extrude(convexity = 10)
		translate([r - rr, h - rr, 0])
		circle(r = rr, $fn = fn);
	}
}

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
		translate([0,-19,10]) rotate([0,-90,0]) ScrewHole();
		translate([0,19,10]) rotate([0,-90,0]) ScrewHole();
	};
}
