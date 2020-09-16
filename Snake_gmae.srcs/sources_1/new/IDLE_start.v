`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2019 14:11:56
// Design Name: 
// Module Name: IDLE_Start
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


module IDLE_Start(
   input CLK,
   input [9:0] ADDRH,   
   input [8:0] ADDRV,   
   output [11:0] IDLE_COLOR_OUT
   
   );
   
 
   parameter PINK = 12'h78f;
   
   assign IDLE_COLOR_OUT = colour_in;
   
   reg [11:0] colour_in;     //final input color put into VGA interface 
   
   always@(posedge CLK) begin  
                   // give layout
                  if (  ( (ADDRV >= 0) && ( ADDRV <= 205)) && ((ADDRH >= 0) && (ADDRH <= 640)) )                  
                        colour_in <= ~PINK;
                        
                    else if (  ( (ADDRV >= 205) && ( ADDRV <=275)) && ((ADDRH >= 0) && (ADDRH <=70)) )
                         colour_in <= ~PINK;
                    else if (  ( (ADDRV >= 275) && ( ADDRV <= 480)) && ((ADDRH >= 0) && (ADDRH <=640)) )
                         colour_in <= ~PINK;      
                      
                    else if (  ( (ADDRV >= 205) && ( ADDRV <= 215)) && ((ADDRH >= 530) && (ADDRH <= 640)) )
                         colour_in <= ~PINK;
                    else if (  ( (ADDRV >= 215) && ( ADDRV <= 275)) && ((ADDRH >= 505) && (ADDRH <= 640)) )
                         colour_in <= ~PINK;
                              
                    else if (  ( (ADDRV >= 245) && ( ADDRV <= 265)) && ((ADDRH >= 70) && (ADDRH <= 120)) )
                        colour_in <= ~PINK;
                    else if (  ( (ADDRV >= 215) && ( ADDRV <= 235)) && ((ADDRH >= 80) && (ADDRH <= 130)) )
                        colour_in <= ~PINK;                  
                    
                    else if (  ( (ADDRV >= 205) && ( ADDRV <= 215)) && ((ADDRH >=130) && (ADDRH <= 170)) )
                         colour_in <= ~PINK;
                    else if (  ( (ADDRV >= 215) && ( ADDRV <= 275)) && ((ADDRH >= 130) && (ADDRH <= 195)) )
                       colour_in <= ~PINK;
                    else if (  ( (ADDRV >= 205) && ( ADDRV <= 215)) && ((ADDRH >= 230) && (ADDRH <= 270)) )
                       colour_in <= ~PINK;
                    else if (  ( (ADDRV >= 215) && ( ADDRV <= 275)) && ((ADDRH >= 205) && (ADDRH <= 270)) )
                       colour_in <= ~PINK;                
    
                    else if (  ( (ADDRV >= 215) && ( ADDRV <= 235)) && ((ADDRH >= 280) && (ADDRH <= 320)) )
                         colour_in <= ~PINK;
                    else if (  ( (ADDRV >= 245) && ( ADDRV <= 275)) && ((ADDRH >= 280) && (ADDRH <= 320)))
                         colour_in <= ~PINK;
                    else if (  ( (ADDRV >= 205) && ( ADDRV <= 275)) && ((ADDRH >= 330) && (ADDRH <= 370)) )
                        colour_in <= ~PINK;
                    else if (  ( (ADDRV >= 215) && ( ADDRV <= 235)) && ((ADDRH >= 380) && (ADDRH <= 420)) )
                         colour_in <= ~PINK;                  
                         
                     else if (  ( (ADDRV >= 245) && ( ADDRV <= 275)) && ((ADDRH >= 385) && (ADDRH <= 430)&&(3*ADDRV<=2*ADDRH-35)) )
                          colour_in <= ~PINK;
                     else if (  ( (ADDRV >= 250) && ( ADDRV <= 275)) && ((ADDRH >= 380) && (ADDRH <= 420)&&(8*ADDRV>=5*ADDRH+100)) )
                         colour_in <= ~PINK;
                     else if (  ( (ADDRV >= 205) && ( ADDRV <= 215)) && ((ADDRH >= 430) && (ADDRH <= 470)) )
                         colour_in <= ~PINK;
                     else if (  ( (ADDRV >= 215) && ( ADDRV <= 275)) && ((ADDRH >= 430) && (ADDRH <= 495)) )
                         colour_in <= ~PINK;                                     
                   
                    
                    else
                       colour_in <= PINK;  
  
              
    end
endmodule
