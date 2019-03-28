module Stopwatch(
              input clk_50m, 
              input pause, rst_n,
              
				  output	[6:0] hex0,hex1,hex2,hex3,hex4,hex5 
); 

wire	clk_100hz;
clock clock_inst(
	.clk_50m(clk_50m), 
	.pause(pause), 
	.rst_n(rst_n),
   .clk_100hz(clk_100hz) 
); 

wire			clk_10;
wire [3:0]	cnt_10;
cnt10 cnt10_inst(
	.pause(pause),
	.clk(clk_100hz), 
	.rst_n(rst_n),
	.cnt(cnt_10),
	.out(clk_10)
); 

wire			clk_60;
wire [3:0]	cnt_60;
cnt60 cnt60_inst(
	.pause(pause),
	.clk(clk_10), 
	.rst_n(rst_n),
	.cnt(cnt_60),
	.out(clk_60)
); 

wire			clk_600;
wire [3:0]	cnt_600;
cnt600 cnt600_inst(
	.pause(pause),
	.clk(clk_60), 
	.rst_n(rst_n),
	.cnt(cnt_600),
	.out(clk_600)
); 

wire			clk_3600;
wire [3:0]	cnt_3600;
cnt3600 cnt3600_inst(
	.pause(pause),
	.clk(clk_600), 
	.rst_n(rst_n),
	.cnt(cnt_3600),
	.out(clk_3600)
);

wire			clk_36000;
wire [3:0]	cnt_36000;
cnt36000 cnt36000_inst(
	.pause(pause),
	.clk(clk_3600), 
	.rst_n(rst_n),
	.cnt(cnt_36000),
	.out(clk_36000)
);

wire [3:0]	cnt_216000;
cnt21600 cnt21600_inst(
	.pause(pause),
	.clk(clk_36000), 
	.rst_n(rst_n),
	.cnt(cnt_216000),
	.out()
);


segment segment_inst0(
	.cnt(cnt_10), 
	.hex(hex0)
); 

segment segment_inst1(
	.cnt(cnt_60), 
	.hex(hex1)
);

segment segment_inst2(
	.cnt(cnt_600), 
	.hex(hex2)
);

segment segment_inst3(
	.cnt(cnt_3600), 
	.hex(hex3)
);

segment segment_inst4(
	.cnt(cnt_36000), 
	.hex(hex4)
);

segment segment_inst5(
	.cnt(cnt_216000), 
	.hex(hex5)
);


endmodule 

