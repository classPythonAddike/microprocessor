`timescale 1ns/10ps

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
    input IN, input S0, input S1,
    output O0, output O1, output O2, output O3
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

module DEMUX_16(
    input S0, input S1, input S2, input S3, input IN,
    output O0, output O1, output O2, output O3,
    output O4, output O5, output O6, output O7,
    output O8, output O9, output O10, output O11,
    output O12, output O13, output O14, output O15
);
    wire  in_0, in_1, in_2, in_3;

    DEMUX_4 demux_0(in_0, S0, S1, O0, O1, O2, O3);
    DEMUX_4 demux_1(in_1, S0, S1, O4, O5, O6, O7);
    DEMUX_4 demux_2(in_2, S0, S1, O8, O9, O10, O11);
    DEMUX_4 demux_3(in_3, S0, S1, O12, O13, O14, O15);

    DEMUX_4 demux_4(IN, S3, S2, in_0, in_1, in_2, in_3);
endmodule
