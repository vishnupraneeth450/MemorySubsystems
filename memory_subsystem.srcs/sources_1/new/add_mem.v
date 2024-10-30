`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2020 19:29:11
// Design Name: 
// Module Name: add_mem
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


module add_mem(
    input [7:0] pc,
    input rst,
    output [31:0] address
    );
    
    reg [31:0] instr_mem[31:0];
       
        always@(rst)
        begin
         if(rst == 0)
        begin
            $readmemh("Instruction.mem",instr_mem);
        end
        end
        
         assign address=instr_mem[pc];
endmodule
