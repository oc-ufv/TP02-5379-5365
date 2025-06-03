`timescale 1ns/100ps
module add (
    input [31:0] value1, value2,
    output [31:0] out
);
assign out = value1 + value2;
    
endmodule