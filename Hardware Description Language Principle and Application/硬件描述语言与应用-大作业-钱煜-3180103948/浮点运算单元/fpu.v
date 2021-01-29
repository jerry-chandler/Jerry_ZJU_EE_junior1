module fpu(
fpu_clock,
rst,
instruction,
enable_adds,
enable_addps,
enable_subs,
enable_subps,
enable_muls,
enable_mulps,
enable_divs,
enable_cvtpss,
enable_cvtsw,
enable_cvtws,
enable_cvtspl,
enable_cvtspu,
enable_lui,
enable_ori,
enable_mfc1,
enable_mtc1,
read,
write,
addr_ft,
addr_fs,
addr_fd,
imm_data,
read_gpr,
write_imm,
addr_fs_gpr,
addr_ft_gpr,
addr_fd_gpr,
write_gpr,
addr_MUX
);

input         fpu_clock;
input	      rst;
input  [31:0] instruction;

output reg		[1:0]	enable_adds;
output reg			enable_addps;
output reg		[1:0]	enable_subs;
output reg		[1:0]	enable_subps;
output reg			enable_muls;
output reg			enable_mulps;
output reg			enable_divs;
output reg		[1:0]	enable_cvtpss;
output reg			enable_cvtsw;
output reg			enable_cvtws;
output reg			enable_cvtspl;
output reg			enable_cvtspu;
output reg			enable_lui;
output reg			enable_ori;
output reg			enable_mfc1;
output reg			enable_mtc1;
output reg [1:0] read; //1: both read; 2:only read rt
output reg [1:0] write;
//output reg [31:0] imm_data;
output reg  [4:0]    addr_ft;
output reg  [4:0]    addr_fs;
output reg  [4:0]    addr_fd;
output reg  [1:0] read_gpr; //1: both read; 2:only read rt
output reg  [1:0] write_imm;
output reg  [1:0] write_gpr;
output reg [31:0] imm_data;
output reg  [4:0]    addr_ft_gpr;
output reg  [4:0]    addr_fs_gpr;
output reg  [4:0]    addr_fd_gpr;
output reg  [3:0]    addr_MUX;

parameter decode=6'b000000,add_read=6'b000001,add_cal=6'b000010,add_write=6'b000011,sub_read=6'b000100,sub_cal=6'b000101,mul_read=6'b000110, mul_cal=6'b000111, div_read=6'b001000, div_cal=6'b001001,cvtpss_read=6'b001010, cvtpss_write_high=6'b001011, cvtpss_write_low=6'b001100, mfc1_read=6'b001101, mfc1_write=6'b001110, mtc1_read=6'b001111, mtc1_write=6'b010000, addps_read1=6'b010001, addps_write1=6'b010010, addps_read2=6'b010011, addps_write2=6'b010100, addps_cal1=6'b010101, addps_cal2=6'b010110, subps_read1=6'b010111, subps_write1=6'b011000, subps_read2=6'b011001, subps_write2=6'b011010, subps_cal1=6'b011011, subps_cal2=6'b011100, mulps_read1=6'b011101, mulps_read2=6'b011110, mulps_write1=6'b011111, mulps_write2=6'b100000, mulps_cal1=6'b100001, mulps_cal2=6'b100010, cvtsw_read=6'b100011, cvtsw_cal=6'b100100, cvtsw_write=6'b100101, cvtws_read=6'b100110, cvtws_cal=6'b100111, cvtws_write=6'b101000, cvtspl_read=6'b101001, cvtspl_write=6'b101010, cvtspu_read=6'b101011, cvtspu_write=6'b101100, cvtspl_cal=6'b101101, cvtspu_cal=6'b101110, over=6'b111111;
reg[5:0]	state, nextstate;       //FSM
reg [31:0] cmp_instruction;


always@(posedge fpu_clock)
begin
	    if(!rst)
		   //state = start;
		   begin nextstate = decode;
		   end
	    	
	    else
		   state = nextstate;
begin	
	case(state)
	
	decode:
		
	begin
	cmp_instruction = instruction;
	if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10000  && instruction[5:0]==6'b000000) //add.s 1
			begin
				//floatadd floatadd_s (.clk(func_clk), .rst(cpu_reset_b), .x(x), .y(y), .z(z), .overflow(overflow));
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b0001;
				nextstate = add_read;
			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10110  && instruction[5:0]==6'b000000) //add.ps 2
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b0010;
				nextstate = addps_read1;				

			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10000  && instruction[5:0]==6'b000001) //sub.s 3
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b0011;
				nextstate = sub_read;				

			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10110  && instruction[5:0]==6'b000001) //sub.ps 4
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b0100;
				nextstate = subps_read1;				

			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10000  && instruction[5:0]==6'b000010) //mul.s 5
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b0101;
				nextstate = mul_read;				

			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10110  && instruction[5:0]==6'b000010) //mul.ps 6
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b0110;
				nextstate = mulps_read1;				

			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10000  && instruction[5:0]==6'b000011) //div.s 7
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b0111;
				nextstate = div_read;				

			end
	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10000  && instruction[5:0]==6'b100110) //cvt.ps.s fd = fs || fd 8
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b1000;				
				nextstate = cvtpss_read;

			end
	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10100  && instruction[5:0]==6'b100000) //cvt.s.w 9
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b1001;				
				nextstate = cvtsw_read;		

			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10000  && instruction[5:0]==6'b100100) //cvt.w.s 9
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b1001;				
				nextstate = cvtws_read;					

			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10110  && instruction[5:0]==6'b101000) //cvt.s.pl 10
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b1010;				
				nextstate = cvtspl_read;					

			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b10110  && instruction[5:0]==6'b100000) //cvt.s.pu 11
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b1011;				
				nextstate = cvtspu_read;				

			end

	else if (instruction[31:26]==6'b001111) //lui  12
			begin
				read = 0; write=0; write_imm = 2'b10;//addr_MUX = 4'b1100;
				addr_fd_gpr = instruction[20:16]; //the addr of write target of the register
				imm_data = {instruction[15:0],16'b0};
				nextstate = over;

			end

	else if (instruction[31:26]==6'b001101 ) //ori 13
			begin
				read = 0; write=0; write_imm = 2'b11;//addr_MUX = 4'b1101;
				addr_fd_gpr = instruction[20:16]; //the addr of write target of the register
				addr_fs_gpr = instruction[25:21];
				imm_data = {instruction[15:0],16'b0};
				nextstate = over;

			end

	else if (instruction[31:26]==6'b010001 && instruction[25:21]==5'b00000  && instruction[10:0]==11'b00000000000) //mfc1 14
			begin
				
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;//addr_MUX = 4'b1110;	
				nextstate = mfc1_read;	
			end

	else 
				//if (instruction[31:26]==5'b010001 && instruction[25:21]==5'b00100  && instruction[10:0]==11'b00000000000) //mtc1 15
			begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				read=0; write=0; write_imm=0;addr_MUX = 4'b1111;	
				nextstate = mtc1_read;				

			end
	end //end of case 'decode'

//*********************************************************************
	add_read:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16];
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = add_cal;
	

	end //end of case 'add_read'
	
	sub_read:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16];
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = sub_cal;
	

	end //end of case 'sub_read'

	mul_read:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16];
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = mul_cal;
	

	end //end of case 'mul_read'

	div_read:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16];
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = div_cal;
	

	end //end of case 'div_read'

	cvtpss_read:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16];
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = cvtpss_write_high;
	

	end //end of case 'cvtpss_read'

	mfc1_read:
	begin

		read = 1; read_gpr = 0; write = 0;  
		//addr_ft = instruction[20:16];
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = mfc1_write;
	

	end //end of case 'mfc1_read'

	mtc1_read:
	begin

		read = 0; write = 0; read_gpr = 1;
		//addr_ft = instruction[20:16];
		addr_fs_gpr = instruction[20:16];
		//addr_fd = instruction[10:6];
		nextstate = mtc1_write;
	

	end //end of case 'mtc1_read'

	addps_read1:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16];
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = addps_cal1;
	end // end of 'addps_read1'

	addps_read2:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16]+1;
		addr_fs = instruction[15:11]+1;
		//addr_fd = instruction[10:6];
		nextstate = addps_cal2;
	end // end of 'addps_read2'

	subps_read1:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16];
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = subps_cal1;
	end // end of 'subps_read1'

	subps_read2:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16]+1;
		addr_fs = instruction[15:11]+1;
		//addr_fd = instruction[10:6];
		nextstate = subps_cal2;
	end // end of 'subps_read2'

	mulps_read1:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16];
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = mulps_cal1;
	end // end of 'mulps_read1'

	mulps_read2:
	begin

		read = 1; write = 0;
		addr_ft = instruction[20:16]+1;
		addr_fs = instruction[15:11]+1;
		//addr_fd = instruction[10:6];
		nextstate = mulps_cal2;
	end // end of 'mulps_read2'

	cvtsw_read:
	begin

		read = 1; write = 0;
		//addr_ft = instruction[20:16]+1;
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = cvtsw_cal;
	end // end of 'cvtsw_read'

	cvtws_read:
	begin

		read = 1; write = 0;
		//addr_ft = instruction[20:16]+1;
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = cvtws_cal;
	end // end of 'cvtws_read'

	cvtspl_read:
	begin

		read = 1; write = 0;
		//addr_ft = instruction[20:16]+1;
		addr_fs = instruction[15:11]+1;
		//addr_fd = instruction[10:6];
		nextstate = cvtspl_cal;
	end // end of 'cvtspl_read'

	cvtspu_read:
	begin

		read = 1; write = 0;
		//addr_ft = instruction[20:16]+1;
		addr_fs = instruction[15:11];
		//addr_fd = instruction[10:6];
		nextstate = cvtspu_cal;
	end // end of 'cvtspu_read'
//******************************************************************************************
	add_cal:
	begin

				enable_adds=2'b01;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = add_write;

	end //end of case 'add_cal'

	addps_cal1:
	begin

				enable_adds=0;
				enable_addps=1;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = addps_write1;

	end //end of case 'addps_cal1'

	addps_cal2:
	begin

				enable_adds=0;
				enable_addps=1;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = addps_write2;

	end //end of case 'addps_cal2'

	sub_cal:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=2'b10;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = add_write;

	end //end of case 'sub_cal'

	subps_cal1:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=2'b10;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = subps_write1;

	end //end of case 'addps_cal1'

	subps_cal2:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=2'b10;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = subps_write2;

	end //end of case 'addps_cal2'

	mul_cal:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=1;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = add_write;

	end //end of case 'mul_cal'

	mulps_cal1:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=1;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = mulps_write1;

	end //end of case 'mulps_cal1'

	mulps_cal2:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=1;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = mulps_write2;

	end //end of case 'mulps_cal2'

	div_cal:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=1;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = add_write;

	end //end of case 'div_cal'

	cvtsw_cal:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=1;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = cvtsw_write;

	end //end of case 'cvtsw_cal'

	cvtws_cal:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=1;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = cvtws_write;

	end //end of case 'cvtws_cal'

	cvtspl_cal:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=1;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = cvtspl_write;

	end //end of case 'cvtspl_cal'

	cvtspu_cal:
	begin

				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=1;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
				nextstate = cvtspu_write;

	end //end of case 'cvtspu_cal'

//*******************************************************************************
	add_write:
	begin
		read = 0; write = 2'b01;
		addr_fd = instruction[10:6];		
		nextstate = over;
	end //end of case 'add_write'

	addps_write1:
	begin
		read = 0; write = 2'b01;
		addr_fd = instruction[10:6];		
		nextstate = addps_read2;
	end //end of case 'addps_write1'

	addps_write2:
	begin
		read = 0; write = 2'b01;
		addr_fd = instruction[10:6]+1;		
		nextstate = over;
	end //end of case 'addps_write2'

	subps_write1:
	begin
		read = 0; write = 2'b01;
		addr_fd = instruction[10:6];		
		nextstate = subps_read2;
	end //end of case 'subps_write1'

	subps_write2:
	begin
		read = 0; write = 2'b01;
		addr_fd = instruction[10:6]+1;		
		nextstate = over;
	end //end of case 'subps_write2'

	mulps_write1:
	begin
		read = 0; write = 2'b01;
		addr_fd = instruction[10:6];		
		nextstate = mulps_read2;
	end //end of case 'mulps_write1'

	mulps_write2:
	begin
		read = 0; write = 2'b01;
		addr_fd = instruction[10:6]+1;		
		nextstate = over;
	end //end of case 'mulps_write2'

	cvtpss_write_high:
	begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=2'b01;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
		read = 0; write = 1;
		addr_fd = instruction[10:6];		
		nextstate = cvtpss_write_low;
	end //end of case 'cvtpss_write_high'

	cvtpss_write_low:
	begin
		read = 0; write = 0;
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=1;
				enable_cvtpss=2'b10;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
		read = 0; write = 1;
		addr_fd = instruction[10:6]+1;		
		nextstate = over;
	end //end of case 'cvtpss_write_low'

	mfc1_write:
	begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=1;
				enable_mtc1=0;
		read = 0; write = 0; read_gpr = 0; write_gpr = 1;
		addr_fd_gpr = instruction[20:16];		
		nextstate = over;
	end //end of case 'mfc1_write'

	mtc1_write:
	begin
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=1;
		read = 0; read_gpr = 0; write = 1; write_gpr = 0;
		addr_fd = instruction[15:11];		
		nextstate = over;
	end //end of case 'mtc1_write'

	cvtsw_write:
	begin
				
		read = 0; write = 1;
		addr_fd = instruction[10:6];		
		nextstate = over;
	end //end of case 'cvtsw_write'

	cvtws_write:
	begin
				
		read = 0; write = 1;
		addr_fd = instruction[10:6];		
		nextstate = over;
	end //end of case 'cvtws_write'

	cvtspl_write:
	begin
				
		read = 0; write = 1;
		addr_fd = instruction[10:6];		
		nextstate = over;
	end //end of case 'cvtspl_write'

	cvtspu_write:
	begin
				
		read = 0; write = 1;
		addr_fd = instruction[10:6];		
		nextstate = over;
	end //end of case 'cvtspu_write'
//**********************************************************************

	over:
	begin
		read = 0; write = 0;
				enable_adds=0;
				enable_addps=0;
				enable_subs=0;
				enable_subps=0;
				enable_muls=0;
				enable_mulps=0;
				enable_divs=0;
				enable_cvtpss=0;
				enable_cvtsw=0;
				enable_cvtws=0;
				enable_cvtspl=0;
				enable_cvtspu=0;
				enable_lui=0;
				enable_ori=0;
				enable_mfc1=0;
				enable_mtc1=0;
		if (cmp_instruction == instruction) nextstate = over;
		else nextstate = decode;
	end //end of case 'over'
endcase

end
end

endmodule
