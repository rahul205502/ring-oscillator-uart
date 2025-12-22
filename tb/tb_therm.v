`timescale 1ns/1ps

module tb_therm();
    
    reg clk;
    reg rst_n;
    wire tx;
    
    top_therm TT1 (.clk(clk), .rst_n(rst_n), .tx(tx) );
    
    initial begin
        clk = 1'b0;
        forever begin
            # 5 clk = ~clk;
        end
     end 
     
     initial begin

        rst_n = 1'b0;
        #100; rst_n = 1'b1;
        
        #5_000_000; $finish;
     end
        
    

endmodule