`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2019 14:53:05
// Design Name: 
// Module Name: WIN_State
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


module WIN_State(
    input CLK,
   input [9:0] ADDRH,   
   input [8:0] ADDRV,   
   output [11:0] WIN_COLOR_OUT
    );
    
    parameter WHITE = 12'hfff; 
    parameter RED  = 12'h00f;
    parameter BLACK = 12'h000;
    
      
    assign WIN_COLOR_OUT = {4'b0001,colour_in};  
    reg [7:0] colour_in;     //final input color put into VGA interface  
    
    reg [16:0] FrameCount;
    
     always@(posedge CLK) begin    
     
            if(ADDRV==479) begin
               FrameCount<=FrameCount+1;
            end
         end
         
         always@(posedge CLK) begin
            
               if(ADDRV[8:0]>240) begin
                  if(ADDRH[9:0]>320)
                     colour_in<=FrameCount[15:8]+ADDRV[7:0]+ADDRH[7:0]-240-320;
                  else
                     colour_in<=FrameCount[15:8]+ADDRV[7:0]-ADDRH[7:0]-240+320;
               end
               else begin
                  if(ADDRH>320)
                     colour_in<=FrameCount[15:8]-ADDRV[7:0]+ADDRH[7:0]+240-320;
                  else
                     colour_in<=FrameCount[15:8]-ADDRV[7:0]-ADDRH[7:0]+240+320;
               end
       end
    endmodule        
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
