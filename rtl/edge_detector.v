`timescale 1ns/1ps

module edge_detector ( input clk, input ro_out, input en, output edge_dec );

    reg ro_out_prev;
    always @(posedge clk) begin
        if (en) begin 
            ro_out_prev <= ro_out;
        end
        else begin 
            ro_out_prev <= 1'b0;
        end
     end
     
     assign edge_dec = (~ro_out_prev) & ro_out;
endmodule
