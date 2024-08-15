`timescale 1ns/10ps

module NOT(output B, input A);
    not #15 (B, A);
endmodule

module AND(output C, input A, input B);
    and #(15, 20) (C, A, B);
endmodule


module NAND(output C, input A, input B);
    nand #15 (C, A, B);
endmodule


module OR(output C, input A, input B);
    or #(15, 22) (C, A, B);
endmodule


module NOR(output C, input A, input B);
    nor #15 (C, A, B);
endmodule


module XOR(output C, input A, input B);
    xor (C, A, B);
    
    specify
        if (A)  (B => C) = (30, 22);
        if (B)  (A => C) = (30, 22);
        if (~A) (B => C) = (23, 17);
        if (~B) (A => C) = (23, 17);
    endspecify
endmodule


module XNOR(output C, input A, input B);
    xnor #30 (C, A, B);
endmodule
