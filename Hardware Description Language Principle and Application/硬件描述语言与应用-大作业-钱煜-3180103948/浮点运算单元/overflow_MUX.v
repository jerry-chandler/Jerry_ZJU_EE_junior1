module overflow_MUX(
clk,
rst,
adds_overflow,
subs_overflow,
muls_overflow,
divs_overflow,
cvtpss_overflow,
mtc1_overflow,
addps_overflow,
subps_overflow,
mulps_overflow,
cvt0_overflow,
cvtspl_overflow,
cvtspu_overflow,
addr,
overflow,
mfc1_overflow
);

input clk;
input rst;
input [3:0] addr;
input [1:0] adds_overflow;
input [1:0] subs_overflow;
input [1:0] muls_overflow;
input [1:0] divs_overflow;
//input [1:0] cvt;
input [1:0] cvtpss_overflow;
input [1:0] mtc1_overflow;
input [1:0] addps_overflow;
input [1:0] subps_overflow;
input [1:0] mulps_overflow;
input [1:0] cvt0_overflow;
input [1:0] cvtspl_overflow;
input [1:0] cvtspu_overflow;
input [1:0] mfc1_overflow;
output reg [1:0] overflow;

always @(posedge clk)begin

	if (!rst) overflow=0;
	else if (addr == 4'b0001) overflow = adds_overflow;
	else if (addr == 4'b0010) overflow = addps_overflow;
        else if (addr == 4'b0011) overflow = subs_overflow;
        else if (addr == 4'b0100) overflow = subps_overflow;
        else if (addr == 4'b0101) overflow = muls_overflow;
        else if (addr == 4'b0110) overflow = mulps_overflow;
        else if (addr == 4'b0111) overflow = divs_overflow;
        else if (addr == 4'b1000) overflow = cvtpss_overflow;
        else if (addr == 4'b1001) overflow = cvt0_overflow;
        else if (addr == 4'b1010) overflow = cvtspl_overflow;
        else if (addr == 4'b1011) overflow = cvtspu_overflow;
        //else if (addr == 4'b1100) overflow = 0; //lui
        //else if (addr == 4'b1101) overflow = 0; //ori
        else if (addr == 4'b1110) overflow = mfc1_overflow; //mfc1
        else if (addr == 4'b1111) overflow = mtc1_overflow;
	else overflow = 0;

end
endmodule
