`timescale 1ns/1ps

module NOT(input A, output B);
    not #15 (B, A);
endmodule

module AND(input A, input B, output C);
    and #(15, 20) (C, A, B);
endmodule


module NAND(input A, input B, output C);
    nand #15 (C, A, B);
endmodule


module OR(input A, input B, output C);
    or #(15, 22) (C, A, B);
endmodule


module NOR(input A, input B, output C);
    nor #15 (C, A, B);
endmodule


module XOR(input A, input B, output C);
    xor (C, A, B);
    
    specify
        if (A)  (B => C) = (30, 22);
        if (B)  (A => C) = (30, 22);
        if (~A) (B => C) = (23, 17);
        if (~B) (A => C) = (23, 17);
    endspecify
endmodule


module XNOR(input A, input B, output C);
    xnor #30 (C, A, B);
endmodule
