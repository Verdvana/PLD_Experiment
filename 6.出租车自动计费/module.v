//--------------------------------------------
//计数器
module cnt10(
             input clk, rst_n,
             output reg [3:0] cnt,
             output reg out
); 
always@(posedge clk or negedge rst_n) 
begin  
  if(!rst_n)   
    cnt<=4'b000; 
  else if(cnt==4'd9)   
    begin cnt<=4'b000; out<=1'b1; end
  else   
    begin cnt<=cnt+1; out<=1'b0; end
end 
endmodule 


//--------------------------------------------
//解码-数码管

module segment(
input        [3:0] cnt, 
output  reg  [6:0] hex
);
assign  scan=4'b0001; 
always@(cnt) 
begin   
  case(cnt)   
    4'b0001:hex= 7'b1111001;	   // ---t---- 
	 4'b0010:hex= 7'b0100100; 	// |	  |
	 4'b0011:hex= 7'b0110000; 	// lt	 rt 
	 4'b0100:hex= 7'b0011001; 	// |	  |
	 4'b0101:hex= 7'b0010010; 	// ---m----
	 4'b0110:hex= 7'b0000010; 	// |	  |
	 4'b0111:hex= 7'b1111000; 	// lb	 rb
	 4'b1000:hex= 7'b0000000; 	// |	  |
	 4'b1001:hex= 7'b0011000; 	// ---b----
	 4'b1010:hex= 7'b1000000;
	 default:hex= 7'b1000000;  
  endcase 
 end 
endmodule 
