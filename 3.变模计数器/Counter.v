module Counter(
		input					clk_50m,
		input					rst_n,
		
		input [1:0] 		setup,
		
		output reg [6:0]	hex0
		
		
);

//-----------------------------------------------------
reg  [24:0]  cnt_0;  
reg	clk_1hz;

always@(posedge clk_50m or negedge rst_n ) 
begin  
  if(!rst_n)  
    cnt_0<=24'd0;  
  else if(cnt_0==25000000)
    begin   
	   cnt_0<=24'd0;   
		clk_1hz<=~clk_1hz;   //半秒反转一次 一秒一个上升沿
		end  
  else   
    cnt_0<=cnt_0+1; 
end 

//-----------------------------------------------------
reg [3:0]	cnt_1;

always@(*)
begin
	case(setup)
		2'b00:  cnt_1 <= 9;
		2'b01:  cnt_1 <= 11;
		2'b10:  cnt_1 <= 13;
		2'b11:  cnt_1 <= 15;
		default:cnt_1 <= 0;
		
	endcase
end




//-----------------------------------------------------
reg [3:0]	cnt_2;

always@(posedge clk_1hz or negedge rst_n )
begin  
  if(!rst_n)  
    cnt_2<=4'd0;  
	 
  else if(cnt_2==cnt_1-1)  
	 cnt_2<=4'd0;

  else   
    cnt_2<=cnt_2+1; 
end 


//-----------------------------------------------------
always@(*) 
begin   
  case(cnt_2) 
	 4'b0000:hex0= 7'b1000000;
    4'b0001:hex0= 7'b1111001;	   // ---t---- 
	 4'b0010:hex0= 7'b0100100; 	// |	  |
	 4'b0011:hex0= 7'b0110000; 	// lt	 rt 
	 4'b0100:hex0= 7'b0011001; 	// |	  |
	 4'b0101:hex0= 7'b0010010; 	// ---m----
	 4'b0110:hex0= 7'b0000010; 	// |	  |
	 4'b0111:hex0= 7'b1111000; 	// lb	 rb
	 4'b1000:hex0= 7'b0000000; 	// |	  |
	 4'b1001:hex0= 7'b0011000; 	// ---b----
	 4'b1010:hex0= 7'b0001000;
	 4'b1011:hex0= 7'b0000011;
	 4'b1100:hex0= 7'b1000110;
	 4'b1101:hex0= 7'b0100001;
	 4'b1110:hex0= 7'b0000110;
	 4'b1111:hex0= 7'b0001110;
	 default:hex0= 7'b1000000;  
  endcase 
end

endmodule
