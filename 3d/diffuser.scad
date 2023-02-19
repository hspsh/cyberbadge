E = 0.6;  // Extruder dia.
L = 0.3;  // Layer height

N = 8;
M = 32;

h = 2.726 * 10;
w = 11.180 * 10;

led_h = h/N;
led_w = w/M;

module pcb () {
    color("green") offset(r=0.3) import("outline.svg");
}

module usb () {
    color("red") offset(r=0.3) import("usb.svg");
}


module holder () {
    color("red") offset(r=0.3) import("holder.svg");
}

module buttons () {
    color("red") offset(r=0.3) import("buttons.svg");
}

module led() {
    square([led_w, led_h]);
}

module matrix_courtyard () {
    import("matrix_courtyard.svg");
}

matrix_x = 9.85;
matrix_y = 9.5;
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
            linear_extrude(L*3)
            difference () {
                outer_outline();
                matrix_courtyard();
            }

            
            linear_extrude(2)
            union() {
                difference() {
                    outer_outline();
                    offset(r= -1 )pcb();
                }
                offset(E) matrix_courtyard();
            }
            
            linear_extrude(5)
            difference() {
                outer_outline();
                pcb();
            }
            
        }
            color("yellow") linear_extrude(3)
        matrix_diffuser();
    }
        
    linear_extrude(L*2) {
        matrix_courtyard();
    }
}

//cover();

mirror([1,0,0]) difference () {
    cover();
    linear_extrude(5) color("red") usb();    linear_extrude(5) color("red") holder();
    linear_extrude(5) color("red") buttons();
}