`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 18:57:19
// Design Name: 
// Module Name: master_slave_time_test
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


module master_slave_time_test();
reg	rst=1'b1;
reg	[1:0]spi_cmd=2'b11;
reg	clk=1'b1;
reg	out_data=1'b0;
wire	[1:0]recive_data;

top	test1(
	.rst(rst),
    .spi_cmd(spi_cmd),
	.out_data(out_data),
    .clk(clk),  //

	.recive_data(recive_data)
	
);

always#2 clk=!clk;

initial
begin
	
   #2 spi_cmd=2'b01;out_data=2'b1;
   #43 out_data=1'b0;
   #83  out_data=1'b1;
   #123	out_data=1'b0;
   #163  out_data=1'b1;
   #203  out_data=1'b1;
   #223	spi_cmd=2'b10;out_data=1'b0;
   #243	out_data=1'b1;

end

endmodule
