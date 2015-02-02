include <Settings.scad>

module M5ScrewHole()
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