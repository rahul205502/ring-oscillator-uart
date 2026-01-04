`timescale 1ns/1ps

module top_therm( input clk, input rst, input en, input preset_en, input [7:0] preset_val, output tx);//wiring module

    reg start_pending; // start signal latch
    
    wire op, ro_out, edge_dec;
    wire [7:0]count;
    wire window_done;
    wire [7:0]latch_count;
    wire uart_busy;
    
    always @(posedge clk) begin
        if (en) begin
           if (window_done) begin
               start_pending <= 1'b1;
           end
           else if(uart_busy) begin
               start_pending <= 1'b0;
           end 
        end
        else begin
            start_pending <= 1'b0;
        end
    end
         
    ring_oscillator R1 (.en(en), .op(op) );
    FF2 F1 (.clk(clk), .en(en) , .ro_in(op), .ro_out(ro_out) );
    edge_detector ED1( .clk(clk), .en(en), .ro_out(ro_out), .edge_dec(edge_dec) );
    edge_counter EC1( .clk(clk), .en(en), .edge_chk(edge_dec), .count(count) );
    window w1 (.clk(clk), .en(en), .window_done(window_done) );
    latch_register LR1 (.clk(clk), .en(en), .count(count), .window_done(window_done), .latch_count(latch_count) );
    UART U1 (.clk(clk), .rst(rst), .en(en), .preset_en(preset_en), .preset_val(preset_val), .start(start_pending), .latch_count(latch_count), .tx(tx), .tx_busy(uart_busy) );
endmodule
