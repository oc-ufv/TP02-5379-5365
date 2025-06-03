`include "src/add.v"
`include "src/alu.v"
`include "src/aluControl.v"
`include "src/control.v"
`include "src/dataMemory.v"
`include "src/immGen.v"
`include "src/instructionMem.v"
`include "src/mux.v"
`include "src/pc.v"
`include "src/regMemory.v"
`timescale 1ns/100ps

module datapath (
    input clock, reset
);

    wire [31:0] PCInDP, PCOutDP, Add1OutDP, Add2OutDP, InsMemOutDP, ReadData1DP, 
                ReadData2DP, ImmGenOutDP, MuxOutAluInDP, WriteDataDP, AluResultDP,
                ReadDataDMOutDP;

    wire ZeroResultDP, BranchDP, MemReadDP, MemtoRegDP, RegWriteDP, ALUSrcDP, MemWriteDP;
    wire [1:0] ALUOpDP;
    wire [3:0] aluControlOutDP;


    add add4DP(
        .value1(PCOutDP),
        .value2(32'b100),
        .out(Add1OutDP)
    );

    add addBranchDP(
        .value1(PCOutDP),
        .value2(ImmGenOutDP),
        .out(Add2OutDP)
    );

    alu aluDP(
        .aluInput1(ReadData1DP),
        .aluInput2(MuxOutAluInDP),
        .aluControl(aluControlOutDP),
        .aluResult(AluResultDP),
        .aluZero(ZeroResultDP)
    );

    aluControl aluControlDP(
      .ALUOp(ALUOpDP),
      .funct3(InsMemOutDP[14:12]),
      .aluControlreg(aluControlOutDP)
    );
    
    control controlDP(
        .opcode(InsMemOutDP[6:0]),
        .Branch(BranchDP),
        .MemRead(MemReadDP),
        .ALUOp(ALUOpDP),
        .MemtoReg(MemtoRegDP),
        .MemWrite(MemWriteDP),
        .ALUSrc(ALUSrcDP),
        .RegWrite(RegWriteDP)
    );

    dataMemory dataMemoryDP(
        .clock(clock),
        .reset(reset),
        .address(AluResultDP),
        .writeData(ReadData2DP),
        .memRead(MemReadDP),
        .memWrite(MemWriteDP),
        .readData(ReadDataDMOutDP)
    );

    immGen immGenDP(
        .instruction(InsMemOutDP),
        .imm(ImmGenOutDP)
    );
    
    mux muxALUDP(
        .crtlSignal(ALUSrcDP),
        .value1(ImmGenOutDP),
        .value2(ReadData2DP),
        .out(MuxOutAluInDP)
    );

    mux muxBranchDP(
        .crtlSignal(BranchDP & ZeroResultDP),
        .value1(Add2OutDP),
        .value2(Add1OutDP),
        .out(PCInDP)
    );

    mux muxDMDP(
        .crtlSignal(MemtoRegDP),
        .value1(ReadDataDMOutDP),
        .value2(AluResultDP),
        .out(WriteDataDP)
    );
    
    instructionMem instructionMemDP(
        .clock(clock),
        .address(PCOutDP),
        .current_instruction(InsMemOutDP)
    );

    pc pcDP(
        .clock(clock),
        .reset(reset),
        .pcIn(PCInDP),
        .pcOut(PCOutDP)
    );

    regMemory regMemoryDP(
        .regWrite(RegWriteDP),
        .readReg1(InsMemOutDP[19:15]),
        .readReg2(InsMemOutDP[24:20]),
        .writeData(WriteDataDP),
        .readData1(ReadData1DP),
        .readData2(ReadData2DP),
        .writeReg(InsMemOutDP[11:7])
    );
    
endmodule
