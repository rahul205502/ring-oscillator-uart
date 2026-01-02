`timescale 1ns/1ps

module latch_register ( input window_done, input [7:0]count, input clk, input en, output reg [7:0] latch_count);

    always @(posedge clk or posedge en) begin 
        if(en) begin
           if (window_done) begin
               latch_count <= count;
           end 
        end
        else begin 
            latch_count <= 8'b0;
        end
    end
    
endmodule
