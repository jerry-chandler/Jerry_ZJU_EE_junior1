module floatdiv(clk, rst, enable, x, y, z,overflow);


   	input clk;
	input rst;
	input enable;
	input [31:0] x;
	input [31:0] y;

        //
	output [31:0] z;
	output [1:0] overflow;//00:no overflow 01:upflow 10:downflow 11:the input does not meet format

	reg [31:0] z; // z=x/y 
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

	parameter start=3'b000,one_zero=3'b001,ex_add=3'b010,div=3'b011,normalize=3'b100,over =3'b110;

	always @(posedge clk) begin
	    if(!rst)
		   //state = start;
		   begin nextstate = start;
		   xm=0;ym=0;zm=0;xe=0;ye=0;ze=0;overflow=0; z=0;end
	    else if (!enable)
		  begin state=state; nextstate=nextstate; end
			
	    else
		   state = nextstate;
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
			 z=0;
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
			 else
			    nextstate = div;
		  end

		div:
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
			//
			if (mulshift != 23) begin if(xm1>=ym1) begin zm[0] = 1; zm = {zm[48:0], 1'b0}; xm1 = xm1 - ym1; xm1 = {xm1[48:0], 1'b0};  
							             nextstate = div; mulshift = mulshift + 1; end 
						  else         begin zm[0] = 0; zm = {zm[48:0], 1'b0}; xm1 = {xm1[48:0], 1'b0};  
							             nextstate = div; mulshift = mulshift + 1;end  
					    end 
			else begin   nextstate = normalize; end



		  end	

		normalize://
		  begin
		    if      (zm[23]) begin zm_final = {zm[23:0],1'b0}; shift_1 = 0; shift_2 = 0; end
                    else if (zm[22]) begin zm_final = {zm[22:0],1'b0}; shift_1 = 0; shift_2 = 1; end
                    else if (zm[21]) begin zm_final = {zm[21:0],2'b0}; shift_1 = 0; shift_2 = 2; end
                    else if (zm[20]) begin zm_final = {zm[20:0],3'b0}; shift_1 = 0; shift_2 = 3; end
                    else if (zm[19]) begin zm_final = {zm[19:0],4'b0}; shift_1 = 0; shift_2 = 4; end
                    else if (zm[18]) begin zm_final = {zm[18:0],5'b0}; shift_1 = 0; shift_2 = 5; end
                    else if (zm[17]) begin zm_final = {zm[17:0],6'b0}; shift_1 = 0; shift_2 = 6; end
                    else if (zm[16]) begin zm_final = {zm[16:0],7'b0}; shift_1 = 0; shift_2 = 7; end
                    else if (zm[15]) begin zm_final = {zm[15:0],8'b0}; shift_1 = 0; shift_2 = 8; end
                    else if (zm[14]) begin zm_final = {zm[14:0],9'b0}; shift_1 = 0; shift_2 = 9; end
                    else if (zm[13]) begin zm_final = {zm[13:0],10'b0}; shift_1 = 0; shift_2 = 10; end
                    else if (zm[12]) begin zm_final = {zm[12:0],11'b0}; shift_1 = 0; shift_2 = 11; end
                    else if (zm[11]) begin zm_final = {zm[11:0],12'b0}; shift_1 = 0; shift_2 = 12; end
                    else if (zm[10]) begin zm_final = {zm[10:0],13'b0}; shift_1 = 0; shift_2 = 13; end
                    else if (zm[9]) begin zm_final = {zm[9:0],14'b0}; shift_1 = 0; shift_2 = 14; end
                    else if (zm[8]) begin zm_final = {zm[8:0],15'b0}; shift_1 = 0; shift_2 = 15; end
                    else if (zm[7]) begin zm_final = {zm[7:0],16'b0}; shift_1 = 0; shift_2 = 16; end
                    else if (zm[6]) begin zm_final = {zm[6:0],17'b0}; shift_1 = 0; shift_2 = 17; end
                    else if (zm[5]) begin zm_final = {zm[5:0],18'b0}; shift_1 = 0; shift_2 = 18; end
                    else if (zm[4]) begin zm_final = {zm[4:0],19'b0}; shift_1 = 0; shift_2 = 19; end
                    else if (zm[3]) begin zm_final = {zm[3:0],20'b0}; shift_1 = 0; shift_2 = 20; end
                    else if (zm[2]) begin zm_final = {zm[2:0],21'b0}; shift_1 = 0; shift_2 = 21; end
                    else if (zm[1]) begin zm_final = {zm[1:0],22'b0}; shift_1 = 0; shift_2 = 22; end
                    else      	    begin zm_final = {zm[0:0],23'b0}; shift_1 = 0; shift_2 = 23; end
		    
		    //if (zsign) begin zm_final[23:1] = ~ (zm_final[23:1]-1) ; end
		    nextstate=over;		
		  end	

		over:
		  begin
			 e_temp = xe - ye ;
			 if (e_temp > 8'd255) begin ze = 8'd255; end
			 else if (e_temp < shift_2) begin ze = 8'd0; end
			 else  begin e_temp = xe - ye - shift_2; ze = e_temp[7:0]; end
		         ze = ze + 127;
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
	
	

