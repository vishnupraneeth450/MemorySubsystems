`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2020 13:27:08
// Design Name: 
// Module Name: processor
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


module processor(
    input clk,
    input rst,
    output[31:0] address
    );
    reg [7:0]pc;
    reg x;
    add_mem s1(pc,rst,address);
   always@(posedge clk,rst)
        begin
        if(rst==0)
        begin
            pc<=0;
            x<=1;
            end
        else
        begin
            
            pc=pc+1;
            if(x==1)
                        begin
                        pc=0;
                        x=0;
                        end
            end
            
        end
endmodule
