module Sequence_Detector(
			input			clk_50m,
			input			rst_n,
			
			input			data_in,
			
			output		indication,		//led熄灭时更改输入状态，led点亮时读取
			
			output reg	x
);

//------------------------------------------------
//分频指示
reg  [25:0]  cnt;  
reg			clk_2hz;

always@(posedge clk_50m or negedge rst_n ) 
begin  
	if(!rst_n)  
		cnt<=26'd0;  
  else if(cnt==50000000)
    begin   
	   cnt<=26'd0;   
			clk_2hz<=~clk_2hz;   
		end  
  else   
    cnt<=cnt+1; 
end 



assign indication = clk_2hz;


//------------------------------------------------
//移位寄存
reg [3:0] detector;

always@(posedge clk_2hz or negedge rst_n)
begin
	if(!rst_n)
		detector<=4'b0;
	
	else
		begin
			detector <= {detector[2:0],data_in};
		end
end

//------------------------------------------------
//判断输出
always@(*)
begin
	case(detector)
		4'b1111: x<=1;
		default: x<=0; 
	endcase
end


endmodule
