module Adder_Subtractor(
		input				setup,
		
		input		[3:0]	a,b,
		input				ci,
		
		output	[3:0]	s,
		output	co
); 


wire	[3:0] adder_s;
wire	      adder_co;


wire	[3:0] subtractor_s;
wire	      subtractor_co;


assign s  =setup?adder_s :subtractor_s;
assign co =setup?adder_co:subtractor_co;


adder addr_inst(
	.a(a),
	.b(b),
	.ci(ci),
	
	.s(adder_s),
	.co(adder_co)
);

subtractor subtractor_inst(
	.a(a),
	.b(b),
	.ci(ci),
	
	.s(subtractor_s),
	.co(subtractor_co)
);

endmodule
