# Direct Memory Access on AXI

This project is an attempt to create an SV based testbench around DMA AXI.

RTL source:
https://opencores.org/projects/dma_axi

Steps to compile(ModelSim/QuestaSim):
```
cd dma_axi
vlib work
vlog -novopt -sv .\filelist -f verif/agents/apb_mstr_agent/apb_mstr_agent.f .\verif\dma_axi
_dv.f  -timescale 1ns/1ps
```
Running test:
```
vsim -novopt tb_top -c +UVM_TESTNAME=apb_directed_reg_write_read_test -do "log tb_top/* -r;
 run -all"
```

Steps to open waveform(ModelSim/QuestaSim):
```
vsim -view .\vsim.wlf
```
