`timescale 1ns/100ps
module mux (
    input crtlSignal,
    input [31:0] value1, value2,
    output [31:0] out
);
    
    assign out = (crtlSignal == 0)? value2 : value1;

endmodule