// Matthew O'Connor & Sean Phelps
// ECE 287 Final Project
// Seven Segment .v file used for seven segment display
module final_project_seven_seg (score, seg7_dig0, seg7_dig1, seg7_dig2);
	input [6:0] score;
	output [6:0] seg7_dig0;
	output [6:0] seg7_dig1;
	output [6:0] seg7_dig2;
	
	reg [3:0] result_one_digit;
	reg [3:0] result_ten_digit;
	reg [3:0] result_hundred_digit;
	
	// Combinational block to handle msb, lsb, and middle digit
	always @(*) begin
		result_one_digit = score % 10;
		result_ten_digit = (score / 10) % 10;
		result_hundred_digit = score / 100;
	end
	
	// Separate instantiations of the seven segment display module
	final_project_seven_seg_disp lsb(result_one_digit, seg7_dig0);
	final_project_seven_seg_disp mid_dig(result_ten_digit, seg7_dig1);
	final_project_seven_seg_disp msb(result_hundred_digit, seg7_dig2);
	
endmodule