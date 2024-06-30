`timescale 1ns/10ps

module CHIP(
    input CLK, input [3:0]OPCODE,
    output [7:0]R0, output [7:0]R1,
    output [7:0]R2, output [7:0]R3
);

    reg [7:0]F0_CONST = 8'b00010000;
    reg [7:0]F1_CONST = 8'b00100000;
    reg [7:0]F2_CONST = 8'b01000000;
    reg [7:0]F3_CONST = 8'b10000000;

    wire [7:0]F0;
    wire [7:0]F1;
    wire [7:0]F2;
    wire [7:0]F3;

    // Fixed Registers
    REGISTER f0(CLK, F0_CONST, F0);
    REGISTER f1(CLK, F1_CONST, F1);
    REGISTER f2(CLK, F2_CONST, F2);
    REGISTER f3(CLK, F3_CONST, F3);
    
    // Output Registers
    REGISTER r0(CLK, F0_CONST, R0);
    REGISTER r1(CLK, F1_CONST, R1);
    REGISTER r2(CLK, F2_CONST, R2);
    REGISTER r3(CLK, F3_CONST, R3);
endmodule


module CHIP_TB();
    wire CLK;
    wire [7:0] R0;
    wire [7:0] R1;
    wire [7:0] R2;
    wire [7:0] R3;
    reg [3:0]OPCODE;
    
    CLOCK #(50) clock(CLK);
    CHIP chip(CLK, OPCODE, R0, R1, R2, R3);

    initial begin
        OPCODE = 4'b0000;

        $dumpfile("chip.vcd");
        $dumpvars(0, CHIP_TB);

        #1000 $finish;
    end
endmodule
