`timescale 1ns / 1ps
`define SIM

module tb_therm ();
    reg clk, rst, en, preset_en;
    reg [7:0] preset_val;
    wire tx;

    parameter CLK_PERIOD = 10; // 100MHz clock
    parameter BIT_PERIOD = 868 * CLK_PERIOD; // 115200 Baud

    top_therm uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .preset_en(preset_en),
        .preset_val(preset_val),
        .tx(tx)
    );

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        force uut.R1.w[0] = 0;
        forever #3 force uut.R1.w[0] = ~uut.R1.w[0];
    end

    initial begin
        $display("Simulation Started: Monitoring UART Output...");
        $display("=== enable not asserted ===");
        en = 0;
        rst = 0;
        preset_en = 0;
        preset_val = 8'h00;

        #10_000;
        $display("time=%0t, === enable is asserted ===", $time);
        en = 1;
        #1_000_000
        
        preset_val = 8'hFF;
        preset_en = 1;
        $display("time=%0t, === preset_en is asserted (preset_val = %0h) ===", $time, preset_val);
        #1_000_000;
        preset_en = 0;
        $display("time=%0t, === preset_en is desserted ===", $time);
        #100_000;
        
        $display("time=%0t, === reset is asserted ===", $time);
        rst = 1;
        #1_000_000;
        rst = 0;
        $display("time=%0t, === reset is desserted ===", $time);
        
        #100_000;
        $display("time=%0t, === enable is desserted ===", $time);
        en = 0;
        #1_000_000
        en = 1;
        $display("time=%0t, === enable is asserted ===", $time);
        #500_000;
        
        $display("Simulation Finished.");
        $finish;
    end

    integer i;
    reg [7:0] rx_data;
    
    initial begin
        forever begin
            @(negedge tx); // Wait for Start Bit
            #(BIT_PERIOD/2);    // Move to middle of Start Bit
            
            if (tx == 0) begin
                rx_data = 0;
                for (i = 0; i < 8; i = i + 1) begin
                    #(BIT_PERIOD); // Move to middle of next bit
                    rx_data[i] = tx;
                end
                #(BIT_PERIOD); // Stop bit
                $display("[UART MON] Received Frequency Data (Hex): %h", rx_data);
            end
        end
    end

endmodule
