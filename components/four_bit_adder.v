module HALF_ADDER(input A, input B, output SUM, output COUT);
    XOR sum(SUM, A, B);
    AND carry(COUT, A, B);
endmodule

module FULL_ADDER(input A, input B, input CIN, output SUM, output COUT);
    wire carry_out_ha1, sum_ha1, carry_out_ha2;

    HALF_ADDER ha1(
        .A (A),
        .B (B),
        .SUM (sum_ha1),
        .COUT (carry_out_ha1)
    );

    HALF_ADDER ha2(
        .A (sum_ha1),
        .B (CIN),
        .SUM (SUM),
        .COUT (carry_out_ha2)
    );

    or carry(COUT, carry_out_ha1, carry_out_ha2);
endmodule

module FOUR_BIT_ADDER(input [3:0]A, input [3:0]B, input CIN, output [3:0]SUM, output COUT);
    wire c1, c2, c3;

    FULL_ADDER fa0(
        .A (A[0]),
        .B (B[0]),
        .CIN (CIN),
        .SUM (SUM[0]),
        .COUT (c1)
    );

    FULL_ADDER fa1(
        .A (A[1]),
        .B (B[1]),
        .CIN (c1),
        .SUM (SUM[1]),
        .COUT (c2)
    );
    
    FULL_ADDER fa2(
        .A (A[2]),
        .B (B[2]),
        .CIN (c2),
        .SUM (SUM[2]),
        .COUT (c3)
    );

    FULL_ADDER fa3(
        .A (A[3]),
        .B (B[3]),
        .CIN (c3),
        .SUM (SUM[3]),
        .COUT (COUT)
    );
endmodule

module EIGHT_BIT_ADDER(input [7:0]A, input [7:0]B, input CIN, output [7:0]SUM, output COUT);
    wire c1;

    FOUR_BIT_ADDER fba_0(
        .A (A[3:0]),
        .B (B[3:0]),
        .CIN (CIN),
        .SUM (SUM[3:0]),
        .COUT (c1)
    );

    FOUR_BIT_ADDER fba_1(
        .A (A[7:4]),
        .B (B[7:4]),
        .CIN(c1),
        .SUM (SUM[7:4]),
        .COUT (COUT)
    );
endmodule
