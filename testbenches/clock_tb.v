`timescale 1ns/10ps

module CLOCK_TB();
    wire CLK;

    CLOCK #(.HALF_T(10)) clock (.CLK(CLK));

    initial begin
        $dumpfile("testbenches.vcd");
        $dumpvars(1, CLOCK_TB);

        #100 $finish;
    end
endmodule
