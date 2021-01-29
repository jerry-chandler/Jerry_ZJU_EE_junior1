

//`timescale 1ns/1ns
`define clock_period 20

module floatadd_tb;
  reg [31:0] x,y;

  wire [31:0] z;

  reg enable;
  reg clk;
  reg rst_n;
  wire [1:0] overflow;

initial
begin
$dumpfile("float_add.vcd");
$dumpvars();
#2000 $finish;
end

  floatadd  floatadd_0(
                  .clk(clk),
						.rst(rst_n),
						.x(x),
						.y(y),
						.enable(enable),
						//.add(add),
						.z(z),
						.overflow(overflow)
                  );

  initial clk = 0;
  always #(`clock_period/4) clk = ~clk;

  initial begin
     x = 0; enable=0;
	  rst_n = 1'b0;
	  #20 rst_n = 1'b1;
	  #(`clock_period) x = 32'b01000000011011101001011110001101; enable = 1; //3.456
	  #(`clock_period*7) x = 32'hc2b5999a; //-90.8

  end

  initial begin
     y = 0;
	  #20
	  #(`clock_period) y = 32'b01000000010011001100110011001101;//2.4
     #(`clock_period*7) y = 32'h41a3c28f;//20.47

  end


  initial begin
     #(`clock_period*100)
	  $stop;
  end


endmodule




