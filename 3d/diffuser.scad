E = 0.6;  // Extruder dia.
L = 0.3;  // Layer height

N = 7;
M = 24;

h = 2.350 * 10;
w = 8.354 * 10;

led_h = h/N;
led_w = w/M;

module pcb () {
    color("green") offset(r=0.3) import("outline.svg");
}

module led() {
    square([led_w, led_h]);
}


module matrix_diffuser () {
    difference() {
    import("matrix_courtyard.svg");
    translate([0.53,10.78])
    for (j = [0:M-1]) {
    for (i = [0:N-1]) {
        translate([j * led_w, i * led_h, 0]) offset(r=-E/3) led();
    }
    }
    }
    
}

module outer_outline(r=E) {
    offset(r=r) pcb();
}

module cover() {
    linear_extrude(L*3)
    outer_outline();
    
    linear_extrude(2)
    difference() {
        outer_outline();
        offset(r= -1 )pcb();
    }
    
    linear_extrude(5)
    difference() {
        outer_outline();
        pcb();
    }
    
    linear_extrude(2)
    matrix_diffuser();
}

//cover();

mirror([1,0,0]) cover();