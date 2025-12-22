`timescale 1ns/1ps
module edge_counter ( input clk, input rst_n, input edge_chk, output reg [7:0]count );

    always @ (posedge clk or negedge rst_n ) begin 
     if (!rst_n) begin
        count <= 8'b0;
     end
     else begin
        if(edge_chk) begin
            count <= count + 1'b1;
        end
      end
      end
      
endmodule
     