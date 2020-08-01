`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 12:29:02
// Design Name: 
// Module Name: master_test
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


module master_test();
wire        sck;
reg         miso=1'b0;
wire        mosi;
wire        ss;//低电平有效
    
reg         rst=1'b1;
reg         spi_cmd=1'b1;
reg         out_data=1'b0;
reg         clk=1'b0;

SPI_Master master(

    .sck(sck),
    .miso(miso),
    .mosi(mosi),
    .ss(ss),//低电平有效
    
    .rst(rst),
    .spi_cmd(spi_cmd),
    .out_data(out_data),
    .clk(clk)  //50MHZ
);

always # 2 clk=!clk;

initial
begin
   #2 spi_cmd=1'b0;out_data=1'b1;
   #43 out_data=1'b0;
   #83  out_data=1'b1;
   #163  out_data=1'b0;
end

endmodule
