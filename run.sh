# Icarus
mkdir -p icarus_obj_dir
rm -f icarus_obj_dir/Vtop && iverilog -g2012 -o icarus_obj_dir/Vtop top.sv tb_icarus.sv
vvp icarus_obj_dir/Vtop +vcd

# Verilator
verilator --cc --exe --trace --Wno-UNOPTFLAT --build tb.cc top.sv -CFLAGS '-I/include -g' --Mdir obj_dir_traces --build-jobs 32
TRACEFILE=trace.vcd ./obj_dir_traces/Vtop
