`timescale 1ns / 1ps
module traffic_controller(clk, reset,sensor,hwy,country) ;
output reg [1:0] hwy;
output reg [1:0] country;
input clk;
input reset;
input sensor;

`define Y2RDELAY 3// yellow to red delay
`define R2GDELAY 2// yellow to red delay

reg [2:0] state;
reg [2:0] next_state;
    
parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100;
parameter GREEN=2'b00,YELLOW=2'b01,RED=2'b10; 


always @(posedge clk or negedge reset)
    begin
    if(~reset)
    state<=S0;
    else
    state<=next_state;
    end
    
always@(state or sensor)
    begin
    case(state)
  
    S0:begin
       hwy=GREEN;
       country=RED;
       if (sensor) 
           next_state = S1;
       else 
           next_state = S0;
       end 
    
    S1:begin
       repeat(`Y2RDELAY)
       hwy=YELLOW;
       country=RED;
       next_state=S2;
       end 
    
    S2:begin
       repeat(`R2GDELAY)
       hwy=RED;
       country=RED;
       next_state=S3;
       end 
    
    S3:begin
       hwy=RED;
       country=GREEN;
       if (sensor) 
           next_state = S3;
       else 
           next_state = S4;
       end 
    
    S4:begin
       repeat(`Y2RDELAY)
       hwy=RED;
       country=YELLOW;
       next_state=S0;
       end 
    
    default:next_state=S0;
    
    endcase 
    
    end
    
    endmodule
