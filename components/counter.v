`timescale 1ns/10ps

module ONE_BIT_COUNTER(input CLK, input RESET, output S);
    reg counter;

    initial
        counter = 1'b0;

    always @ (posedge CLK)
        #5 counter <= counter + 1;

    always @ (!RESET)
        counter = 0;

    assign S = counter;
endmodule
