`timescale 1ns/10ps

module RAM_64_BYTE(input[7:0] A, input[7:0] D, output[7:0] O, input CS_BAR, input WE_BAR);
    reg[7:0] memory [0:255];
    reg[7:0] out;
    
    specify
        (A => O) = (26, 19);
        (CS_BAR *> O) = (9, 13, 8);
        (WE_BAR *> O) = (0, 0, 13);
    endspecify

    initial
        for (integer i = 0; i <= 255; i++)
            memory[i] = 8'bxxxxxxxx;

    always @ (~CS_BAR & WE_BAR) begin
        memory[A] = D;
        out = 8'bzzzzzzzz;
    end

    always @ (~CS_BAR & ~WE_BAR)
        out = memory[A];

    always @ (CS_BAR)
        out = 8'bzzzzzzzz;

    assign O = out;

endmodule
