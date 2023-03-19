`timescale 1ns / 1ps

module prog_counter_tb;
    reg clock, rst;
    wire clock_out;
    reg [3:0] sw_in;
    wire [7:0] cout;
    
    prog_counter uut(
        .clock(clock),
        .clock_out(clock_out),
        .cout(cout),
        .rst(rst),
        .sw_in(sw_in)
    );
    
    initial begin
        clock = 0;
            forever #10 clock = ~clock;
    end
   
    initial begin
        rst = 1'b1;
        sw_in[0] = 1'b1;
        sw_in[1] = 1'b1;
        sw_in[2] = 1'b0;
        sw_in[3] = 1'b0; 
        #100;
        
        rst = 1'b0;
        sw_in[0] = 1'b1;
        sw_in[1] = 1'b1;
        sw_in[2] = 1'b0;
        sw_in[3] = 1'b0; 
        #100;
    end
   
endmodule