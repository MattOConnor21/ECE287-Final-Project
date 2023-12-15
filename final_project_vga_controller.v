// Matthew O'Connor & Sean Phelps
// ECE 287 Final Project
// Credit of VGA file creation to Huan Dang as he created initial file and I modified for my needs
module final_project_vga_controller (
    input wire clk_50, // 50 MHz system clock
    input wire rst,       // Reset input
    output reg clk_25, // 25 MHz clock output
    output reg hsync,     // Horizontal sync output
    output reg vsync,     // Vertical sync output
    output reg [9:0] h_count = 0,
    output reg [9:0] v_count = 0
);

    // Clock divider to generate 25 MHz clock from 50 MHz clock
    always @(posedge clk_50) begin
        if (rst) begin
            clk_25 <= 0;
        end else begin
            clk_25 <= ~clk_25;
        end
    end

    // VGA parameters for 640x480 resolution
    parameter h_front_porch = 16;
    parameter h_sync_pulse = 96;
    parameter h_back_porch = 48;
    parameter h_total_pixels = 800;

    parameter v_front_porch = 10;
    parameter v_sync_pulse = 2;
    parameter v_back_porch = 33;
    parameter v_total_lines = 525;

	 reg [9:0] note_top = 0;
	 reg [9:0] note_bottom = 80;
	 reg [9:0] flag = 0;

    // Updating horizontal and vertical counters
    always @(posedge clk_25 or posedge rst) begin
        if (rst) begin
            h_count <= 0;
            v_count <= 0;
				note_top <= 0;
				note_bottom <= 80;
        end else begin
            if (h_count < h_total_pixels - 1) begin
                h_count <= h_count + 1;
            end else begin
                h_count <= 0;
                if (v_count < v_total_lines - 1) begin
                    v_count <= v_count + 1;
                end else begin
                    v_count <= 0;
                end
            end
				
				if (flag == 5) begin
					flag <= 0;
					if (note_top > 445) begin
						note_top <= 0;
						note_bottom <= 0;
					end else begin
						note_top <= note_top + 1;
						note_bottom <= note_bottom + 1;
					end
				end else begin
					flag <= flag + 1;
				end
        end
    end

    // Generating hsync and vsync signals
    always @(*) begin
        hsync = ~(h_count < h_sync_pulse);
        vsync = ~(v_count < v_sync_pulse);
    end

	 parameter empty_space = 80; 
    // Defining the display area
    wire display_active = (h_count >= h_sync_pulse + h_back_porch + empty_space) &&
                          (h_count < h_total_pixels - h_front_porch - empty_space) &&
                          (v_count >= v_sync_pulse + v_back_porch) &&
                          (v_count < v_total_lines - v_front_porch);

	 // logic for the border
	 reg border_loc;
	 always @(*)
	 begin
		border_loc = (v_count <= v_sync_pulse + v_back_porch + 10) ||
						 (v_count >= v_total_lines - v_front_porch - 10)||
						 (h_count <= h_sync_pulse + h_back_porch + 10 + empty_space)||
						 (h_count >= h_total_pixels - h_front_porch - 10 - empty_space); 
	 end
	
endmodule
