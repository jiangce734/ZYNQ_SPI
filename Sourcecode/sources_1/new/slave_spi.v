`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 19:09:09
// Design Name: 
// Module Name: slave_spi
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


module slave_spi(
	input      		sck,
    output      reg	miso=1'b0,
    input  			mosi,
    input      		ss,//低电平有效
	
	output		reg	recive_data=1'b0
);

always@(posedge sck)
if(ss)
begin
	miso<=1'b0;
	recive_data<=1'b0;
end
else
begin
	miso<=mosi;
	recive_data<=mosi;
end
endmodule
