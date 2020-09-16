`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2019 15:41:35
// Design Name: 
// Module Name: Bit_8_LFSR
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

// reduce the resolution, maximum of horz dirction is 80
module Bit_7_LFSR(
                    input  RESET,    
                    input  CLK,
                    input  [6:0]  Horz_init_LFSR,     
                    input  get_Target,        
                    output [6:0]  Horz_LFSR_OUT  
                 );


  reg [6:0] random_7_bits;
  assign Horz_LFSR_OUT = random_7_bits;
  

  always@(posedge CLK) begin
      if(RESET)
          random_7_bits <= Horz_init_LFSR;
      else if(get_Target) begin
          random_7_bits[0] <= ((random_7_bits[6] ~^ random_7_bits[4]) ~^ random_7_bits[3]) ~^ random_7_bits[2];
          random_7_bits[1] <= random_7_bits[0];
          random_7_bits[2] <= random_7_bits[1];
          random_7_bits[3] <= random_7_bits[2];
          random_7_bits[4] <= random_7_bits[3];
          random_7_bits[5] <= random_7_bits[4];
          random_7_bits[6] <= random_7_bits[5];
          
      end
  end

endmodule
