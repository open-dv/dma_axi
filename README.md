# Direct Memory Access on AXI

This project is an attempt to create an SV based testbench around DMA AXI.

RTL source:
https://opencores.org/projects/dma_axi

Steps to compile(ModelSim/QuestaSim):
```
cd dma_axi
vlib work
vlog -sv filelist
```
Steps to open simulator(ModelSim/QuestaSim):
```
vsim -novopt dma_axi64
```
