simulate: build run waveform
simulate_tb: build_tb run_tb waveform

build:
	@rm -f chip_sim.vvp
	@iverilog -gspecify -o chip_sim.vvp components/*.v design/*.v

build_tb:
	@rm -f components_tb.vvp
	@iverilog -gspecify -o $(target)_tb.vvp components/*.v testbenches/$(target)_tb.v

run:
	@vvp chip_sim.vvp

run_tb:
	@rm *.vcd
	@vvp $(target)_tb.vvp

waveform:
	@gtkwave *.vcd
