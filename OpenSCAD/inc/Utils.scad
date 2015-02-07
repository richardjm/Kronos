include <Settings.scad>

wiggle = 0.05;

M3NutHeight = 2.4;
M4NutHeight = 3.2;
M4NylockHeight = 5;

module M3Nut()
{
    Nut(5.5, M3NutHeight);
}

module M4Nut()
{
    Nut(7, M4NutHeight);
}

module M4Nylock()
{
    Nut(7, M4NylockHeight);
}

module Nut(flatDistance, height)
{
    cylinder(r = flatDistance / 2 / cos(180 / 6) + wiggle, h = height + wiggle, $fn=6);
}

module M5ScrewHole()
{
	screwDepth = 20;
	screwHoleR = M5ScrewHoleD / 2;
	union()
	{
		translate([0,0,-1]) cylinder(screwDepth + 1,screwHoleR,screwHoleR);
		translate([0,-screwHoleR,-1]) cube([screwHoleR,M5ScrewHoleD,screwDepth + 1]);
		translate([0,0,-screwDepth*2-wiggle]) cylinder(h=screwDepth*2, r=M5HeadD/2);
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