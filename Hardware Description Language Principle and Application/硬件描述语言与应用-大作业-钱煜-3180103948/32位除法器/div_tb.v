//`timescale 1ns / 1ps
module DIVUN_32_tb;
parameter delay=10;

reg clk; 
reg reset; 
reg enable; 
reg [31:0] dividend;
reg [31:0] divisor;
wire [31:0] quotient;
wire [31:0] remainder;


initial
begin
$dumpfile("div.vcd");
$dumpvars();
#300 $finish;
end



DIVUN_32  DIVUN_32_test(.clk(clk),
					 .reset(reset),
					 .enable(enable),
					 .dividend(dividend),
					 .divisor0(divisor),
					 .quotient(quotient),
					 .remainder(remainder));

	initial 
	  begin

		// Initialize Inputs
		clk = 0;
		reset = 1;
		enable = 0;
		dividend = 0;
		divisor = 0;

		// 
		#(delay*5)  reset=0;
		#(delay*5)  reset=1;enable=1;dividend=183;divisor=14;
		#(delay*5)  dividend=115;divisor=1;
		#(delay*5)  dividend=13;divisor=0;
		#(delay*5)  dividend=153;divisor=1;
	    #(delay*10) $stop;
         
    end

	//clock
  always 		#(delay/5) clk=~clk;

//`ifdef FSDB
//initial begin
//	$fsdbDumpfile("tb_div.fsdb");
//	$fsdbDumpvars;
//end
//`endif
endmodule 




