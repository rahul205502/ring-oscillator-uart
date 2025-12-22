`timescale 1ns/1ps

module latch_register ( input window_done, input [7:0]count, input clk, input rst_n, output reg [7:0] latch_count);

    always @(posedge clk or negedge rst_n) begin 
        if(!rst_n) begin
            latch_count <= 8'b0;
        end
        else begin 
            if (window_done) begin
                latch_count <= count;
            end
        end
    end
    
endmodule