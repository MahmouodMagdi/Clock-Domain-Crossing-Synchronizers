###################################################################

# Created by write_sdc on Sat Feb 25 04:01:18 2023

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
set_load -pin_load 2 [get_ports Full]
set_load -pin_load 1.3 [get_ports Empty]
set_load -pin_load 2 [get_ports {R_Data[7]}]
set_load -pin_load 2 [get_ports {R_Data[6]}]
set_load -pin_load 2 [get_ports {R_Data[5]}]
set_load -pin_load 2 [get_ports {R_Data[4]}]
set_load -pin_load 2 [get_ports {R_Data[3]}]
set_load -pin_load 2 [get_ports {R_Data[2]}]
set_load -pin_load 2 [get_ports {R_Data[1]}]
set_load -pin_load 2 [get_ports {R_Data[0]}]
create_clock [get_ports W_CLK]  -period 50  -waveform {0 25}
set_clock_uncertainty -setup 8  [get_clocks W_CLK]
set_clock_uncertainty -hold 0.55  [get_clocks W_CLK]
create_clock [get_ports R_CLK]  -period 20  -waveform {0 10}
set_clock_latency -max 12  [get_clocks R_CLK]
set_clock_uncertainty -setup 8  [get_clocks R_CLK]
set_clock_uncertainty -hold 0.55  [get_clocks R_CLK]
set_input_delay -clock W_CLK  40  [get_ports W_inc]
set_input_delay -clock W_CLK  40  [get_ports R_inc]
set_input_delay -clock W_CLK  40  [get_ports {W_Data[7]}]
set_input_delay -clock W_CLK  40  [get_ports {W_Data[6]}]
set_input_delay -clock W_CLK  40  [get_ports {W_Data[5]}]
set_input_delay -clock W_CLK  40  [get_ports {W_Data[4]}]
set_input_delay -clock W_CLK  40  [get_ports {W_Data[3]}]
set_input_delay -clock W_CLK  40  [get_ports {W_Data[2]}]
set_input_delay -clock W_CLK  40  [get_ports {W_Data[1]}]
set_input_delay -clock W_CLK  40  [get_ports {W_Data[0]}]
set_output_delay -clock R_CLK  8  [get_ports Full]
set_output_delay -clock R_CLK  8  [get_ports Empty]
set_output_delay -clock R_CLK  8  [get_ports {R_Data[7]}]
set_output_delay -clock R_CLK  8  [get_ports {R_Data[6]}]
set_output_delay -clock R_CLK  8  [get_ports {R_Data[5]}]
set_output_delay -clock R_CLK  8  [get_ports {R_Data[4]}]
set_output_delay -clock R_CLK  8  [get_ports {R_Data[3]}]
set_output_delay -clock R_CLK  8  [get_ports {R_Data[2]}]
set_output_delay -clock R_CLK  8  [get_ports {R_Data[1]}]
set_output_delay -clock R_CLK  8  [get_ports {R_Data[0]}]
set_clock_groups -asynchronous -name Asynchronous_Clocks -group [get_clocks R_CLK] -group [get_clocks W_CLK]
