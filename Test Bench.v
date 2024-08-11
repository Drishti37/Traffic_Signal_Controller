`timescale 1ns / 1ps

module traffic_controller_tb;
reg clk;
reg reset;
reg sensor;

wire [1:0] hwy;
wire[1:0] country;

traffic_controller uut(clk,reset,sensor,hwy,country);

initial
begin
clk=0;
forever #10 clk=~clk;
end 

initial 
begin
sensor=0;
reset=0;

$monitor("Time: %0dns, State: %b, Hwy: %b, Country: %b, Sensor: %b", $time, uut.state, hwy, country, sensor);

#10 reset=1;

end 

initial
begin

#200 sensor=1;

#100 sensor=0;

#200 sensor=1;

#100 sensor=0;

#100 $stop;

end
endmodule
