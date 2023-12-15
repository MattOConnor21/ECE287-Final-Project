// Matthew O'Connor & Sean Phelps
// ECE 287 Final Project
// Main .v file to instantiate display
module final_project_main (CLOCK_50, KEY, SW, LEDR, HEX0, HEX1, HEX2, VGA_CLK, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B, VGA_BLANK_N);
	
	input CLOCK_50;
	input [9:0]SW;
	input [3:0]KEY;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [9:0]LEDR;
	
	output VGA_CLK, VGA_HS, VGA_VS;
	output [7:0]VGA_R;
	output [7:0]VGA_G;
	output [7:0]VGA_B;
	output VGA_BLANK_N;
	
	// reset assigned to switch 4
	wire rst;
	assign rst = SW[4];

	// Display instantiated
	final_project_display disp (
		.clk_50(CLOCK_50),
		.rst(rst),
		.key(KEY),
		.sw(SW),
		.hex0(HEX0),
		.hex1(HEX1),
		.hex2(HEX2),
		.clk_25(VGA_CLK),
		.hsync(VGA_HS),
		.vsync(VGA_VS),
		.red(VGA_R),
		.green(VGA_G),
		.blue(VGA_B));
		
endmodule