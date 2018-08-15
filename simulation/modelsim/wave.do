onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clock
add wave -noupdate -label Clock /tb/clock
add wave -noupdate -label ld_reg -radix binary /tb/dut/regfile0/ldreg
add wave -noupdate -label R0 -radix hexadecimal {/tb/dut/regfile0/reg_memory[0]}
add wave -noupdate -label R1 -radix hexadecimal {/tb/dut/regfile0/reg_memory[1]}
add wave -noupdate -label R2 -radix hexadecimal {/tb/dut/regfile0/reg_memory[2]}
add wave -noupdate -label R3 -radix hexadecimal {/tb/dut/regfile0/reg_memory[3]}
add wave -noupdate -label R4 -radix hexadecimal {/tb/dut/regfile0/reg_memory[4]}
add wave -noupdate -label R5 -radix hexadecimal {/tb/dut/regfile0/reg_memory[5]}
add wave -noupdate -label R6 -radix hexadecimal {/tb/dut/regfile0/reg_memory[6]}
add wave -noupdate -label R7 -radix hexadecimal {/tb/dut/regfile0/reg_memory[7]}
add wave -noupdate -label IR -radix hexadecimal /tb/dut/ir0/out
add wave -noupdate -label PC -radix hexadecimal /tb/dut/pc0/out
add wave -noupdate -label State -radix unsigned /tb/dut/control0/state
add wave -noupdate -label Bus -radix hexadecimal /tb/dut/bus
add wave -noupdate -label aluk -radix binary -radixenum numeric /tb/dut/alu0/aluk
add wave -noupdate -label ALU-a -radix hexadecimal /tb/dut/alu0/a
add wave -noupdate -label ALU-b -radix hexadecimal /tb/dut/alu0/b
add wave -noupdate -label ALU-res -radix hexadecimal /tb/dut/alu0/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 142
configure wave -valuecolwidth 98
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {22 ps} {151 ps}
