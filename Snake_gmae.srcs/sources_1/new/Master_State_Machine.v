`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 14:45:22
// Design Name: 
// Module Name: Master_State_Machine
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


module Master_State_Machine(
   input CLK,     //gibe the CLK signal
   input RESET,   //give the reset signal  
   // any button pressed can be make the state change
   input B_L,     
   input B_U,
   input B_R,
   input B_D,
   input [3:0] TARGET, // how many target eaten by snake
   // state could be the output
   output [1:0] states
    );
    
      
    reg [1:0] Mas_Curr_state;
    reg [1:0] Mas_Next_state;
    //assign currentstate to output states as connecting
    assign states = Mas_Curr_state;
   
    always@(posedge CLK) begin
       if(RESET)
           Mas_Curr_state<=2'b00;
       else 
           Mas_Curr_state  <= Mas_Next_state;
       end
      
     always@(B_L or B_U or B_R or B_D or Mas_Curr_state or TARGET) begin
         case(Mas_Curr_state)
         //idle state 
         2'b00  :begin
         
                if(B_L || B_U || B_R || B_D)
                   Mas_Next_state <= 2'b01;
                else
                   Mas_Next_state <= 2'b00;
                end
         //play state
         2'b01  :begin
                if(TARGET == 5'd3)
                   Mas_Next_state <= 2'b10;
                else
                   Mas_Next_state <= 2'b01;
                end
                
         // the win state, remain at this state when achivevd        
         2'b10  :begin
                 Mas_Next_state <= Mas_Curr_state;  
                end
                
         default:
                Mas_Next_state <= 2'b00;
         endcase 
       end    
         
endmodule
