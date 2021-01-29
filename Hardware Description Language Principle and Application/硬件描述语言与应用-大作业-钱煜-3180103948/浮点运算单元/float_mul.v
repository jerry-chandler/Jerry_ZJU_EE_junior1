module floatmul(clk, rst, enable, x, y, z,overflow);

   	input clk;
	input rst;
	input enable;
	input [31:0] x;
	input [31:0] y;

        //input add;//add=1:add case  add=0:sub case
	output [31:0] z;
	output [1:0] overflow;//00:no overflow 01:upflow 10:downflow 11:the input does not meet format

	reg [31:0] z; // z=x+y 
	reg[24:0] xm, ym, zm_final; //fraction part, 0+ 1+[22:0]，
	reg[49:0] zm, xm1, ym1;
	reg[6:0]  mulshift = 0;
	reg[7:0] xe, ye, ze,teste;  //exponent part
	reg[2:0]	state, nextstate;       //FSM
	reg zsign; //sign part
	reg [1:0] overflow;
	reg [31:0] cmp_x;
	reg [31:0] cmp_y;
	reg [7:0] shift_1, shift_2;
	reg [9:0] e_temp=0;

	parameter start=3'b000,one_zero=3'b001,ex_add=3'b010,mul=3'b011,normalize=3'b100,over =3'b110;

	always @(posedge clk) begin
	    if(!rst)
		   //state = start;
		   begin nextstate = start;
		   xm=0;ym=0;zm=0;xe=0;ye=0;ze=0;overflow=0; z=0;end
	    else if (!enable)
		  begin state=state; nextstate=nextstate; end
			
	    else
		   state = nextstate;

	//game start!
	//always@(state,nextstate,xe,ye,xm,ym,ze,zm) 
begin
		case(state)

		start: //initialize

		  begin
			 cmp_x=x;
			 cmp_y=y;
		    	 xe = x[30:23];
          		 xm = {1'b0,1'b1,x[22:0]};
          		 ye = y[30:23];
			 ym = {1'b0,1'b1,y[22:0]};
			 //if (x[31]) begin xm[22:0]=~(xm[22:0])+1; end
			 //else xm[22:0]=xm[22:0];
			 //if (y[31]) begin ym[22:0]=~(ym[22:0])+1; end
			 //else ym[22:0]=ym[22:0];
			 
			 xm1 = {25'b0, xm[24:0]};
			 ym1 = {25'b0, ym[24:0]};
			 zm = 0;
			 mulshift = 0;

			 //test denormalized cases: 1.one input's exponent is overflow; 2.one input is (!=0)^0
			 if((xe==8'd255)||(ye==8'd255)||((xe==8'd0)&&(xm[22:0]!=23'b0))||((ye==8'd0)&&(ym[22:0]!=23'b0)) )
			 begin
			    	 overflow = 2'b11;
				 nextstate = over; //
				 z = 32'b1; //error case
			 end
			 else if (x[30:0]==31'b0 || y[30:0] == 31'b0) begin z = 32'b0; overflow = 2'b00; end
			 else
			    nextstate = mul;
		  end


		mul://fraction add
		  begin
		    //ze = xe;

			 if((x[31]^y[31])==1'b0) //same +-
			 begin
			   zsign = 0;
			   //zm = xm * ym;
			   //ze = xe+ye;
			 end
			 else
			 begin
			   zsign = 1;
		           //zm = xm * ym;
			   //ze = xe+ye;
			 end

			ze = xe ;//consider that + ye may overflow, this operates in over state
			//zm = xm * ym;
			if (mulshift == 0) begin if(xm1[0]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end 
						 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end  
					   end 
                        else if (mulshift == 1) begin if(xm1[1]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 2) begin if(xm1[2]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 3) begin if(xm1[3]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 4) begin if(xm1[4]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 5) begin if(xm1[5]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 6) begin if(xm1[6]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 7) begin if(xm1[7]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 8) begin if(xm1[8]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 9) begin if(xm1[9]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 10) begin if(xm1[10]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 11) begin if(xm1[11]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 12) begin if(xm1[12]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 13) begin if(xm1[13]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 14) begin if(xm1[14]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 15) begin if(xm1[15]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 16) begin if(xm1[16]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 17) begin if(xm1[17]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 18) begin if(xm1[18]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 19) begin if(xm1[19]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 20) begin if(xm1[20]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 21) begin if(xm1[21]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 22) begin if(xm1[22]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else if (mulshift == 23) begin if(xm1[23]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1; end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = mul; mulshift = mulshift + 1;end
                                           end
                        else  begin if(xm1[24]) begin zm = zm + ym1; ym1 = {ym1[48:0],1'b0}; nextstate = normalize;  end
                                                 else       begin ym1 = {ym1[48:0],1'b0}; nextstate = normalize; end
                                           end


		  end

		normalize://
		  begin
		    if (zm[49]) begin zm_final = zm[49:25]; shift_1=3; shift_2 =0; end
		    else if (zm[48]) begin zm_final = zm[48:24]; shift_1=2; shift_2 =0; end
	            else if (zm[47]) begin zm_final = zm[47:23]; shift_1=1; shift_2 =0; end
                    else if (zm[46]) begin zm_final = zm[46:22]; shift_1=0; shift_2 =0; end
                    else if (zm[45]) begin zm_final = zm[45:21]; shift_1=0; shift_2 =0; end
                    else if (zm[44]) begin zm_final = zm[44:20]; shift_1=0; shift_2 =1; end
                    else if (zm[43]) begin zm_final = zm[43:19]; shift_1=0; shift_2 =2; end
                    else if (zm[42]) begin zm_final = zm[42:18]; shift_1=0; shift_2 =3; end
                    else if (zm[41]) begin zm_final = zm[41:17]; shift_1=0; shift_2 =4; end
                    else if (zm[40]) begin zm_final = zm[40:16]; shift_1=0; shift_2 =5; end
                    else if (zm[39]) begin zm_final = zm[39:15]; shift_1=0; shift_2 =6; end
                    else if (zm[38]) begin zm_final = zm[38:14]; shift_1=0; shift_2 =7; end
                    else if (zm[37]) begin zm_final = zm[37:13]; shift_1=0; shift_2 =8; end
                    else if (zm[36]) begin zm_final = zm[36:12]; shift_1=0; shift_2 =9; end
                    else if (zm[35]) begin zm_final = zm[35:11]; shift_1=0; shift_2 =10; end
                    else if (zm[34]) begin zm_final = zm[34:10]; shift_1=0; shift_2 =11; end
                    else if (zm[33]) begin zm_final = zm[33:9]; shift_1=0; shift_2 =12; end
                    else if (zm[32]) begin zm_final = zm[32:8]; shift_1=0; shift_2 =13; end
                    else if (zm[31]) begin zm_final = zm[31:7]; shift_1=0; shift_2 =14; end
                    else if (zm[30]) begin zm_final = zm[30:6]; shift_1=0; shift_2 =15; end
                    else if (zm[29]) begin zm_final = zm[29:5]; shift_1=0; shift_2 =16; end
                    else if (zm[28]) begin zm_final = zm[28:4]; shift_1=0; shift_2 =17; end
                    else if (zm[27]) begin zm_final = zm[27:3]; shift_1=0; shift_2 =18; end
                    else if (zm[26]) begin zm_final = zm[26:2]; shift_1=0; shift_2 =19; end
                    else if (zm[25]) begin zm_final = zm[25:1]; shift_1=0; shift_2 =20; end
                    else if (zm[24]) begin zm_final = zm[24:0]; shift_1=0; shift_2 =21; end
                    else if (zm[23]) begin zm_final = {zm[23:0],1'b0}; shift_1 = 0; shift_2 = 22; end
                    else if (zm[22]) begin zm_final = {zm[22:0],2'b0}; shift_1 = 0; shift_2 = 23; end
                    else if (zm[21]) begin zm_final = {zm[21:0],3'b0}; shift_1 = 0; shift_2 = 24; end
                    else if (zm[20]) begin zm_final = {zm[20:0],4'b0}; shift_1 = 0; shift_2 = 25; end
                    else if (zm[19]) begin zm_final = {zm[19:0],5'b0}; shift_1 = 0; shift_2 = 26; end
                    else if (zm[18]) begin zm_final = {zm[18:0],6'b0}; shift_1 = 0; shift_2 = 27; end
                    else if (zm[17]) begin zm_final = {zm[17:0],7'b0}; shift_1 = 0; shift_2 = 28; end
                    else if (zm[16]) begin zm_final = {zm[16:0],8'b0}; shift_1 = 0; shift_2 = 29; end
                    else if (zm[15]) begin zm_final = {zm[15:0],9'b0}; shift_1 = 0; shift_2 = 30; end
                    else if (zm[14]) begin zm_final = {zm[14:0],10'b0}; shift_1 = 0; shift_2 = 31; end
                    else if (zm[13]) begin zm_final = {zm[13:0],11'b0}; shift_1 = 0; shift_2 = 32; end
                    else if (zm[12]) begin zm_final = {zm[12:0],12'b0}; shift_1 = 0; shift_2 = 33; end
                    else if (zm[11]) begin zm_final = {zm[11:0],13'b0}; shift_1 = 0; shift_2 = 34; end
                    else if (zm[10]) begin zm_final = {zm[10:0],14'b0}; shift_1 = 0; shift_2 = 35; end
                    else if (zm[9]) begin zm_final = {zm[9:0],15'b0}; shift_1 = 0; shift_2 = 36; end
                    else if (zm[8]) begin zm_final = {zm[8:0],16'b0}; shift_1 = 0; shift_2 = 37; end
                    else if (zm[7]) begin zm_final = {zm[7:0],17'b0}; shift_1 = 0; shift_2 = 38; end
                    else if (zm[6]) begin zm_final = {zm[6:0],18'b0}; shift_1 = 0; shift_2 = 39; end
                    else if (zm[5]) begin zm_final = {zm[5:0],19'b0}; shift_1 = 0; shift_2 = 40; end
                    else if (zm[4]) begin zm_final = {zm[4:0],20'b0}; shift_1 = 0; shift_2 = 41; end
                    else if (zm[3]) begin zm_final = {zm[3:0],21'b0}; shift_1 = 0; shift_2 = 42; end
                    else if (zm[2]) begin zm_final = {zm[2:0],22'b0}; shift_1 = 0; shift_2 = 43; end
                    else if (zm[1]) begin zm_final = {zm[1:0],23'b0}; shift_1 = 0; shift_2 = 44; end
                    else  begin zm_final = {zm[0:0],24'b0}; shift_1 = 0; shift_2 = 45; end
		    
		    //if (zsign) begin zm_final[23:1] = ~ (zm_final[23:1]-1) ; end
		    nextstate=over;		
		  end

		over:
		  begin
			 e_temp =xe + ye + shift_1 - shift_2 -127;
			 if (e_temp > 8'd255) begin ze = 8'd255; end
			 else if ((xe + ye + shift_1 -127) < shift_2) begin ze = 8'd0; end
			 else  begin ze = e_temp[7:0]; end
		         z = {zsign, ze[7:0], zm_final[23:1]};
			 //see if it overflows
			 if(ze==8'd255 )
			 begin
			    overflow = 2'b01;
			 end
			 else if((ze==8'd0)&&(zm[22:0]!=23'b0)) //不处理非规约数
			 begin
			    overflow = 2'b10;
			 end
			 else
			    overflow = 2'b00;
		    if ((cmp_x!=x || cmp_y!=y) && enable) begin nextstate = start; end
		    else begin nextstate = over; end
	          end

		  default:
		  begin
		    nextstate = start;
		  end
		endcase

end
end

endmodule
