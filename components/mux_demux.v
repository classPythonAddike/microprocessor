`timescale 1ns/1ps

module MUX_4(
    input[7:0] I0, input[7:0] I1, input[7:0] I2, input[7:0] I3,
    input S0, input S1, output[7:0] OUT
);
    specify
        (I0, I1, I2, I3 *> OUT) = 9;
        (S0, S1 *> OUT) = 18;
    endspecify

    assign OUT = ((~S1) & (~S0)) ? I0 : ((~S1) & S0) ? I1 : (S1 & (~S0)) ? I2 : I3;
endmodule

module MUX_16(
    input[7:0] I0, input[7:0] I1, input[7:0] I2, input[7:0] I3,
    input[7:0] I4, input[7:0] I5, input[7:0] I6, input[7:0] I7,
    input[7:0] I8, input[7:0] I9, input[7:0] I10, input[7:0] I11,
    input[7:0] I12, input[7:0] I13, input[7:0] I14, input[7:0] I15,
    input S0, input S1, input S2, input S3, output[7:0] OUT
);
    wire [7:0] out_0, out_1, out_2, out_3;

    MUX_4 mux_0(I0, I1, I2, I3, S0, S1, out_0);
    MUX_4 mux_1(I4, I5, I6, I7, S0, S1, out_1);
    MUX_4 mux_2(I8, I9, I10, I11, S0, S1, out_2);
    MUX_4 mux_3(I12, I13, I14, I15, S0, S1, out_3);

    MUX_4 mux_4(out_0, out_1, out_2, out_3, S2, S3, OUT);
endmodule

module DEMUX_4(
    input[7:0] IN, input S0, input S1,
    output[7:0] O0, output[7:0] O1, output[7:0] O2, output[7:0] O3
);
    specify
        (S0, S1 *> O0, O1, O2, O3) = 12;
        (IN *> O0, O1, O2, O3) = (8, 10);
    endspecify

    assign O0 = (~S0) & (~S1) ? IN : 0;
    assign O1 = (S0) & (~S1) ? IN : 0;
    assign O2 = (~S0) & (S1) ? IN : 0;
    assign O3 = (S0) & (S1) ? IN : 0;
endmodule
