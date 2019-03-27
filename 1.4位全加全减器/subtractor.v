module subtractor(
		input		[3:0]	a,b,
		input				ci,
		
		output	[3:0]	s,
		output	co
		
);

wire [3:0] out;
assign {co,out} = 16+a-b-ci;
assign s = ~out;


endmodule
