`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2020 19:39:52
// Design Name: 
// Module Name: cache_controller
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


module cache_controller(
    input clk,
    input rst
    );
    
    wire [31:0] address,data;
    wire clock;                   
    wire hit;                
    processor a1(clock,rst,address);
    cache a2(address,clk,hit,rst,data,clock);
     
endmodule
                              