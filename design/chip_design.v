`timescale 1ns/10ps

module CHIP(
    input CLK, input [15:0]OPCODE,
    output [7:0]R0_REG_OUT, output [7:0]R1_REG_OUT,
    output [7:0]R2_REG_OUT, output [7:0]R3_REG_OUT
);
    // IO for fixed registers
    reg [7:0]F0_REG_IN = 8'b00010000;
    reg [7:0]F1_REG_IN = 8'b00100000;
    reg [7:0]F2_REG_IN = 8'b01000000;
    reg [7:0]F3_REG_IN = 8'b10000000;

    wire [7:0]F0_REG_OUT;
    wire [7:0]F1_REG_OUT;
    wire [7:0]F2_REG_OUT;
    wire [7:0]F3_REG_OUT;

    // Enable for fixed registers
    // Redundant, but can't have hanging wires in Verilog
    wire F0_ENABLE, F1_ENABLE, F2_ENABLE, F3_ENABLE;

    // Output wires for dynamic registers
    wire [7:0]D0_REG_OUT;
    wire [7:0]D1_REG_OUT;
    wire [7:0]D2_REG_OUT;
    wire [7:0]D3_REG_OUT;
    wire [7:0]D4_REG_OUT;
    wire [7:0]D5_REG_OUT;
    wire [7:0]D6_REG_OUT;
    wire [7:0]D7_REG_OUT;

    // Enable for dynamic registers
    wire D0_ENABLE, D1_ENABLE, D2_ENABLE, D3_ENABLE;
    wire D4_ENABLE, D5_ENABLE, D6_ENABLE, D7_ENABLE;

    // Enable for output registers
    wire R0_ENABLE, R1_ENABLE, R2_ENABLE, R3_ENABLE;

    // Register input and output data lines
    wire [7:0]R_INPUT;
    wire [7:0]R_OUTPUT_0;
    wire [7:0]R_OUTPUT_1;

    // Register input enable line
    wire R_ENABLE_WRITE;
    
    // Fixed Registers
    REGISTER f0(CLK, F0_REG_IN, F0_ENABLE, F0_REG_OUT);
    REGISTER f1(CLK, F1_REG_IN, F1_ENABLE, F1_REG_OUT);
    REGISTER f2(CLK, F2_REG_IN, F2_ENABLE, F2_REG_OUT);
    REGISTER f3(CLK, F3_REG_IN, F3_ENABLE, F3_REG_OUT);
    
    // Output Registers
    REGISTER r0(CLK, R_INPUT, R0_ENABLE, R0_REG_OUT);
    REGISTER r1(CLK, R_INPUT, R1_ENABLE, R1_REG_OUT);
    REGISTER r2(CLK, R_INPUT, R2_ENABLE, R2_REG_OUT);
    REGISTER r3(CLK, R_INPUT, R3_ENABLE, R3_REG_OUT);

    // Dynamic Registers
    REGISTER d0(CLK, R_INPUT, D0_ENABLE, D0_REG_OUT);
    REGISTER d1(CLK, R_INPUT, D1_ENABLE, D1_REG_OUT);
    REGISTER d2(CLK, R_INPUT, D2_ENABLE, D2_REG_OUT);
    REGISTER d3(CLK, R_INPUT, D3_ENABLE, D3_REG_OUT);
    REGISTER d4(CLK, R_INPUT, D4_ENABLE, D4_REG_OUT);
    REGISTER d5(CLK, R_INPUT, D5_ENABLE, D5_REG_OUT);
    REGISTER d6(CLK, R_INPUT, D6_ENABLE, D6_REG_OUT);
    REGISTER d7(CLK, R_INPUT, D7_ENABLE, D7_REG_OUT);

    // Demux to route input enables to individual registers
    DEMUX_16 register_input_control(
        OPCODE[12], OPCODE[13], OPCODE[14], OPCODE[15], R_ENABLE_WRITE,
        F0_ENABLE, F1_ENABLE, F2_ENABLE, F3_ENABLE,
        D0_ENABLE, D1_ENABLE, D2_ENABLE, D3_ENABLE,
        D4_ENABLE, D5_ENABLE, D6_ENABLE, D7_ENABLE,
        R0_ENABLE, R1_ENABLE, R2_ENABLE, R3_ENABLE
    );
    
    // Mux to route output wires from registers to processing unit
    // We need 2 because some instructions operate on two registers
    // OPCODE bits 4-11 are always the register addresses
    MUX_16 register_output_control_0(
        F0_REG_OUT, F1_REG_OUT, F2_REG_OUT, F3_REG_OUT,
        D0_REG_OUT, D1_REG_OUT, D2_REG_OUT, D3_REG_OUT,
        D4_REG_OUT, D5_REG_OUT, D6_REG_OUT, D7_REG_OUT,
        R0_REG_OUT, R1_REG_OUT, R2_REG_OUT, R3_REG_OUT,
        OPCODE[4], OPCODE[5], OPCODE[6], OPCODE[7], R_OUTPUT_0
    );
    
    MUX_16 register_output_control_1(
        F0_REG_OUT, F1_REG_OUT, F2_REG_OUT, F3_REG_OUT,
        D0_REG_OUT, D1_REG_OUT, D2_REG_OUT, D3_REG_OUT,
        D4_REG_OUT, D5_REG_OUT, D6_REG_OUT, D7_REG_OUT,
        R0_REG_OUT, R1_REG_OUT, R2_REG_OUT, R3_REG_OUT,
        OPCODE[8], OPCODE[9], OPCODE[10], OPCODE[11], R_OUTPUT_1
    );

    /*
     * ###############################
     * Executing Instructions
     * ###############################
     * 
     * 2 operations per instruction -
     * - Decode and Read
     * - Operate and Write
     */
    
    // Inst counter outputs
    // and Inst counter enable
    wire INST_S0, INST_S1, INST_S0_BAR;
    wire INST_COUNTER_ENABLE;

    ONE_BIT_COUNTER inst_counter(
        CLK, INST_COUNTER_ENABLE, R_ENABLE_WRITE
    );
    
    // Arithmetic-Logic Unit
    ALU alu(OPCODE[3:0], R_OUTPUT_0, R_OUTPUT_1, R_INPUT);
endmodule


module CHIP_TB();
    wire CLK;
    wire [7:0]R0;
    wire [7:0]R1;
    wire [7:0]R2;
    wire [7:0]R3;
    reg [15:0]OPCODE;
    
    CLOCK #(500) clock(CLK);
    CHIP chip(CLK, OPCODE, R0, R1, R2, R3);

    initial begin
        OPCODE = 16'b0000000000000000;

        $dumpfile("chip.vcd");
        $dumpvars(0, CHIP_TB);

        #1000 $finish;
    end
endmodule
