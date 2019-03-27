module Water_Light(
		clk_50m,rst_n,led[7:0]
						);
						
input		clk_50m;
input		rst_n;

output	reg [7:0] led=8'b00000001;   //赋初值

//-------------------------------------------


//-----------------------------
//分频器：3s
reg			clk_3hz;
reg [26:0]	cnt;

always@(posedge clk_50m or negedge rst_n)
begin
	if (!rst_n)
		begin
			cnt<=27'b0;
		end
	else if(cnt==27'd75000000) //50000000*3/2=75000000 
		begin
			clk_3hz<=~clk_3hz;
			cnt<=27'b0;
		end
	else	
		cnt<=cnt+1'b1;
end


//-----------------------------
//移位输出
always@(posedge clk_3hz)
begin	
	led={led[6:0],led[7]};	
end

endmodule
