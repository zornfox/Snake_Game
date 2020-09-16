`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2019 16:34:45
// Design Name: 
// Module Name: Score_Counter
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


module Score_Counter(
  input get_Target,
  input RESET,
  input CLK,
  output [3:0] scoreOut
  );
  
  reg [3:0] Current_Score;
  assign scoreOut = Current_Score;
  
  always@(posedge RESET or posedge get_Target) begin
     if(RESET)
       Current_Score <= 0;
     else if(get_Target)
        Current_Score <= Current_Score + 1;
   end 
   
endmodule
