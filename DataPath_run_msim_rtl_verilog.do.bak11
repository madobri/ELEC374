transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/DataPath.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/register.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/Bus.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/MDR_register.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/Mux_32to1.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/Encoder32to5.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/register_64.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/sra.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/shiftRight.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/shiftLeft.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/rotateRight.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/rotateLeft.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/orALU.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/notALU.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/negALU.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/andALU.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/booth.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/divisor.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/ALU.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/adder.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/subtractor.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/PC_register.v}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/elec374/CPU_Project {C:/intelFPGA_lite/18.1/elec374/CPU_Project/ALU_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ALU

add wave *
view structure
view signals
run -all
