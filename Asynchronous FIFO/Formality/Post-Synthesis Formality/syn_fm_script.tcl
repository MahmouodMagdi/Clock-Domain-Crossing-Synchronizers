
############################  Search PATH ################################

lappend search_path /home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys
lappend search_path /home/IC/Projects/FIFO/RTL

########################### Define Top Module ############################
                                                   
set top_module FIFO_TOP

######################### Formality Setup File ###########################

set synopsys_auto_setup true

set_svf "/home/IC/Projects/FIFO/Syn/FIFO.svf"

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

######################## set the top Reference Design ######################## 

set_reference_design FIFO_TOP
set_top FIFO_TOP

####################### Read Implementation tech libs ######################## 

read_db -container Imp [list $SSLIB]

#################### Read Implementation Design Files ######################## 

read_verilog -container Imp -netlist "/home/IC/Projects/FIFO/Syn/netlists/FIFO_TOP.v"

####################  set the top Implementation Design ######################

set_implementation_design FIFO_TOP
set_top FIFO_TOP


## matching Compare points
match

## verify
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
