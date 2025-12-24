
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
## create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} [get_ports clk]

set_property PACKAGE_PIN U18 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

set_property PACKAGE_PIN A18 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]

set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -hierarchical *op*]