`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 西南科技大学
// Engineer: 姜蕴峰
// 
// Create Date: 2020/07/28 10:17:53
// Design Name: PSI_MASTAR
// Module Name: SPI_Master
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


module SPI_Master(

    output      sck,
    input       miso,
    output  reg mosi=1'b0,
    output      ss1,//低电平有效
	output		ss2,
	
    input		data,
    input       rst,
    input [1:0] spi_cmd,
    input       clk  //50MHZ
);


//时序寄存器,
reg  [7:0]SS_cnt=8'd0;
reg  [15:0]MISO_cnt=16'd0;
reg  [15:0]MOSI_cnt=16'd0;
reg  [7:0]  SCK_cnt=8'd0;

//数据传输时钟设置
parameter   SS_haf=8'd10;
parameter   MISO_haf=16'd20;
parameter   MOSI_haf=16'd20;
parameter   SCK_haf=8'd10;


reg [1:0]state=2'b11;

//可配置时钟初始相位
reg sck_flag=1'b0;
reg miso_flag=1'b0;
reg mosi_flag=1'b0;
reg ss_flag=1'b1;

//
wire    mosi_clk;
wire    miso_clk;
wire	ss;

assign  sck=sck_flag;
assign  ss1=state[0]?ss_flag:1'b1;
assign	ss2=state[1]?ss_flag:1'b1;
assign  mosi_clk=mosi_flag;
assign  miso_clk=miso_flag;
assign	ss=ss_flag;
always@(posedge clk)
begin
    if(!rst)
        state<=2'b0;
    else if(!spi_cmd[0])
        state<=2'b01;
    else if(!spi_cmd[1])
        state<=2'b10;
	else
		state<=state;
end

//NSS时序寄存器
always@(posedge clk)
begin
     if(!state)
     begin
        SS_cnt<=8'd0;
        ss_flag<=1'b1;
    end
    else if(SS_cnt!=SS_haf)
    begin
        SS_cnt<=SS_cnt+1'b1;
        ss_flag<=1'b1;
    end
    else
        ss_flag<=1'b0;
end

//SCK时序寄存器 
always@(posedge clk)
begin
    if(ss)
    begin
      SCK_cnt<=8'd0;
      sck_flag=1'b0;
    end
    else if(SCK_cnt!=SCK_haf)
        SCK_cnt<=SCK_cnt+1'b1;
    else
    begin
        SCK_cnt<=8'b1;
        sck_flag<=!sck_flag;
    end
end

//  miso时序寄存器
always@(posedge clk)
begin
    if(ss)
    begin
      MISO_cnt<=8'd0;
      miso_flag<=1'b0;
    end
    else if(MISO_cnt!=MISO_haf)
    begin
        MISO_cnt<=MISO_cnt+1'b1;
        miso_flag<=!miso_flag;
    end
    else
        MISO_cnt<=16'b1;
end

//MOSI时序寄存器
always@(posedge clk)
begin
    if(ss)
    begin
      MOSI_cnt<=8'd0;
      miso_flag<=1'b0;
    end
    else if(MOSI_cnt!=MOSI_haf)
        MOSI_cnt<=MOSI_cnt+1'b1;   
    else
    begin
        MOSI_cnt<=16'b1;
        mosi_flag<=!mosi_flag;
     end   
end

always@(mosi_clk)   
    mosi=data;

endmodule
