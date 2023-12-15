// Matthew O'Connor & Sean Phelps

module final_project_seven_seg_disp (
input [3:0]i,
output reg [6:0]o
);


// HEX out - rewire DE2
//  ---a---
// |       |
// f       b
// |       |
//  ---g---
// |       |
// e       c
// |       |
//  ---d---

always @(i)begin
    o = 7'b1000000;

    case(i)
        4'd0: o = 7'b1000000;
        4'd1: o = 7'b1111001;
        4'd2: o = 7'b0100100;
        4'd3: o = 7'b0110000;
        4'd4: o = 7'b0011001;
        4'd5: o = 7'b0010010;
        4'd6: o = 7'b0000010;
        4'd7: o = 7'b1111000;
        4'd8: o = 7'b0000000;
        4'd9: o = 7'b0010000;
        default: o = 7'b1000000;
    endcase
end
endmodule