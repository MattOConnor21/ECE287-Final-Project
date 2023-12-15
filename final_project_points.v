module final_project_points(clk, rst, key, y1, y2, y3, seg7_dig0, seg7_dig1, seg7_dig2); // calc middle of box, if in line then increment seven seg
	input clk;
	input rst;
	input [3:0] key;
	input [9:0] y1;
	input [9:0] y2;
	input [9:0] y3;
	output [6:0] seg7_dig0;
	output [6:0] seg7_dig1;
	output [6:0] seg7_dig2;
	
	reg [6:0] score;
	
	always @(posedge clk) begin
		if (rst == 1'b1)
			score <= 0;
		else begin
			if (key[3] == 1'b0) begin
				if (y1 + 15 >= 414 & y1 - 15 <= 424)
					score <= score + 1;
			end
			
			if (key[2] == 1'b0) begin 
				if (y2 + 15 >= 414 & y2 - 15 <= 424)
					score <= score + 1;
			end
			
			if (key[1] == 1'b0) begin 
				if (y3 + 15 >= 414 & y3 - 15 <= 424)
					score <= score + 1;
			end
		end
	end
	
//	final_project_seven_seg_disp seg_disp (
//		.i
	final_project_seven_seg score_disp (
		.score(score),
		.seg7_dig0(seg7_dig0),
		.seg7_dig1(seg7_dig1),
		.seg7_dig2(seg7_dig2));
	
endmodule