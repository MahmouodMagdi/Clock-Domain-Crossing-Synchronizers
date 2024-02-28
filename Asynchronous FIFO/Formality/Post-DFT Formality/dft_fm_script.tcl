

############################  Search PATH ################################

lappend search_path /home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys
lappend search_path /home/IC/Projects/FIFO/dft/RTL

########################### Define Top Module ############################
                                                   
set top_module FIFO_TOP

######################### Formality Setup File ###########################

set synopsys_auto_setup true

set_svf "/home/IC/Projects/FIFO/dft/FIFO_TOP.svf"

####################### Read Reference tech libs ########################
 
set SSLIB "/home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"

read_db -container Ref [list $SSLIB]

###################  Read Reference Design Files ######################## 

read_verilog -container Ref "FIFO_TOP.v"
read_verilog -container Ref "FIFO_RPTR.v"
read_verilog -container Ref "ASYNC_FIFO_RAM.v"
read_verilog -container Ref "FIFO_WPTR.v"
read_verilog -container Ref "Read_Pointer_Sync.v"
read_verilog -container Ref "Write_Pointer_Sync.v"
read_verilog -container Ref "2X1_MUX.v"

######################## set the top Reference Design ######################## 

set_reference_design FIFO_TOP
set_top FIFO_TOP

####################### Read Implementation tech libs ######################## 

read_db -container Imp [list $SSLIB]

#################### Read Implementation Design Files ######################## 

read_verilog -container Imp -netlist "/home/IC/Projects/FIFO/dft/netlist/FIFO_mapped.v"

####################  set the top Implementation Design ######################

set_implementation_design FIFO_TOP
set_top FIFO_TOP

############################### Don't verify #################################

# do not verify scan in & scan out ports as a compare point as it is existed only after synthesis and not existed in the RTL

#scan in
set_dont_verify_points -type port Ref:/WORK/*/scan_in
set_dont_verify_points -type port Imp:/WORK/*/scan_in

#scan_out
set_dont_verify_points -type port Ref:/WORK/*/scan_out
set_dont_verify_points -type port Imp:/WORK/*/scan_out

############################### contants #####################################

# all atpg enable(test_mode, scan_enable) are zero during formal compare

#test_mode
set_constant Ref:/WORK/*/scan_mode 0
set_constant Imp:/WORK/*/scan_mode 0

#scan_enable
set_constant Ref:/WORK/*/scan_en 0
set_constant Imp:/WORK/*/scan_en 0

########################### matching Compare points ##########################

match

################################# verify #####################################

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

report_passing_points > "reports/passing_points.rpt"
report_failing_points > "reports/failing_points.rpt"
report_aborted_points > "reports/aborted_points.rpt"
report_unverified_points > "reports/unverified_points.rpt"


start_gui
