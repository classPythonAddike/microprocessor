`timescale 1ns/1ps

module MUX_4_TB();
    reg [7:0]r1, r2, r3, r4;
    reg s0, s1;
    wire [7:0]out;

    MUX_4 mux(r1, r2, r3, r4, s0, s1, out);

    initial begin
        $dumpfile("mux_demux.vcd");
        $dumpvars(1, MUX_4_TB);

        r1 = 8'b00000000;
        r2 = 8'b10101010;
        r3 = 8'b11111111;
        r4 = 8'b01010101;

        s0 = 0;
        s1 = 0;

        #50 s1 = 1;
        #50 s0 = 1;
        #50 s1 = 0;

        #50 $finish;
    end

endmodule
