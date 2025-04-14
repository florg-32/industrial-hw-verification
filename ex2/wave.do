onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ex2/state
add wave -noupdate /ex2/clock
add wave -noupdate /ex2/clock_n
add wave -noupdate /ex2/output
add wave -noupdate /ex2/eventCounter
add wave -noupdate /ex2/transCounter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {834750 ps}
