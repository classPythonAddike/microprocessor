`timescale 1ns/10ps

// Max clock freq = 25 MHz
module REGISTER(input CLK, input[7:0] DATA_IN, input ENABLE, output[7:0] DATA_OUT);
    reg [7:0]d_out;

    specify
        // (CLK *> DATA_OUT) = (27, 32);
    endspecify

    always @ (posedge CLK, ENABLE) begin;
        d_out <= #32 DATA_IN;
    end

    assign DATA_OUT = d_out;
endmodule
