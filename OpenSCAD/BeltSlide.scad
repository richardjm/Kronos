// This is modified from Eustathios-mini by misan
// http://www.thingiverse.com/thing:513955

module body() {
cylinder(r=20/2,h=25,,$fn=60);
translate([-10,0,0]) cube([10,19+5+3+5,25]); 
translate([-5,4-3,0]) cube([20-5,15+5+3+3,8]);
}

module holes() {
cylinder(r=12.7/2,h=26,$fn=60);
// correa
translate([10-5-5,5+5+5,0]) {
	#cube([10,2.4,40]);
	translate([2+3,-2.5,0]) #cylinder(r=1.8,h=40,$fn=20);
	translate([2+3,5,0]) #cylinder(r=1.8,h=40,$fn=20);
}

//varilla 
translate([0-5,2.5+7.5,3]) {
// varilla en cruz
translate([5+20,10,10]) rotate([0,-90,0]) #cylinder(h=100,r=8.4/2,$fn=30);
// tornillo varilla
translate([0,6,17]) rotate([-90,-90,0]) #cylinder(h=100,r=3.6/2,$fn=20);
// ranura varilla
translate([-5,9,12]) #cube([10,2.4,10]);
// tuerca varilla
translate([0,6-3-10-7,17]) rotate([-90,-90,0]) rotate(30) #cylinder(h=4+10+7,r=6.60/2,$fn=6);
}
/*
//dollas
cylinder(r=16.6/2,h=2,$fn=30);
cylinder(r=12.8/2,h=10,$fn=30);

translate([0,0,25.1]) rotate([0,180,0]) {
	cylinder(r=16.6/2,h=2,$fn=30);
	cylinder(r=12.8/2,h=10,$fn=30);
	}
*/
}

difference() { body(); holes(); }

mirror() translate([-30,0,0]) difference() { body(); holes(); }

translate([0,-30,0,]) end_belt();
translate([30,-30,0,]) mirror() end_belt();

module end_belt() {
 difference() {
	cube([10,12,10]);
// correa
translate([10-5-5,5,0]) {
	#cube([7.5,2.4,40]);
	translate([2+3,-2.5,0]) #cylinder(r=1.8,h=40,$fn=20);
	translate([2+3,5,0]) #cylinder(r=1.8,h=40,$fn=20);
	translate([-5,-11,0]) #cylinder(r=20/2,h=25,,$fn=60);
}
}
}