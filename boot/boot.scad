bl = 200; // boot length
inf = bl * 10;   // "infinity"
zer = 0.001; // "zero"

module ground() {
	difference() {
		minkowski() {
			translate([0,0,(zer-inf)])
				cylinder(inf,zer,zer,$fn=3);
			child();
		}
		translate([-inf/2,-inf/2,-2*inf])
			cube([inf,inf,2*inf]);
	}
}

module ankle() {
	translate([0,-45,-30])
		linear_extrude(1)
		scale([0.9,1.5]) circle(r=20,$fn=30);
}

module button() {
	scale([1,0.7,1]) sphere(r=3,$fn=40);
}

module stps() {
	translate([-18.5,-65,0])
		scale([0.26,0.55,1])
		minkowski() {
			linear_extrude(0.01)
				import("smash.dxf");
			scale([1,1,1.8]) sphere(r=1,$fn=10);
		}
}

module boot() {
	// foot
	difference() {
		hull() {
			union() {
				difference() {
					scale([1.2,2,1.1])
						sphere(r=20,$fn=50);
					translate([-50,-50,0])
						cube([100,100,100]);
				}
				translate([0,0,-1])
					linear_extrude(1)
					translate([0,-35])
					scale([1.1,2.3])
					circle(r=20);
			}
			ankle();
		}
		translate([64.5,-10,0])
			rotate([-60,0,0])
			scale([0.8,0.8,3])
			sphere(r=56,$fn=60);
	}

	// text
	stps();

	// leg
	difference() {
		hull() {
			ankle();
			translate([0,-45,-80])
				linear_extrude(1)
				scale([1.05,1.65])
				circle(r=20,$fn=100);
		}
		translate([0,-14.5,-90])
			scale([600,40,45])
			rotate([0,0,45])
			cube([1,1,1]);
	}
	translate([0,-14,-50]) button();
	translate([0,-14,-60]) button();
	translate([0,-14,-70]) button();
}

difference() {
	scale([0.5,0.5,0.18])
		translate([-10,23,0])
		ground()
		translate([0,0,85])
		rotate([20,-35,0])
		boot();

	// magnet holes
	translate([0,0,0.3])  cylinder(1.75,6.5,6.5);
	translate([0,0,-0.1]) cylinder(1.75,0.5,0.5);
}
