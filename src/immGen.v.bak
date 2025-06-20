`timescale 1ns/100ps
module immGen (
    input [31:0] instruction,
    output reg [31:0] imm
);
    

    always @(*) begin

        case (instruction[6:0])

            // lw - I
            7'b0000011: imm <= {{21{instruction[31]}}, instruction[30:20]}; 
            // sw - S
            7'b0100011: imm <= {{21{instruction[31]}}, instruction[30:25], instruction[11:7]}; 
            // I - aritmetica + imediato
            7'b0010011: imm <= {{21{instruction[31]}}, instruction[30:20]}; 
            // SB - desvio
            7'b1100011: imm <= {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], {1'b0}}; 
            
            default: imm <= 32'bx;

        endcase
    end
    

endmodule