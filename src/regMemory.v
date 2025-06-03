`timescale 1ns/100ps

module regMemory (
    input regWrite,
    input [4:0] readReg1, readReg2, writeReg, 
    input [31:0] writeData,
    output reg [31:0] readData1, readData2
);
    reg [31:0] registersSet [0:31]; 
    
    //x0 sempre sera 0
    always @(registersSet[0]) begin
        registersSet[0] = 0;
    end
    
    always @(regWrite or writeData) begin
        if (regWrite == 1) begin
            registersSet[writeReg] <= writeData; 
        end
    end

    always @(readReg1, registersSet[readReg1]) begin
        readData1 <= registersSet[readReg1];
        
    end
    
    always @(readReg2, registersSet[readReg2]) begin
        readData2 <= registersSet[readReg2];
        
    end

endmodule