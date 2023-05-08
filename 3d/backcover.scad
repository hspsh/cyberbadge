
include <diffuser.scad>

include <commit.scad>
/*skew takes an array of six angles:
 *x along y
 *x along z
 *y along x
 *y along z
 *z along x
 *z along y
 */
module skew(dims) {
matrix = [
	[ 1, dims[0]/45, dims[1]/45, 0 ],
	[ dims[2]/45, 1, dims[4]/45, 0 ],
	[ dims[5]/45, dims[3]/45, 1, 0 ],
	[ 0, 0, 0, 1 ]
];
multmatrix(matrix)
children();
}

height_back = 6*L;
hl = 5.8;

back_wall_w = 1;

module mounts_courtyard() {
    color("green") offset(r=0.4) import("mounts_courtyard.svg");
}

module holder_courtyard() {
    color("green") offset(r=0.4) import("holder_courtyard.svg");
}

module internal_supports() {
    color("green") import("internal_supports.svg");
}

module idontknow() {
    difference() {
        pcb();
        mounts_courtyard();
    }
}



module idontknow_extruded(off=0) {
    a = 40;
    intersection() {
        skew([0, 0, 0, 0, a, 0]) linear_extrude(hl) offset(off) idontknow();
        skew([0, 0, 0, 0, -a, 0]) linear_extrude(hl) offset(off)idontknow();
    }
}

module insidespace (){
    difference () {
        translate([0,0,-2*L]) idontknow_extruded(-2*E);

        linear_extrude(100, center=true) internal_supports();
    }
}

module angled_holder() {
    skew([0, 0, 0, 0, -40, 0]) linear_extrude(hl) 
        offset(0.4) holder_holes();
    intersection() {
        cube([100,100,3.]);
        skew([0, 0, 0, 0, -40, 0]) linear_extrude() pcb();
        skew([0, 0, 0, 0, 60, 0]) linear_extrude() holder_courtyard();
    }
}
module back_structure() {
    difference() {
        union() {
            linear_extrude(height_back) pcb();
            translate([0,0,height_back]) idontknow_extruded();
        }
        translate([0,0,1.5]) insidespace();
        linear_extrude(1.5) projection() insidespace();
        linear_extrude(.7) offset(.3) import("esp.svg");
    }   
    if (!has_holder) {
        translate([0,0,height_back]) angled_holder();   
    }
}

module backplate() {
    translate([0,0,height]) mirror([1,0,0]) {
        difference() {
            back_structure();
            linear_extrude() color("red") holes();
            translate([36, 4,0]) mirror([1,0,0]) linear_extrude() 
                text("/////", size=4, font="Iosevka:style=Extrabold Extended");
            translate([36, 38,0]) mirror([1,0,0]) linear_extrude() 
                text(" ////", size=4, font="Iosevka:style=Extrabold Extended");
            if (has_holder) linear_extrude(height) color("red") holder();
            translate([72, 12,height_back+hl-L]) mirror([1,0,0]) linear_extrude(L*2, true) 
                text("CyberBadge", size=6, font="Iosevka:style=Bold Extended");
            translate([0,0,height_back+hl-L]) linear_extrude(L*2, true) 
                import("onoff.svg");
            
            // strap hole
            translate([121,25,height_back+hl-1]) rotate([90,0,0]) difference() {
                cylinder(h=4, d=6, $fn=30);
                cylinder(h=10, d=3, $fn=30);
            }
            author_size = 4.5;
            author_height = hl + .7;
            translate([20,31,author_height]) linear_extrude(2*L) 
                text("2023", size=author_size, font="Iosevka:style=Extended");
            translate([20,24,author_height]) linear_extrude(2*L) 
                text("sf: Goggi", size=author_size, font="Iosevka:style=Extended");
            translate([20,17,author_height]) linear_extrude(2*L) 
                text("hw: cr1tbit", size=author_size, font="Iosevka:style=Extended");
            translate([20,10,author_height]) linear_extrude(2*L) 
                text("3d: not7CD", size=author_size, font="Iosevka:style=Extended");
            if(commit) {
                translate([105,36,author_height]) rotate([0,0,-90]) linear_extrude(2*L) 
                    text(commit, size=author_size, font="Iosevka:style=Extended");
            }
        }
    }
}



//#color("grey") faceplate();
difference() {
backplate();
    cube([100,100,100], true);
}