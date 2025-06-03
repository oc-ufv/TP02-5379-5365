`timescale 1ns/100ps
module aluControl (
    input [1:0] ALUOp,
    input [2:0] funct3,
    output reg [3:0] aluControlreg
    
);
    
    always @(*)
    begin
        case (ALUOp) //lh, sh, add, or, andi, sll, bne
            2'b00: aluControlreg <= 4'b0010; //lh e sh
            2'b01: aluControlreg <= 4'b0110; //bne
            2'b11: aluControlreg <= 4'b0000; //andi
            2'b10: case (funct3) 
                3'b000: aluControlreg <= 4'b0010; //add
                3'b110: aluControlreg <= 4'b0001; //or
                3'b001: aluControlreg <= 4'b0100; //sll
            endcase
        endcase


    end
endmodule