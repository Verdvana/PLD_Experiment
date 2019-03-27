module Traffic_Light(
			input					clk_50m,
			input					rst_n,
			output reg [2:0]	led   //红，黄，绿

);


//------------------------------------------------
//分频指示
reg  [25:0]  cnt;  
reg			clk_1hz;

always@(posedge clk_50m or negedge rst_n ) 
begin  
	if(!rst_n)  
		cnt<=26'd0;  
	else if(cnt==25000000)
		begin   
			cnt<=26'd0;   
			clk_1hz<=~clk_1hz;   
		end  
	else   
		cnt<=cnt+1; 
end 


//--------------------------------------------
//

reg [3:0]	cnt_1;
reg [1:0] 	state;

always@(posedge clk_1hz or negedge rst_n ) 
begin  
  if(!rst_n)  
    cnt_1<=4'd0;  
  else if(cnt_1==5)
    begin   
	   cnt_1<=cnt_1+1;   
		state<=2'b01;  
		end  
		
  else if(cnt_1==7)  
    begin   
	   cnt_1<=cnt_1+1;   
		state<=2'b10;  
		end 
	
  else if(cnt_1==13)  
    begin   
	   cnt_1<=4'b0;   
		state<=2'b00;  
		end 
		
	else
    begin   
	   cnt_1<=cnt_1+1;    
		end 
end


always@(*)
begin
	case(state)
		2'b00:	led<=3'b100;
		2'b01:	led<=3'b010;
		2'b10:	led<=3'b001;
		default: led<=3'b000;
	endcase
end


endmodule
