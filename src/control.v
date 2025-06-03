`timescale 1ns/100ps
module control (
    input [6:0] opcode,
    output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] ALUOp
    //output aluOpCtrl,
);
    reg [7:0] outControl;
    always @(*)
    begin
        case (opcode) //lh, sh, add, or, andi, sll, bne
            7'b0000011: outControl <= 8'b01100011; //lh - Tipo I Certo
            7'b0100011: outControl <= 8'b00000110; //sh = Tipo S Certo
            7'b0110011: outControl <= 8'b00010001; //add, or, sll - Tipo R Certo
            7'b0010011: outControl <= 8'b00011011; //andi - Tipo I Certo
            7'b1100011: outControl <= 8'b10001000; //bne - Tipo SB Certo
            default: outControl <= 8'bx;
        endcase

        Branch <= outControl[7];
        MemRead <= outControl[6];
        MemtoReg <= outControl[5];
        ALUOp <= outControl[4:3];
        MemWrite <= outControl[2];
        ALUSrc <= outControl[1];
        RegWrite <= outControl[0];
    end
endmodule