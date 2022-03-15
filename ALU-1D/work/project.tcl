set projDir "D:/Documents/School/GitHub/ALU-1D/work/vivado"
set projName "ALU 1D"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "D:/Documents/School/GitHub/ALU-1D/work/verilog/au_top_0.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/reset_conditioner_1.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/initialise_2.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/button_conditioner_3.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/edge_detector_4.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/alu_manual_5.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/tester_6.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/multi_seven_seg_7.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/pipeline_8.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/alu_9.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/boolTest_10.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/compareTester_11.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/shifterTester_12.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/adderTester_13.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/multiplierTester_14.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/modulo_tester_15.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/counter_16.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/seven_seg_17.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/decoder_18.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/shifter_19.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/adder_20.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/boolean_21.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/compare_22.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/multiplier_23.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/modulo_24.v" "D:/Documents/School/GitHub/ALU-1D/work/verilog/counter_25.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "D:/Documents/School/GitHub/ALU-1D/work/constraint/alchitry.xdc" "D:/Documents/School/GitHub/ALU-1D/work/constraint/io.xdc" "D:/Alchitry/library/components/au.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 12
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 12
wait_on_run impl_1
