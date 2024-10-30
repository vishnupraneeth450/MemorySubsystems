`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2020 13:27:08
// Design Name: 
// Module Name: cache
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


module cache(
    input [31:0] address,
    input clk,
    input hit,
    input rst,
    output reg [31:0] data,
    output clock
    );
    wire valid1,valid2;
    wire [1:0] tag1,tag2;
    reg encoder;
    wire [1:0]tag=address[6:5];
    wire block_offset=address[2];
    reg [67:0] cache_mem[7:0];
    
//    always@(rst)
//    begin
//    if(rst==0)
//    begin
//    //cache_mem[0]=68'b0;
//    cache_mem[1]={67'b0,1'b1};
//    cache_mem[0]={67'b0,1'b1};
//    cache_mem[2]=68'b0;
//    cache_mem[3]=68'b0;
//    cache_mem[4]=68'b0;
//    cache_mem[5]=68'b0;
//    cache_mem[6]=68'b0;
//    cache_mem[7]=68'b0;
//    end
//    end
    
    wire [2:0]x={address[4:3],1'b0};
    wire [2:0]y={address[4:3],1'b1};
    
    wire e1,e2;
     assign valid1=cache_mem[x][67];
     assign valid2=cache_mem[y][67];
     assign tag1=cache_mem[x][66:65];
     assign tag2=cache_mem[y][66:65];
     assign e1= (tag1==tag)?1'b1:1'b0;
     assign e2= (tag2==tag)?1'b1:1'b0;     
     assign hit=(valid1 && e1) || (valid2 && e2);
     
     
     wire [31:0] data1;
     wire [31:0] data2;
 
     main_memory a3(clk,address,hit,rst,data1,data2,clock);
     
     
     always@(posedge clock,negedge rst)
     begin
     if(rst==0)
         begin
         //cache_mem[0]=68'b0;
         cache_mem[1]={67'b0,1'b1};
         cache_mem[0]={67'b0,1'b1};
         cache_mem[2]=68'b0;
         cache_mem[3]=68'b0;
         cache_mem[4]=68'b0;
         cache_mem[5]=68'b0;
         cache_mem[6]=68'b0;
         cache_mem[7]=68'b0;
         end
         
         else begin
        if(hit)
        begin
            if((valid1 && tag1)==1 && (valid2 && tag2)==0)  encoder=0;
            if((valid1 && tag1)==0 && (valid2 && tag2)==1)  encoder=1; //////include lru
            case(encoder)
            1'b0:begin
                  case(address[2])
                        1'b0:data=cache_mem[x][63:32];
                        1'b1:data=cache_mem[x][31:0];
                  endcase
                  cache_mem[x][64]=1'b0;
                  cache_mem[y][64]=1'b1;
                 end
            1'b1:begin
                  case(address[2])
                        1'b0:data=cache_mem[y][63:32];
                        1'b1:data=cache_mem[y][31:0];
                  endcase
                  cache_mem[x][64]=1'b1;                                      //lru
                  cache_mem[y][64]=1'b0;                                      //lru
                 end
            endcase
        end
        
        else
        begin
            if(valid1==1)
            begin
                if(valid2==1)
                    begin
                    if(cache_mem[x][64])
                    begin
                    cache_mem[x][63:0]={data1,data2};
                    cache_mem[x][67]=1;
                    cache_mem[x][66:65]=address[6:5];
                    end 
                    else if(cache_mem[y][64])
                    begin
                    cache_mem[y][63:0]={data1,data2};
                    cache_mem[y][67]=1;
                    cache_mem[y][66:65]=address[6:5];
                    end 
               end
               
               else
               begin 
               cache_mem[y][63:0]={data1,data2};
               cache_mem[y][67]=1;
               cache_mem[y][66:65]=address[6:5];
               end
            end
            else
            begin
            cache_mem[x][63:0]={data1,data2};
            cache_mem[x][67]=1;
            cache_mem[x][66:65]=address[6:5];
            end            
        end
        end
     end
endmodule
