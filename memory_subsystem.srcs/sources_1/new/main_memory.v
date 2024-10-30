`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2020 13:27:08
// Design Name: 
// Module Name: main_memory
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


module main_memory(
    input clk,
    input [31:0]address,
    input hit,
    input rst,
    output [31:0] data1,
    output [31:0] data2,
    output clock
    );
    
    reg [7:0] memory[127:0];
    reg clock;
    
    always@(rst)
    begin
    if(rst==0)
    $readmemb("data.mem",memory);
    end
    
    reg x;
   
    always@(hit,clk)
    begin
    clock=clk;
    if(hit==0)
    begin
    x=0;
    clock=0;
    repeat(10) 
    begin
    @(posedge clk);
    end
    x=1;
    clock=clk;
    end
    end
    
    assign data1={memory[address+3],memory[address+2],memory[address+1],memory[address]};
    assign data2={memory[address+7],memory[address+6],memory[address+5],memory[address+4]};
endmodule
