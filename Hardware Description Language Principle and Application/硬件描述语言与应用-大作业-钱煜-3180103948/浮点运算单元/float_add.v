module floatadd(clk, rst, enable, x, y, z,overflow);

   input clk;
	input rst;
	input [1:0] enable;
	input [31:0] x;
	input [31:0] y;
        //input add;//add=1:add case  add=0:sub case
	output [31:0] z;
	output [1:0] overflow;//00:no overflow 01:upflow 10:downflow 11:the input does not meet format

	reg [31:0] z; // z=x+y 
	reg[24:0] xm, ym, zm; //fraction part, 0+ 1+[22:0]，
	reg[7:0] xe, ye, ze;  //exponent part
	reg[2:0]	state, nextstate;       //FSM
	reg zsign; //sign part
	reg [1:0] overflow;
	reg [31:0] cmp_x;
	reg [31:0] cmp_y;


	parameter start=3'b000,one_zero=3'b001,ex_equal=3'b010,add_fra=3'b011,normalize=3'b100,over =3'b110;


	always @(posedge clk) begin
	    if(!rst)
		   //state = start;
		   begin nextstate = start;
		   xm=0;ym=0;zm=0;xe=0;ye=0;ze=0;overflow=0;z=0;cmp_x=32'b1;cmp_y=32'b1; end
	    else if (!enable)
		  begin state=state; nextstate=nextstate; end
			
	    else
		   state = nextstate;
	//end

	//game start!
	//always@(state,nextstate,xe,ye,xm,ym,ze,zm) 
begin
		case(state)

		start: //initialize

		  begin
			//if (enable == 2'b10) y[31]=~y[31];
			//else y[31]=y[31];
			 cmp_x=x;
			 cmp_y=y;
		    	 xe = x[30:23];
          		 xm = {1'b0,1'b1,x[22:0]};
          		 ye = y[30:23];
			 ym = {1'b0,1'b1,y[22:0]};

			 //test denormalized cases: 1.one input's exponent is overflow; 2.one input is (!=0)^0
			 if((xe==8'd255)||(ye==8'd255)||((xe==8'd0)&&(xm[22:0]!=23'b0))||((ye==8'd0)&&(ym[22:0]!=23'b0)) )
			 begin
			    overflow = 2'b11;
				 nextstate = over; //
				 z = 32'b1; //error case
			 end
			 else
			    nextstate = one_zero;
		  end

		one_zero://if any input is 0, then go short way to over state
		  begin
		    if((x[22:0]==23'b0)&&(xe==8'b0))
			 begin
				if (enable[1]==1) 			   {zsign, ze,zm} = {~y[31],ye, ym};
			        else					   {zsign, ze,zm} = {y[31],ye, ym};
				nextstate = over;
			 end
			 else
			 begin
				 if((y[22:0]==23'b0)&&(ye==8'b0))
				 begin
			           {zsign,ze,zm} = {x[31],xe, xm};
				   nextstate = over;
				 end
				 else
				   nextstate = ex_equal;
			 end
		  end

		ex_equal: //<<||>>

		  begin
		    	 if(xe == ye)
			   nextstate = add_fra;
	                 else
			 begin
			   if(xe > ye)
				begin
				  ye = ye + 1'b1;//
				  ym[23:0]= {1'b0, ym[23:1]};
				  if(ym==8'b0)
				  begin
				         zm = xm;
					 ze = xe;
					 zsign=x[31];
					 nextstate = over;
				  end
				  else
				    nextstate = ex_equal;

				end
			   else
				begin
				  xe = xe + 1'b1;//
				  xm[23:0] = {1'b0, xm[23:1]};
				  if(xm==8'b0)
				  begin
				         zm = ym;
					 ze = ye;
					 zsign = y[31];
					 nextstate = over;
				  end
				  else
				    nextstate = ex_equal;
				end
			 end

		  end

		add_fra://fraction add
		  begin
		    ze = xe;
		     		if (enable == 2'b10)begin

					if((x[31]^(~y[31]))==1'b0) //same +-
			 			begin
			   				zsign = x[31];
			   				zm = xm + ym;
			 			end
					else
			 			begin
			   				if(xm>ym)
							begin
			     				zsign = x[31];
			     				zm = xm - ym;
							end
							else
							begin
			     				zsign = ~y[31];
			     				zm = ym - xm;
							end
						
						end
					end

		      		else begin
					if((x[31]^(y[31]))==1'b0) //same +-
			 			begin
			   				zsign = x[31];
			   				zm = xm + ym;
			 			end
					else
			 			begin
			   				if(xm>ym)
							begin
			     				zsign = x[31];
			     				zm = xm - ym;
							end
							else
							begin
			     				zsign = y[31];
			     				zm = ym - xm;
							end
						end 
			 	end

			if(zm[23:0]==24'b0)
			   nextstate = over;
			else
			   nextstate =normalize;
		  end

		normalize://
		  begin
		    if(zm[24]==1'b1)//cin||cout
			 begin
			   zm = {1'b0,zm[24:1]};
            		   ze = ze + 1'b1;
            		   nextstate = over;
			 end
		    else
			 begin
			   if(zm[23]==1'b0)
				begin
				  zm = {zm[23:0],1'b0};
              			  ze = ze - 1'b1;
              			  nextstate = normalize;
				end
			   else
				begin
				  nextstate = over;
				end
			 end
		  end

		over:
		  begin
		    z = {zsign, ze[7:0], zm[22:0]};
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




