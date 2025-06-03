`include "src/datapath.v"
`timescale 1ns/100ps

module datapathTestbench;
    reg _clock, _reset;

    datapath datapathInst(.clock(_clock), .reset(_reset));

    integer i = 0;
    integer j = 0;

    initial begin
        $readmemb("src/quartus/registers_start.txt", datapathInst.regMemoryDP.registersSet);
        $readmemb("src/quartus/data_Mem.txt", datapathInst.dataMemoryDP.memory);
        $readmemb("src/quartus/instructions1_bin.txt", datapathInst.instructionMemDP.instructions);
        $dumpfile("src/datapath.vcd");
        $dumpvars(3, datapathTestbench);
        _reset = 1;
        _clock = 1;
        #5;
        _reset = 0;


        #60 $finish;

    end

        always @(datapathInst.InsMemOutDP) begin
            //#1;
            if (datapathInst.InsMemOutDP === 32'bx) begin
                for (i = 0; i < 32; i = i + 1 ) begin
                    // if (datapathInst.instructionMemDP.instructions[i] === 32'bx ) begin
                    //     //$display("registrador: %d : %b", i, datapathInst.regMemoryDP.registersSet[i]);
                    // end
                    $display("registrador:[ %d ]: %d", i, datapathInst.regMemoryDP.registersSet[i]);
                    #1;
                end
                for (j = 0; j < 7; j = j + 1 ) begin
                    // if (datapathInst.instructionMemDP.instructions[i] === 32'bx ) begin
                    //     //$display("registrador: %d : %b", i, datapathInst.regMemoryDP.registersSet[i]);
                    // end
                    $display("inst:[ %d ]: %b", j, datapathInst.instructionMemDP.instructions[j]);
                    #1;
                end
                #10;
            end
        end
        
        always begin
        forever #1 _clock <= ~_clock;
        end


endmodule

         