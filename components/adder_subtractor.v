module EIGHT_BIT_ADDER_SUBTRACTOR(input X, input[7:0] A, input[7:0] B, output[7:0] C);
    wire B0, B1, B2, B3, B4, B5, B6, B7;
    
    XOR b0(B0, B[0], X);
    XOR b1(B1, B[1], X);
    XOR b2(B2, B[2], X);
    XOR b3(B3, B[3], X);
    XOR b4(B4, B[4], X);
    XOR b5(B5, B[5], X);
    XOR b6(B6, B[6], X);
    XOR b7(B7, B[7], X);

    wire COUT;

    EIGHT_BIT_ADDER adder_subtractor(A, {B7, B6, B5, B4, B3, B2, B1, B0}, X, C, COUT);

endmodule
