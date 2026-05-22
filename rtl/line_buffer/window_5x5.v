module window_5x5 #(
    parameter DW    = 8,    // data width
    parameter IMG_W = 32    // image width
)(
    input                clk, rst_n, data_valid,
    input  [DW-1:0]      din,
    output [DW-1:0] p11, p12, p13, p14, p15,
    output [DW-1:0] p21, p22, p23, p24, p25,
    output [DW-1:0] p31, p32, p33, p34, p35,
    output [DW-1:0] p41, p42, p43, p44, p45,
    output [DW-1:0] p51, p52, p53, p54, p55
);
    reg [DW-1:0] line_buf1 [0:IMG_W-1];
    reg [DW-1:0] line_buf2 [0:IMG_W-1];
    reg [DW-1:0] line_buf3 [0:IMG_W-1];
    reg [DW-1:0] line_buf4 [0:IMG_W-1];

    reg [DW-1:0] w11, w12, w13, w14, w15;
    reg [DW-1:0] w21, w22, w23, w24, w25;
    reg [DW-1:0] w31, w32, w33, w34, w35;
    reg [DW-1:0] w41, w42, w43, w44, w45;
    reg [DW-1:0] w51, w52, w53, w54, w55;

    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            w11<=0; w12<=0; w13<=0; w14<=0; w15<=0;
            w21<=0; w22<=0; w23<=0; w24<=0; w25<=0;
            w31<=0; w32<=0; w33<=0; w34<=0; w35<=0;
            w41<=0; w42<=0; w43<=0; w44<=0; w45<=0;
            w51<=0; w52<=0; w53<=0; w54<=0; w55<=0;
            for (i = 0; i < IMG_W; i = i+1) begin
                line_buf1[i] <= 0;
                line_buf2[i] <= 0;
                line_buf3[i] <= 0;
                line_buf4[i] <= 0;
            end
        end else if (data_valid) begin
            line_buf1[0] <= din;
            for (i = 0; i < IMG_W-1; i = i+1)
                line_buf1[i+1] <= line_buf1[i];

            line_buf2[0] <= line_buf1[IMG_W-1];
            for (i = 0; i < IMG_W-1; i = i+1)
                line_buf2[i+1] <= line_buf2[i];

            line_buf3[0] <= line_buf2[IMG_W-1];
            for (i = 0; i < IMG_W-1; i = i+1)
                line_buf3[i+1] <= line_buf3[i];

            line_buf4[0] <= line_buf3[IMG_W-1];
            for (i = 0; i < IMG_W-1; i = i+1)
                line_buf4[i+1] <= line_buf4[i];

            w55<=din;                    w54<=w55; w53<=w54; w52<=w53; w51<=w52;
            w45<=line_buf1[IMG_W-1];     w44<=w45; w43<=w44; w42<=w43; w41<=w42;
            w35<=line_buf2[IMG_W-1];     w34<=w35; w33<=w34; w32<=w33; w31<=w32;
            w25<=line_buf3[IMG_W-1];     w24<=w25; w23<=w24; w22<=w23; w21<=w22;
            w15<=line_buf4[IMG_W-1];     w14<=w15; w13<=w14; w12<=w13; w11<=w12;
        end
    end

    assign p11=w11; assign p12=w12; assign p13=w13; assign p14=w14; assign p15=w15;
    assign p21=w21; assign p22=w22; assign p23=w23; assign p24=w24; assign p25=w25;
    assign p31=w31; assign p32=w32; assign p33=w33; assign p34=w34; assign p35=w35;
    assign p41=w41; assign p42=w42; assign p43=w43; assign p44=w44; assign p45=w45;
    assign p51=w51; assign p52=w52; assign p53=w53; assign p54=w54; assign p55=w55;

endmodule