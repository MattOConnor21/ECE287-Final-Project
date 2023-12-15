// Matthew O'Connor & Sean Phelps
// ECE 287 Final Project
// Controller .v file to manage FSMs 
module final_project_main_control (sw, clk, rst, en_draw, en_play, en_erase);
	input [9:0] sw;
	input clk, rst;
	output reg en_draw, en_play, en_erase;
	
	reg ready_draw, ready_erase, ready_play;
	
	reg [2:0] S;
	reg [2:0] NS;
	
	// Utilizing 5 different states
	localparam IDLE = 3'b000,
		DRAW = 3'b001,
		PLAY = 3'b010,
		ERASE = 3'b011,
		UPDATE = 3'b100;
	
	// Sequential block to manage current State 
	always @(posedge clk or posedge rst) begin
		if (rst == 1'b1)
			S <= IDLE;
		else
			S <= NS;
	end
	
	// Combinational block to manage Next State
	always @(*) begin
		case(S)
			IDLE: NS = (sw[0] & ~sw[1] & ~sw[2]) ? DRAW : IDLE;
			DRAW: NS = (sw[1] & sw[0] & ~sw[2]) ? PLAY : DRAW;
			PLAY: NS = (sw[2] & sw[0] & sw[1]) ? ERASE : PLAY;
			ERASE: NS = UPDATE;
			UPDATE: NS = IDLE;
		endcase
	end
	
	// Cominational block to manage signals with case statements for drawing, playing, and erasing
	always @(*) begin
		en_draw = 1'b0;
		en_play = 1'b0;
		en_erase = 1'b0;
		
		case(S)
			IDLE: begin
				en_draw = 1'b0;
				en_play = 1'b0;
				en_erase = 1'b0;
			end
			DRAW: begin
				en_draw = 1'b1;
				en_play = 1'b0;
				en_erase = 1'b0;
			end
			PLAY: begin
				en_draw = 1'b1;
				en_play = 1'b1;
				en_erase = 1'b0;
			end
			ERASE: begin
				en_draw = 1'b0;
				en_play = 1'b0;
				en_erase = 1'b1;
			end
			UPDATE: begin
				en_draw = 1'b0;
				en_play = 1'b0;
				en_erase = 1'b0;
			end
		endcase
	end	
endmodule