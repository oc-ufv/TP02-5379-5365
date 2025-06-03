`timescale 1ns/100ps

module pc (
    input clock, reset,
    input [31:0] pcIn,
    output reg [31:0] pcOut
);

    always @(posedge clock) begin
        if (reset) begin
            pcOut <= 32'b0;
        end
        else begin
            pcOut <= pcIn;
        end
    end

endmodule