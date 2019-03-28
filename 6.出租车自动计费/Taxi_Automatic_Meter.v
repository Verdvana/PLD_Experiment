module Taxi_Automatic_Meter(
			input				clk_50m,
			input				rst_n,
			
			input	 [0:0]	sw,
			
			output [6:0]	hex0,hex1,hex2,hex3
);


//--------------------------------------------
//分频器
reg  [24:0]  cnt;  
reg clk_10hz ;

always@(posedge clk_50m or negedge sw[0] ) 
begin  
	if(!sw[0])  
		cnt<=24'd0;  
	else if(cnt==2500000)
		begin   
			cnt<=24'd0;   
			clk_10hz<=~clk_10hz;  
		end  
	else   
		cnt<=cnt+1; 
end

wire			clk_0;
wire [3:0]	cnt_0;
cnt10 cnt10_inst0(
	.clk(clk_10hz), 
	.rst_n(rst_n),
	.cnt(cnt_0),
	.out(clk_0)
);

wire			clk_1;
wire [3:0]	cnt_1;
cnt10 cnt10_inst1(
	.clk(clk_0), 
	.rst_n(rst_n),
	.cnt(cnt_1),
	.out(clk_1)
);

wire			clk_2;
wire [3:0]	cnt_2;
cnt10 cnt10_inst2(
	.clk(clk_1), 
	.rst_n(rst_n),
	.cnt(cnt_2),
	.out(clk_2)
);


wire [3:0]	cnt_3;
cnt10 cnt10_inst3(
	.clk(clk_2), 
	.rst_n(rst_n),
	.cnt(cnt_3),
	.out()
);

segment segment_inst0(
	.cnt(cnt_0), 
	.hex(hex0)
);

segment segment_inst1(
	.cnt(cnt_1), 
	.hex(hex1)
);

segment segment_inst2(
	.cnt(cnt_2), 
	.hex(hex2)
);

segment segment_inst3(
	.cnt(cnt_3), 
	.hex(hex3)
);

endmodule
