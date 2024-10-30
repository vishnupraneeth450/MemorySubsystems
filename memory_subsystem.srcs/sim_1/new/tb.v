`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2020 22:35:46
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb(
    );
    
    reg clk,rst;
    
    cache_controller uut(clk,rst);
    
    initial begin
    clk=0;
    repeat(100) #5 clk=~clk;
    end
    
    initial begin
    rst=1;
    #5 rst=0;
    #5 rst=1;
    end
endmodule
