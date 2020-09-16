`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2019 15:48:30
// Design Name: 
// Module Name: Bit_7_LFSR
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


module Bit_6_LFSR(
                  input  RESET,    
                  input   CLK,     
                  input  [5:0]  Vert_init_LFSR,     
                  input   get_Target,        
                  output  [5:0] Vert_LFSR_OUT  
                 );


   reg  [5:0]  random_6_bits;
   assign Vert_LFSR_OUT = random_6_bits;


   always@(posedge CLK) begin
       if(RESET)
           random_6_bits <= Vert_init_LFSR;
       else if(get_Target) begin
           random_6_bits[0] <= random_6_bits[5] ~^ random_6_bits[4];
           random_6_bits[1] <= random_6_bits[0];
           random_6_bits[2] <= random_6_bits[1];
           random_6_bits[3] <= random_6_bits[2];
           random_6_bits[4] <= random_6_bits[3];
           random_6_bits[5] <= random_6_bits[4];
           
       end
   end

endmodule
