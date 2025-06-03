`timescale 1ns/100ps
module alu (
    input [31:0] aluInput1, aluInput2,
    input [3:0] aluControl,
    output reg [31:0] aluResult,
    output aluZero
);
    assign aluZero = (aluResult == 0) ? 1 : 0;

    always @(*)
    begin
        case (aluControl) //lh, sh, add, or, andi, sll, bne
        4'b0010: aluResult <= aluInput1 + aluInput2; //lh, sh, add
        4'b0110: aluResult <= aluInput1 - aluInput2; //bne
        4'b0001: aluResult <= aluInput1 | aluInput2; //or
        4'b0000: aluResult <= aluInput1 & aluInput2; //andi
        4'b0100: aluResult <= aluInput1 << aluInput2; //sll
        endcase
    end

endmodule