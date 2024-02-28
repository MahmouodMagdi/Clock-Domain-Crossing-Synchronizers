
########################### Define Top Module ############################
                                                   
set top_module FIFO_TOP

##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work


############################# Formality Setup File ##########################
                                                   
set_svf $top_module.svf

################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries           #"
puts "###########################################"

#Add the path of the libraries to the search_path variable
lappend search_path /home/IC/Projects/FIFO/dft/Std_Cells/synopsys

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"

## Standard Cell libraries 
set target_library [list $SSLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB]  

######################## Reading RTL Files #################################

puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"

set file_format verilog

set fh [open FIFO.lst r+]
set rtl [read $fh]
set designs ""
regsub -all "\n" $rtl " " designs

read_file -format $file_format $designs

###################### Defining toplevel ###################################

current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

link 

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"


source ./cons.tcl


#################### Archirecture Scan Chains #########################
puts "###############################################"
puts "############ Configure scan chains ############"
puts "###############################################"

set_scan_configuration -clock_mixing no_mix  -style multiplexed_flip_flop -replace true -max_length 100

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"


compile -scan 

################################################################### 
# Setting Test Timing Variables
################################################################### 

# Preclock Measure Protocol (default protocol)
set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0

########################## Define DFT Signals ##########################

set_dft_signal -type ScanClock	  -port	[get_ports scan_CLK]	-timing {30 60}	-view existing_dft
set_dft_signal -type Reset	  -port	[get_ports scan_rst]	-active_state 0	-view existing_dft
set_dft_signal -type TestMode	  -port	[get_ports scan_mode]	-active_state 1	-view spec
set_dft_signal -type ScanEnable	  -port	[get_ports scan_en]	-active_state 1 -view spec		-usage scan
set_dft_signal -type ScanDataIn	  -port	[get_ports scan_in]			-view spec
set_dft_signal -type ScanDataOut  -port	[get_ports scan_out]			-view spec
set_dft_signal -type Constant 	  -port	[get_ports scan_mode]	-active_state 1	-view existing_dft

############################# Create Test Protocol #####################
                                           
create_test_protocol 

###################### Pre-DFT Design Rule Checking ####################

dft_drc -verbose

############################# Preview DFT ##############################

preview_dft -show scan_summary


############################# Insert DFT ###############################

insert_dft

######################## Optimize Logic post DFT #######################

compile -scan -incremental

###################### Design Rule Checking post DFT ###################

dft_drc -verbose -coverage_estimate

#############################################################################
# Write out Design after initial compile
#############################################################################

#Avoid Writing assign statements in the netlist
change_name -hier -rule verilog
write_file -format verilog -hierarchy -output netlist/FIFO_mapped.v

####################### reporting ##########################################

report_area -hierarchy > reports/DFT_area.rpt
report_power -hierarchy > reports/DFT_power.rpt
report_timing -nworst 3 -delay_type min > reports/DFT_hold.rpt
report_timing -nworst 3 -delay_type max > reports/DFT_setup.rpt
report_clock -attributes > reports/DFT_clocks.rpt
report_constraint -all_violators > reports/DFT_constraints.rpt

################# starting graphical user interface #######################

gui_start

#exit
