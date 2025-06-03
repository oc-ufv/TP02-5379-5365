`timescale 1ns/100ps
module dataMemory(
    input clock, reset,
    input [31:0] address, writeData,
    input memRead, memWrite,
    output reg [31:0] readData
);

    reg [31:0] memory [0:511];
    reg [31:0] temp;

    always @(*) 
        begin
            temp <= memory[address >> 2];
            if (memWrite) begin
                if (address % 2 == 0)
                    memory[address] <= {writeData[15:0], {temp[31:15]}};
                else
                    memory[address] <= {writeData[15:0], {temp[15:0]}};
            end
            if (memRead) begin
                //se o bit de sinal (bit 15) for 1, isto significa que o número é negativo. 
                //portanto, a expressão retorna 16 bits todos em 1 (extensão de sinal para negativo).
                //se o bit de sinal for 0, isto significa que o número é positivo ou zero. 
                //portanto, a expressão retorna 16'b0, que são 16 bits todos em 0 (extensão de sinal para positivo).
                if (address % 2 == 0)
                    readData <= {{16{temp[31]}}, {temp[31:15]}};
                else
                    readData <= {{16{temp[15]}}, {temp[15:0]}};
            end
        end
endmodule

