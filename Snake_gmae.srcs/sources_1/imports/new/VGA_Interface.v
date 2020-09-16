`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2019 15:13:14
// Design Name: 
// Module Name: VGA_Interface
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


module VGA_Interface(
    input CLK,                      //One of the incoming signal
    input [11:0] COLOUR_IN,         // colour incoming signal
//    input RESET,                    //add the input reset to let counters adjust by themselves
    output reg [9:0] ADDRH,         //the current state of horizontal pixel location
    output reg [8:0] ADDRV,         //the current state of vertical pixel location
    output reg [11:0] COLOUR_OUT,   //the comingout color signal
    output reg HS,                  //determine if the counter less than the width of the pulse
    output reg VS,                  //determine if the counter less than the width of the pulse
    output triggerVert              //aim to connect thw waiting counter
    );
 
 
 wire [9:0] horzOut; //  10-bit binary can count to 1023, maximum horizontal counting up to 800, in this range
 wire [9:0] vertOut; //  use 10-bit to ensure the counting output aaare in the range
 wire triggerHorz;   //  connecting between two counters
 
 
    //Time is Vertical Lines 
parameter VertTimeToPulseWidthEnd = 10'd2;
parameter VertTimeToBackPorchEnd = 10'd31;            //the display range starts
parameter VertTimeToDisplayTimeEnd = 10'd511;         //the display range end
parameter VertTimeToFrontPorchEnd = 10'd521;

    //Time is Front Horizontal Lines
parameter HorzTimeToPulseWidthEnd = 10'd96;
parameter HorzTimeToBackPorchEnd = 10'd144;           //the display range starts
parameter HorzTimeToDisplayTimeEnd = 10'd784;         //the display range end
parameter HorzTimeToFrontPorchEnd = 10'd800;



    //Instantiate the Horizontal counter named as  H_Counter 
  Generic_counter # (.COUNTER_WIDTH(10),
                     .COUNTER_MAX(799)
                     )
                        H_Counter(
                        .CLK(CLK),
                        .RESET(1'b0),               //self adjust the reset (details showing in the generic counter)
                        .ENABLE(1'b1),
                        .TRIG_OUT(triggerHorz),      //will become the enable of the vertical counter
                        .COUNT(horzOut)              // for counting Horizontal pixel
                        );
                        
     //Instantiate the Vertical counter named as  V_Counter 
  Generic_counter # (.COUNTER_WIDTH(10),
                     .COUNTER_MAX(520)
                      )
                         V_Counter(
                         .CLK(CLK),
                         .RESET(1'b0),             //self adjust the reset (details showing in the generic counter)
                         .ENABLE(triggerHorz),      //input of the triger_Out from the horizontal, daisy chained together
                         .TRIG_OUT(triggerVert),    // will connect the waiting counter
                         .COUNT(vertOut)            // for counting vertical pixel
                         );


// Dertermine the HS and VS
   always@(posedge CLK)begin
     if(vertOut < VertTimeToPulseWidthEnd)
           VS <= 0;                                //give the VS to 0 before PulseWidth
        else
           VS <=1;                                 //after PulseWidth will give the VS = 1
      end
      
   always@(posedge CLK)begin
     if(horzOut < HorzTimeToPulseWidthEnd)
        HS <= 0;                                  //give the HS to 0 before PulseWidth
     else
        HS <=1;                                   //after PulseWidth will give the HS = 1
   end
   
 
 //locate the current pixel in display range, ADDRV represent the current vertical pixel location
   always@(posedge CLK) begin
   if(vertOut > VertTimeToBackPorchEnd && vertOut < VertTimeToDisplayTimeEnd)
        ADDRV <= vertOut - VertTimeToBackPorchEnd;
   else
        ADDRV <= 0;
   end
 
 //locate the current pixel in display range, ADDRH represent the current horizontal pixel location 
   always@(posedge CLK) begin
   if(horzOut > HorzTimeToBackPorchEnd && horzOut < HorzTimeToDisplayTimeEnd)
   ADDRH <= horzOut - HorzTimeToBackPorchEnd;
   else
   ADDRH = 0;
   end
 
  // display colour in the range, out of range assign 12'h000
  always@(posedge CLK) begin
   if(vertOut > VertTimeToBackPorchEnd && vertOut < VertTimeToDisplayTimeEnd && horzOut > HorzTimeToBackPorchEnd && horzOut < HorzTimeToDisplayTimeEnd)
     COLOUR_OUT <= COLOUR_IN;
   else
     COLOUR_OUT <= 12'h000; // refer to the definition 12-bit, give color 000 for out of range
   end
  
endmodule
