`timescale 1ns/1ps
module edge_counter ( input clk, input en, input edge_chk, output reg [7:0]count );

    always @ (posedge clk or posedge en) begin 
     if (en) begin
        if(edge_chk) begin
            count <= count + 1'b1;
        end
     end
     else begin
        count <= 8'b0;
      end
      end
      
endmodule
     
