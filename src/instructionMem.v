`timescale 1ns/100ps
module instructionMem (
    input clock,
    input [31:0] address,
    output reg [31:0] current_instruction
);

    reg[31:0] instructions [0:31];


    always @(*) begin
        current_instruction <= instructions[address >> 2];
    end


endmodule
