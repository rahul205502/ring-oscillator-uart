`timescale 1ns/1ps

module window(input clk, input en, output reg window_done );
    
    parameter CLK_SPEED = 100_000_000;
    // parameter MS = 0.1;
    // parameter LIM = (MS*CLK_SPEED)/1000;
    `ifdef SIM
        parameter LIM = 100;
    `else
        parameter LIM = 10_000;
    `endif
    
    reg [31:0]ct;
    always @( posedge clk or posedge en) begin
        if (en) begin
            if (ct == LIM-1) begin
                window_done <= 1'b1;
                ct <= 32'b0;
            end
            else begin
                ct <= ct + 1'b1;
                window_done <= 1'b0; //deassert as it must be 1'b1 for only one clk pulse
            end
        end
        else begin
            window_done <= 1'b0;
            ct <= 32'b0;
        end     
    end
endmodule
