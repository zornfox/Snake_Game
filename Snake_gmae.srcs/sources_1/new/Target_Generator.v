`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2019 15:54:46
// Design Name: 
// Module Name: Target_Generator
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


module Target_Generator(
  input CLK,
  input RESET,
  input get_Target,
  output [12:0] Random_Target_Address //output to snake control
  );
  
  reg [6:0] X;
  reg [5:0] Y;

  wire [6:0] Horz_LFSR_OUT;
  wire [5:0] Vert_LFSR_OUT;

  
  Bit_7_LFSR Horz(  
         .RESET(RESET),    
         .CLK(CLK), 
         .Horz_init_LFSR(7'b0101011),    
         .get_Target(get_Target),        
         .Horz_LFSR_OUT(Horz_LFSR_OUT)       //get a 8-bit random number
  );
  
  Bit_6_LFSR Vert(
         .RESET(RESET),    
         .CLK(CLK),     
         .Vert_init_LFSR(6'b011010),    
         .get_Target(get_Target),        
         .Vert_LFSR_OUT(Vert_LFSR_OUT)      //get a 7-bit random number
  );
  
 
  
  // check the range 
  always@(posedge CLK) begin
      if(Horz_LFSR_OUT >= 76)
          X <= 41;
      else if(Horz_LFSR_OUT<=0)
          X <= 46;
      else
          X <= Horz_LFSR_OUT;   
  end

  always@(posedge CLK) begin
      if(Vert_LFSR_OUT >= 56)
          Y <= 32;
      else if(Vert_LFSR_OUT<=0)
          Y <= 40;
      else
          Y <= Vert_LFSR_OUT;   
  end
  
  
  assign Random_Target_Address = {Y, X};
 
endmodule
