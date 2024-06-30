`timescale 1ns/10ps

module D_FLIP_FLOP_TB();
    wire CLK, Q, Q_BAR;
    reg D, CLEAR, PRESET;

    CLOCK #(.HALF_T(50)) clock (.CLK(CLK));
    D_FLIP_FLOP dff (.D(D), .CLK(CLK), .PRESET(PRESET), .CLEAR(CLEAR), .Q(Q), .Q_BAR(Q_BAR));

    initial begin
        $dumpfile("dff.vcd");
        $dumpvars(1, D_FLIP_FLOP_TB);
        
        CLEAR = 0;
        PRESET = 1;
        D = 0;
        #100 CLEAR = 1;
        #10 D = 1;
        #1000 $finish;
    end
endmodule

