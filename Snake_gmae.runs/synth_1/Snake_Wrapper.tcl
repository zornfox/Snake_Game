# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.cache/wt [current_project]
set_property parent.project_path /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib {
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/imports/new/Generic_counter.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/imports/new/VGA_Interface.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/Bit_8_LFSR.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/Bit_7_LFSR.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/WIN_State.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/IDLE_start.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/Snake_Control.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/VGA_Wrapper.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/Segment7_Display_Interface.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/Score_Counter.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/Navigation_State_Machine.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/Master_State_Machine.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/Target_Generator.v
  /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/sources_1/new/Snake_Wrapper.v
}
read_xdc /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/constrs_1/new/Game_XDC.xdc
set_property used_in_implementation false [get_files /home/s1703084/Digital/LKY_SNAKE/Snake_gmae.srcs/constrs_1/new/Game_XDC.xdc]

synth_design -top Snake_Wrapper -part xc7a35tcpg236-1
write_checkpoint -noxdef Snake_Wrapper.dcp
catch { report_utilization -file Snake_Wrapper_utilization_synth.rpt -pb Snake_Wrapper_utilization_synth.pb }
