`timescale 1ns/1ps

module UART (
    input        clk,
    input        en,           
    input        rst,          
    input        start,
    input        preset_en,
    input  [7:0] preset_val,
    input  [7:0] latch_count,
    output reg   tx,
    output reg   tx_busy
);

    parameter SERIAL_COMM = 115200;
    parameter CLK_SPEED   = 100_000_000;
    parameter TICK        = CLK_SPEED / SERIAL_COMM;

    reg [$clog2(TICK)-1:0] count;
    reg baud_tick;

    always @(posedge clk) begin
        if (!en) begin
            count     <= 0;
            baud_tick <= 1'b0;
        end
        else if (count == TICK-1) begin
            count     <= 0;
            baud_tick <= 1'b1;
        end
        else begin
            count     <= count + 1'b1;
            baud_tick <= 1'b0;
        end
    end

    reg [7:0] data;
    reg [2:0] ct;

    localparam [1:0]
        IDLE  = 2'd0,
        START = 2'd1,
        DATA  = 2'd2,
        STOP  = 2'd3;

    reg [1:0] state;

    always @(posedge clk or posedge rst) begin
        if (!en) begin
            tx       <= 1'b1;
            tx_busy <= 1'b0;
            state   <= IDLE;
            ct      <= 3'b0;
        end
        else if (baud_tick) begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;
                    ct <= 3'b0;
                    if (start) begin
                        state   <= START;
                        tx_busy <= 1'b1;

                        if (rst)
                            data <= 8'h00;
                        else if (preset_en)
                            data <= preset_val;
                        else
                            data <= latch_count;
                    end
                end

                START: begin
                    tx    <= 1'b0;
                    state <= DATA;
                end

                DATA: begin
                    tx <= data[ct];
                    if (ct == 3'b111)
                        state <= STOP;
                    else
                        ct <= ct + 1'b1;
                end

                STOP: begin
                    tx       <= 1'b1;
                    tx_busy <= 1'b0;
                    state    <= IDLE;
                    ct       <= 3'b0;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
