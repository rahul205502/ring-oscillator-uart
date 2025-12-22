`timescale 1ns/1ps

module top_therm( input clk, input rst_n, output tx);//wiring module

    reg start_pending; // start signal latch
    
    wire op, ro_out, edge_dec;
    wire [7:0]count;
    wire window_done;
    wire [7:0]latch_count;
    wire uart_busy;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            start_pending <= 1'b0;
        end
        else begin
            if (window_done) begin
                start_pending <= 1'b1;
            end
            else if(uart_busy) begin
                start_pending <= 1'b0;
            end
        end
    end
         
    ring_oscillator R1(.op(op) );
    FF2 F1 (.clk(clk), .rst_n(rst_n) , .ro_in(op), .ro_out(ro_out) );
    edge_detector ED1( .clk(clk), .rst_n(rst_n), .ro_out(ro_out), .edge_dec(edge_dec) );
    edge_counter EC1( .clk(clk), .rst_n(rst_n), .edge_chk(edge_dec), .count(count) );
    window w1 (.clk(clk), .rst_n(rst_n), .window_done(window_done) );
    latch_register LR1 (.clk(clk), .rst_n(rst_n), .count(count), .window_done(window_done), .latch_count(latch_count) );
    UART U1 (.clk(clk), .rst_n(rst_n), .start(start_pending), .latch_count(latch_count), .tx(tx), .tx_busy(uart_busy) );
endmodule