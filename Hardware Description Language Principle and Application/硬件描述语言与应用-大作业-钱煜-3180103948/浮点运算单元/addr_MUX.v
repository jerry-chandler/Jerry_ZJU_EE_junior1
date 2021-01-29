module addr_MUX(
clk,
rst,
w_data_adds,
w_data_subs,
w_data_muls,
w_data_divs,
w_data_cvtpss,
w_data_mtc1,
w_data_addps,
w_data_subps,
w_data_mulps,
w_data_cvt0,
w_data_cvtspl,
w_data_cvtspu,
addr,
zout
);

input clk;
input rst;
input [3:0] addr;
input [31:0] w_data_adds;
input [31:0] w_data_subs;
input [31:0] w_data_muls;
input [31:0] w_data_divs;
//input [31:0] w_data_cvt;
input [31:0] w_data_cvtpss;
input [31:0] w_data_mtc1;
input [31:0] w_data_addps;
input [31:0] w_data_subps;
input [31:0] w_data_mulps;
input [31:0] w_data_cvt0;
input [31:0] w_data_cvtspl;
input [31:0] w_data_cvtspu;
output reg [31:0] zout;

always @(posedge clk)begin

	if (!rst) zout=0;
	else if (addr == 4'b0001) zout = w_data_adds;
	else if (addr == 4'b0010) zout = w_data_addps;
        else if (addr == 4'b0011) zout = w_data_subs;
        else if (addr == 4'b0100) zout = w_data_subps;
        else if (addr == 4'b0101) zout = w_data_muls;
        else if (addr == 4'b0110) zout = w_data_mulps;
        else if (addr == 4'b0111) zout = w_data_divs;
        else if (addr == 4'b1000) zout = w_data_cvtpss;
        else if (addr == 4'b1001) zout = w_data_cvt0;
        else if (addr == 4'b1010) zout = w_data_cvtspl;
        else if (addr == 4'b1011) zout = w_data_cvtspu;
        //else if (addr == 4'b1100) zout = 0; //lui
        //else if (addr == 4'b1101) zout = 0; //ori
        //else if (addr == 4'b1110) zout = 0; //mfc1
        else if (addr == 4'b1111) zout = w_data_mtc1;
	else zout = 0;

end
endmodule
