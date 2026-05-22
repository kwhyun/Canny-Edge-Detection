`timescale 1ns / 1ps

module window_3x3 #(
    parameter DW    = 8,    // data width
    parameter IMG_W = 32    // image width
)(
    input              clk, rst_n, data_valid,
    input  [DW-1:0]    din,
    output [DW-1:0]    p11, p12, p13,
    output [DW-1:0]    p21, p22, p23,
    output [DW-1:0]    p31, p32, p33
);
    reg [DW-1:0] line_buf_1 [0:IMG_W-1];
    reg [DW-1:0] line_buf_2 [0:IMG_W-1];

    reg [DW-1:0] w11, w12, w13;
    reg [DW-1:0] w21, w22, w23;
    reg [DW-1:0] w31, w32, w33;

    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            w11<=0; w12<=0; w13<=0;
            w21<=0; w22<=0; w23<=0;
            w31<=0; w32<=0; w33<=0;
            for (i = 0; i < IMG_W; i = i+1) begin
                line_buf_1[i] <= 0;
                line_buf_2[i] <= 0;
            end
        end else if (data_valid) begin
            line_buf_2[0] <= din;
            for (i = 0; i < IMG_W-1; i = i+1)
                line_buf_2[i+1] <= line_buf_2[i];

            line_buf_1[0] <= line_buf_2[IMG_W-1];
            for (i = 0; i < IMG_W-1; i = i+1)
                line_buf_1[i+1] <= line_buf_1[i];

            w33 <= din;                  w32 <= w33; w31 <= w32;
            w23 <= line_buf_2[IMG_W-1]; w22 <= w23; w21 <= w22;
            w13 <= line_buf_1[IMG_W-1]; w12 <= w13; w11 <= w12;
        end
    end

    assign p11=w11; assign p12=w12; assign p13=w13;
    assign p21=w21; assign p22=w22; assign p23=w23;
    assign p31=w31; assign p32=w32; assign p33=w33;

endmodule