
########################### Define Top Module ############################
                                                   
set top_module FIFO_TOP

##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work

############################# Formality Setup File ##########################
set_svf FIFO.svf                                                   


################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries          #"
puts "###########################################"

#Add the path of the libraries to the search_path variable
lappend search_path /home/IC/Projects/FIFO/Synthesis/Std_Cells/synopsys

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
check_timing

#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

source ./cons.tcl

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile

#############################################################################
# Write out files
#############################################################################

write_file -format verilog -hierarchy -output netlists/$top_module.ddc
write_file -format verilog -hierarchy -output netlists/$top_module.v
write_sdf  sdf/$top_module.sdf
write_sdc  -nosplit sdc/$top_module.sdc

####################### reporting ##########################################

report_area -hierarchy > Reports/area.rpt
report_power -hierarchy > Reports/power.rpt
report_timing -delay_type min > Reports/hold.rpt
report_timing -delay_type max > Reports/setup.rpt
report_clock -attributes > Reports/clocks.rpt
report_constraint -all_violators -nosplit > Reports/constraints.rpt

################# starting graphical user interface #######################

#gui_start

#exit
