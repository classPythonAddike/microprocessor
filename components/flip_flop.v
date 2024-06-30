`timescale 1ns/10ps

module D_FLIP_FLOP(input D, input CLK, input PRESET, input CLEAR, output Q, output Q_BAR);
    reg q, q_bar;
    
    specify
        (CLK *> Q, Q_BAR) = (25, 40);
        $setup(D, posedge CLK, 20);
        $hold(D, posedge CLK, 5);
    endspecify

    always @ (CLEAR, PRESET)
        if (~CLEAR) begin
            q = 0;
            q_bar = 1;
        end
        else if (~PRESET) begin
            q = 1;
            q_bar = 0;
        end

    always @ (posedge CLK) begin
        if (CLEAR & PRESET) begin
            q = D;
            q_bar = ~D;
        end
    end
            

    assign Q = q;
    assign Q_BAR = q_bar;
endmodule


module JK_FLIP_FLOP(input J, input K, input CLK, input PRESET, input CLEAR, output Q, output Q_BAR);
    reg q, q_bar;
    
    specify
        (CLK *> Q, Q_BAR) = (25, 40);
    endspecify

    always @ (CLEAR, PRESET)
        if (~CLEAR) begin
            q = 0;
            q_bar = 1;
        end
        else if (~PRESET) begin
            q = 1;
            q_bar = 0;
        end

    always @ (posedge CLK) begin
        if (CLEAR & PRESET) begin
            q = J & Q_BAR + (~K) & Q;
            q_bar = ~q;
        end
    end
            

    assign Q = q;
    assign Q_BAR = q_bar;
endmodule
