// 32*32 Memory model: Depth is 32, width is 32-bit
module memory_fpu(
clock,
rst,
write,
read,
addr_ft,
addr_fs,
addr_fd,
w_data,
r_data_ft,
r_data_fs,
imm_data
);

input           clock;
input           rst;
input  [4:0]    addr_ft;
input  [4:0]    addr_fs;
input  [4:0]    addr_fd;
input  [1:0]    read;
input  [1:0]	write;
input  [31:0]   w_data;
input  [31:0]   imm_data;
output reg [31:0]   r_data_ft;
output reg [31:0]   r_data_fs;


reg    [31:0]   data_cell[31:0];
reg    [31:0]   temp;
//reg    [31:0]   rdata;

//write operation
always@(posedge clock)
begin
	if (!rst) begin data_cell[0] = 0; data_cell[1] = 0; data_cell[2] = 0; data_cell[3] = 0; data_cell[4] = 0; data_cell[5] = 0; data_cell[6] = 0; data_cell[7] = 0; data_cell[8] = 0; data_cell[9] = 0; data_cell[10] = 0; data_cell[11] = 0; data_cell[12] = 0; data_cell[13] = 0; data_cell[14] = 0; data_cell[15] = 0; data_cell[16] = 0; data_cell[17] = 0; data_cell[18] = 0; data_cell[19] = 0; data_cell[20] = 0; data_cell[21] = 0; data_cell[22] = 0; data_cell[23] = 0; data_cell[24] = 0; data_cell[25] = 0; data_cell[26] = 0; data_cell[27] = 0; data_cell[28] = 0; data_cell[29] = 0; data_cell[30] = 32'b00000000000000000000000000000011; data_cell[31] = 32'b01000000010000000000000000000000;r_data_ft=0;r_data_fs=0;end
	else if (write == 2'b01) begin
                                if (addr_fd == 0) data_cell[0] = w_data;
                                else if (addr_fd == 1) data_cell[1] = w_data;
                                else if (addr_fd == 2) data_cell[2] = w_data;
                                else if (addr_fd == 3) data_cell[3] = w_data;
                                else if (addr_fd == 4) data_cell[4] = w_data;
                                else if (addr_fd == 5) data_cell[5] = w_data;
                                else if (addr_fd == 6) data_cell[6] = w_data;
                                else if (addr_fd == 7) data_cell[7] = w_data;
                                else if (addr_fd == 8) data_cell[8] = w_data;
                                else if (addr_fd == 9) data_cell[9] = w_data;
                                else if (addr_fd == 10) data_cell[10] = w_data;
                                else if (addr_fd == 11) data_cell[11] = w_data;
                                else if (addr_fd == 12) data_cell[12] = w_data;
                                else if (addr_fd == 13) data_cell[13] = w_data;
                                else if (addr_fd == 14) data_cell[14] = w_data;
                                else if (addr_fd == 15) data_cell[15] = w_data;
                                else if (addr_fd == 16) data_cell[16] = w_data;
                                else if (addr_fd == 17) data_cell[17] = w_data;
                                else if (addr_fd == 18) data_cell[18] = w_data;
                                else if (addr_fd == 19) data_cell[19] = w_data;
                                else if (addr_fd == 20) data_cell[20] = w_data;
                                else if (addr_fd == 21) data_cell[21] = w_data;
                                else if (addr_fd == 22) data_cell[22] = w_data;
                                else if (addr_fd == 23) data_cell[23] = w_data;
                                else if (addr_fd == 24) data_cell[24] = w_data;
                                else if (addr_fd == 25) data_cell[25] = w_data;
                                else if (addr_fd == 26) data_cell[26] = w_data;
                                else if (addr_fd == 27) data_cell[27] = w_data;
                                else if (addr_fd == 28) data_cell[28] = w_data;
                                else if (addr_fd == 29) data_cell[29] = w_data;
                                else if (addr_fd == 30) data_cell[30] = w_data;
                                else  data_cell[31] = w_data;
			
			end

	else if (read == 2'b01) begin
                                if (addr_ft == 0) r_data_ft = data_cell[0];
                                else if (addr_ft == 1) r_data_ft = data_cell[1];
                                else if (addr_ft == 2) r_data_ft = data_cell[2];
                                else if (addr_ft == 3) r_data_ft = data_cell[3];
                                else if (addr_ft == 4) r_data_ft = data_cell[4];
                                else if (addr_ft == 5) r_data_ft = data_cell[5];
                                else if (addr_ft == 6) r_data_ft = data_cell[6];
                                else if (addr_ft == 7) r_data_ft = data_cell[7];
                                else if (addr_ft == 8) r_data_ft = data_cell[8];
                                else if (addr_ft == 9) r_data_ft = data_cell[9];
                                else if (addr_ft == 10) r_data_ft = data_cell[10];
                                else if (addr_ft == 11) r_data_ft = data_cell[11];
                                else if (addr_ft == 12) r_data_ft = data_cell[12];
                                else if (addr_ft == 13) r_data_ft = data_cell[13];
                                else if (addr_ft == 14) r_data_ft = data_cell[14];
                                else if (addr_ft == 15) r_data_ft = data_cell[15];
                                else if (addr_ft == 16) r_data_ft = data_cell[16];
                                else if (addr_ft == 17) r_data_ft = data_cell[17];
                                else if (addr_ft == 18) r_data_ft = data_cell[18];
                                else if (addr_ft == 19) r_data_ft = data_cell[19];
                                else if (addr_ft == 20) r_data_ft = data_cell[20];
                                else if (addr_ft == 21) r_data_ft = data_cell[21];
                                else if (addr_ft == 22) r_data_ft = data_cell[22];
                                else if (addr_ft == 23) r_data_ft = data_cell[23];
                                else if (addr_ft == 24) r_data_ft = data_cell[24];
                                else if (addr_ft == 25) r_data_ft = data_cell[25];
                                else if (addr_ft == 26) r_data_ft = data_cell[26];
                                else if (addr_ft == 27) r_data_ft = data_cell[27];
                                else if (addr_ft == 28) r_data_ft = data_cell[28];
                                else if (addr_ft == 29) r_data_ft = data_cell[29];
                                else if (addr_ft == 30) r_data_ft = data_cell[30];
                                else  r_data_ft = data_cell[31];

                                if (addr_fs == 0) r_data_fs = data_cell[0];
                                else if (addr_fs == 1) r_data_fs = data_cell[1];
                                else if (addr_fs == 2) r_data_fs = data_cell[2];
                                else if (addr_fs == 3) r_data_fs = data_cell[3];
                                else if (addr_fs == 4) r_data_fs = data_cell[4];
                                else if (addr_fs == 5) r_data_fs = data_cell[5];
                                else if (addr_fs == 6) r_data_fs = data_cell[6];
                                else if (addr_fs == 7) r_data_fs = data_cell[7];
                                else if (addr_fs == 8) r_data_fs = data_cell[8];
                                else if (addr_fs == 9) r_data_fs = data_cell[9];
                                else if (addr_fs == 10) r_data_fs = data_cell[10];
                                else if (addr_fs == 11) r_data_fs = data_cell[11];
                                else if (addr_fs == 12) r_data_fs = data_cell[12];
                                else if (addr_fs == 13) r_data_fs = data_cell[13];
                                else if (addr_fs == 14) r_data_fs = data_cell[14];
                                else if (addr_fs == 15) r_data_fs = data_cell[15];
                                else if (addr_fs == 16) r_data_fs = data_cell[16];
                                else if (addr_fs == 17) r_data_fs = data_cell[17];
                                else if (addr_fs == 18) r_data_fs = data_cell[18];
                                else if (addr_fs == 19) r_data_fs = data_cell[19];
                                else if (addr_fs == 20) r_data_fs = data_cell[20];
                                else if (addr_fs == 21) r_data_fs = data_cell[21];
                                else if (addr_fs == 22) r_data_fs = data_cell[22];
                                else if (addr_fs == 23) r_data_fs = data_cell[23];
                                else if (addr_fs == 24) r_data_fs = data_cell[24];
                                else if (addr_fs == 25) r_data_fs = data_cell[25];
                                else if (addr_fs == 26) r_data_fs = data_cell[26];
                                else if (addr_fs == 27) r_data_fs = data_cell[27];
                                else if (addr_fs == 28) r_data_fs = data_cell[28];
                                else if (addr_fs == 29) r_data_fs = data_cell[29];
                                else if (addr_fs == 30) r_data_fs = data_cell[30];
                                else r_data_fs = data_cell[31];

			end
		
	else if (write == 2'b10) //lui case
				begin
				
				if (addr_fd == 0) data_cell[0] = imm_data;
                                else if (addr_fd == 1) data_cell[1] = imm_data;
                                else if (addr_fd == 2) data_cell[2] = imm_data;
                                else if (addr_fd == 3) data_cell[3] = imm_data;
                                else if (addr_fd == 4) data_cell[4] = imm_data;
                                else if (addr_fd == 5) data_cell[5] = imm_data;
                                else if (addr_fd == 6) data_cell[6] = imm_data;
                                else if (addr_fd == 7) data_cell[7] = imm_data;
                                else if (addr_fd == 8) data_cell[8] = imm_data;
                                else if (addr_fd == 9) data_cell[9] = imm_data;
                                else if (addr_fd == 10) data_cell[10] = imm_data;
                                else if (addr_fd == 11) data_cell[11] = imm_data;
                                else if (addr_fd == 12) data_cell[12] = imm_data;
                                else if (addr_fd == 13) data_cell[13] = imm_data;
                                else if (addr_fd == 14) data_cell[14] = imm_data;
                                else if (addr_fd == 15) data_cell[15] = imm_data;
                                else if (addr_fd == 16) data_cell[16] = imm_data;
                                else if (addr_fd == 17) data_cell[17] = imm_data;
                                else if (addr_fd == 18) data_cell[18] = imm_data;
                                else if (addr_fd == 19) data_cell[19] = imm_data;
                                else if (addr_fd == 20) data_cell[20] = imm_data;
                                else if (addr_fd == 21) data_cell[21] = imm_data;
                                else if (addr_fd == 22) data_cell[22] = imm_data;
                                else if (addr_fd == 23) data_cell[23] = imm_data;
                                else if (addr_fd == 24) data_cell[24] = imm_data;
                                else if (addr_fd == 25) data_cell[25] = imm_data;
                                else if (addr_fd == 26) data_cell[26] = imm_data;
                                else if (addr_fd == 27) data_cell[27] = imm_data;
                                else if (addr_fd == 28) data_cell[28] = imm_data;
                                else if (addr_fd == 29) data_cell[29] = imm_data;
                                else if (addr_fd == 30) data_cell[30] = imm_data;
                                else  data_cell[31] = imm_data;

				end

	else if (write == 2'b11) //ori case: get fs in temp, then write
				begin

                                if (addr_fs == 0) temp = data_cell[0];
                                else if (addr_fs == 1) temp = data_cell[1];
                                else if (addr_fs == 2) temp = data_cell[2];
                                else if (addr_fs == 3) temp = data_cell[3];
                                else if (addr_fs == 4) temp = data_cell[4];
                                else if (addr_fs == 5) temp = data_cell[5];
                                else if (addr_fs == 6) temp = data_cell[6];
                                else if (addr_fs == 7) temp = data_cell[7];
                                else if (addr_fs == 8) temp = data_cell[8];
                                else if (addr_fs == 9) temp = data_cell[9];
                                else if (addr_fs == 10) temp = data_cell[10];
                                else if (addr_fs == 11) temp = data_cell[11];
                                else if (addr_fs == 12) temp = data_cell[12];
                                else if (addr_fs == 13) temp = data_cell[13];
                                else if (addr_fs == 14) temp = data_cell[14];
                                else if (addr_fs == 15) temp = data_cell[15];
                                else if (addr_fs == 16) temp = data_cell[16];
                                else if (addr_fs == 17) temp = data_cell[17];
                                else if (addr_fs == 18) temp = data_cell[18];
                                else if (addr_fs == 19) temp = data_cell[19];
                                else if (addr_fs == 20) temp = data_cell[20];
                                else if (addr_fs == 21) temp = data_cell[21];
                                else if (addr_fs == 22) temp = data_cell[22];
                                else if (addr_fs == 23) temp = data_cell[23];
                                else if (addr_fs == 24) temp = data_cell[24];
                                else if (addr_fs == 25) temp = data_cell[25];
                                else if (addr_fs == 26) temp = data_cell[26];
                                else if (addr_fs == 27) temp = data_cell[27];
                                else if (addr_fs == 28) temp = data_cell[28];
                                else if (addr_fs == 29) temp = data_cell[29];
                                else if (addr_fs == 30) temp = data_cell[30];
                                else temp = data_cell[31];

				if (addr_fd == 0) data_cell[0] = imm_data |  temp;
                                else if (addr_fd == 1) data_cell[1] = imm_data |  temp;
                                else if (addr_fd == 2) data_cell[2] = imm_data |  temp;
                                else if (addr_fd == 3) data_cell[3] = imm_data |  temp;
                                else if (addr_fd == 4) data_cell[4] = imm_data |  temp;
                                else if (addr_fd == 5) data_cell[5] = imm_data |  temp;
                                else if (addr_fd == 6) data_cell[6] = imm_data |  temp;
                                else if (addr_fd == 7) data_cell[7] = imm_data |  temp;
                                else if (addr_fd == 8) data_cell[8] = imm_data |  temp;
                                else if (addr_fd == 9) data_cell[9] = imm_data |  temp;
                                else if (addr_fd == 10) data_cell[10] = imm_data |  temp;
                                else if (addr_fd == 11) data_cell[11] = imm_data |  temp;
                                else if (addr_fd == 12) data_cell[12] = imm_data |  temp;
                                else if (addr_fd == 13) data_cell[13] = imm_data |  temp;
                                else if (addr_fd == 14) data_cell[14] = imm_data |  temp;
                                else if (addr_fd == 15) data_cell[15] = imm_data |  temp;
                                else if (addr_fd == 16) data_cell[16] = imm_data |  temp;
                                else if (addr_fd == 17) data_cell[17] = imm_data |  temp;
                                else if (addr_fd == 18) data_cell[18] = imm_data |  temp;
                                else if (addr_fd == 19) data_cell[19] = imm_data |  temp;
                                else if (addr_fd == 20) data_cell[20] = imm_data |  temp;
                                else if (addr_fd == 21) data_cell[21] = imm_data |  temp;
                                else if (addr_fd == 22) data_cell[22] = imm_data |  temp;
                                else if (addr_fd == 23) data_cell[23] = imm_data |  temp;
                                else if (addr_fd == 24) data_cell[24] = imm_data |  temp;
                                else if (addr_fd == 25) data_cell[25] = imm_data |  temp;
                                else if (addr_fd == 26) data_cell[26] = imm_data |  temp;
                                else if (addr_fd == 27) data_cell[27] = imm_data |  temp;
                                else if (addr_fd == 28) data_cell[28] = imm_data |  temp;
                                else if (addr_fd == 29) data_cell[29] = imm_data |  temp;
                                else if (addr_fd == 30) data_cell[30] = imm_data |  temp;
                                else  data_cell[31] = imm_data |  temp;



				end
		
	else begin  data_cell[0] =  data_cell[0]; end

end
endmodule
