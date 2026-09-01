`timescale 1ns / 1ps
module traffic_light_tb();
reg clk;
reg enable;

wire lampuHijau;
wire lampuKuning;
wire lampuMerah;


traffic_light uut(
.clk(clk),
.enable(enable),
.lampuHijau(lampuHijau),
.lampuKuning(lampuKuning),
.lampuMerah(lampuMerah)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    enable= 0;
    
    #20
    
    enable = 1;
     #30000
     
     $finish;
end

endmodule
