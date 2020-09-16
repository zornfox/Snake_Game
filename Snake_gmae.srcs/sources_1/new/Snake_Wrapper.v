`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2019 12:43:04
// Design Name: 
// Module Name: Snake_Wrapper
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


module Snake_Wrapper(
    input CLK,
    input RESET,
    
    input BTNR,
    input BTNL,
    input BTNU,
    input BTND,
   
    output HS,
    output VS,
    output [11:0] COLOUR_OUT,
    
    output [3:0] SEG_SELECT_OUT,
    output [7:0] HEX_OUT
    );
     // chose state from state master machine
       wire [1:0] state;
     // Chose one of 4 driection to move
       wire [1:0] DIRECTION;
      

       wire [12:0] Random_Target_Address;
       wire [6:0]Target_X = Random_Target_Address[6:0];
       wire [5:0]Target_Y = Random_Target_Address[12:7];
       
       wire [9:0] ADDRH;
       wire [8:0] ADDRV;
       
       wire get_Target;   // as a trigger signal, connecting to the 7-segment display
       wire [3:0]CurrentScore;  
       
       wire [11:0] Colour_Display;
       wire trig;
       
     Master_State_Machine MS_Machine(
             .CLK(CLK),
             .RESET(RESET),
             .B_U(BTNU),
             .B_R(BTNR),
             .B_D(BTND),
             .B_L(BTNL),
             .TARGET(CurrentScore),
             .states(state)
             );
             
     Navigation_State_Machine NS_Machine(
             .CLK(CLK),
             .RESET(RESET),
             .B_U(BTNU),
             .B_R(BTNR),
             .B_D(BTND),
             .B_L(BTNL),
             .Navigation_state_out(DIRECTION)
             );
             
      VGA_Wrapper VGA_Interface(
              .CLK(CLK),
              .states(state),
              .COLOR_IN(Colour_Display),
              .trig(trig),
              .X(ADDRH),
              .Y(ADDRV),
              .COLOR_OUT(COLOUR_OUT),
              .HS(HS),
              .VS(VS)
              );  
          
     Target_Generator target(
              .CLK(CLK),
              .RESET(RESET),
              .get_Target(get_Target),
              .Random_Target_Address(Random_Target_Address)
             );         
             
      Score_Counter Score(
             .CLK(CLK),
             .RESET(RESET),
             .get_Target(get_Target),
             .scoreOut(CurrentScore)
              );   
              
      Segment7_Display_Interface Decoder(
             .SEG_SELECT_IN(2'b00),
             .BIN_IN(CurrentScore),
             .DOT_IN(1'b0),
             .SEG_SELECT_OUT(SEG_SELECT_OUT),
             .HEX_OUT(HEX_OUT)
              );  
              
      Snake_Control Controller(
              .CLK(CLK),
              .RESET(RESET),
              .states(state),
              .Direction(DIRECTION),
              .ADDRH(ADDRH),
              .ADDRV(ADDRV),
              .Target_X(Target_X),
              .Target_Y(Target_Y),
              .CONTROL(trig),
              .COLOUR_OUT(Colour_Display),
              .get_Target(get_Target)
      );       
      
endmodule
