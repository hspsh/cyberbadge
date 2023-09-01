E = 0.6;  // Extruder dia.
L = 0.3;  // Layer height

N = 8;    // X LEDs
M = 32;   // Y LEDs

pitch = 0.350 * 10;  // dist. between leds

h = N * pitch;
w = M * pitch;

led_h = pitch;
led_w = pitch;


face_height = L*3;  // transparent diffuser face
pcb_height = 3; // PCB dist from diffures
height = pcb_height + 3;
button_height = 3 - 1.6 - 0.4;

has_holder = false;

module pcb () {
    color("green") offset(r=0.3) import("../outline.svg");
}

module model () {
    #translate([65.9,110,1+pcb_height]) rotate([0,180,0]) import("../model.stl");
}

module usb () {
    color("red") offset(r=0.3) import("../usb.svg");
}

module switch () {
    color("red") import("../switch.svg");
}


module holder () {
    color("red") offset(r=0.3) import("../holder.svg");
}

module holder_holes () {
    color("red") import("../holder_holes.svg");
}

module buttons () {
    color("red") offset(r=-0) import("../buttons.svg");
}

module buttons_area () {
    color("red") offset(r=-0) import("../buttons_area.svg");
}

module holes() {
    offset(r=-0.1) import("../holes.svg");
}

module holes_standoffs () {
    color("orange") difference () {
        offset(r=1.8) import("../holes.svg");
        offset(r=-0.4) import("../holes.svg");
    }
}

module led() {
    square([led_w, led_h]);
}

matrix_x = 9.85;
matrix_y = 9.55;

module matrix_courtyard () {
    offset(-E/2) translate([matrix_x, matrix_y]) square([w, h]);
    //import("matrix_courtyard.svg");
}


module matrix_diffuser () {

    translate([matrix_x,matrix_y])
    for (j = [0:M-1]) {
    for (i = [0:N-1]) {
        translate([j * led_w, i * led_h, 0]) offset(r=-E/2) led();
    }
    }
    
    
}

module outer_outline(r=E) {
    offset(r=r) pcb();
}

module cover() {

    difference() {
        union() {
            linear_extrude(face_height+L)
            difference () {
                outer_outline();
                matrix_courtyard();
            }

            
            linear_extrude(pcb_height)
            union() {
                difference() {
                    outer_outline();
                    offset(r=-1) pcb();
                }
                holes_standoffs();
                offset(E*2) matrix_courtyard();
            }
            
            linear_extrude(height)
            difference() {
                outer_outline();
                pcb(); 
            }
            
        }
        color("yellow") linear_extrude(pcb_height+1)
        matrix_diffuser();
    }
    
    linear_extrude(pcb_height-button_height) color("red") buttons_area();
        
    linear_extrude(face_height) {
        matrix_courtyard();
    }
    if (!has_holder) {
        linear_extrude(face_height+L) offset(-0.5) holder();
        //linear_extrude(height+2) offset(0.4)holder_holes();
    }
}

module faceplate() {
    mirror([1,0,0]) difference () {
        color("white") cover();
        linear_extrude(height) color("red") usb();
        translate([0,0,pcb_height-1.5]) linear_extrude(5) color("red") switch();  
        if (has_holder) linear_extrude(height) color("red") holder();
        linear_extrude(height) color("red") offset(-0.2) buttons();
        //translate([18, 3.3]) linear_extrude(L) text("CyberBadge 1.0.0", size=3, font="Iosevka");
    }
}
module notch () {
translate([-73,43.5,5.4]) rotate([0,90,0]) cylinder(10,r=0.7,true, $fn=20);
}


//cover();
//model();
//faceplate();
//notch();
