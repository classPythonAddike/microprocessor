`timescale 1ns/10ps

module ALU(input[3:0] OPCODE, input[7:0] R1, input[7:0] R2, output[7:0] ROUT);
   EIGHT_BIT_ADDER_SUBTRACTOR adder_subtractor(OPCODE[0], R1, R2, ROUT);
endmodule
