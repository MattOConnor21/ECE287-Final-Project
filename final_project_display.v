// Matthew O'Connor & Sean Phelps
// ECE 287 Final Project
// Display .v file used for drawing with vga & instantiating points and the main controller
module final_project_display (clk_50, rst, sw, key, hex0, hex1, hex2, clk_25, hsync, vsync, red, green, blue);
	input clk_50, rst;
	input [3:0] key;
	input [9:0] sw;
	
	output [6:0] hex0;
	output [6:0] hex1;
	output [6:0] hex2;
	output clk_25;
	output hsync;
	output vsync;
	output reg [7:0] red;
	output reg [7:0] green;
	output reg [7:0] blue;
	
	wire en_play, en_draw, en_erase;
	wire [9:0] x, y;
	reg [9:0] o_x1 = 325;
	reg [9:0] o_x2 = 425;
	reg [9:0] o_x3 = 525;
	reg [9:0] o_y1 = 0;
	reg [9:0] o_y2 = 0;
	reg [9:0] o_y3 = 0;
	reg [63:0] flag = 64'd9999990;
	reg [63:0] counter;
	reg flag1 = 1'd1;
	
	// VGA instantiation
	// h_count & v_count keep track of pixel locations for drawing
	final_project_vga_controller vga (
		.clk_50(clk_50),
		.rst(rst),
		.clk_25(clk_25),
		.hsync(hsync),
		.vsync(vsync),
		.v_count(y),
		.h_count(x));
	
	// Combinational block to draw the 3 columns for notes as well as bar at the bottom
	always @(*) begin
		if (en_erase == 1'b0) begin
			if (y >= 0 && y < 525) begin
				if (x >= 300 && x <= 305) begin
					red = 8'hFF;
					green = 8'hFF;
					blue = 8'hFF;
				end else if (x >= 375 && x <= 380) begin
					red = 8'hFF;
					green = 8'hFF;
					blue = 8'hFF;
				end
				
				else if (x >= 400 && x <= 405) begin
					red = 8'hFF;
					green = 8'hFF;
					blue = 8'hFF;
				end else if (x >= 475 && x <= 480) begin
					red = 8'hFF;
					green = 8'hFF;
					blue = 8'hFF;
				end
				
				else if (x >= 500 && x <= 505) begin
					red = 8'hFF;
					green = 8'hFF;
					blue = 8'hFF;
				end else if (x >= 575 && x <= 580) begin
					red = 8'hFF;
					green = 8'hFF;
					blue = 8'hFF;
				end else begin
					red = 8'h00;
					green = 8'h00;
					blue = 8'h00;
				end
			end
		
			if (x > o_x1 & x < o_x1 + 30 & y > o_y1 & y < o_y1 + 30) begin
				red = 8'hFF;
				green = 8'hFF;
				blue = 8'hFF;
			end
		
			if (x > o_x2 & x < o_x2 + 30 & y > o_y2 & y < o_y2 + 30) begin
				red = 8'hFF;
				green = 8'hFF;
				blue = 8'hFF;
			end
			
			if (x > o_x3 & x < o_x3 + 30 & y > o_y3 & y < o_y3 + 30) begin
				red = 8'hFF;
				green = 8'hFF;
				blue = 8'hFF;
			end
		
			if (y >= 414 && y < 424) begin
				red = 8'hFF;
				green = 8'hFF;
				blue = 8'hFF;
			end
		end else begin
			if (y >= 0 && y < 525) begin
				red = 8'h00;
				green = 8'h00;
				blue = 8'h00;
			end
		end 
	end
	
	// Sequential block to control notes falling down the screen
	// Flag utilized to make notes stop while others run
	always @(posedge clk_50) begin
		if (rst == 1'b1)
			counter <= 64'd0;
		else begin
			if (en_play == 1'b1) begin
				if (counter == 64'd0) begin
					counter <= flag;
					if (o_y1 < 525 && flag1 == 1'd1)
						o_y1 <= o_y1 + 10;
					
					if (o_y2 < 525 && flag1 == 1'd2)
						o_y2 <= o_y2 + 30;
						
					if (o_y3 < 525 && flag1 == 1'd3)
						o_y3 <= o_y3 + 50;
					
					if (o_y1 > 430) begin
						o_y1 <= 50;
						flag1 <= 1'd2;
					end else if (o_y2 > 430) begin
						o_y2 <= 50;
						flag1 <= 1'd3;
					end else if (o_y3 > 430) begin
						o_y3 <= 50;
						flag1 <= 1'd1;
					end
					
				end else
					counter <= counter - 1'b1;
			end else begin
				counter <= 64'd0;
				o_y1 <= 50;
				o_y2 <= 50;
				o_y3 <= 50;
			end
		end
	end
	
	// Points instantiated for score
	final_project_points pts(
		.clk(clk_50),
		.rst(rst),
		.key(key),
		.y1(o_y1),
		.y2(o_y2),
		.y3(o_y3),
		.seg7_dig0(hex0),
		.seg7_dig1(hex1),
		.seg7_dig2(hex2));
	
	// Controller instantiated for FSM
	final_project_main_control cont (
		.sw(sw),
		.clk(clk_50),
		.rst(rst),
		.en_draw(en_draw),
		.en_play(en_play),
		.en_erase(en_erase));
	
endmodule
			