`timescale 1ns/10ps

module TWO_BIT_COUNTER(input CLK, input RESET, output S0, output S1);
    reg [1:0]counter;

    initial
        counter = 2'b00;

    always @ (posedge CLK)
        counter = counter + 1;

    always @ (!RESET)
        counter = 0;

    assign S0 = counter[0];
    assign S1 = counter[1];
endmodule
