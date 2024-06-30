`timescale 1ns/10ps

module CLOCK #(parameter HALF_T=10) (output CLK);
    reg clk;

    initial begin
        clk = 0;
        forever #HALF_T clk = ~clk;
    end

    assign CLK = clk;
endmodule
