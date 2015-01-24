use <MCAD/boxes.scad>

$fn=100;

module ScrewHole()
{
	union()
	{
		translate([0,0,-1]) cylinder(18,2.5,2.5);
		translate([0,0,-10.001]) cylinder(h=10,r=4.5);
		translate([0,-2.5,-1]) cube([2.5,5,18]);
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
		roundedCylinder(h=9.5,r=16,rr=2.5);
		translate([-8,0,10]) roundedBox([16,50,20],radius=3,sidesonly=true);
		translate([-16,-25,0]) cube([8,50,20]);
	};
	union()
	{
      translate([0,0,-0.1]) cylinder (h=2.5,r=7);
		translate([0,0,2]) cylinder (h=7.6,r=10.1);
		translate([0,0,9.501]) roundedCylinder (h=10.6, r=15.8, rr=2.5, bottom=true);
		translate([0,-19,10]) rotate([0,-90,0]) ScrewHole();
		translate([0,19,10]) rotate([0,-90,0]) ScrewHole();
	};
}
