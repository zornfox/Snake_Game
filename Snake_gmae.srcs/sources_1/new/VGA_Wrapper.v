`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2019 14:58:39
// Design Name: 
// Module Name: VGA_Wrapper
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


module VGA_Wrapper(
   input CLK,
   input [1:0] states,
   input  [11:0] COLOR_IN,//snake ,
   input trig,
   output [11:0] COLOR_OUT,
   output [9:0] X, //hrizontal ordinate of pixels
   output [8:0] Y, //vertical ordinate of pixels
   output HS,
   output VS
   );
   
   reg [11:0] COLOR_TRANSFER;    //the colour put into VGA INTERFACE
   wire [11:0] IDLE_COLOR_OUT;
   wire [11:0] WIN_COLOR_OUT;
   
 
     
     wire trigger25;
     wire CLK_25;
    
     
     
     Generic_counter # (.COUNTER_WIDTH(1),
                       .COUNTER_MAX(1)
                        )
                           Fir_Reducer_Counter(
                           .CLK(CLK),
                           .RESET(1'b0),             //self adjust the reset (details showing in the generic counter)
                           .ENABLE(1'b1),      //input of the triger_Out from the horizontal, daisy chained together
                           .TRIG_OUT(trigger25)    // will connect the waiting counter
                           );
                           
     Generic_counter # (.COUNTER_WIDTH(1),
                      .COUNTER_MAX(1)
                       )
                          Sec_Reducer_Counter(
                          .CLK(CLK),
                          .RESET(1'b0),             //self adjust the reset (details showing in the generic counter)
                          .ENABLE(trigger25),      //input of the triger_Out from the horizontal, daisy chained 
                          .COUNT(CLK_25)            // for counting vertical pixel
                          );     
     
                                   
   VGA_Interface VGA(
           .CLK(CLK_25),
           .COLOUR_IN(COLOR_TRANSFER),
           .ADDRH(X),
           .ADDRV(Y),
           .COLOUR_OUT(COLOR_OUT),
           .HS(HS),
           .VS(VS),
           .triggerVert(trig)
           );
           
   WIN_State Win_Sign(
           .CLK(CLK),
           .ADDRH(X),   
           .ADDRV(Y),   
           .WIN_COLOR_OUT(WIN_COLOR_OUT)
           );
           
   IDLE_Start Start_Sign(
           .CLK(CLK),
           .ADDRH(X),   
           .ADDRV(Y),   
           .IDLE_COLOR_OUT(IDLE_COLOR_OUT)
           );
   //display differnt modes according to the state of Master State Machine.    
   always@(posedge CLK) begin 
       case(states)    
           2'b00    :begin  //IDLE
               COLOR_TRANSFER <= IDLE_COLOR_OUT;    
           end         
           2'b01  :begin//SNAKE
               COLOR_TRANSFER<=COLOR_IN;
           end
           2'b10    :begin  //WIN
               COLOR_TRANSFER <= WIN_COLOR_OUT;    
           end
           
           default:
               COLOR_TRANSFER <= 12'h000;   
       endcase
   end            
   
       
endmodule
