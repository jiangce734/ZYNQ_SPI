`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 10:37:56
// Design Name: 
// Module Name: top
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


module top(
	 
    input       rst,
    input       clk,  //
	output reg [3:0] recive_datas
	
);
wire	[3:0] data_led;
reg	[4:0]addr=5'd0;
reg div_clk_r=1'b0;
wire div_clk_w;

parameter divs=17'd62500;
reg	[16:0] div=17'd0;
wire	data;
reg  enb=1'b0;
wire sck;
wire mosi;
wire miso;
wire [3:0]misos;
wire ss01;
wire ss02;
wire	[4:0]addrs;
assign  addrs=addr;
assign	div_clk_w=div_clk_r;
assign	ss01=enb;
assign	spi_cmd={ss02,0};
SPI_Master	master(

    .sck(sck),
    .miso(miso),
    .mosi(mosi),
    .ss1(ss1),
    .ss2(ss2),
	.data(data),
	.rst(rst),
	.spi_cmd(spi_cmd),
    .clk(div_clk_r)  //50MHZ
);

 slave_spi	slave11(
	.sck(sck),
    .miso(misos[0]),
    .mosi(mosi),
    .ss(ss1),//低电平有效
	.recive_data(data_led[3])
);

slave_spi	slave12(
	.sck(sck),
    .miso(misos[1]),
    .mosi(misos[0]),
    .ss(ss1),//低电平有效
	.recive_data(data_led[2])
);
slave_spi	slave13(
	.sck(sck),
    .miso(misos[2]),
    .mosi(misos[1]),
    .ss(ss1),//低电平有效
	.recive_data(data_led[1])
);
slave_spi	slave14(
	.sck(sck),
    .miso(),
    .mosi(misos[2]),
    .ss(ss1),//低电平有效
	.recive_data(data_led[0])
);



slave_spi	slave2(
	.sck(sck),
    .miso(miso),
    .mosi(mosi),
    .ss(ss2),//低电平有效
	.recive_data()
);

blk_mem_gen_0 rom (
  .clka(sck),    // input wire clka
  .ena(!enb),      // input wire ena
  .addra(addr),  // input wire [4 : 0] addra
  .douta(data)  // output wire [0 : 0] douta
);

always@(posedge clk)
begin
if(!rst)
	div<=17'd0;
else if(div==divs)
begin
	div_clk_r<=!div_clk_r;
	div<=17'd0;
end
else	
	div<=div+1'b1;
end

always@(posedge sck)
if(addr<=4'd22)
	addr<=addr+1'b1;
else
	addr<=1'b0;

always@(posedge sck)
if(addr/4==5'd0)
	recive_datas<=data_led;
else
	recive_datas<=recive_datas;
	
endmodule
