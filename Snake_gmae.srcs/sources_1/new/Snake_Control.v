`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2019 11:47:25
// Design Name: 
// Module Name: Snake_Control
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


module Snake_Control(
   input   CLK,
   input   RESET,
   input [1:0] Direction, 
   input [1:0] states,
   input [6:0] Target_X, 
   input [5:0] Target_Y,
   input CONTROL,
   input [9:0] ADDRH,
   input [8:0] ADDRV,
   output reg [11:0] COLOUR_OUT,
   output reg get_Target
    );
    
            //SpeedSlow counter 
        wire [27:0] COUNTER;
        Generic_counter # (.COUNTER_WIDTH(28),
                        .COUNTER_MAX(10000000)
                        )
                        SpeedSlowDown(
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE(1'b1),
                        .COUNT(COUNTER)
                        );   
                        
                        
                        
     parameter SnakeLength = 10;                                                                                                                                                                                                                                                                                                                                                                         
     reg [6:0] SnakeState_X [0: SnakeLength-1];                                                                                                                                                        
     reg [5:0] SnakeState_Y [0: SnakeLength-1];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
     parameter WHITE = 12'hfff;                                                                                                                                                                      
     parameter RED  = 12'h00f;                                                                                                                                                                       
     parameter BLACK = 12'h000;                                                                                                                                                                      
     parameter BLUE = 12'hf00; 
     parameter YELLOW = 12'h0ff;                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                           
    parameter UP = 2'b00;                                                                                                                                                                            
    parameter RIGHT = 2'b01;                                                                                                                                                                         
    parameter DOWN = 2'b10;                                                                                                                                                                          
    parameter LEFT = 2'b11;                                                                                                                                                                          
                                                                                                                                                                                                      
    parameter TOP_BORDER = 0;                                                                                                                                                                         
    parameter DOWN_BORDER = 120;                                                                                                                                                                      
    parameter LEFT_BORDER = 0;                                                                                                                                                                        
    parameter RIGHT_BORDER = 160;                                                                                                                                                                     
                                                                                                                                                                                                      
    parameter IDLE_State = 2'b00;                                                                                                                                                                     
    parameter PLAY_State = 2'b01;                                                                                                                                                                     
    parameter WIN_State = 2'b10;                                                                                                                                                                      
                                 
    wire switch;
    reg [11:0] Orignial = 12'h0ff;                                                                                                                                                                                                 
   //changing the position of the snake registers, shift the snakeState X and Y                                                                                                                                                                                                   
   genvar PixNo;                                                                                                                                                                                      
   generate                                                                                                                                                                                           
        for(PixNo = 0; PixNo < SnakeLength -1; PixNo = PixNo +1)                                                                                                                                      
        begin: PixShift                                                                                                                                                                               
            always@(posedge CLK)                                                                                                                                                                      
            begin                                                                                                                                                                                     
                if(RESET)                                                                                                                                                                             
                begin                                                                                                                                                                                 
                    SnakeState_X[PixNo+1] <=80;                                                                                                                                                       
                    SnakeState_Y[PixNo+1] <= 10;                                                                                                                                                      
                end                                                                                                                                                                                   
                else if(COUNTER == 0)                                                                                                                                                                   
                begin                                                                                                                                                                                 
                    SnakeState_X[PixNo+1] <= SnakeState_X[PixNo];                                                                                                                                     
                    SnakeState_Y[PixNo+1] <= SnakeState_Y[PixNo];                                                                                                                                     
                end                                                                                                                                                                                   
            end                                                                                                                                                                                       
        end                                                                                                                                                                                           
   endgenerate                                                                                                                                                                                        
  //replace top snake state with new one based on the direction                                                                                                                                                                                                     
   always@(posedge CLK)                                                                                                                                                                               
        begin                                                                                                                                                                                         
             if(RESET)                                                                                                                                                                                
             begin     
                 // set the initial state of the snake                                                                                                                                                                               
                      SnakeState_X[0] <= 80;                                                                                                                                                          
                      SnakeState_Y[0] <= 10;                                                                                                                                                          
             end                                                                                                                                                                                      
                                                                                                                                                                                                      
             else if(COUNTER == 0 & states == PLAY_State)                                                                                                                                                                      
             begin                                                                                                                                                                                    
                case(Direction)                                                                                                                                                                       
                                                                                                                                                                                                      
                      UP:                                                                                                                                                                             
                      begin                                                                                                                                                                           
                          SnakeState_Y[0] <= SnakeState_Y[0] - 1;                                                                                                                                     
                                                                                                                                                                                                      
                          if( SnakeState_Y[0] == TOP_BORDER )                                                                                                                                         
                              SnakeState_Y[0] <= DOWN_BORDER;   
                                                                                                                                        
                      end                                                                                                                                                                             
                                                                                                                                                                                                      
                      RIGHT:                                                                                                                                                                          
                      begin                                                                                                                                                                           
                          SnakeState_X[0] <= SnakeState_X[0] + 1;                                                                                                                                     
                                                                                                                                                                                                      
                          if( SnakeState_X[0] == RIGHT_BORDER )                                                                                                                                       
                              SnakeState_X[0]<= LEFT_BORDER;                                                                                                                                          
                      end                                                                                                                                                                             
                                                                                                                                                                                                      
                      DOWN:                                                                                                                                                                           
                      begin                                                                                                                                                                           
                          SnakeState_Y[0]<= SnakeState_Y[0] + 1;                                                                                                                                      
                                                                                                                                                                                                      
                          if( SnakeState_Y[0] == DOWN_BORDER )                                                                                                                                        
                              SnakeState_Y[0]<= TOP_BORDER;                                                                                                                                           
                      end                                                                                                                                                                             
                                                                                                                                                                                                      
                      LEFT:                                                                                                                                                                           
                      begin                                                                                                                                                                           
                          SnakeState_X[0] <= SnakeState_X[0] - 1;                                                                                                                                     
                                                                                                                                                                                                      
                           if(SnakeState_X[0] == LEFT_BORDER )                                                                                                                                        
                              SnakeState_X[0] <= RIGHT_BORDER;                                                                                                                                        
                      end                                                                                                                                                                             
                                                                                                                                                                                                      
                endcase                                                                                                                                                                               
                                                                                                                                                                                        
             end                                                                                                                                                                                      
        end                                                                                                                                                                                           
                                                                                                                                                                                                      
       always@(posedge CLK) begin
               get_Target<= 0;
               
               if((SnakeState_X[0]==Target_X)&(SnakeState_Y[0]==Target_Y))
                  get_Target<= 1'b1;         
           end
          
          always@(posedge CLK) begin
           case(states)
           PLAY_State:    begin
           
              if((ADDRH>=Target_X*6)&(ADDRH<=Target_X*6+4)&(ADDRV>=Target_Y*6)&(ADDRV<=Target_Y*6+4))                                            
                  COLOUR_OUT <= RED;      
          
                                        
              else if((ADDRH>=SnakeState_X[0]*6) & (ADDRH<=SnakeState_X[0]*6+4)
              &(ADDRV>=SnakeState_Y[0]*6) & (ADDRV<=SnakeState_Y[0]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow
              else if((ADDRH>=SnakeState_X[1]*6) & (ADDRH<=SnakeState_X[1]*6+4)
              &(ADDRV>=SnakeState_Y[1]*6) & (ADDRV<=SnakeState_Y[1]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow 
              else if((ADDRH>=SnakeState_X[2]*6) & (ADDRH<=SnakeState_X[2]*6+4)
              &(ADDRV>=SnakeState_Y[2]*6) & (ADDRV<=SnakeState_Y[2]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow        
              else if((ADDRH>=SnakeState_X[3]*6) & (ADDRH<=SnakeState_X[3]*6+4)
              &(ADDRV>=SnakeState_Y[3]*6) & (ADDRV<=SnakeState_Y[3]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow               
              else if((ADDRH>=SnakeState_X[4]*6) & (ADDRH<=SnakeState_X[4]*6+4)
              &(ADDRV>=SnakeState_Y[4]*6) & (ADDRV<=SnakeState_Y[4]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow               
              else if((ADDRH>=SnakeState_X[5]*6) & (ADDRH<=SnakeState_X[5]*6+4)
              &(ADDRV>=SnakeState_Y[5]*6) & (ADDRV<=SnakeState_Y[5]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow              
              else if((ADDRH>=SnakeState_X[6]*6) & (ADDRH<=SnakeState_X[6]*6+4)
              &(ADDRV>=SnakeState_Y[6]*6) & (ADDRV<=SnakeState_Y[6]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow               
              else if((ADDRH>=SnakeState_X[7]*6) & (ADDRH<=SnakeState_X[7]*6+4)
              &(ADDRV>=SnakeState_Y[7]*6) & (ADDRV<=SnakeState_Y[7]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow    
              else if((ADDRH>=SnakeState_X[8]*6) & (ADDRH<=SnakeState_X[8]*6+4)
              &(ADDRV>=SnakeState_Y[8]*6) & (ADDRV<=SnakeState_Y[8]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow 
              else if((ADDRH>=SnakeState_X[9]*6) & (ADDRH<=SnakeState_X[9]*6+4)
              &(ADDRV>=SnakeState_Y[9]*6) & (ADDRV<=SnakeState_Y[9]*6+4))
                  COLOUR_OUT <=Orignial;    //colour yellow     
                                                                                                                                                                                              
              else
                   COLOUR_OUT <=BLUE;    
           end  
          
                         
          endcase
          end                                                                                                                                                                                  
         // creating a waiting counter to be able to COUNT to 1 second and then change the colour automatically 
              Generic_counter # (.COUNTER_WIDTH(6), // extra feature to create a waiting counter for the L automatically change the colour
                                 .COUNTER_MAX(60)
                                 )
                                     Waiting(
                                     .CLK(CLK),
                                     .RESET(1'b0),
                                     .ENABLE(CONTROL),
                                     .TRIG_OUT(switch)
                                     );
               
               // to chack if the waiting counter counts to max 
               always@(posedge CLK)begin                  // chagne the colour of L once the waiting counter counts to 60, about 1 seconds
                  if(switch)
                      Orignial <= Orignial+12'b1;         // once the waiting counters triggered, the colour of L changed by adding 1
                  end                                                                                                                                                                                             
                                                                                                                                                                           
endmodule
