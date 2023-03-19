`timescale 1ns / 1ps
    
module prog_counter(clock,clock_out, cout,rst, sw_in);
    //counter
    input rst;
    input [3:0] sw_in;
    output [3:0] cout;
    reg [3:0] Q;
    
    // init value
    reg [3:0] init_value;
    
    //clock div
    input clock;
    output reg clock_out;
    reg[31:0] counter=32'd0;
    parameter divisor = 32'd100000000;

    // The frequency of the output clk_out
    //  = The frequency of the input clk_in divided by DIVISOR
    // For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
    // You will modify the DIVISOR parameter value to 28'd50.000.000
    // Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz

    //clock div
    always @(posedge clock) begin
     counter <= counter + 32'd1;
     if(counter>=(divisor-1))
        counter <= 32'd0;
     clock_out <= (counter<divisor/2)?1'b1:1'b0;
    end

    // initial value
    always @(posedge (clock_out) , posedge (rst)) begin
        init_value <= sw_in[0] * 1 + sw_in[1] * 2 + sw_in[2] * 4 + sw_in[3] * 8;
        if(rst) 
            Q <= init_value;
        else
            Q <= Q + 4'd1;
    end
    
    assign cout = Q;
endmodule