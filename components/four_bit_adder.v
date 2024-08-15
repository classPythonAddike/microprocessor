module HALF_ADDER(input A, input B, output SUM, output COUT);
    XOR sum(SUM, A, B);
    AND carry(COUT, A, B);
endmodule

module FULL_ADDER(input A, input B, input CIN, output SUM, output COUT);
    wire carry_out_ha1, sum_ha1, carry_out_ha2;

    HALF_ADDER ha1(A, B, sum_ha1, carry_out_ha1);
    HALF_ADDER ha2(sum_ha1, CIN, SUM, carry_out_ha2);
    OR carry(COUT, carry_out_ha1, carry_out_ha2);
endmodule

module FOUR_BIT_ADDER(input [3:0]A, input [3:0]B, input CIN, output [3:0]SUM, output COUT);
    wire c0, c1, c2;

    FULL_ADDER fa0(A[0], B[0], CIN, SUM[0], c0);
    FULL_ADDER fa1(A[1], B[1], c0, SUM[1], c1);
    FULL_ADDER fa2(A[2], B[2], c1, SUM[2], c2);
    FULL_ADDER fa3(A[3], B[3], c2, SUM[3], COUT);
endmodule

module EIGHT_BIT_ADDER(input [7:0]A, input [7:0]B, input CIN, output [7:0]SUM, output COUT);
    wire c1;

    FOUR_BIT_ADDER fba_0(A[3:0], B[3:0], CIN, SUM[3:0], c1);
    FOUR_BIT_ADDER fba_1(A[7:4], B[7:4], c1, SUM[7:4], COUT);
endmodule
