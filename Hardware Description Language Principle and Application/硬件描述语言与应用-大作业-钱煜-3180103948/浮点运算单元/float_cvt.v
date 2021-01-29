module floatcvt(clk, rst, enable, x, y, z,overflow);

   input clk;
	input rst;
	input [1:0] enable;//01:sw, 10:ws [enable_ws,enable_sw]
	input [31:0] x;
	input [31:0] y;
        //input add;//add=1:add case  add=0:sub case
	output [31:0] z;
	output [1:0] overflow;//00:no overflow 01:upflow 10:downflow 11:the input does not meet format

	reg [31:0] z; // z=x+y 
	reg[24:0] xm,  zm; //fraction part, 0+ 1+[22:0]，
	reg[7:0] xe, ye, ze;  //exponent part
	reg[2:0]	state, nextstate;       //FSM
	reg zsign; //sign part
	reg [1:0] overflow;
	reg [31:0] cmp_x;
	reg [31:0] cmp_y;
	reg [4:0] L1;//x's msb
	reg [30:0] ym;

	parameter start=3'b000,sw=3'b001,ws=3'b010,add_fra=3'b011,normalize=3'b100,over =3'b110;

	always @(posedge clk) begin
	    if(!rst)
		   //state = start;
		   begin nextstate = start;
		   xm=0;ym=0;zm=0;xe=0;ye=0;ze=0;overflow=0;z=0; end
	    else if (!enable)
		  begin state=state; nextstate=nextstate; end
			
	    else
		   state = nextstate;
begin
		case(state)

		start: //initialize

		  begin
			//if (enable == 2'b10) y[31]=~y[31];
			//else y[31]=y[31];
			 cmp_x=x;
			 cmp_y=y;
		    	 //xe = x[30:23];
          		 //xm = {1'b0,1'b1,x[22:0]};
          		 ye = y[30:23];
			 ym = {7'b0,1'b1,y[22:0]};

			 //test denormalized cases: 1.one input's exponent is overflow; 2.one input is (!=0)^0
			 //if((ye==8'd255)||((ye==8'd0)&&(ym[22:0]!=23'b0)) )
			 //begin
			//    overflow = 2'b11;
			//	 nextstate = over; //
			//	 z = 32'b1; //error case
			 //end
			// else
			    if (enable == 2'b01)
			    nextstate = sw;
			else nextstate = ws;
		  end

		sw:
		begin
			if (x[30]) begin L1=31; z[22:0]=x[29:7]; z[30:23]=L1-1+127; end
                	else if (x[29]) begin L1=30; z[22:0]=x[28:6]; z[30:23]=L1-1+127; end
                        else if (x[28]) begin L1=29; z[22:0]=x[27:5]; z[30:23]=L1-1+127; end
                        else if (x[27]) begin L1=28; z[22:0]=x[26:4]; z[30:23]=L1-1+127; end
                        else if (x[26]) begin L1=27; z[22:0]=x[25:3]; z[30:23]=L1-1+127; end
                        else if (x[25]) begin L1=26; z[22:0]=x[24:2]; z[30:23]=L1-1+127; end
                        else if (x[24]) begin L1=25; z[22:0]=x[23:1]; z[30:23]=L1-1+127; end
                        else if (x[23]) begin L1=24; z[22:0]=x[22:0]; z[30:23]=L1-1+127; end
			else if (x[22]) begin L1=23; z[22:0]={x[21:0],1'b0}; z[30:23]=L1-1+127; end
                        else if (x[21]) begin L1=22; z[22:0]={x[20:0],2'b0}; z[30:23]=L1-1+127; end
                        else if (x[20]) begin L1=21; z[22:0]={x[19:0],3'b0}; z[30:23]=L1-1+127; end
                        else if (x[19]) begin L1=20; z[22:0]={x[18:0],4'b0}; z[30:23]=L1-1+127; end
                        else if (x[18]) begin L1=19; z[22:0]={x[17:0],5'b0}; z[30:23]=L1-1+127; end
                        else if (x[17]) begin L1=18; z[22:0]={x[16:0],6'b0}; z[30:23]=L1-1+127; end
                        else if (x[16]) begin L1=17; z[22:0]={x[15:0],7'b0}; z[30:23]=L1-1+127; end
                        else if (x[15]) begin L1=16; z[22:0]={x[14:0],8'b0}; z[30:23]=L1-1+127; end
                        else if (x[14]) begin L1=15; z[22:0]={x[13:0],9'b0}; z[30:23]=L1-1+127; end
                        else if (x[13]) begin L1=14; z[22:0]={x[12:0],10'b0}; z[30:23]=L1-1+127; end
                        else if (x[12]) begin L1=13; z[22:0]={x[11:0],11'b0}; z[30:23]=L1-1+127; end
                        else if (x[11]) begin L1=12; z[22:0]={x[10:0],12'b0}; z[30:23]=L1-1+127; end
                        else if (x[10]) begin L1=11; z[22:0]={x[9:0],13'b0}; z[30:23]=L1-1+127; end
                        else if (x[9]) begin L1=10; z[22:0]={x[8:0],14'b0}; z[30:23]=L1-1+127; end
                        else if (x[8]) begin L1=9; z[22:0]={x[7:0],15'b0}; z[30:23]=L1-1+127; end
                        else if (x[7]) begin L1=8; z[22:0]={x[6:0],16'b0}; z[30:23]=L1-1+127; end
                        else if (x[6]) begin L1=7; z[22:0]={x[5:0],17'b0}; z[30:23]=L1-1+127; end
                        else if (x[5]) begin L1=6; z[22:0]={x[4:0],18'b0}; z[30:23]=L1-1+127; end
                        else if (x[4]) begin L1=5; z[22:0]={x[3:0],19'b0}; z[30:23]=L1-1+127; end
                        else if (x[3]) begin L1=4; z[22:0]={x[2:0],20'b0}; z[30:23]=L1-1+127; end
                        else if (x[2]) begin L1=3; z[22:0]={x[1:0],21'b0}; z[30:23]=L1-1+127; end
                        else if (x[1]) begin L1=2; z[22:0]={x[0],22'b0}; z[30:23]=L1-1+127; end
                        else if (x[0]) begin L1=1; z[22:0]=23'b0; z[30:23]=L1-1+127; end
			else z[30:23] = 32'b0;
			
			z[31] = x[31];
			nextstate = over;



		end  //end of sw

		ws:
		begin
			 if((ye==8'd255)||((ye==8'd0)&&(ym[22:0]!=23'b0)) )
			 begin
		  		   overflow = 2'b11;
				 nextstate = over; //
				 z = 32'b1; //error case
			 end
		else begin
			
			if (ye > 181) begin overflow = 2'b01; z[30:0] = 31'b1; end
			else if (ye < 127) begin overflow = 2'b10; z[30:0] = 31'b0; end
			else begin

                                if (ye == 127) ym = {23'b0,ym[30:23]};
                                else if (ye == 128) ym = {22'b0,ym[30:22]};
                                else if (ye == 129) ym = {21'b0,ym[30:21]};
                                else if (ye == 130) ym = {20'b0,ym[30:20]};
                                else if (ye == 131) ym = {19'b0,ym[30:19]};
                                else if (ye == 132) ym = {18'b0,ym[30:18]};
                                else if (ye == 133) ym = {17'b0,ym[30:17]};
                                else if (ye == 134) ym = {16'b0,ym[30:16]};
                                else if (ye == 135) ym = {15'b0,ym[30:15]};
                                else if (ye == 136) ym = {14'b0,ym[30:14]};
                                else if (ye == 137) ym = {13'b0,ym[30:13]};
                                else if (ye == 138) ym = {12'b0,ym[30:12]};
                                else if (ye == 139) ym = {11'b0,ym[30:11]};
                                else if (ye == 140) ym = {10'b0,ym[30:10]};
                                else if (ye == 141) ym = {9'b0,ym[30:9]};
                                else if (ye == 142) ym = {8'b0,ym[30:8]};
                                else if (ye == 143) ym = {7'b0,ym[30:7]};
                                else if (ye == 144) ym = {6'b0,ym[30:6]};
                                else if (ye == 145) ym = {5'b0,ym[30:5]};
                                else if (ye == 146) ym = {4'b0,ym[30:4]};
                                else if (ye == 147) ym = {3'b0,ym[30:3]};
                                else if (ye == 148) ym = {2'b0,ym[30:2]};
                                else if (ye == 149) ym = {1'b0,ym[30:1]};
                                else if (ye == 150) ym = ym;
                                else if (ye == 151) ym = {ym[29:0],1'b0};
                                else if (ye == 152) ym = {ym[28:0],2'b0};
                                else if (ye == 153) ym = {ym[27:0],3'b0};
                                else if (ye == 154) ym = {ym[26:0],4'b0};
                                else if (ye == 155) ym = {ym[25:0],5'b0};
                                else if (ye == 156) ym = {ym[24:0],6'b0};
                                else if (ye == 157) ym = {ym[23:0],7'b0};
                                else if (ye == 158) ym = {ym[22:0],8'b0};
                                else if (ye == 159) ym = {ym[21:0],9'b0};
                                else if (ye == 160) ym = {ym[20:0],10'b0};
                                else if (ye == 161) ym = {ym[19:0],11'b0};
                                else if (ye == 162) ym = {ym[18:0],12'b0};
                                else if (ye == 163) ym = {ym[17:0],13'b0};
                                else if (ye == 164) ym = {ym[16:0],14'b0};
                                else if (ye == 165) ym = {ym[15:0],15'b0};
                                else if (ye == 166) ym = {ym[14:0],16'b0};
                                else if (ye == 167) ym = {ym[13:0],17'b0};
                                else if (ye == 168) ym = {ym[12:0],18'b0};
                                else if (ye == 169) ym = {ym[11:0],19'b0};
                                else if (ye == 170) ym = {ym[10:0],20'b0};
                                else if (ye == 171) ym = {ym[9:0],21'b0};
                                else if (ye == 172) ym = {ym[8:0],22'b0};
                                else if (ye == 173) ym = {ym[7:0],23'b0};
                                else if (ye == 174) ym = {ym[6:0],24'b0};
                                else if (ye == 175) ym = {ym[5:0],25'b0};
                                else if (ye == 176) ym = {ym[4:0],26'b0};
                                else if (ye == 177) ym = {ym[3:0],27'b0};
                                else if (ye == 178) ym = {ym[2:0],28'b0};
                                else if (ye == 179) ym = {ym[1:0],29'b0};
                                else if (ye == 180) ym = {ym[0],30'b0};	
				else ym=0;			

				end

			z[31] = y[31];
			z[30:0] = ym;
			nextstate = over;
		end
		end  //end of ws

		over:
		begin

			if (enable == 2'b01) begin 
			 	if(z[30:23]==8'd255 )
			 	begin
			   	 overflow = 2'b01;
			 	end
			 	else if((z[30:23]==8'd0)&&(z[22:0]!=23'b0)) //不处理非规约数
			 	begin
			    	overflow = 2'b10;
			 	end
				 else
			   	 overflow = 2'b00;
					end	

			else begin z=z; end										

		    if ((cmp_x!=x || cmp_y!=y) && enable) begin nextstate = start; end
		    else begin nextstate = over; end

						

		end

endcase
end

end//end of always

endmodule
