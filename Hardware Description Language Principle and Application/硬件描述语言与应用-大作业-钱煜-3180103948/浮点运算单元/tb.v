

//`timescale 1ns/1ns
`define clock_period 20

module tb;
  //wire [31:0] x,y;

  //wire [31:0] z;

  //wire enable_adds;

  //wire [1:0] overflow;

reg         fpu_clk;
reg         memory_clk;
reg         clk;
reg	      rst;
reg  [31:0] instruction;

wire		[1:0]	enable_adds;
wire			enable_addps;
wire		[1:0]	enable_subs;
wire		[1:0]	enable_subps;
wire			enable_muls;
wire			enable_mulps;
wire			enable_divs;
wire		[1:0]	enable_cvtpss;
wire			enable_cvtsw;
wire			enable_cvtws;
wire			enable_cvtspl;
wire			enable_cvtspu;
wire			enable_lui;
wire			enable_ori;
wire			enable_mfc1;
wire			enable_mtc1;
wire [1:0] read; //1: both read; 2:only read rt
wire [1:0] write;
wire [4:0] addr_fs;
wire [4:0] addr_ft;
wire [4:0] addr_fd;
wire [31:0] imm_data;
wire  [31:0]   w_data;
wire  [31:0]   r_data_ft;
wire  [31:0]   r_data_fs;
wire [1:0] read_gpr; //1: both read; 2:only read rt
wire [1:0] write_gpr;
wire [1:0] write_imm;
wire [4:0] addr_fs_gpr;
wire [4:0] addr_ft_gpr;
wire [4:0] addr_fd_gpr;
//wire [31:0] imm_data;
//wire  [31:0]   w_data;
wire  [31:0]   r_data_ft_gpr;
wire  [31:0]   r_data_fs_gpr;
wire [31:0] w_data_gpr;

wire [3:0] addr;
wire [31:0] w_data_adds;
wire [31:0] w_data_subs;
wire [31:0] w_data_muls;
wire [31:0] w_data_divs;
//wire [31:0] w_data_cvt;
wire [31:0] w_data_cvtpss;
wire [31:0] w_data_mtc1;
wire [31:0] w_data_addps;
wire [31:0] w_data_subps;
wire [31:0] w_data_mulps;
wire [31:0] w_data_cvt0;
wire [31:0] w_data_cvtspl;
wire [31:0] w_data_cvtspu;

//wire [31:0] zout;

wire [1:0] adds_overflow;
wire [1:0] subs_overflow;
wire [1:0] muls_overflow;
wire [1:0] divs_overflow;
//wire [1:0] cvt;
wire [1:0] cvtpss_overflow;
wire [1:0] mtc1_overflow;
wire [1:0] addps_overflow;
wire [1:0] mfc1_overflow;
wire [1:0] subps_overflow;
wire [1:0] mulps_overflow;
wire [1:0] cvt0_overflow;
wire [1:0] cvtspl_overflow;
wire [1:0] cvtspu_overflow;
//wire [1:0] mfc1_overflow;
wire [1:0] overflow;

initial
begin
$dumpfile("tb.vcd");
$dumpvars();
#(`clock_period*25000) $finish;
end

  floatadd  floatadd_0(
                  .clk(clk),
						.rst(rst),
						.x(r_data_ft),
						.y(r_data_fs),
						.enable(enable_adds),
						//.add(add),
						.z(w_data_adds),
						.overflow(adds_overflow)
                  );

  floatadd  floatsub_0(
                  .clk(clk),
						.rst(rst),
						.x(r_data_ft),
						.y(r_data_fs),
						.enable(enable_subs),
						//.add(add),
						.z(w_data_subs),
						.overflow(subs_overflow)
                  );

  floatmul  floatmul_0(
                  .clk(clk),
						.rst(rst),
						.x(r_data_ft),
						.y(r_data_fs),
						.enable(enable_muls),
						//.add(add),
						.z(w_data_muls),
						.overflow(muls_overflow)
                  );

  floatdiv  floatdiv_0(
                  .clk(clk),
						.rst(rst),
						.x(r_data_ft),
						.y(r_data_fs),
						.enable(enable_divs),
						//.add(add),
						.z(w_data_divs),
						.overflow(divs_overflow)
                  );
//cvt.pss***********************
  floatadd  floatcvt_high(
                  .clk(clk),
						.rst(rst),
						.x(0),
						.y(r_data_fs),
						.enable({1'b0,enable_cvtpss[0]}),
						//.add(add),
						.z(w_data_cvtpss),
						.overflow(cvtpss_overflow)
                  );
   floatadd  floatcvt_low(
                  .clk(clk),
						.rst(rst),
						.x(r_data_ft),
						.y(0),
						.enable({1'b0,enable_cvtpss[1]}),
						//.add(add),
						.z(w_data_cvtpss),
						.overflow(cvtpss_overflow)
                  );
   floatadd  mfc1(
                  .clk(clk),
						.rst(rst),
						.x(r_data_fs),
						.y(0),
						.enable({1'b0,enable_mfc1}),
						//.add(add),
						.z(w_data_gpr),
						.overflow(mfc1_overflow)
                  );

   floataddmtc1  mtc1(
                  .clk(clk),
						.rst(rst),
						.x(r_data_fs_gpr),
						.y(0),
						.enable({1'b0,enable_mtc1}),
						//.add(add),
						.z(w_data_mtc1),
						.overflow(mtc1_overflow)
                  );

   floatadd  addps(
                  .clk(clk),
						.rst(rst),
						.x(r_data_fs),
						.y(r_data_ft),
						.enable({1'b0,enable_addps}),
						//.add(add),
						.z(w_data_addps),
						.overflow(addps_overflow)
                  );

   floatadd  subps(
                  .clk(clk),
						.rst(rst),
						.x(r_data_fs),
						.y(r_data_ft),
						.enable(enable_subps),
						//.add(add),
						.z(w_data_subps),
						.overflow(subps_overflow)
                  );

   floatmul  mulps(
                  .clk(clk),
						.rst(rst),
						.x(r_data_fs),
						.y(r_data_ft),
						.enable(enable_mulps),
						//.add(add),
						.z(w_data_mulps),
						.overflow(mulps_overflow)
                  );

   floatcvt  cvt0(
                  .clk(clk),
						.rst(rst),
						.x(r_data_fs),
						.y(r_data_fs),
						.enable({enable_cvtws,enable_cvtsw}),
						//.add(add),
						.z(w_data_cvt0),
						.overflow(cvt0_overflow)
                  );
   floatadd  cvtpl(
                  .clk(clk),
						.rst(rst),
						.x(r_data_fs),
						.y(0),
						.enable({1'b0,enable_cvtspl}),
						//.add(add),
						.z(w_data_cvtspl),
						.overflow(cvtspl_overflow)
                  );
   floatadd  cvtpu(
                  .clk(clk),
						.rst(rst),
						.x(r_data_fs),
						.y(0),
						.enable({1'b0,enable_cvtspu}),
						//.add(add),
						.z(w_data_cvtspu),
						.overflow(cvtspu_overflow)
                  );
//***************************

  fpu	fpu0(
.fpu_clock(fpu_clk),
.rst(rst),
.instruction(instruction),
.enable_adds(enable_adds),
.enable_addps(enable_addps),
.enable_subs(enable_subs),
.enable_subps(enable_subps),
.enable_muls(enable_muls),
.enable_mulps(enable_mulps),
.enable_divs(enable_divs),
.enable_cvtpss(enable_cvtpss),
.enable_cvtsw(enable_cvtsw),
.enable_cvtws(enable_cvtws),
.enable_cvtspl(enable_cvtspl),
.enable_cvtspu(enable_cvtspu),
.enable_lui(),
.enable_ori(),
.enable_mfc1(enable_mfc1),
.enable_mtc1(enable_mtc1),
.read(read),
.write(write),		
.addr_fs(addr_fs),
.addr_ft(addr_ft),
.addr_fd(addr_fd),
.imm_data(imm_data),
.read_gpr(read_gpr),
.write_imm(write_imm),
.addr_fs_gpr(addr_fs_gpr),
.addr_ft_gpr(addr_ft_gpr),
.addr_fd_gpr(addr_fd_gpr),
.write_gpr(write_gpr),
.addr_MUX(addr)
);

 addr_MUX addr_MUX0(
.clk(memory_clk),
.rst(rst),
.w_data_adds(w_data_adds),
.w_data_subs(w_data_subs),
.w_data_muls(w_data_muls),
.w_data_divs(w_data_divs),
.w_data_cvtpss(w_data_cvtpss),
.w_data_mtc1(w_data_mtc1),
.w_data_addps(w_data_addps),
.w_data_subps(w_data_subps),
.w_data_mulps(w_data_mulps),
.w_data_cvt0(w_data_cvt0),
.w_data_cvtspl(w_data_cvtspl),
.w_data_cvtspu(w_data_cvtspu),
.addr(addr),
.zout(w_data)
);

 overflow_MUX overflow_MUX0(
.clk(memory_clk),
.rst(rst),
.adds_overflow(adds_overflow),
.subs_overflow(subs_overflow),
.muls_overflow(muls_overflow),
.divs_overflow(divs_overflow),
.cvtpss_overflow(cvtpss_overflow),
.mtc1_overflow(mtc1_overflow),
.addps_overflow(addps_overflow),
.subps_overflow(subps_overflow),
.mulps_overflow(mulps_overflow),
.cvt0_overflow(cvt0_overflow),
.cvtspl_overflow(cvtspl_overflow),
.cvtspu_overflow(cvtspu_overflow),
.addr(addr),
.overflow(overflow),
.mfc1_overflow(mfc1_overflow)
);


  memory_fpu   memory0(
.clock(memory_clk),
.rst(rst),
.write(write),
.read(read),
.addr_ft(addr_ft),
.addr_fs(addr_fs),
.addr_fd(addr_fd),
.w_data(w_data),
.r_data_ft(r_data_ft),
.r_data_fs(r_data_fs),
.imm_data(0)
);

  memory_fpu   gpr(
.clock(memory_clk),
.rst(rst),
.write(write_imm),
.read(read_gpr),
.addr_ft(addr_ft_gpr),
.addr_fs(addr_fs_gpr),
.addr_fd(addr_fd_gpr),
.w_data(w_data_gpr),
.r_data_ft(r_data_ft_gpr),
.r_data_fs(r_data_fs_gpr),
.imm_data(imm_data)
);
  initial clk = 0;
  initial memory_clk = 0;
  initial fpu_clk = 0;
  always #(`clock_period/4) clk = ~clk;
  always #(`clock_period/4) memory_clk = ~memory_clk;
  always #(`clock_period*20) fpu_clk = ~fpu_clk;

  initial begin //rst, then cell[31] stores 3 (word format)
     //x = 0; enable=0;
//add.s 1
	  rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]  lui
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  #(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00001,5'b00001,5'b00000,6'b000000}; //move 3.5 from gpr_cell[1] to fpr_cell[1] (mtc1 command)
	  #(`clock_period*300) instruction = {11'b01000110000,5'b00000,5'b00001,5'b00010,6'b000000}; //add.s cell[2]=cell[0]+cell[1] =>6.5
//add.ps 2
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]  lui
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  #(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00001,5'b00001,5'b00000,6'b000000}; //move 3.5 from gpr_cell[1] to fpr_cell[1] (mtc1 command)
	  #(`clock_period*300) instruction = {11'b01000110110,5'b00000,5'b00010,5'b00100,6'b000000}; //add.ps cell[4][5]=cell[0][1]+cell[2][3] 
//cvt.w.s 3
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  //#(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000110000,5'b00000,5'b00000,5'b00010,6'b100100}; //cvt.w.s cell[0]->cell[2]
//cvt.s.w 4
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  //#(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000110100,5'b00000,5'b11110,5'b00010,6'b100000}; //cvt.s.w cell[30]->cell[2]
//cvt.s.pl 5
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  //#(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000110110,5'b00000,5'b11110,5'b00010,6'b101000}; // cell[31] = 3 ->cell[2]
//cvt.s.pu  6
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  //#(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000110110,5'b00000,5'b11110,5'b00010,6'b100000}; // cell[30] = 0 ->cell[2]
//sub.s    7
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]  lui
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  #(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00001,5'b00001,5'b00000,6'b000000}; //move 3.5 from gpr_cell[1] to fpr_cell[1] (mtc1 command)
	  #(`clock_period*300) instruction = {11'b01000110000,5'b00000,5'b00001,5'b00010,6'b000001}; //sub.s cell[2]=cell[0]-cell[1] =>0.5
//sub.ps  8
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]  lui
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  #(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00001,5'b00001,5'b00000,6'b000000}; //move 3.5 from gpr_cell[1] to fpr_cell[1] (mtc1 command)
	  #(`clock_period*300) instruction = {11'b01000110110,5'b00000,5'b00010,5'b00100,6'b000001}; //sub.ps cell[4][5]=cell[2][3]-cell[0][1]
//mul.s   9
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]  lui
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  #(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00001,5'b00001,5'b00000,6'b000000}; //move 3.5 from gpr_cell[1] to fpr_cell[1] (mtc1 command)
	  #(`clock_period*300) instruction = {11'b01000110000,5'b00000,5'b00001,5'b00010,6'b000010}; //mul.s cell[2]=cell[0]*cell[1] =>10.5

//mul.ps  10
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]  lui
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  #(`clock_period*300) instruction = {16'b0011110000000010,9'b010000000,7'b1000000}; //write 3 into gpr_cell[2]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00010,5'b00010,5'b00000,6'b000000}; //move 3.5 from gpr_cell[2] to fpr_cell[2] (mtc1 command)
	  #(`clock_period*300) instruction = {11'b01000110110,5'b00000,5'b00010,5'b00100,6'b000010}; //mul.ps cell[4][5]=cell[0][1]*cell[2][3]
 
//div.s   11
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[0]  lui
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[0] to fpr_cell[0] (mtc1 command)
	  #(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00001,5'b00001,5'b00000,6'b000000}; //move 3.5 from gpr_cell[1] to fpr_cell[1] (mtc1 command)
	  #(`clock_period*300) instruction = {11'b01000110000,5'b00000,5'b00001,5'b00010,6'b000011}; //div.s cell[2]=cell[0]/cell[1] =>1.6667

//cvt.pss 12
	  #(`clock_period*600)rst = 1'b0;
	  #(`clock_period*20+10) rst = 1'b1;
	  #(`clock_period) instruction = {16'b0011110000000010,9'b010000000,7'b1100000}; //write 3.5 into gpr_cell[2]  lui
	  #(`clock_period*300) instruction = {11'b01000100100,5'b00010,5'b00010,5'b00000,6'b000000}; //move 3.5 from gpr_cell[2] to fpr_cell[2] (mtc1 command)


	  #(`clock_period*300) instruction = {11'b01000100100,5'b00010,5'b00011,5'b00000,6'b000000}; //move 3.5 from gpr_cell[2] to fpr_cell[3] (mtc1 command)


	  #(`clock_period*300) instruction = {11'b00110100010,5'b00011,5'b00000,5'b00000,6'b000000}; //move 3.5 from gpr_cell[2] to gpr_cell[3] (ori command)chenggong

	  #(`clock_period*300) instruction = {11'b01000100000,5'b00100,5'b00011,5'b00000,6'b000000}; //move 3.5 from fpr_cell[3] to gpr_cell[4] (mfc1 command)
//
	  //#(`clock_period*300) instruction = {11'b01000100100,5'b00011,5'b00101,5'b00000,6'b000000}; //move 3.5 from gpr_cell[3] to fpr_cell[5] (mtc1 command)

	  #(`clock_period*300) instruction = {11'b01000100100,5'b00011,5'b00101,5'b00000,6'b000000}; //move 3.5 from gpr_cell[3] to fpr_cell[5] (mtc1 command)
//

	  #(`clock_period*300) instruction = {11'b01000110000,5'b00101,5'b00011,5'b00000,6'b100110}; //cvt.pss cell[0]=cell[3], cell[1]=cell[5]
	  #(`clock_period*1000) instruction = {11'b01000110000,5'b00000,5'b00001,5'b00010,6'b000011}; //div.s cell[2]=cell[1]/cell[0] =>1

//mfc1 NO13
//	  #(`clock_period*600)rst = 1'b0;
//	  #(`clock_period*20+10) rst = 1'b1;
//	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into cell[0]
	  //#(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
//	  #(`clock_period*300) instruction = {11'b01000100000,5'b00001,5'b00000,5'b00000,6'b000000}; //mfc1 cell[0]->cell[1]

//mtc1 NO14
//	  #(`clock_period*600)rst = 1'b0;
//	  #(`clock_period*20+10) rst = 1'b1;
//	  #(`clock_period) instruction = {16'b0011110000000000,9'b010000000,7'b1100000}; //write 3.5 into cell[0]
	  //#(`clock_period*300) instruction = {16'b0011110000000001,9'b010000000,7'b1000000}; //write 3 into cell[1]
//	  #(`clock_period*300) instruction = {11'b01000100100,5'b00000,5'b00001,5'b00000,6'b000000}; //mtc1 cell[0]->cell[1]

  end

  //initial begin
  //   y = 0;
//	  #20
//	  #(`clock_period) y = 32'b01000000010011001100110011001101;//2.4
  //   #(`clock_period*7) y = 32'h41a3c28f;//20.47

//  end


  initial begin
     #(`clock_period*25000)
	  $stop;
  end


endmodule




