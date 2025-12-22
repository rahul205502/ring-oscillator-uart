`timescale 1ns/1ps

module FF2 (input ro_in, input clk, input rst_n, output reg ro_out );
    
    reg f1;
    always @( posedge clk or negedge rst_n ) begin
        if (!rst_n) begin
            f1 <= 1'b0;
            ro_out <= 1'b0;
        end
        else begin
            f1 <= ro_in;
            ro_out <= f1;
        end
    end
endmodule