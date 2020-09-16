`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 15:32:23
// Design Name: 
// Module Name: Navigation_State_Machine
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


module Navigation_State_Machine(
  input CLK,     //gibe the CLK signal
  input RESET,   //give the reset signal  
  // any button pressed can be make the state change
  input B_L,     
  input B_U,
  input B_R,
  input B_D,
  output [1:0] Navigation_state_out
    );
    
   reg  [1:0] Navigation_Curr_state;
   reg  [1:0] Navigation_Next_state;
   assign Navigation_state_out = Navigation_Curr_state;
   
   always@(posedge CLK) begin
      if(RESET)
          Navigation_Curr_state<=2'b00;
      else 
          Navigation_Curr_state  <= Navigation_Next_state;
   end
   
   always@(B_L or B_U or B_R or B_D or Navigation_Curr_state) begin
      case(Navigation_Curr_state)
          2'b00  :begin            
                  if(B_R) Navigation_Next_state = 2'b01;
                  else if(B_L) Navigation_Next_state = 2'b11;
                  else   Navigation_Next_state = Navigation_Curr_state;  
                  end
          
          2'b01  :begin
                  if(B_U) Navigation_Next_state = 2'b00;
                  else if(B_D) Navigation_Next_state = 2'b10;  
                  else  Navigation_Next_state = Navigation_Curr_state;
                  end
                  
         2'b10   :begin
                  if(B_R) Navigation_Next_state = 2'b01;
                  else if(B_L) Navigation_Next_state = 2'b11;  
                  else Navigation_Next_state = Navigation_Curr_state;
                  end
               
         2'b11   :begin
                  if(B_U) Navigation_Next_state = 2'b00;
                  else if(B_D) Navigation_Next_state = 2'b10;  
                  else Navigation_Next_state = Navigation_Curr_state;
                  end
         default:
                  Navigation_Curr_state = 2'b00;
          endcase 
        end    
endmodule
