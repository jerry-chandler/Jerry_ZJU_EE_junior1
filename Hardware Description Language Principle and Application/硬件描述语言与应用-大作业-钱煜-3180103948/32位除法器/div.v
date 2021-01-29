module DIVUN_32(clk,reset,enable,dividend,divisor0,quotient,remainder);
input clk; 
input reset; 
input enable; 
input [31:0] dividend;
input [31:0] divisor0;
output reg [31:0] quotient;
output reg [31:0] remainder;

reg [1:0] state,next_state;//state:0:wait 1:get MSB and f 2:initialize  3:calculate
reg [4:0] iteration,f,L1,L2;
reg [31:0] divisor;
reg [31:0] cmp_dividend,cmp_divisor; 
reg r1,r2,r3,r4;
reg [31:0] r5;

always @(posedge clk)
	begin
	
	
	if (!reset) 
			begin
			quotient=0;
			remainder=0;
			next_state=1;		
		    end
	else 
	
	begin
	
	if (enable)
	begin
		state=next_state;
		case (state)
		
		2'b00:begin  
	
				if (cmp_dividend!==dividend || divisor0!==cmp_divisor) next_state=1;
				else next_state=0;
		      end
		
		2'b01:
		  begin
			if (dividend[31]) L1=32;
                else if (dividend[30]) L1=31;
                else if (dividend[29]) L1=30;
                else if (dividend[28]) L1=29;
                else if (dividend[27]) L1=28;
                else if (dividend[26]) L1=27;
                else if (dividend[25]) L1=26;
                else if (dividend[24]) L1=25;
                else if (dividend[23]) L1=24;
                else if (dividend[22]) L1=23;
                else if (dividend[21]) L1=22;
                else if (dividend[20]) L1=21;
                else if (dividend[19]) L1=20;
                else if (dividend[18]) L1=19;
                else if (dividend[17]) L1=18;
                else if (dividend[16]) L1=17;
                else if (dividend[15]) L1=16;
                else if (dividend[14]) L1=15;
                else if (dividend[13]) L1=14;
                else if (dividend[12]) L1=13;
                else if (dividend[11]) L1=12;
                else if (dividend[10]) L1=11;
                else if (dividend[9]) L1=10;
                else if (dividend[8]) L1=9;
                else if (dividend[7]) L1=8;
                else if (dividend[6]) L1=7;
                else if (dividend[5]) L1=6;
                else if (dividend[4]) L1=5;
                else if (dividend[3]) L1=4;
                else if (dividend[2]) L1=3;
                else if (dividend[1]) L1=2;
		else if (dividend[0]) L1=1;
                else L1=0;
				
			if (divisor0[31]) L2=32;
                else if (divisor0[30]) L2=31;
                else if (divisor0[29]) L2=30;
                else if (divisor0[28]) L2=29;
                else if (divisor0[27]) L2=28;
                else if (divisor0[26]) L2=27;
                else if (divisor0[25]) L2=26;
                else if (divisor0[24]) L2=25;
                else if (divisor0[23]) L2=24;
                else if (divisor0[22]) L2=23;
                else if (divisor0[21]) L2=22;
                else if (divisor0[20]) L2=21;
                else if (divisor0[19]) L2=20;
                else if (divisor0[18]) L2=19;
                else if (divisor0[17]) L2=18;
                else if (divisor0[16]) L2=17;
                else if (divisor0[15]) L2=16;
                else if (divisor0[14]) L2=15;
                else if (divisor0[13]) L2=14;
                else if (divisor0[12]) L2=13;
                else if (divisor0[11]) L2=12;
                else if (divisor0[10]) L2=11;
                else if (divisor0[9]) L2=10;
                else if (divisor0[8]) L2=9;
                else if (divisor0[7]) L2=8;
                else if (divisor0[6]) L2=7;
                else if (divisor0[5]) L2=6;
                else if (divisor0[4]) L2=5;
                else if (divisor0[3]) L2=4;
                else if (divisor0[2]) L2=3;
                else if (divisor0[1]) L2=2;
		else if (divisor0[0]) L2=1;
                else L2=0;

                	if (!L2) begin
				next_state=0;
				remainder=32'b1111111111111111;
				quotient=32'b1111111111111111;
				cmp_dividend=dividend;				
				cmp_divisor=divisor0;
				end
				
			else
				begin		
				f=L1-L2;
				next_state=2;
				end
		  end
		  
		2'b10:
		  begin
			remainder=dividend;
			cmp_dividend=dividend;
			cmp_divisor=divisor0;
			divisor=divisor0;
			divisor=divisor<<f;
			quotient=0;
			iteration=f+1;
		    next_state=3;
		  end
		
		2'b11:
		  begin
			if (!iteration)
				begin
					
					next_state=0;
				
				end
				
			else
				begin
				
				    if (remainder>=divisor) 
						begin
						quotient=(quotient<<1)+1;
						remainder=remainder-divisor;
						divisor=divisor>>1;
						end
					else
						begin
						quotient=(quotient<<1)+0;
						remainder=remainder;
						divisor=divisor>>1;
						end
					
					iteration=iteration-1;
					next_state=3;
				end
		  
		  end


		endcase

	
	end
	else next_state=next_state;
	end
	end
	
endmodule
	
	

