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

	wire rst;
	assign rst = SW[4];

	wire [2:0]colour;
	wire [7:0]x;
	wire [6:0]y;
	wire [2:0] first_three_sw;
	wire writteEn;

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
		
	
//	wire en_count, draw, erase, reset_counter, reset_draw, done_wait, done_flag, en_delay;
//	reg [2:0] S;
//	reg [2:0] NS;
	assign LEDR[3:0] = KEY[3:0];
//	reg en_draw, en_play;
//	
//	localparam IDLE = 3'b000,
//		DRAW = 3'b001,
//		WAIT = 3'b010,
//		PLAY = 3'b011,
//		ERASE = 3'b100,
//		UPDATE = 3'b101;
//		
//	always @(posedge CLOCK_50 or negedge rst) begin
//		if (rst == 1'b1)
//			S <= IDLE;
//		else
//			S <= NS;
//	end
//	
//	always @(*) begin
//		case(S)
//			IDLE: NS = SW[0] ? DRAW : IDLE;
//			DRAW: NS = ~SW[0] ? PLAY : IDLE;
//			WAIT: NS = SW[1] ? PLAY : IDLE;
//			PLAY: NS = ~SW[1] ? ERASE : PLAY;
//			ERASE: NS = UPDATE;
//			UPDATE: NS = DRAW;
//		endcase
//	end
//	
//	always @(*) begin
//		en_draw = 1'b0;
//		en_play = 1'b0;
//		case(S)
//			IDLE: begin
//				en_draw = 1'b0;
//				en_play = 1'b0;
//			end
//			DRAW: begin
//				en_draw = 1'b1;
//				en_play = 1'b0;
//			end
//			WAIT: begin
//				en_draw = 1'b0;
//				en_play = 1'b0;
//			end
//			PLAY: begin
//				en_draw = 1'b0;
//				en_play = 1'b1;
//			end
//			ERASE: begin
//				en_draw = 1'b0;
//				en_play = 1'b0;
//			end
//			UPDATE: begin
//				en_draw = 1'b0;
//				en_play = 1'b0;
//			end
//		endcase
//	end	
	
	// 1 state for DRAW which draws the board but nothing else happens
	// 1 state for PLAY which drops the note(s) & lets you increment score
	// 1 state for ERASE/RST which clears the board
	// 1 state for UPDATE which brings us back to draw
	
	// DRAW relies on a switch to flip on to go to PLAY else remains at DRAW
	// PLAY requires the switch that flipped on to be flipped off to go to ERASE/RST else stay in play (if it wont let me do that then flip a different switch)
	// UPDATE will go to draw once all switches are off 
		
endmodule